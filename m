Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTKUXFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTKUXFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:05:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:36533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261384AbTKUXFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:05:30 -0500
Date: Fri, 21 Nov 2003 15:05:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       <bug-binutils@gnu.org>
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io
 priorities (fwd)]
In-Reply-To: <Pine.LNX.4.44.0311211439120.13789-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Trivial test input file included, and "bug-binutils" added to the CC ]

On Fri, 21 Nov 2003, Linus Torvalds wrote:
> 
> Just do "gdb vmlinux" and do "disassemble system_call" to see this. It 
> says something like
> 
> 	cmp    $0x448,%eax
> 	jae    syscall_badsys
> 
> and it _should_ use just 274 (0x112 rather than 0x448) on x86.
> 
> Now, I wonder if this has ever worked, of which binutils version broke 
> it..

Some looking around shows that it works correctly on a SuSE box with

	GNU assembler version 2.13.90.0.18 (i486-suse-linux) using BFD version 2.13.90.0.18 20030121 (SuSE Linux)
	GNU ld version 2.13.90.0.18 20030121 (SuSE Linux)

but is broken on RH Fedora core 1:

	GNU assembler version 2.14.90.0.6 (i386-redhat-linux) using BFD version 2.14.90.0.6 20030820
	GNU ld version 2.14.90.0.6 20030820

So it definitely _does_ work in some versions, and the bug appears to be 
new to binutils 2.14, with 2.13 doing the right thing.

You can trivially see if with a simple assembly file like

	start:
		.long 1,2,3,a
	a=(.-start)/4

where 2.13.90 as shipped by SuSE will get it right (and generate a list of
1,2,3,4), while 2.14.90 from Fedora core will generate 1,2,3,16.

		Linus


