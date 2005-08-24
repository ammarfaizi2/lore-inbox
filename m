Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbVHXTsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVHXTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVHXTsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:48:25 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30217 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751493AbVHXTsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:48:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200508242132.52730.oliver@neukum.org>
References: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com> <Pine.LNX.4.61.0508241347020.30497@chaos.analogic.com> <200508242132.52730.oliver@neukum.org>
X-OriginalArrivalTime: 24 Aug 2005 19:48:20.0138 (UTC) FILETIME=[C76768A0:01C5A8E4]
Content-class: urn:content-classes:message
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 15:47:37 -0400
Message-ID: <Pine.LNX.4.61.0508241542110.31690@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question on memory barrier
Thread-Index: AcWo5MdwOORqqVIbTeOlei7viHDcxA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Aug 2005, Oliver Neukum wrote:

> Am Mittwoch, 24. August 2005 20:22 schrieb linux-os (Dick Johnson):
>>> sorry but I'm not sure to understand you...Do you mean that the first write
>>> into reg_a pointer will be completed before the second write because they're
>>> separated by a (;) ?
>>
>> Yes. The compiler must make sure that every effect of all previous
>> code and all side-effects are complete at a "sequence-point". There
>> are several sequence-points and the most obvious is a ";".
>
> What the compiler may or may not generate is a little beside the point.
> You have no guarantee that the CPU will execute these instructions in
> the order given. If you need ordered writes use the appropriate barriers,
> eg. wmb();

You mean these??

system.h: * For now, "wmb()" doesn't actually do anything, as all
system.h: * Some non intel clones support out of order store. wmb() ceases to be a
system.h:#define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
system.h:#define wmb()	__asm__ __volatile__ ("": : :"memory")
system.h:#define smp_wmb()	wmb()
system.h:#define smp_wmb()	barrier()
system.h:#define set_wmb(var, value) do { var = value; wmb(); } while (0)

The "future" black magic that currently does nothing?????

> If this is PCI you also need to worry about the bridge caching. You
> need to do dummy reads.
>

And you never even bothered to read what I said about that???
The write ORDER will NOT change. Period. It's a FIFO. Writes
may be cached for awhile. You can force the writes, IN ORDER,
by doing a dummy read.


Too many people like to pretend that there is some black magic.
It works like it's supposed to. If it doesn't work, you have a bug.


> 	Regards
> 		Oliver
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
