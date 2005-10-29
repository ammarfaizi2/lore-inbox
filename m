Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVJ2Soa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVJ2Soa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVJ2Soa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:44:30 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:34990 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751249AbVJ2So3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:44:29 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 29 Oct 2005 19:44:20 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, 333776@bugs.debian.org
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly
 case-insensitive
In-Reply-To: <87k6fwcmp0.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.64.0510291941020.5182@hermes-1.csi.cam.ac.uk>
References: <20051013165529.GA2472@tennyson.dodds.net> <20051028082252.GC11045@verge.net.au>
 <874q71wv2b.fsf@devron.myhome.or.jp> <200510291645.08872.ioe-lkml@rameria.de>
 <87k6fwcmp0.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2005, OGAWA Hirofumi wrote:
> Ingo Oeser <ioe-lkml@rameria.de> writes:
> >> This is known bug. For fixing this bug cleanly, we will need to much
> >> change the both of nls and filesystems.
> >
> > Using per locale collation sequences? :-)
> >
> > Do you know, how Windows handles the problem of differing collation 
> > sequences on the file system?
> 
> I don't know. Why do we need to care the collation sequences here?
> 
> > Or is the file system always dependend on the locale of the Windows
> > version, which created the file system?
> 
> Probably, yes. I think we need to know on-disk filename's code set.

If FAT stores the filenames in 8 bits (non-UTF) then yes, it will be in 
the current locale/code page of the Windows system writing them (e.g. that 
happens with the names of EAs in NTFS).

If the names are stored in 16-bit Unicode like on NTFS then obviously they 
are completely locale/code page independent.  (Makes my life in NTFS a 
_lot_ easier.  Especially since the NTFS volume contains an upcase table 
for the full 16-bit Unicode which we load and use to do upcasing for the 
case insensitive comparisons...)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
