Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWDMP4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWDMP4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWDMP4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:56:41 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:17415 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750953AbWDMP4l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:56:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
x-originalarrivaltime: 13 Apr 2006 15:56:38.0628 (UTC) FILETIME=[D94B5240:01C65F12]
Content-class: urn:content-classes:message
Subject: Re: select takes too much time
Date: Thu, 13 Apr 2006 11:56:37 -0400
Message-ID: <Pine.LNX.4.61.0604131141140.6964@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: select takes too much time
Thread-Index: AcZfEtlxfAWu74w0SzeF5Pj3fsONOg==
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Apr 2006, Ram Gupta wrote:

> I am using select with a timeout value of 90 ms. But for some reason
> occasionally  it comes out of select after more than one second . I
> checked the man page but it does not help in concluding if this is ok
> or not. Is this expected  or it is a bug. Most of this time is
> consumed in   schedule_timeout . I am using 2.5.45 kernel but I
> believe the same would  be the true for the latest kernel too. Any
> thoughts or suggestion are welcome.
>
> Thanks
> Ram Gupta

This may point out a problem with a driver that is polling
inside a spin-lock or other places where interrupts are disabled.
It is unlikely that select() or poll() are at fault. I have a
server that takes high-speed DAS data and sends it over the
network as UDP packets. The server sleeps in poll() until data
are ready, then wakes up and sends the data. This happens 4,000
times per second and has been tested to 10,000 times per second.
The HZ value on that server is 1024. So, poll() and select()
can be fast in response to a 'wake_up_interruptible()' inside
a driver. They should be equally fast to a normal timeout.

Make sure that your 'struct timeval' is initialized prior to every
call to select(). Linux writes remaining time back into that
structure! Also make sure you are using the right structure,
'struct timeval', not 'struct timespec'!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
