Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319189AbSH2LXR>; Thu, 29 Aug 2002 07:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319192AbSH2LXR>; Thu, 29 Aug 2002 07:23:17 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:50601 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319189AbSH2LXP>; Thu, 29 Aug 2002 07:23:15 -0400
Date: Thu, 29 Aug 2002 12:27:35 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: hch@infradead.org, kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
In-Reply-To: <200208291100.EAA11337@adam.yggdrasil.com>
Message-ID: <Pine.SOL.3.96.1020829121310.11617B-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Adam J. Richter wrote:
[snip]
> 	Here are the three approaches that I can think of and their
> major pros and cons:
> 
> 	1. Make loop.c never use {prepare,commit}_write.
> 	2. As you mention (but do not endorse) in your posting to gfs-devel,
> 	   modify loop.c so that it does not use {prepare,commit}_write
> 	   on OpenGFS, but does on other file systems (to avoid a data copy).
> 	3. Make OpenGFS (and potentially other future file systems)
> 	   export a {prepare,commit}_write that works with loop.c, as
> 	   documented in Documentation/filesystem/Locking.

And why not 4., have a per fs flag (say fs_{,set_,clear_,}generic_aops())
(or per superblock flag or whatever, perhaps a per address space flag
even?) specifying whether the fs' aops support loop or not. loop.c then
simply does:

if (fs_generic_aops()/fs_aops_support_loop()/whatever...)
	use aops ->readpage and ->{prepare,commit}_write
else
	use fops ->read and ->write

I guess that is like point 2, just making it a simple generic mechanism so
that loop always works yet users of address spaces are free to implement
their ->readpage and ->{prepare,commit}_write anything they want...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

