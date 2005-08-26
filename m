Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVHZQIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVHZQIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVHZQIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:08:06 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:33295 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965088AbVHZQIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:08:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1132fcd605082608455081c769@mail.gmail.com>
References: <1132fcd605082608455081c769@mail.gmail.com>
X-OriginalArrivalTime: 26 Aug 2005 16:08:03.0730 (UTC) FILETIME=[56A31720:01C5AA58]
Content-class: urn:content-classes:message
Subject: Re: my view about schedule( ) and system call , right or wrong ?
Date: Fri, 26 Aug 2005 12:07:19 -0400
Message-ID: <Pine.LNX.4.61.0508261153490.10760@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: my view about schedule( ) and system call , right or wrong ?
Thread-Index: AcWqWFasybikQySlSxiCN28nYQXGRg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "lab liscs" <liscs.lab@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Aug 2005, lab liscs wrote:

> schedule( ) always runs in kernel space, therefore  the address of all
> elements used by schedule() is not virtual address but physical
> address.?


Wrong. All addresses accessed by the CPU(s) are virtual. All addresses
accessed by other devices, including DMA-masters are bus addresses, i.e.,
what a logic analyzer would see. In some architectures, the bus address is
the physical address but in others there is a separate address-space
for devices.

>
>
> analogous question also appears in system call , when I define myself
> syscall , for example:
>
> asmlinkage long sys_check(a,b ,c){
>
>        unsigned long buf;
>
>        ...........
> }
>
> then , the buf is stored in kernel space , that is , physical address .
>
>
> right or wrong
> -

Wrong. 'buf' is stored somewhere on the stack. That stack and its
data can be anywhere in physical memory. It is possible to find
it by searching through page-tables, but what you find will be
the bus address. Since the CPU deals only with virtual addresses,
i.e., translated addresses, that information is not normally useful.

Each user making a system call has a different stack that is
allocated for the purpose of making that system call. The user
can't make the system call on the user's stack because the user
could trash that and bring down the system.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
