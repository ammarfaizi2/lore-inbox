Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUBHSsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 13:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUBHSsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 13:48:33 -0500
Received: from main.gmane.org ([80.91.224.249]:42896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264313AbUBHSsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 13:48:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Improved file handling mechanisms for 64-bit architectures
Date: Sun, 08 Feb 2004 19:48:22 +0100
Message-ID: <yw1x4qu1s8zt.fsf@kth.se>
References: <001b01c3ee72$a5d5a3b0$0301a8c0@mojeime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-1862.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:MhV55a2gu+IZCf3Wtbgw5D1XbI8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vijolicni.oblak" <un.info@gmx.net> writes:

> I would like to make a suggestion how to best use the new AMD64 architecture
> in the new kernel version for 64-bit architectures. You are making new sets
> of functions and optimizing new compilers anyway so I think that now is also
> the time to introduce new file handling mechanisms that can be fully
> implemented only in 64-bit environment.
>
> Currently, the AMD64 architecture defines a mechanism for translating 48-bit
> virtual addresses to 52-bit physical addresses.
>
> I will make a suggestion on how to improve file handling performance:
>
> Currently if you want to work with files, you have to:
>
> 1) assign file a handle; 2) read wanted portions of file into memory 3) if
> there is not enough physical memory, save the contents of the file to disk
>
> With AMD64 you are able to make 48-bit addresses, which amount to 256000
> gigabytes of virtual memory. When working with large (eg. 10GB) video or
> database files, Linux kernel could map the whole file into the virtual
> memory using processor's Page Translation Mechanism.
>
> Those 10GB would then be mapped to a certain memory range. If a portion of
> file that is currently requested is in physical RAM the processor would
> handle it without OS intervention; if not, then a page fault (#PF, 14)
> exception would occur and read a missing page (a missing portion of file).
>
> The application would see the file as a 10GB large array (or a string), or
> perhaps could map its own data structures into this memory space.
>
> When writing to file, i.e. modifying the data in the array, a #PF would
> occur and mark this page as dirty and write modified data to the disk (or
> schedule writing to a later time)

Did you have something different from mmap in mind?  What you are
saying look very much like the existing mmap functionality.

> There is also one addition benefit to this: when inserting data into the
> middle of the 10GB file - a new video frame or enlarging a table in SQL only
> a remapping of virtual memory and the cooperation of file system is needed.
>
> Let's say that AAAAAAAAAAAAAAAAAAAAAAAA is the original file. You want to
> insert B somewhere in the middle of the file. AAAAAAAAABAAAAAAAAAAAAAAA is
> done by calling a function increasefile(startoffset,length) that moves a few
> hundred bytes in Page Table or in Page directory table and by adding an
> additional segment to the file chain (eg. FAT chain). The length must just
> be a multiplier of 4KB.

This is non-trivial.  It would require support from all the various
filesystems.  Surely there's some filesystem using an on-disk layout
making such things difficult or impossible.

-- 
Måns Rullgård
mru@kth.se

