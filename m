Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbRCCGtl>; Sat, 3 Mar 2001 01:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130426AbRCCGtc>; Sat, 3 Mar 2001 01:49:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64759 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130425AbRCCGtT>;
	Sat, 3 Mar 2001 01:49:19 -0500
Date: Sat, 3 Mar 2001 01:49:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: TimO <hairballmt@mcn.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS-kernel 2.4.3-pre1
In-Reply-To: <3AA07471.3D46194B@mcn.net>
Message-ID: <Pine.GSO.4.21.0103030140070.17703-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Mar 2001, TimO wrote:

> eax: 00000000  ebx: 00000000  ecx: 00000000  edx: 00000000
[snip]
> >>EIP; c0142a52 <get_new_inode+b2/160>   <=====
> Trace; c0142ca6 <iget4+b6/d0>
> Trace; c0145f01 <proc_get_inode+41/120>
> Trace; c014601a <proc_read_super+3a/b0>
> Trace; c01349a4 <read_super+104/180>
> Trace; c0134f7a <kern_mount+2a/80>
> Trace; c0107007 <init+7/110>
> Trace; c01074b8 <kernel_thread+28/40>
> Code;  c0142a52 <get_new_inode+b2/160>
> 00000000 <_EIP>:
> Code;  c0142a52 <get_new_inode+b2/160>   <=====
[snip]

Lovely. sb->s_op == NULL in iget(). The thing being, proc_read_super()
explicitly sets ->s_op to non-NULL. Oh, and that area hadn't changed since
2.4.2, so I'd rather suspect the b0rken build. Can you reproduce it?

							Cheers,
								Al

