Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275288AbRJJKsV>; Wed, 10 Oct 2001 06:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275289AbRJJKsL>; Wed, 10 Oct 2001 06:48:11 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:53141 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S275288AbRJJKsA>; Wed, 10 Oct 2001 06:48:00 -0400
Message-ID: <3BC4278C.6070907@wipro.com>
Date: Wed, 10 Oct 2001 16:18:44 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] register_blkdev and unregister_blkdev
In-Reply-To: <Pine.GSO.4.21.0110100633300.17790-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:

>>I was looking at the code for register_blkdev and unregister_blkdev. I 
>>found that no
>>locking (spinlocks) are used to protect the blkdevs struture in these 
>>functions. I suspect
>>we have not seen a problem till now since
>>
>
>... they are only called under BKL; ditto for lookups in the tables they
>(de-)populate.
>
What I wanted to know was, who is calling/holding the BKL? Is it because
lock_kernel is called in sys_create_module() and sys_init_module().

I also looked at sd.c, it does not hold the BKL before calling register_blkdev()
it calls devfs_register_blkdev() from sd_init().

Maybe I am still missing something.

Balbir



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
