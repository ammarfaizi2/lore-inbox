Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270821AbRHSWZu>; Sun, 19 Aug 2001 18:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRHSWZk>; Sun, 19 Aug 2001 18:25:40 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:41534 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S270821AbRHSWZ1>; Sun, 19 Aug 2001 18:25:27 -0400
Message-ID: <3B803C8D.4060005@blue-labs.org>
Date: Sun, 19 Aug 2001 18:24:13 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010817
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
CC: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <998193404.653.12.camel@phantasy> <478297685.998259561@[169.254.45.213]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then add another factor to the equation, randomly pick the next event.

Consider if you would, gather entropy by choosing random bytes from 
checksums from random packets.  All the selection isn't technically 
random but very uncontrolled.  You start by picking a random packet 
(seeded from existing entropy), and take a random byte from the checksum 
of that packet.  Using that byte, add it to the entropy pool and use it 
to help determine the next 'random' packet you'll swipe data from.

An attacker would have to have absolute control over the packets 
arriving at the machine to have a chance.  He still cannot know exactly 
which packets are chosen for entropy gathering being that the next 
packet is chosen randomly from two or more entropy sources.  Neither 
will he know which byte(s) in the checksum are chosen.

In real world situations you should have a plentiful source of 'noise'. 
 The above idea can be improved upon significantly I'm sure.

David

Alex Bligh - linux-kernel wrote:

> Robert,
>
>> I claim there is entropy from what?  The difference between interrupts
>> for net devices?  Everyone agrees that there is.  The issues is that an
>> external attacker could influence the interrupts to the net device, and
>
>                          ^^^^^^^^^
>
> Actually, to be fair, the true risk is more that an external attacker 
> could
> /obvserve/ the timing of packets to the NIC with sufficient accuracy to
> predict the inter-IRQ timing, and hence the consequent manipulation of
> the pool. This would mean that entropy was being added, (assuming a 
> system
> free of entropy to start with), eventually causing /dev/random not to 
> block,
> and thus, short of any other entropy, the net effect would be that
> /dev/random would become exactly as good/bad a random number source
> as /dev/urandom. However, in most environments, it is not possible
> to observe and accurately (microseconds) time the packet coming into
> the NIC without physical access to the machine (in which case there
> are, urm, easier attacks), and there is a largely indeterminable latency
> between the arrival of the packet and the consequent network IRQ, this
> latency being neither externally visible, nor being determinable by
> some non-root user.



