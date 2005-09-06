Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVIFSmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVIFSmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVIFSmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:42:05 -0400
Received: from spirit.analogic.com ([208.224.221.4]:9235 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750764AbVIFSmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:42:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: A<dfkjav$lmd$1@sea.gmane.org>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <1125854398.23858.51.camel@localhost.localdomain> <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org> <58d0dbf10509061005358dce91@mail.gmail.com> A<dfkjav$lmd$1@sea.gmane.org>
X-OriginalArrivalTime: 06 Sep 2005 18:42:02.0936 (UTC) FILETIME=[AC2D4B80:01C5B312]
Content-class: urn:content-classes:message
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 14:42:02 -0400
Message-ID: <Pine.LNX.4.61.0509061431440.4277@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: i386: kill !4KSTACKS
Thread-Index: AcWzEqw02hA+0pGWRhKcCDzImHlmkQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Giridhar Pemmasani" <giri@lmc.cs.sunysb.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Sep 2005, Giridhar Pemmasani wrote:

> Jan Kiszka wrote:
>
>> The only way I see is to switch stacks back on ndiswrapper API entry.
>> But managing all those stacks correctly is challenging, as you will
>> likely not want to create a new stack on each switching point. Rather,
>
> This is what I had in mind before I saw this thread here. I, in fact, did
> some work along those lines, but it is even more complicated than you
> mentioned here: Windows uses different calling conventions (STDCALL,
> FASTCALL, CDECL) so switching stacks by copying arguments/results gets
> complicated. So I gave up on that approach. For X86-64 drivers we use
> similar approach, but for that there is only one calling convention and we
> don't need to switch stacks, but reshuffle arguments on stack / in
> registers.
>
> I am still hoping that Andi's approach is possible (I don't understand how
> we can make kernel see current info from private stack).
>
> Giri

You can't without copying info from one stack to another. There are
other problems, also, the only place you can get data for a stack in the
kernel dynamically is from kmalloc(GFP_ATOMIC). Other kmalloc() data
are paged which may (will) cause a double-fault if you use it for
a stack. You are not going to get much more than a page of GFP_ATOMIC
data so you can't really make a larger stack than the existing
process/kernel stack.

I have tried to just allocate data when a module is installed (in the
.bss or .data segments as static data). Unfortunately, some kernel
code traps this as a "triple fault" if I try to use it for a stack,
even though the kernel segments for ES, SS, DS, all point to the
same area(s).

I think the purpose of compressing the stack was to get rid of
NDIS, but that's only a theory. Currently, they did a good job
of it!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
