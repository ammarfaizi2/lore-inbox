Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273789AbRJDJT1>; Thu, 4 Oct 2001 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbRJDJTQ>; Thu, 4 Oct 2001 05:19:16 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:29388 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S273789AbRJDJTM>; Thu, 4 Oct 2001 05:19:12 -0400
Message-ID: <3BBC29A4.7080209@wipro.com>
Date: Thu, 04 Oct 2001 14:49:32 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: mingo@elte.hu
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110032011300.10924-100000@localhost.localdomain>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo, is it possible to provide an interface (optional interface) to drivers,
so that they can decide how many interrupts are too much. Drivers who feel
that they should go in for interrupt mitigation have the option of deciding
to go for it.

Ofcourse, you could also have a ceiling on the maximun number of interrupts,
but the ceiling should be user configurable (using sysctl or /proc), this
would enable administrators to config their systems depending on what kind
of devices (with shared interrupts or not) they have.

Just my 2cents,
Balbir


Ingo Molnar wrote:

>On Wed, 3 Oct 2001, Linus Torvalds wrote:
>
>>Now test it again with the disk interrupt being shared with the
>>network card.
>>
>>Doesn't happen? It sure does. [...]
>>
>
>yes, disk IRQs might be delayed in that case. Without this mechanizm there
>is a lockup.
>
>>Which is why I like the NAPI approach.  If somebody overloads my
>>network card, my USB camera doesn't stop working.
>>
>
>i agree that NAPI is a better approach. And IRQ overload does not happen
>on cards that have hardware-based irq mitigation support already. (and i
>should note that those cards will likely perform even faster with NAPI.)
>
>>I don't disagree with your patch as a last resort when all else fails,
>>but I _do_ disagree with it as a network load limiter.
>>
>
>okay - i removed those parts already (kpolld) in today's patch. (It
>initially was an experiment to prove that this is the only problem we are
>facing under such loads.)
>
>	Ingo
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
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
