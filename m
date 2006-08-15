Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWHOLeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWHOLeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWHOLeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:34:21 -0400
Received: from spirit.analogic.com ([204.178.40.4]:56849 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965370AbWHOLeU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:34:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 15 Aug 2006 11:34:18.0280 (UTC) FILETIME=[BE89D280:01C6C05E]
Content-class: urn:content-classes:message
Subject: Re: Network compatibility and performance
Date: Tue, 15 Aug 2006 07:34:17 -0400
Message-ID: <Pine.LNX.4.61.0608150732560.28984@chaos.analogic.com>
In-Reply-To: <44E0EA5E.30306@candelatech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network compatibility and performance
thread-index: AcbAXr6TXbuZJM/JTaeENJNzqeH5kQ==
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com> <44DE2A44.5070006@candelatech.com> <Pine.LNX.4.61.0608140714170.20677@chaos.analogic.com> <44E0EA5E.30306@candelatech.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ben Greear" <greearb@candelatech.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2006, Ben Greear wrote:

> linux-os (Dick Johnson) wrote:
>
>> No it will return FAIL (-1) or an error and 0 (the bottom of the procedure)
>> if the whole things went. It is mandatory that the whole thing goes
>> so this procedure should handle any intermediate actions.
>
> I see..I missed that part.
>
>> Upon your advice, I may try to add select() although, on a write it
>> seems to be putting in user-space something that used to be handled
>> quite well in the kernel. I don't think the user should really care
>> about the kernel internals, whether or not the kernel happens to have
>> a buffer available.
>
> Since you put it in non-blocking mode, you need the select() to throttle
> unless you want to busy spin.  Whether you should have to actually put
> in in non-blocking mode or not is a different question.
>
>>> I have no idea why you need to add the MIN() logic..and that seems like
>>> something that should not be required.
>>>
>>
>> It seems that some code 'thinks' that a large buffer of data is
>> an error and won't even try to send some anymore.
>
> I have seen a problem where I can repeatedly hang a TCP connection
> when running at high speed.  The tx queue is full or mostly full, and
> on the wire I only see 200kpps of duplicate acks.  Can't reproduce it
> with anything other than my big complicated proprietary app, so it
> remains unfixed.
>
> I am not sure if this is related to what you see or not..but could you
> check to see if there is lots of acks on the wire when this hang happens?

I will check to see what it's doing on the wire and get back.


>
>>> Even 112kbps sucks on a decent network.  What is the speed of your
>>> network, what protocol are you using, if tcp, what is the latency
>>> of your network?
>>>
>>
>>
>> The network is a single wire about 8 feet long, connecting Intel gigibit
>> links on two identical computers (crossover cable). This link is TCP.
>> For high-speed data, I use UDP and I get a higher throughput because
>> there is no handshake. Thew latency is the latency of Linux. BTW, it's
>> only a gigaBIT link, you can divide that by 8 for gigabytes. I don't
>> know the actual bit-rate on the wires, if we assume 1GHz, the byte-rate
>> is only 125,000 bytes per second. Being able to use 89.6 percent of
>> that isn't bad at all.
>
> You must be meaning to add a few more zeros to that number.  If you
> are getting ~125,000,000 Bytes per second then you are doing OK.
>

ACK that!

> Ben
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
