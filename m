Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281204AbRKPDLH>; Thu, 15 Nov 2001 22:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKPDKr>; Thu, 15 Nov 2001 22:10:47 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29169 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281201AbRKPDKf>;
	Thu, 15 Nov 2001 22:10:35 -0500
Date: Thu, 15 Nov 2001 20:09:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115200916.A5739@lynx.no>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no> <20011115183858.N329@visi.net> <20011115170742.W5739@lynx.no> <20011115195551.Q329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115195551.Q329@visi.net>; from bcollins@debian.org on Thu, Nov 15, 2001 at 07:55:51PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  19:55 -0500, Ben Collins wrote:
> On Thu, Nov 15, 2001 at 05:07:42PM -0700, Andreas Dilger wrote:
> > What would be interesting to correlate is what inode 48 is (probably a
> > directory, or you wouldn't have noticed it at all), with the corruption
> > problems you are having while ext3 is loaded.
> 
> 48 /usr/lib/perl5/5.005/File/Copy.pm
> 
> Since this file is pretty small, I can only assume that it overwrote
> some adjacent files. There is some corruption in this file (luckily in
> the comment area :) starting at the 25th byte, and extending 12 bytes in
> length. Here's the values from hexedit:
> 
> 	00 00 00 01  00 00 00 00  00 00 00 00

No, this would be the only expected corruption - there are 3 32-bit
fields that that get written to disk in journal_update_superblock(),
and these are consistent with that.

That means the source of the other corruption is unknown.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

