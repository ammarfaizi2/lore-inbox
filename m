Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275255AbRJJKXE>; Wed, 10 Oct 2001 06:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJJKW4>; Wed, 10 Oct 2001 06:22:56 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:57993 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S275255AbRJJKWn>; Wed, 10 Oct 2001 06:22:43 -0400
Message-ID: <3BC4219F.6020604@wipro.com>
Date: Wed, 10 Oct 2001 15:53:27 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] register_blkdev and unregister_blkdev
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I was looking at the code for register_blkdev and unregister_blkdev. I 
found that no
locking (spinlocks) are used to protect the blkdevs struture in these 
functions. I suspect
we have not seen a problem till now since

Either

1. register_blkdev is called from modules, and only module 
initialization is protected.
2. register_blkdev is called during init time for drivers in the kernel 
and I am not sure
    about whether calls to register_blkdev at this time are implicitly 
serialized, since only
    1 CPU is active during initialization

Anway, what I needed to know was if (1) and (2) are enough to ensure 
safety in register_blkdev
and unregister_blkdev.

May be I am missing something, there is already some lock which is held 
before these routines
are invoked, I could not find any.

Comments

Thanks,
Balbir Singh.


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
