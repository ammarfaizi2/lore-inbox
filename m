Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136675AbREGVo4>; Mon, 7 May 2001 17:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136678AbREGVor>; Mon, 7 May 2001 17:44:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136675AbREGVoe>; Mon, 7 May 2001 17:44:34 -0400
Date: Mon, 7 May 2001 14:44:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: <nigel@nrg.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <3AF712D5.5D712E0F@didntduck.org>
Message-ID: <Pine.LNX.4.31.0105071443080.1195-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Brian Gerst wrote:
>
> Keep in mind that regs->eflags could be from user space, and could have
> some undesirable flags set.  That's why I did a test/sti instead of
> reloading eflags.  Plus my patch leaves interrupts disabled for the
> minimum time possible.

The plain "popf" should be ok: the way intel works, you cannot actually
use popf to set any of the strange flags (if vm86 mode etc).

I like the size of this alternate patch.

		Linus

