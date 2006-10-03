Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWJCCek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWJCCek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 22:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWJCCek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 22:34:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030249AbWJCCej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 22:34:39 -0400
Date: Mon, 2 Oct 2006 19:34:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <20061002191638.093fde85.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
 <p73venk2sjw.fsf@verdi.suse.de> <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org> <20061002191638.093fde85.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Randy Dunlap wrote:
> 
> I had no trouble reproducing the boot failure (on Pentium-M), then
> I tried TRACE_RESUME().  Nifty, but not really needed here since
> earlyprintk worked and contained the fault messages:
> 
> [   16.841784] math_emulate: 0060:c01062dd
> [   16.845579] Kernel panic - not syncing: Math emulation needed in kernel
> 
> But CONFIG_MATH_EMULATION=y, so what now?

The "Math emulation needed in kernel" message means that it was asked to 
emulate a kernel instruction, and it refuses to do so. The emulation is 
_not_ meant to be a real FPU, it simply looks like one to user space. A 
lot of things aren't really emulated (there's no global x87 context, for 
example: the context is all strictly per-process).

> Linus mentioned CPU feature bits.  The message log above didn't
> make me feel good about them.  Sure enough, we are playing with
> features before reading the feature bits.

Please look up address c01062dd in the system map (or just using gdb), 
that will tell you what code _tried_ to use the math coprocessor in kernel 
space.

			Linus
