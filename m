Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWFHKYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWFHKYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFHKYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:24:43 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:35848 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932141AbWFHKYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:24:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 08 Jun 2006 10:24:39.0382 (UTC) FILETIME=[BFA19760:01C68AE5]
Content-class: urn:content-classes:message
Subject: Re: Interrupts disabled for too long in printk
Date: Thu, 8 Jun 2006 06:24:36 -0400
Message-ID: <Pine.LNX.4.61.0606080618520.29263@chaos.analogic.com>
In-reply-to: <9e4733910606071935o5f42f581g6392d5a23897fb09@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interrupts disabled for too long in printk
Thread-Index: AcaK5b+oi/tabty3SaW9xU8o/diKyw==
References: <20060603111934.GA14581@Krystal> <9e4733910606071837l4e81c975t8d531ed9810af60f@mail.gmail.com> <20060608023102.GA22022@Krystal> <9e4733910606071935o5f42f581g6392d5a23897fb09@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Mathieu Desnoyers" <compudj@krystal.dyndns.org>,
       <linux-kernel@vger.kernel.org>, <ltt-dev@shafik.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jun 2006, Jon Smirl wrote:

> On 6/7/06, Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
>> * Jon Smirl (jonsmirl@gmail.com) wrote:
>>> You can look at this problem from the other direction too. Why is it
>>> taking 15ms to get between the two points? If IRQs are off how is the
>>> serial driver getting interrupts to be able to display the message? It
>>> is probably worthwhile to take a look and see what the serial console
>>> driver is doing.
>>
>> Hi John,
>>
>> The serial port is configured at 38000 bauds. It can therefore transmit 4800
>> bytes per seconds, for 72 characters in 15 ms. So the console driver would be
>> simply busy sending characters to the serial port during that interrupt
>> disabling period.
>
> Why can't the serial console driver record the message in a buffer at
> the point where it is being called with interrupts off, and then let
> the serial port slowly print it via interupts? It sounds to me like
> the serial port is being driven in polling mode.
>
>>
>> Mathieu
>>
>> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
>> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

Probably because there is no buffer that is big enough! If the character
source (a call to printk()) can generate N characters per second, but
the UART can only send out N-1, then the buffer will fill up at which
time software will wait until the UART is ready for the next character,
effectively becoming poll-mode with a buffer full of characters as
backlog.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
