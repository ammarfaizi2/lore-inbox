Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276474AbRJDJtL>; Thu, 4 Oct 2001 05:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276623AbRJDJtC>; Thu, 4 Oct 2001 05:49:02 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:55768 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S276922AbRJDJss>; Thu, 4 Oct 2001 05:48:48 -0400
Message-ID: <3BBC30B6.1030203@wipro.com>
Date: Thu, 04 Oct 2001 15:19:42 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: mingo@elte.hu
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110041119060.5309-100000@localhost.localdomain>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, if I missed something in the patch, but here is a question.

Shouldn't the interrupt mitigation be on a per CPU basis?
What I mean is that if a particular CPU is hogged due to some
interrupt, that interrupt should be mitigated on that particular CPU
and not on all CPUs in the system. So, unless an interrupt ends up
taking a lot of time on all CPUs it should still have a chance to
do something.

This could probably help in distributing the interrupts more evenly and
fairly on an SMP system or vice-versa.

Balbir



Ingo Molnar wrote:

>On Thu, 4 Oct 2001, BALBIR SINGH wrote:
>
>>Ingo, is it possible to provide an interface (optional interface) to
>>drivers, so that they can decide how many interrupts are too much.
>>
>
>well, it existed, and i can add it back - i dont have any strong feelings
>either.
>
>>Drivers who feel that they should go in for interrupt mitigation have
>>the option of deciding to go for it.
>>
>
>in those cases the 'irq overload' code should not trigger. It's not the
>rate of interrupts that matters, it's the amount of time we spend in irq
>contexts. The code counts the number of times we 'interrupt and interrupt
>context'. Interrupting an irq-context is a sign of irq overload. The code
>goes into 'overload mode' (and disables that particular interrupt source
>for the rest of the current timer tick) only if more than 97% of all
>interrupts from that source 'interrupt and irq context'. (ie. irq load is
>really high.) As any statistical method it has some inaccuracy, but
>'statistically' it gets things right.
>
>	Ingo
>
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
