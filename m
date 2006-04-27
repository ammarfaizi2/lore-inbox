Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWD0OW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWD0OW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWD0OW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:22:56 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:56328 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965122AbWD0OWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:22:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200604271558.46212.mb@bu3sch.de>
X-OriginalArrivalTime: 27 Apr 2006 14:22:52.0000 (UTC) FILETIME=[11588600:01C66A06]
Content-class: urn:content-classes:message
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 10:22:51 -0400
Message-ID: <Pine.LNX.4.61.0604271006500.4040@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C++ pushback
thread-index: AcZqBhFixMrZ5MEsQi6VyeL3lkp2qA==
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44505891.8080300@yahoo.com> <200604271558.46212.mb@bu3sch.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michael Buesch" <mb@bu3sch.de>
Cc: "Roman Kononov" <kononov195-far@yahoo.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Apr 2006, Michael Buesch wrote:

> On Thursday 27 April 2006 07:37, you wrote:
>>> If C++ doesn't work
>>> properly for a simple and clean example like struct list_head, why
>>> should we assume that it's going to work any better for more complicated
>>> examples in the rest of the kernel?  Whether or not some arbitrary
>>> function is inlined should be totally orthogonal to adding type-checking.
>>
>> You misunderstood something. The struct list_head is indeed a perfect
>> type to be templatized with all members inlined. C++ works properly in
>> this case.
>
> I am not sure, if you can relieably use the container_of() magic
> in C++. Do you know?
> I have a C++ linked list example here:
> http://websvn.kde.org/trunk/extragear/security/pwmanager/pwmanager/libpwmanager/linkedlist.h?rev=421676&view=markup
> It is very simple and in some points different from the kernel
> linked lists. It has a separate "head" and "entry" class and it stores
> a pointer to the entry (the kernel linked lists would use container_of()
> instead)
>
>> Nothing works by default. I did not say that static constructors are
>> advantageous. I said that it is easy for the kernel to make static
>> constructors working. Global variables should be deprecated anyway.
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Any operating system kernel needs globals.

1	CPUs require structures existing in physical memory. Such
structures are page-tables, interrupt descriptor tables, and global
descriptor tables.

2	The first element (at least) of a linked-list, accessed by
more than one task needs a global anchor-point.

3	The first element (at least) of an interrupt dispatch table
needs to be global. More efficient code makes the whole table
global for efficient indexing.

4	The first element (at least) of a kernel function request
dispatch table needs to be global. More efficient code makes the
whole table global.

5	Hardware, a.k.a., PCI bus access is global. There is no
way around that. If the operating system interfaces with hardware,
it interfaces with global objects. They might be artifically
"private", but still global.

6	Spin-lock and semaphore variables need to be global, existing
in non-paged memory. Again, they might be artifically "private", but
are still global.

This is just a handful of examples. If you are going to use a tool
to make an O.S., you need to use the correct tool(s).

> You are kidding. Must be...
>
[SNIPPED Rest...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
