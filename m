Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWELOHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWELOHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWELOHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:07:52 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58129 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932085AbWELOHv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:07:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 14:07:51.0157 (UTC) FILETIME=[74990A50:01C675CD]
Content-class: urn:content-classes:message
Subject: Re: Segfault on the i386 enter instruction
Date: Fri, 12 May 2006 10:07:50 -0400
Message-ID: <Pine.LNX.4.61.0605121003450.9012@chaos.analogic.com>
In-Reply-To: <20060512131654.GB2994@duch.mimuw.edu.pl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Segfault on the i386 enter instruction
Thread-Index: AcZ1zXSgzG6/PoLNS9+nFYQ8EGtOCg==
References: <20060512131654.GB2994@duch.mimuw.edu.pl>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Tomasz Malesinski" <tmal@mimuw.edu.pl>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Tomasz Malesinski wrote:

> The code attached below segfaults on the enter instruction. It works
> when a stack frame is created by the three commented out
> instructions and also when the first operand of the enter instruction
> is small (less than about 6500 on my system).
>
> AFAIK, the only difference between creating a stack frame with the
> enter instruction or push/mov/sub is that enter checks if the new
> value of esp is inside the stack segment limit.
>
> I tested it on a vanilla kernel 2.4.26 on Intel Celeron and also on
> probably non-vanilla 2.6.16.13 running on 3 dual core AMD Opteron,
> quite busy, server. It is working in 32-bit mode. Interestingly, on
> the second machine sometimes the program worked correctly.
>
> I am not subscribed to the list. Please cc replies to me.
>
>
> 	.file	"a.c"
> 	.version	"01.01"
> gcc2_compiled.:
> .section	.rodata
> .LC0:
> 	.string	"asdf\n"
> .text
> 	.align 4
> .globl main
> 	.type	 main,@function
> main:
> 	enter $10008, $0
> #	pushl %ebp
> #	movl %esp,%ebp
> #	subl $10008,%esp
> 	addl $-12,%esp
         ^^^^^^^^^^^^^^____________ WTF
         adding a negative number is subtracting that positive value.
         You just subtracted 0xfffffff3 (on a 32-bit machine) from
         the stack pointer. It damn-well better seg-fault!


> 	pushl $.LC0
> 	call printf
> 	addl $16,%esp
> .L2:
> 	leave
> 	ret
> .Lfe1:
> 	.size	 main,.Lfe1-main
> 	.ident	"GCC: (GNU) 2.95.4 20011002 (Debian prerelease)"
>
> --
> Tomek Malesinski
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
