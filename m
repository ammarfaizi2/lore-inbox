Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTLDGmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 01:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTLDGmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 01:42:15 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:36019 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263024AbTLDGmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 01:42:13 -0500
Date: Thu, 4 Dec 2003 17:39:21 +1100
From: Nathan Scott <nathans@sgi.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031204063921.GD1967@frodo>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <20031203162045.GA27964@suse.de> <Pine.LNX.4.58.0312030823010.5258@home.osdl.org> <16334.17126.154718.614827@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16334.17126.154718.614827@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 07:09:10AM +1100, Neil Brown wrote:
> On Wednesday December 3, torvalds@osdl.org wrote:
> > 
> > 
> > On Wed, 3 Dec 2003, Jens Axboe wrote:
> > > >
> > > > Interesting. Another RAID 0 problem report..
> > >
> > > Hmm did _all_ reports include raid-0, or just "some" raid? I'm looking
> > > at the bio_pair stuff which raid-0 is the only user of, something looks
> > > fishy there.
> > 
> > The ones I've seen seem to be raid-0, but Nathan (nathans@sgi.com)
> > reported problems in RAID-5 under load. I didn't decode the full oops on
> > that one, but it really looked like a stale "bi" bio that trapped on the
> > PAGE_ALLOC debug code.
> > 
> 
> Nathan's had a second oops that turned out to be a bi_next pointer
> being bad in a bio that raid5 had just about finished writing out.
> So there does seem to be something wrong with bio handling, quite
> possibly in raid5.
> 
> The only thing I could find was that if raid5 received two overlapping
> bios concurrently (or atleast received the second before it had
> finished with the first) it could get confused.  I've asked Nathan to
> try a patch that BUGs when that happens.

I haven't tripped the bug so far today, although have been
running with page-sized fs blocksize so far - perhaps that
is implicated, and makes it less likely to trigger (when I
say "the bug" there, I mean neither the panic, nor the new
BUG_ON(); I'll revert back to smaller block sizes next).

That error path bio_put issue you spotted in XFS, Neil, I
think is a valid problem - I'm not sure that is reachable
code in practice (possibly overly defensive XFS bio code),
I'll go investigate that some more.

cheers.

-- 
Nathan
