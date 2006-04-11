Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWDKNLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDKNLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 09:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWDKNLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 09:11:39 -0400
Received: from spirit.analogic.com ([204.178.40.4]:64777 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750813AbWDKNLi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 09:11:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060411130024.GA3364@gsy2.lepton.home>
x-originalarrivaltime: 11 Apr 2006 13:11:36.0908 (UTC) FILETIME=[769540C0:01C65D69]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] asm-i386/atomic.h: local_irq_save should be used instead of local_irq_disable
Date: Tue, 11 Apr 2006 09:11:31 -0400
Message-ID: <Pine.LNX.4.61.0604110907060.29348@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] asm-i386/atomic.h: local_irq_save should be used instead of local_irq_disable
Thread-Index: AcZdaXa9LTkaBEEATNeB2gGPL/NEBg==
References: <20060411130024.GA3364@gsy2.lepton.home>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "lepton" <ytht.net@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2006, lepton wrote:

> Hi!
> 	When I read the kernel codes, I think this perhaps be a little
> 	bug, What do you think about this?
>
> 	See the following patch (against 2.6.16.3)
>
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
>
> diff -pru linux-2.6-curr.orig/include/asm-i386/atomic.h linux-2.6-curr.lepton/include/asm-i386/atomic.h
> --- linux-2.6-curr.orig/include/asm-i386/atomic.h	2006-04-06 09:21:53.000000000 +0800
> +++ linux-2.6-curr.lepton/include/asm-i386/atomic.h	2006-04-11 20:47:39.000000000 +0800
> @@ -189,6 +189,7 @@ static __inline__ int atomic_add_return(
> {
> 	int __i;
> #ifdef CONFIG_M386
> +	unsigned long flags;
> 	if(unlikely(boot_cpu_data.x86==3))
> 		goto no_xadd;
> #endif
> @@ -202,10 +203,10 @@ static __inline__ int atomic_add_return(
>
> #ifdef CONFIG_M386
> no_xadd: /* Legacy 386 processor */
> -	local_irq_disable();
> +	local_irq_save(flags);
> 	__i = atomic_read(v);
> 	atomic_set(v, i + __i);
> -	local_irq_enable();
> +	local_irq_restore(flags);
> 	return i + __i;
> #endif
> }

You need to disable interrupts on the local CPU! So, you would need
to save the flags, disable the interrupts, then restore the flags
after the atomic operations.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
