Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKRES7>; Fri, 17 Nov 2000 23:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbQKRESu>; Fri, 17 Nov 2000 23:18:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3852 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129097AbQKRESk>; Fri, 17 Nov 2000 23:18:40 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Freeze on FPU exception with Athlon
Date: 17 Nov 2000 19:48:21 -0800
Organization: Transmeta Corporation
Message-ID: <8v4u65$120$1@penguin.transmeta.com>
In-Reply-To: <20001118014019.18006.qmail@web3404.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001118014019.18006.qmail@web3404.mail.yahoo.com>,
=?iso-8859-1?q?Markus=20Schoder?=  <markus_schoder@yahoo.de> wrote:
>The following small program (linked against glibc 2.1.3) reliably
>freezes my system (Athlon Thunderbird CPU) with at least kernels
>2.4.0-test10 and 2.4.0-test11-pre5.  Even the SysRq keys do not work
>after the freeze.

Are you sure sysrq doesn't work? Many distributions will disable the
kernel printing to the console, or move it to console 7 or similar. 

It would be really good to get the EIP trace of RightAlt+ScrollLock
pressed a few times if you can try to see if you can use klogd to enable
proper printk's.

>Older kernels (e.g. 2.3.40) seem to work.  Any Ideas?

The FP exception handling has certainly changed, but the changes should
all have affected mainly just PIII kernels with XMM support enabled. An
Athlon system should have been pretty unaffected. But I'll take a look
if I see something obvious.

One thing to try: if interrupts really don't work for you (and if SysRq
doesn't work, that may be the case), please test out a kernel that
simply ignores irq13 by just commenting out the line

	setup_irq(13, &irq13);

in arch/i386/kernel/i8259.c.  Does that make any difference? (irq13
shouldn't be used any more, it's horrible legacy crap, but we do want to
support even horrible legacy systems). 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
