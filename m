Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVEZXRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVEZXRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEZXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:17:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:53646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261723AbVEZXRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:17:19 -0400
Date: Thu, 26 May 2005 16:19:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: roland@redhat.com, akpm@osdl.org, mtk-lkml@gmx.net,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
In-Reply-To: <20050526.153713.95060123.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0505261617360.2307@ppc970.osdl.org>
References: <24601.1116404447@www71.gmx.net> <200505262222.j4QMMHWe010741@magilla.sf.frob.com>
 <20050526.153713.95060123.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 May 2005, David S. Miller wrote:
> 
> > Other machines are subject to the same risk and should have a
> > prevent_tail_call definition too.  The asm-i386/linkage.h version probably
> > works fine for every machine.  It might as well be generic, I'd say.
> 
> Sparc, for one, doesn't need it.  We pass the pt_regs in via a pointer
> to the trap level stack frame which won't be released by a tail-call
> in C code.

x86 has largely tried to move in that direction too, ie a lot of the 
asm-calls have been turned into FASTCALL() with %eax pointing to the 
stack.

Roland, I applied the patch, but if there was some particular case that 
triggered this, maybe it's worth trying to re-write that one.

		Linus
