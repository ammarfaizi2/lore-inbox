Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSKRS3n>; Mon, 18 Nov 2002 13:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSKRS20>; Mon, 18 Nov 2002 13:28:26 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:29706 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264665AbSKRS2L>; Mon, 18 Nov 2002 13:28:11 -0500
Date: Mon, 18 Nov 2002 18:35:12 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Chris Cheney <ccheney@cheney.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47+ input as module broken
In-Reply-To: <20021117052434.GF26199@cheney.cx>
Message-ID: <Pine.LNX.4.44.0211181813480.22101-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Normal. You have CONFIG_VT set to y and CONFIG_INPUT set to module. The VT 
console system now depends on the input layer. That is why the error. I 
can create a patch to deal with this. Unfortunely the console system is to 
broken to handle the input layer being modular. I do have a new core 
console system that can handle this. 

On Sat, 16 Nov 2002, Chris Cheney wrote:

> When CONFIG_INPUT=m is set the following occurs:
> 
>         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
> drivers/built-in.o(.text+0x39b43): In function `kd_nosound':
> : undefined reference to `input_event'
> drivers/built-in.o(.text+0x39b5c): In function `kd_nosound':
> : undefined reference to `input_event'
> drivers/built-in.o(.text+0x39c07): In function `kd_mksound':
> : undefined reference to `input_event'
> drivers/built-in.o(.text+0x3a8a2): In function `kbd_bh':
> : undefined reference to `input_event'
> drivers/built-in.o(.text+0x3a8b0): In function `kbd_bh':
> : undefined reference to `input_event'
> drivers/built-in.o(.text+0x3a8c1): more undefined references to `input_event' follow
> drivers/built-in.o(.text+0x3ad73): In function `kbd_connect':
> : undefined reference to `input_open_device'
> drivers/built-in.o(.text+0x3ad97): In function `kbd_disconnect':
> : undefined reference to `input_close_device'
> drivers/built-in.o(.init.text+0x2391): In function `kbd_init':
> : undefined reference to `input_register_handler'
> 
> Chris Cheney
> 
> cc: any replies
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

