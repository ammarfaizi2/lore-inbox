Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbTIEQXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbTIEQRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:17:31 -0400
Received: from [213.94.219.177] ([213.94.219.177]:2309 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S265677AbTIEQNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:13:19 -0400
Message-ID: <3F58B566.2030000@draigBrady.com>
Date: Fri, 05 Sep 2003 17:10:14 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henning Schmiedehausen <hps@intermeta.de>
CC: Florian Weimer <fw@deneb.enyo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
References: <20030830230701.GA25845@work.bitmover.com>	 <87llt9bvtc.fsf@deneb.enyo.de> <bj1fhj$its$4@tangens.hometree.net>	 <874qzrsljc.fsf@deneb.enyo.de> <1062776157.20632.1697.camel@forge.intermeta.de>
In-Reply-To: <1062776157.20632.1697.camel@forge.intermeta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning Schmiedehausen wrote:
> On Fri, 2003-09-05 at 10:10, Florian Weimer wrote:
> 
>>>You need a shaper connected to the ISP backbone which shapes the
>>>outgoing traffic for you and a border router which talks to the T1
>>>(C17xx or C26xx). Normally, if your ISP has some sort of clue, you
>>>will also need a bastion router which can handle backbone <-> 100 MBit
>>>traffic and does dynamic routing updates (EGP or OSPF) to the ISP
>>>backbone (A C26xx or C37xx).
>>
>>C37xx can handle a maximum load of 225 kpps (data sheet number,
>>i.e. this value cannot be exceeded even under most favorable
>>conditions), the others handle even less.  Such routers are of no help
>>during a DoS attack.
>>
>>Yes, I snipped the DoS context, and your approach would work in a
>>benign environment. 8-)
> 
> 225kpps * 64 Bytes (minimum packet len) = 13,7 MBytes / sec
> 
> 100 MBit / 8 bit = 12,5 MBytes / sec
> 
> So, IMHO even with a small packet saturated 100 MBit link you won't
> reach 225kpps. AFAIK this was Ciscos intention to publish this number.
> It basically says "you will have filled your link before you fill our
> router". 

100Mb/s LAN @ 64 byte packets is 148500 pps half duplex
from my testing => 257Kpps full duplex.

Here's some interesting results I've got from the latest
intel e100 3.0.0_dev13 driver, showing how the receive
rate degrades at higher packet rates.

------------------------
send Kpps     recv Kpps
------------------------
126           126
126.5         118.4
128           115.7
130           102.7
135            99.1
140            90.6
148            88.2
------------------------

It's not a CPU issue as it can receive at
the same rate on another interface.
renicing ksoftirqd has no effect.
system is PIII 1.2GHz, i815, 2.4.20
NAPI is turned on in the driver.

Pádraig.

