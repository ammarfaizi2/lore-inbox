Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbSKSHAa>; Tue, 19 Nov 2002 02:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSKSHAa>; Tue, 19 Nov 2002 02:00:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267114AbSKSHA3>; Tue, 19 Nov 2002 02:00:29 -0500
Date: Mon, 18 Nov 2002 23:03:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dax Kelson <dax@gurulabs.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>, <pavel@ucw.cz>,
       <vojtech@suse.cz>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK current compile failure
In-Reply-To: <1037683446.1530.9.camel@mentor>
Message-ID: <Pine.LNX.4.44.0211182252280.24793-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Nov 2002, Dax Kelson wrote:
>
> Linus, do you want compile failure reports like below?

Well, I certainly prefer not to, simply because you might as well send 
them to linux-kernel and get it resolved that way by some random person 
who just happens to be awake.

It looks like 

 - an ACPI configuration bug, where CONFIG_ACPI_SLEEP is allowed even
   though CONFIG_SOFTWARE_SUSPEND is not enabled.

 - keyboard.c and parts of VT not depending on CONFIG_INPUT

 - device mapper using vcalloc() even though no such function has ever 
   existed in the kernel (it's vmalloc + memset()).

and I think the only way to fix these things is to publicly shame 
maintainers into fixing the stuff they maintain.

		Linus

---
> arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
> arch/i386/kernel/built-in.o(.data+0x1304): undefined reference to `save_processor_state'
> arch/i386/kernel/built-in.o(.data+0x130a): undefined reference to `saved_context_esp'
....

> drivers/built-in.o: In function `kd_nosound':
> drivers/built-in.o(.text+0x420ea): undefined reference to `input_event'
> drivers/built-in.o(.text+0x4210c): undefined reference to `input_event'
....
> drivers/built-in.o: In function `kd_mksound':
> drivers/built-in.o(.text+0x421ab): undefined reference to `input_event'
> drivers/built-in.o: In function `kbd_bh':
> drivers/built-in.o(.text+0x42f07): undefined reference to `input_event'
> drivers/built-in.o(.text+0x42f2a): undefined reference to `input_event'
....
> drivers/built-in.o: In function `alloc_targets':
> drivers/built-in.o(.text+0x8d0a7): undefined reference to `vcalloc'
> drivers/built-in.o: In function `setup_indexes':
> drivers/built-in.o(.text+0x8dabb): undefined reference to `vcalloc'

