Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWJETus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWJETus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWJETus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:50:48 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:29189 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751069AbWJETur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:50:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 05 Oct 2006 19:50:26.0894 (UTC) FILETIME=[811516E0:01C6E8B7]
Content-class: urn:content-classes:message
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Thu, 5 Oct 2006 15:50:26 -0400
Message-ID: <Pine.LNX.4.61.0610051535420.29755@chaos.analogic.com>
In-Reply-To: <200610052059.11714.mb@bu3sch.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Really good idea to allow mmap(0, FIXED)?
thread-index: Acbot4EcJCG2Ag5HSQ2T6jCNjkeNPg==
References: <200610052059.11714.mb@bu3sch.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michael Buesch" <mb@bu3sch.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Oct 2006, Michael Buesch wrote:

> Hi,
>
> This question has already been discussed here in the past, but
> we did not come to a good result. So I want to ask the question again:

Meaning that you didn't get the result you wanted.

> Is is really a good idea to allow processes to remap something
> to address 0?

Of course you must be able to remap the physical address 0 (offset
zero in the whole machine), and if your 'hint' to mmap() in
user code is a 0, it can (it's allowed) to return a pointer
initialized to zero --and it's your fault if it's incompatible
with some 'C' runtime libraries.

It is a perfectly good address and the fact that malloc() returns
(void *)0 upon failure, does not qualify it as king or some other
ruler. In fact, mmap() returns (void *)-1 upon failure.

> I say no, because this can potentially be used to turn rather harmless
> kernel bugs into a security vulnerability.
>

Can't. The kernel doesn't check for NULL for user access, it
simply traps if the address is bad. That's why we have copy/to/from_user()
for user-mode access.

> Let's say we have some kernel NULL pointer dereference bug somewhere,
> that's rather harmless, if it happens in process context and
> does not leak any resources on segfaulting the triggering app.
> So the worst thing that happens is a crashing app. Yeah, this bug must
> be fixed. But my point is that this bug can probably be used to
> manipulate the way the kernel works or even to inject code into
> the kernel from userspace.
>

Can't.

> Attached to this mail is an example. The kernel module represents
> the actual "kernel-bug". Its whole purpose in this example is to
> introduce a user-triggerable NULL pointer dereference.
> Please stop typing now, if you are typing something like
> "If you can load a kernel module, you have access to the kernel anyway".
> This is different. We always _had_ and most likely _have_ NULL pointer
> dereference bugs in the kernel.
>
> The example programm injects a magic value 0xB15B00B2 into the
> kernel, which is printk'ed on success.

Well this shows nothing interesting.

>
> In my opinion, this should be forbidden by disallowing mmapping
> to address 0. A NULL pointer dereference is such a common bug, that
> it is worth protecting against.
> Besides that, I currently don't see a valid reason to mmap address 0.
>

That's where the real-mode BIOS table is. Who says that I can't
look at any piece of physical memory I want. It's my machine.

The whole concept of a NULL pointer is simply an artifact of
incorrect engineering.

> Comments?
>
> --
> Greetings Michael.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
