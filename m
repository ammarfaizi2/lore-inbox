Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVIWTFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVIWTFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVIWTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:05:44 -0400
Received: from spirit.analogic.com ([204.178.40.4]:61195 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751155AbVIWTFo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:05:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <94e67edf0509231053181289a9@mail.gmail.com>
References: <94e67edf0509231053181289a9@mail.gmail.com>
X-OriginalArrivalTime: 23 Sep 2005 19:05:42.0783 (UTC) FILETIME=[CB7E80F0:01C5C071]
Content-class: urn:content-classes:message
Subject: Re: Placing a kernel module at a known fixed address
Date: Fri, 23 Sep 2005 15:05:42 -0400
Message-ID: <Pine.LNX.4.61.0509231455390.20915@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Placing a kernel module at a known fixed address
Thread-Index: AcXAccuk/Yc8/fWHSxCiFir3Y5dbiA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sreeni" <sreeni.pulichi@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Sep 2005, Sreeni wrote:

> Hi,
>
> I have a kernel module on Montavista Linux (ARM-MontavistaLinux-XIP).
> My application demands me placing/running this kernel module at a known
> fixed virtual/physical address. I can make this module a static one.
> For this I need the following -

Your application is therefore totally and completely broken by
definition.

When you need to access certain physical offsets or bus addresses
from user-space, we use mmap().

>
> ***** Placing text,data, heap, stack at a known fixed address *****
>

You can place your code and your data at some fixed (offset) by
using different sections (i.e., .section .foo), then having
the linker do the fixups. You CANNOT move the .text section or
the .bss or the .data sections and have anything work. You also
can't put the stack at some physical location because there are
different stacks in use when your module is accessed (each
caller has its own "kernel" stack).

> May I know the possible ways of achieving this. I have tried playing
> around arch/arm/vmlinux.lds linker script file. But when i try to force
> the linker to place my module at a particular address, the System.map
> shows me the correct address but the kernel image size is getting very
> large (when add 10 words of my module, kernel image size is getting
> increased by 800KB).
>
> Any help in this is highly appreciated.
>
> Thanks
> Sreeni
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
