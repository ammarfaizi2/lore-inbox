Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSKWFK0>; Sat, 23 Nov 2002 00:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSKWFK0>; Sat, 23 Nov 2002 00:10:26 -0500
Received: from dp.samba.org ([66.70.73.150]:38828 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261433AbSKWFKZ>;
	Sat, 23 Nov 2002 00:10:25 -0500
Date: Sat, 23 Nov 2002 16:16:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, ak@muc.de
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Message-ID: <20021123051628.GA3658@krispykreme>
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au> <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> You're doing a compat layer, and then you're using various undefined types 
> that can be random sizes, and calling them xxx_t32.
> 
> For christ sake, somebody is on drugs here.

Then it must be davem, Andi and I :) Stephen is just merging what we
already have.

> If they are called "xxx_t32", then that means that you _know_ the size 
> already statically, and you should use "u32" or "s32" which are shorter 
> and clearer anyway. You should sure as hell not use some random C type 
> that can be different depending on compiler options etc, and then calling 
> it a "compat" library.

_t32 == 32 bit version, its not the size. eg

asm-ia64/ia32.h:		typedef unsigned short	__kernel_ipc_pid_t32;
asm-mips64/posix_types.h:	typedef int		__kernel_ipc_pid_t32;
asm-parisc/posix_types.h:	typedef unsigned short	__kernel_ipc_pid_t32;
asm-ppc64/ppc32.h:		typedef unsigned short	__kernel_ipc_pid_t32;
asm-sparc64/posix_types.h:	typedef unsigned short	__kernel_ipc_pid_t32;
asm-x86_64/ia32.h:		typedef unsigned short	__kernel_ipc_pid_t32;

Or do you mean we should use typedef u16 __kernel_ipc_pid_t32? Yeah,
I can understand that.

Anton
