Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWELOmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWELOmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWELOmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:42:21 -0400
Received: from spirit.analogic.com ([204.178.40.4]:41488 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932103AbWELOmU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:42:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 14:42:19.0015 (UTC) FILETIME=[45232170:01C675D2]
Content-class: urn:content-classes:message
Subject: Re: Segfault on the i386 enter instruction
Date: Fri, 12 May 2006 10:42:18 -0400
Message-ID: <Pine.LNX.4.61.0605121033030.9091@chaos.analogic.com>
In-Reply-To: <200605121720.13820.vda@ilport.com.ua>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Segfault on the i386 enter instruction
Thread-Index: AcZ10kVJBrBaxVsKTBur6DMaoBYsow==
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <Pine.LNX.4.61.0605121003450.9012@chaos.analogic.com> <200605121720.13820.vda@ilport.com.ua>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Tomasz Malesinski" <tmal@mimuw.edu.pl>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Denis Vlasenko wrote:

> On Friday 12 May 2006 17:07, linux-os (Dick Johnson) wrote:
>>> 	.file	"a.c"
>>> 	.version	"01.01"
>>> gcc2_compiled.:
>>> .section	.rodata
>>> .LC0:
>>> 	.string	"asdf\n"
>>> .text
>>> 	.align 4
>>> .globl main
>>> 	.type	 main,@function
>>> main:
>>> 	enter $10008, $0
>>> #	pushl %ebp
>>> #	movl %esp,%ebp
>>> #	subl $10008,%esp
>>> 	addl $-12,%esp
>>          ^^^^^^^^^^^^^^____________ WTF
>>          adding a negative number is subtracting that positive value.
>>          You just subtracted 0xfffffff3 (on a 32-bit machine) from
>>          the stack pointer. It damn-well better seg-fault!
>
> No. Try it yourself.
> --
> vda

It doesn't matter. It means that you still own the space there
(it's mapped into your process). The code is bogus, broken beyond
all repair. It has nothing to do with 'enter' it has to do with
putting the stack pointer (wrapping it) to somewhere it shouldn't
be. The stack pointer is normally around 0xafff0000. It just got
wrapped down past zero up to fafff00d, then stuff got pushed
onto it for the call.

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
