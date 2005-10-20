Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVJTNgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJTNgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJTNgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:36:13 -0400
Received: from spirit.analogic.com ([204.178.40.4]:3336 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932168AbVJTNgM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:36:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <64c763540510200612s1e3aa7dvefdac28dd8d24106@mail.gmail.com>
References: <64c763540510200612s1e3aa7dvefdac28dd8d24106@mail.gmail.com>
X-OriginalArrivalTime: 20 Oct 2005 13:36:07.0047 (UTC) FILETIME=[3963E970:01C5D57B]
Content-class: urn:content-classes:message
Subject: Re: Increase priority of a workqueue thread ?
Date: Thu, 20 Oct 2005 09:36:06 -0400
Message-ID: <Pine.LNX.4.61.0510200928180.8691@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Increase priority of a workqueue thread ?
Thread-Index: AcXVezl+zSTHNWpqRiOd7x4KMEs1Lg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Block Device" <blockdevice@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Block Device wrote:

> Hi,
>    I am using a custom workqueue thread in my module. How do I increase the
> priority of the workqueue threads ?
> I've seen that each workqueue contains an array of per-cpu structures
> which has a
> task_struct of the thread on a particular cpu. Since these threads are
> created from keventd
> I think they'll have the same priority as keventd.  Also the per-cpu
> structure is something which is private to the workqueue
> implementation. Directly using it (from my driver) to increase the
> priority of the workqueue doesnt seem correct to me. Is there any
> interface or standard way of changing the priority of a workqueue.
>
> Thanks
> BD

I don't think you want to increase the priority of keventd.
You need to create a seperate kernel thread for your module's
work. That thread's priority can be set with set_user_nice()...

 	set_user_nice(current, -19);

Older kernels required:

 	task_lock(current);
         current->nice = -19;
         task_unlock(current);

The kernel thread can set this up when it is first started.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
