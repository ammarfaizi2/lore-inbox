Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283488AbRK3ElN>; Thu, 29 Nov 2001 23:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283500AbRK3ElE>; Thu, 29 Nov 2001 23:41:04 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:38637 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S283488AbRK3Eky>; Thu, 29 Nov 2001 23:40:54 -0500
Message-ID: <3C070A4D.7000708@wipro.com>
Date: Fri, 30 Nov 2001 09:55:49 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com> <20011129161756.D6214@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-f070f0e2-e509-11d5-a216-0000e22173f5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-f070f0e2-e509-11d5-a216-0000e22173f5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Russell King wrote:

>On Thu, Nov 29, 2001 at 08:06:37AM -0800, Balbir Singh wrote:
>
>>Let me make it clearer to you,
>>
>>lets say I call rs_open() on /dev/ttyS0 and if it
>>fails then I should not call rs_close() after a failed
>>rs_open().
>>
>
>You don't call rs_open.  The tty layer does that for you.  The tty layer
>also cleans up on close by calling the driver specific close function.
>
>Yes I agree with you that it might not, but that is a 2.5 kernel issue,
>not a 2.4 "lets do a massive change" issue.  The tty layer is complex
>and messy, and we shouldn't go around randomly changing it in 2.4.
>
>>Lets see what happens with your approach
>>
>>1. I call rs_open(), it fails, ref_count set to 1
>>
>
>Ok, so you're poking around in kernel code calling kernel functions that
>were previously declared static and not visible to anything but the tty
>layer.  That immediately makes your example invalid because you're not
>following the rules that the tty layers lays down for opening tty devices.
>

What I mean by I call rs_open() is that the person who writes the tty layer
should not call close() after open() fails, I cannot directly invoke rs_open()
and rs_close(), I KNOW that.

If I were to define an API like rs_open(), I would expect the person who
uses these API (rs_*) in our case the tty layer, to call rs_close()
only if rs_open() is successfull. I do not want to leave a dependency
that rs_close() SHOULD BE called even if rs_open() failed.

As you say this fix works for 2.4, Since we are into 2.5, I hope
that it will be fixed in a better manner in 2.5. I have some suggestions,
ideas for the serial driver in 2.5, are u willing to discuss them?

Balbir

>
>--
>Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>             http://www.arm.linux.org.uk/personal/aboutme.html
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



------=_NextPartTM-000-f070f0e2-e509-11d5-a216-0000e22173f5
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
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

------=_NextPartTM-000-f070f0e2-e509-11d5-a216-0000e22173f5--
