Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276901AbRJHO2n>; Mon, 8 Oct 2001 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276905AbRJHO2e>; Mon, 8 Oct 2001 10:28:34 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:12698 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S276901AbRJHO2X>; Mon, 8 Oct 2001 10:28:23 -0400
Message-ID: <3BC1B831.1060601@wipro.com>
Date: Mon, 08 Oct 2001 19:59:05 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] I still see people using cli()
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I saw the latest patch for 2.4.10 and saw that people are still blindly
copying the code in serial.c (au1000), though it uses save_flags() and cli().
Is somebody looking to replace these with either spinlocks or __cli() where
applicable, I do not mind spending sometime looking into these issues.

I would request people to look at the global-spin-lock document at lse.sf.net
before doing any locking. Also please look at kernel-locking.tmpl (using db2pdf
or db2ps). Please understand how locking works and then use this in your code.

Imagine a driver using save_flags(); cli(); and essentially serializing an entire
SMP system. Please do not do this until extremely necessary.

BTW, that brings me to another issue, once the kernel becomes preemptibel, what
are the locking issues? how are semaphores and spin-locks affected? Has anybody
defined or come up with the rules/document yet?

I hope, I have understood these issues  :-D 

Comments, flames
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
