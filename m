Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281436AbRKEXqN>; Mon, 5 Nov 2001 18:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281437AbRKEXqD>; Mon, 5 Nov 2001 18:46:03 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23800 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281436AbRKEXpy>;
	Mon, 5 Nov 2001 18:45:54 -0500
Date: Mon, 5 Nov 2001 16:45:01 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Christian Laursen <xi@borderworlds.dk>, linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
Message-ID: <20011105164501.K3957@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Christian Laursen <xi@borderworlds.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <20011105014225Z17055-18972+38@humbolt.nl.linux.org> <m3n120x1re.fsf@borg.borderworlds.dk> <20011105231222Z16039-18972+236@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011105231222Z16039-18972+236@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Tue, Nov 06, 2001 at 12:13:12AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2001  00:13 +0100, Daniel Phillips wrote:
> > > From 2.4.10 on ext2 has an accelerator in 
> > > ext2_find_entry - it caches the last lookup position.  I'm wondering how 
> > > that affects this case.
> > 
> > From the description I read a while ago, I believe it could cause a
> > significant speedup.
> > 
> > I'll have to try that out one of these days.
> 
> I noticed split results with the find_entry accelerator, at least in its 
> current form: faster delete, slower create.

Well, according to reiserfs benchmarks at:
http://namesys.com/benchmarks/mongo/2.4.8_vs_2.4.9_vs_2.4.10_table.txt

the accelerator speeds up stat times (in all cases) by a factor of 3 to 5.
Create times are reduced as well (although not as much).  In fact, it also
shows delete speed as being slower, but that is hard to quantify as the
reiserfs delete spped is slower also.

It actually looks like both ext2 and reiserfs took a hit in the read
department in 2.4.10 as well.  Maybe a bad interaction with the page
cache or something?  It would also be worthwhile to go back to the
addition of directories-in-pagecache as well, because I seem to recall
posting about a hit in read performance at that time as well, and never
really heard anything about it.

The bonnie++ benchmark doesn't show any obvious trends (incomplete tables):
http://namesys.com/benchmarks/bonnie/2.4.8_2.4.9_2.4.10.txt

I'll have to go and update my bonnie benchmarks for newer kernels (last
run when testing indexed directores and dir-in-pagecache at 2.4.5).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

