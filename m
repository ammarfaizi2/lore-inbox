Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966454AbWKNXIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966454AbWKNXIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966456AbWKNXIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:08:50 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:51073 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S966454AbWKNXIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:08:49 -0500
Message-ID: <38090.194.90.237.34.1163545721.squirrel@dev.mellanox.co.il>
In-Reply-To: <20061114143531.2ee7eae0@freekitty>
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il>
    <20061114143531.2ee7eae0@freekitty>
Date: Wed, 15 Nov 2006 01:08:41 +0200 (IST)
Subject: Re: UDP packets loss
From: eli@dev.mellanox.co.il
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: eli@dev.mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
User-Agent: SquirrelMail/1.4.8-1.fc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the commets.
I actually use UDP because I am seeking for ways to improve the
performance of IPOIB and I wanted to avoid TCP's flow control. I am really
up to making anaysis. Can you tell me more about irqbalnced? Where can I
find more info how to control it? I would like my interrupts serviced by
all CPUs in a somehow equal manner. I mentioned MSIX - the driver already
make use of MSIX and I thought this is relevant to interrupts affinity.

> On Wed, 15 Nov 2006 00:15:47 +0200 (IST)
> eli@dev.mellanox.co.il wrote:
>
>> Hi,
>> I am running a client/server test app over IPOIB in which the client
>> sends
>> a certain amount of data to the server. When the transmittion ends, the
>> server prints the bandwidth and how much data it received. I can see
>> that
>> the server reports it received about 60% that the client sent. However,
>> when I look at the server's interface counters before and after the
>> transmittion, I see that it actually received all the data that the
>> client
>> sent. This leads me to suspect that the networking layer somehow dropped
>> some of the data. One thing to not - the CPU is 100% busy at the
>> receiver.
>> Could this be the reason (the machine I am using is 2 dual cores - 4
>> CPUs).
>
> If receiver application can't keep up UDP drops packets. The counter
> receive buffer errors (UDP_MIB_RCVBUFERRORS) is incremented.
>
> Don't expect flow control or reliable delivery; it's a datagram service!
>
>> The secod question is how do I make the interrupts be srviced by all
>> CPUs?
>> I tried through the procfs as described by IRQ-affinity.txt but I can
>> set
>> the mask to 0F bu then I read back and see it is indeed 0f but after a
>> few
>> seconds I see it back to 02 (which means only CPU1).
>
> Most likely, the user level irq balance daemon (irqbalanced) is adjusting
> it?
>
>>
>> One more thing - the device I am using is capable of generating MSIX
>> interrupts.
>>
>
> Look at device capabilities with:
>
> 	lspci -vv
>
>
> --
> Stephen Hemminger <shemminger@osdl.org>
>


