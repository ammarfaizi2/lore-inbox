Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283233AbRK2OIM>; Thu, 29 Nov 2001 09:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbRK2OHx>; Thu, 29 Nov 2001 09:07:53 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:10683 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S283233AbRK2OHv>; Thu, 29 Nov 2001 09:07:51 -0500
Message-ID: <3C063E6B.5060308@wipro.com>
Date: Thu, 29 Nov 2001 19:25:55 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-17489e5c-e4c2-11d5-a216-0000e22173f5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-17489e5c-e4c2-11d5-a216-0000e22173f5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Even register_blkdev(), etc hold BKL, without these there will be
a lot of problems, all these need to be taken care of if BKL is
ever replaced.

Just adding what I know,
Balbir  


Russell King wrote:

>On Wed, Nov 28, 2001 at 03:32:32PM -0800, David C. Hansen wrote:
>
>>Nothing, because the BKL is not held for all opens anymore.  In most of 
>>the cases that we addressed, the BKL was in release _only_, not in open 
>>at all.  There were quite a few drivers where we added a spinlock, or 
>>used atomic operations to keep open from racing with release.  
>>
>
>All char and block devs are opened with the BKL held - see chrdev_open in
>fs/devices.c and do_open in fs/block_dev.c
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



------=_NextPartTM-000-17489e5c-e4c2-11d5-a216-0000e22173f5
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

------=_NextPartTM-000-17489e5c-e4c2-11d5-a216-0000e22173f5--
