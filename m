Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265251AbSJaTyE>; Thu, 31 Oct 2002 14:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265252AbSJaTyE>; Thu, 31 Oct 2002 14:54:04 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:61194 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S265251AbSJaTyC>; Thu, 31 Oct 2002 14:54:02 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200210311952.g9VJqZs9014839@wildsau.idv.uni.linz.at>
Subject: Re: need h/e/l/p:  PM -> RM in machine_real_start
In-Reply-To: <Pine.LNX.3.95.1021031112938.12292A-100000@chaos.analogic.com> from "Richard B. Johnson" at "Oct 31, 2 11:50:39 am"
To: root@chaos.analogic.com
Date: Thu, 31 Oct 2002 20:52:35 +0100 (MET)
Cc: kernel@wildsau.idv.uni.linz.at, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Linux leaves the BIOS area alone, but interrupts may not be directly
> usable because Linux loads a different IDT and reprograms the IO-APIC,
> which is used in place of the interrupt controller if it exists.
> 
> You need to reload the IDT once in real-mode. Documentation states
> that it is "ignored", but the reload is necessary to get the default
> interrupt-table to work. I think you can just reload with any memory
> operand (reload junk). If you were transitioning from real to 32-bit
> and back, you would save the current one "SIDT", before loading the
> 32-bit one "LIDT". Since you don't know where the previous one was saved,
> (if ever) you can't reload it.

well, reloading the idt is already done in "machine_real_start", look
at line 255 (definition) and line 336 (execution).

what I've never heard of is the IO-APIC (allthough there's a file
named io_apic.c just in the same directory). there surely is a way to
"get rid of it" and have the 8259(A) or the emulating chipset(?) take
over again. do you have, or do you know where I can find, documention
about the IO-APIC? probably that's the reason why I don't see any
hardware interrupts.
 
> Whatever interrupt controllers are used, they are programmed differently
> in Linux than the BIOS expects. You would need to reprogram them, not
> difficult, just a few instructions (check free-BIOS) or other references.

I've been afraid of that :-) okay ... I'll try. So far, I've already
been checking linux-bios (didn't help much) and OpenBIOS. Hm, hm!
It looks like (just as I ask google for FreeBIOS) that FreeBIOS is
another different project.
 
> Check free-BIOS

thanks for the hint. It looks promising.

herbert

