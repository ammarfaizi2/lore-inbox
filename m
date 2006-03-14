Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWCNVLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWCNVLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWCNVLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:11:39 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:53002 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932457AbWCNVLi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:11:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <31016.1142368317@warthog.cambridge.redhat.com>
x-originalarrivaltime: 14 Mar 2006 21:11:36.0985 (UTC) FILETIME=[E1334090:01C647AB]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
Date: Tue, 14 Mar 2006 16:11:36 -0500
Message-ID: <Pine.LNX.4.61.0603141601550.9216@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Document Linux's memory barriers [try #4] 
Thread-Index: AcZHq+E86K9IKhfUQe6G7AOSL2AFkw==
References: <878xrecypp.fsf@javad.com>  <16835.1141936162@warthog.cambridge.redhat.com>  <31016.1142368317@warthog.cambridge.redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Howells" <dhowells@redhat.com>
Cc: "Sergei Organov" <osv@javad.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2006, David Howells wrote:

> Sergei Organov <osv@javad.com> wrote:
>
>> "You can prevent an `asm' instruction from being deleted by writing the
>> keyword `volatile' after the `asm'. [...]
>> The `volatile' keyword indicates that the instruction has important
>> side-effects.  GCC will not delete a volatile `asm' if it is reachable.
>> (The instruction can still be deleted if GCC can prove that
>> control-flow will never reach the location of the instruction.)  *Note
>> that even a volatile `asm' instruction can be moved relative to other
>> code, including across jump instructions.*"
>
> Ummm... If "asm volatile" statements don't form compiler barriers, then how do
> you specify a compiler barrier? Or is that what the "memory" bit in:
>
> 	#define barrier() __asm__ __volatile__("": : :"memory")
>
> does?
>
> David

Yeh. This is the problem (restated) that I mentioned the other
day when you must do a dummy read of the PCI/Bus to flush all
the writes, to some variable that gcc can't decide isn't
important. That's why (void)readl(PCI_STATUS) won't work
(with gcc 3.3.3 anyway). Some assignment needs to be made
to something gcc thinks is important or it might be moved or
removed altogether.

  	#define barrier() __asm__ __volatile__("": : :"memory")

Just tells the compiler that memory may have been modified. Therefore,
it will re-read any variables that might be setting in registers, before
it uses them. This is very useful since it basically makes all variables
temporarily "volatile" in its effects.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
