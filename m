Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWIMUcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWIMUcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWIMUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:32:15 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:23051 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751170AbWIMUcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:32:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 13 Sep 2006 20:32:07.0419 (UTC) FILETIME=[AE6C6CB0:01C6D773]
Content-class: urn:content-classes:message
Subject: Re: Assignment of GDT entries
Date: Wed, 13 Sep 2006 16:32:06 -0400
Message-ID: <Pine.LNX.4.61.0609131622570.28347@chaos.analogic.com>
In-Reply-To: <45086553.4090804@goop.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Assignment of GDT entries
thread-index: AcbXc654pNvOBZmrQVyLleMleLHHTg==
References: <450854F3.20603@goop.org> <Pine.LNX.4.61.0609131523390.28091@chaos.analogic.com> <45086553.4090804@goop.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andi Kleen" <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Zachary Amsden" <zach@vmware.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Michael A Fetterman" <Michael.Fetterman@cl.cam.ac.uk>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2006, Jeremy Fitzhardinge wrote:

> linux-os (Dick Johnson) wrote:
>> The entries 1 through 3 are used during the boot sequence, see
>> setup.S, search for "gdt" around line 983.
>>
>
> OK, but that's an early GDT used during boot, which shouldn't have any
> bearing on the GDT of the running kernel.
>
>> I can't imagine a reason why you'd want to do this.
>>
>
> I'm looking at packing all the descriptors together so they share a
> cache line, and therefore reduce the likelihood of a cache miss when
> loading a segment register.
>
>    J

You can certainly see if what you do works, but the last time I
looked, you need the linear address-space mapped by these to load
a new GDT, which needs to be untranslated in the TLB (unity mapped).
You can also search the kernel to see if they are required to
get into and get out of VM86 mode, for the dosemu users. Basically,
you need to change to what you want, see if it boots, then test
everything that might use these entries. It's scary and a lot of
work, probably the reason why nobody's bothered to muck with the
GDT. There is also a "specific" entry, used for pseudo-real mode
to access the BIOS for some APM stuff. I don't remember the number,
but that shouldn't be changed because the BIOS hard-codes it for
setting segments.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
