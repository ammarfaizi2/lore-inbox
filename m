Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVIHRDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVIHRDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVIHRDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:03:51 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:37642 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964931AbVIHRDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:03:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <E1EDP2d-000Jzx-00.s_goodenko-mail-ru@f27.mail.ru>
References: <E1EDP2d-000Jzx-00.s_goodenko-mail-ru@f27.mail.ru>
X-OriginalArrivalTime: 08 Sep 2005 17:03:43.0811 (UTC) FILETIME=[44D9C130:01C5B497]
Content-class: urn:content-classes:message
Subject: Re: msghdr problem in tcp_sendmsg
Date: Thu, 8 Sep 2005 13:03:43 -0400
Message-ID: <Pine.LNX.4.61.0509081257190.4800@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: msghdr problem in tcp_sendmsg
Thread-Index: AcW0l0T/DdVyGlS9Qfm3iYh+A7gUTQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Serge Goodenko" <s_goodenko@mail.ru>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Sep 2005, Serge Goodenko wrote:

> Hello!
>
> I trace the kernel networking code (ver 2.4.25).
> I send simple message (say, "hello") using simple client and see how
> tcp_sendmsg function works.
> And what I see is that there's NO my message (e.g. "hello") in the msghdr
> structure that tcp_sendmsg receives,
> e.g. in (char*)msg->msg_iov->iov_base, although debugger shows that
> msg->msg_iov->iov_len = 6, e.g. equals to "hello" message length (+1).
> Can anyone explain where I am wrong or what I do not understand?
>
> I am using the UML kernel and standard gdb debugger.
>

Did you build the proper 'struct iovec' ?  It gets a pointer to
your "hello", not the string itself as member iov_base.
If you look at this with the debugger, you need to dereference
this pointer. The string can be anywhere.

When receiving, that struct member gets a pointer to your buffer,
not the buffer itself. This means that struct iovec is always
the sizeof(void *) + sizeof(size_t) in length.

>
> Serge Goodenko,
> MIPT, Russia
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
