Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUAKRxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUAKRxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:53:15 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:2725 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265919AbUAKRxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:53:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 Jan 2004 09:53:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Martin Schlemmer <azarah@nosferatu.za.org>
cc: Bart Samwel <bart@samwel.tk>, Tim Cambrant <tim@cambrant.com>,
       Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
In-Reply-To: <1073843075.9096.125.camel@nosferatu.lan>
Message-ID: <Pine.LNX.4.44.0401110948590.19685-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Martin Schlemmer wrote:

> On Sun, 2004-01-11 at 18:53, Davide Libenzi wrote:
> > On Sun, 11 Jan 2004, Bart Samwel wrote:
> > 
> > > Now it seems to behave correctly: for '~' it always warns, for '-' it 
> > > only warns if the negative value is below -0x80000000. I'll submit a 
> > > patch to this effect (including the format extensions) to the binutils 
> > > people.
> > 
> > binutils 2.14 works fine, so I believe they already fixed it.
> > 
> 
> I would beg to differ:
> 
> --
> nosferatu linux # make
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-i386/asm_offsets.h
>   CHK     include/linux/compile.h
>   AS      arch/i386/boot/setup.o
> arch/i386/boot/setup.S: Assembler messages:
> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff
>   LD      arch/i386/boot/setup
>   BUILD   arch/i386/boot/bzImage
> Root device is (8, 3)
> Boot sector 512 bytes.
> Setup is 4799 bytes.
> System is 1366 kB
> Kernel: arch/i386/boot/bzImage is ready
>   Building modules, stage 2.
>   MODPOST
> nosferatu linux # ld --version
> GNU ld version 2.14.90.0.7 20031029
> Copyright 2002 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License.  This program has absolutely no warranty.
> nosferatu linux #

Ouch ! I have:

GNU assembler 2.14 20030612

and it works fine. Can you try:

$ as << EOF

	PG=0xC0000000
	VM=(128 << 20)

	.long (-PG -VM)
	.long (~PG + 1 - VM)
EOF

$ objdump -D a.out




- Davide


