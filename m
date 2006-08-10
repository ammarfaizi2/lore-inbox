Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWHJSch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWHJSch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWHJSch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:32:37 -0400
Received: from spirit.analogic.com ([204.178.40.4]:1548 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751267AbWHJScg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:32:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 10 Aug 2006 18:32:30.0625 (UTC) FILETIME=[56AD1110:01C6BCAB]
Content-class: urn:content-classes:message
Subject: Re: Network compatibility and performance
Date: Thu, 10 Aug 2006 14:32:30 -0400
Message-ID: <Pine.LNX.4.61.0608101419480.4689@chaos.analogic.com>
In-Reply-To: <20060810111433.476a74d6@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network compatibility and performance
Thread-Index: Aca8q1a04QLbyev2TlS/KEzHAX4kIw==
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com><20060810102841.55efa78a@localhost.localdomain><Pine.LNX.4.61.0608101339310.4577@chaos.analogic.com> <20060810111433.476a74d6@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2006, Stephen Hemminger wrote:

> On Thu, 10 Aug 2006 14:09:34 -0400
> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:
>
>>
>> On Thu, 10 Aug 2006, Stephen Hemminger wrote:
>>
>>> On Thu, 10 Aug 2006 11:34:23 -0400
>>> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:
>>>
>>>>
>>>> Hello,
>>>>
>>>> Network throughput is seriously defective with linux-2.6.16.24
>>>> if the length given to 'write()' is a large number.
>>>>
>>>> Given this code on a connected socket........
>>>
>>> What protocol (TCP?) and what Ethernet hardware (does it support TSO)?
>>> Did you set non-blocking?
>>
>> A connected TCP socket. The Ethernet hardware was also
>> described (Intel using e1000 as shown) It's on PCI-X 133MHz, two
>> devices on the motherboard, not really relevent because it worked
>> previously as described. TSO?
>
> TSO = TCP segmentation Offload, if you are using e1000 it gets enabled.
> Only slightly relevant to this, because it would change the timing.
>
>> They went away in 1972. The socket was set to non-blocking because the
>> same socket is used for reading (not at the same time), using poll()
>> to find when data are supposed to be available. BTW, read() code
>> used to use poll() to find out when data were available, but if
>> poll returned POLLIN, sometimes data would NOT be available and
>> the code would hang <forever>. Therefore a work-around was to set
>> the socket non-blocking. Under the conditions where poll() would
>> return POLLIN and a read of a non-blocking socket returned no data,
>
> Basic unix programming, errno only has meaning if system call returns -1.
>

True. So what?

> Basic network programming. If read returns 0 it means other side
> has disconnected.
>

So, the other side did not disconnect or shutdown. This is a previously
reported problem that has required work-arounds because it has never
been fixed. The read() problem may not be relevent to the spin-forever
when the kernel doesn't try to send even 1440 bites of the 0x01000000
byte buffer. That's the new problem being reported at this time.

Remember we (me and the others whose code I help review and sometimes
fix) have been doing socket programming since the days BSD first added
them to Unix, and have been comming up with work-arounds for things that
keep changing ever since. We have socket programming running on Interactive
Unix (now that's old), SCO Unix (sorry for the swear word), and SunOS.
I am reporting that something has CHANGED and, even with a work-around
in place, the result is a severe reduction in throughput.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
