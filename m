Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWBBQre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWBBQre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBBQre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:47:34 -0500
Received: from spirit.analogic.com ([204.178.40.4]:18192 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932154AbWBBQrd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:47:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.61.0602021047350.20707@chaos.analogic.com>
X-OriginalArrivalTime: 02 Feb 2006 16:47:32.0742 (UTC) FILETIME=[5CC5A260:01C62818]
Content-class: urn:content-classes:message
Subject: Re: changing physical page
Date: Thu, 2 Feb 2006 11:47:32 -0500
Message-ID: <Pine.LNX.4.61.0602021138001.21010@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: changing physical page
Thread-Index: AcYoGFzpgr9JOLreQK+nmKosY2IPvg==
References: A<loom.20060202T160457-366@post.gmane.org> <Pine.LNX.4.61.0602021047350.20707@chaos.analogic.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "yipee" <yipeeyipeeyipeeyipee@yahoo.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Feb 2006, Richard B. Johnson wrote:

> On Thu, 2 Feb 2006, yipee wrote:
>
>> Hi,
>>
>> On a system running without swap, can there be a case in which the
>> kernel decides to move (from one physical page to another)
>> a dynamically-allocated page owned by a user program?
>>
>> Thanks,
>> y
>
> <yipeeyipeeyipeeyipee@yahoo.com>
>
> I'll bet this is a one-shot-deal so you can tell somebody you
> posted to the linux-kernel list!
>
> The answer is absolutely, positively, maybe, especially on
> Tuesdays.

I got the previous reply but accidentially deleted it. The
kernel may try to create some contiguous pages for DMA or
other usage. If some page in your task can be switched to
make that continuous allocation, it might be.

If your program(s) rely upon being in some physical location,
they are broken. Even with mlockall(), you just keep them
where they are, not where you'd like them to be. If you
are trying to DMA into/out-of user-space, there is only
ONE way to do it. Your driver allocates DMA-able pages and
your code mmaps() it into user-space. That way, the page(s)
are always present and have the right attributes. If you
malloc() something, then try to "convert" in the kernel
through your driver, the code's broken.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
To unsubscribe


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
