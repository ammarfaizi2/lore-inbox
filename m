Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267177AbUBMTOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUBMTOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:14:31 -0500
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:27576 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id S267177AbUBMTO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:14:26 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F0BA@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Maciej Zenczykowski'" <maze@cela.pl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: your mail
Date: Fri, 13 Feb 2004 11:14:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, your assumtion about the 1GB is correct.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Maciej Zenczykowski [mailto:maze@cela.pl]
Sent: Friday, February 13, 2004 1:11 PM
To: Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail


The deleted marks in question mean that the file in question has been 
unlinked (rm'ed), however it is still being used and the inode in question 
still exists.  This memory is in use and thus validly takes up mapping 
space.  You'd need to unmap inorder to free that memory.  Deleting a file 
does not delete that file until _all_ processes close and unmap any 
references to it.  What's more worrying is the large area of unmapped 
memory below 1GB (0x40000000), wonder why it doesn't get allocated?  But I 
think the answer is that the standard allocator only searches 1GB..3GB for 
free areas...

Cheers,
MaZe.

On Fri, 13 Feb 2004, Bloch, Jack wrote:

> I am running a 2.4.19 Kernel and have a problem where a process is using
the
> up to the 0xC0000000 of space. It is no longer possible for this process
to
> get any more memory vi mmap or via shmget. However, when I dump the
> /procs/#/maps file, I see large chunks of memory deleted. i.e this should
be
> freely available to be used by the next call. I do not see these addresses
> get re-used. The maps file is attached.
> 
>  <<9369>> 
> 
> Jack Bloch 
> Siemens ICN
> phone                (561) 923-6550
> e-mail                jack.bloch@icn.siemens.com
> 
> 
