Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVIITU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVIITU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVIITU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:20:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:44559 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030298AbVIITU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:20:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1126291900.2725.4.camel@syd.mkgnu.net>
References: <1126122068.2744.20.camel@syd.mkgnu.net> <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com> <1126127233.2743.25.camel@syd.mkgnu.net> <Pine.LNX.4.61.0509071826180.4951@chaos.analogic.com> <1126291900.2725.4.camel@syd.mkgnu.net>
X-OriginalArrivalTime: 09 Sep 2005 19:20:50.0585 (UTC) FILETIME=[96CD9890:01C5B573]
Content-class: urn:content-classes:message
Subject: Re: [ham] Re: Gracefully killing kswapd, or any kernel thread
Date: Fri, 9 Sep 2005 15:20:50 -0400
Message-ID: <Pine.LNX.4.61.0509091513310.5663@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ham] Re: Gracefully killing kswapd, or any kernel thread
Thread-Index: AcW1c5bUt3tbHF7HQVW1RlBulqU+IQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kristis Makris" <kristis.makris@asu.edu>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Sep 2005, Kristis Makris wrote:

> On Wed, 2005-09-07 at 18:36 -0400, linux-os (Dick Johnson) wrote:
>> On Wed, 7 Sep 2005, Kristis Makris wrote:
>>
>>>> To kill a kernel thread, you need to make __it__ call exit(). It must be
>
> I was able to make it call do_exit(). However, even if I recompile a
> kernel to have kswapd issued a do_exit(), I still see from ps:
>
> root         4  0.0  0.0     0    0 ?        Z    06:20   0:00 [kswapd
> <defunct>]
>
> Why isn't the task_struct for it gone ?
>

Because it's now defunct <Z>, a zombie, waiting for somebody to
reap its return status. You are almost there, you need to issue
the kernel equivalent of waitpid() (sys_waitpid) to grab that
status and throw it away. That's what the code I showed you
did when it would shut down and remove a module that had
a kernel thread.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
