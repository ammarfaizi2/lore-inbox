Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWFIMwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWFIMwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 08:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWFIMwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 08:52:13 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:54279 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965244AbWFIMwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 08:52:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 09 Jun 2006 12:52:11.0004 (UTC) FILETIME=[8605ABC0:01C68BC3]
Content-class: urn:content-classes:message
Subject: Re: Discovering select(2) parameters from driver's poll method
Date: Fri, 9 Jun 2006 08:52:10 -0400
Message-ID: <Pine.LNX.4.61.0606090841460.2163@chaos.analogic.com>
In-reply-to: <20060609114940.01442490169@uekae.uekae.gov.tr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Discovering select(2) parameters from driver's poll method
Thread-Index: AcaLw4YRt071GpdpRiqDJW6LCPiUvA==
References: <20060609114940.01442490169@uekae.uekae.gov.tr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ozan Eren Bilgen" <oebilgen@uekae.tubitak.gov.tr>
Cc: "Linux e-posta listesi" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jun 2006, Ozan Eren Bilgen wrote:

> *** Please CC me your responses ***
>
> Hi,
>
> I am writing a device driver and I have problem with poll method.  For
> some reason, I need learn the timeout and descriptor sets of select(2)
> call.  Other words to say, if the user space process calls:
>
> 	select(n, &readfds, NULL, &exceptionfds, &tv);
>
> With the help of my poll implementation in device driver, I want to
> learn that only the write fds is empty.  I am also interested in the
> value of timeout parameter.  Please let me know if this is possible.
>

If you want to know, your driver is HORRIBLY BROKEN beyond any
repair.

The kernel handles poll in a POSIX correct manner. There is a
link into your device driver which is __not__ directly attached
to the user's poll call, even though its name is similar. Your
driver must properly signal the kernel, with the proper wake-up
call, after the proper bits are put into the poll variable, any
time anything has changed.

If or when user action (read, write, etc.) changes those bits,
then they must also be updated -- and the kernel again signaled
that those bits have changed.

> By the way, I checked out some Linux device drivers, which are
> implemented poll method, and related books like LDD.  Everywhere,
> poll_wait is called for both read and write queues, without taking the
> select(2) call's parameters into account.  For example it still waits
> for the read queue although the select call was looking only for write
> fds.  My second question is, why a poll method queries all the queues,
> instead of querying only the necessary one?

Wrong. The kernel calls the poll function in the driver. The user code
does not call this directly. The kernel knows what fds are active
for whatever. Your driver **MUST NOT**!

>
> Thank you in advance,
>
> Ozan Eren Bilgen

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
