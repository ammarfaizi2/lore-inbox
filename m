Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRLLLkW>; Wed, 12 Dec 2001 06:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRLLLkN>; Wed, 12 Dec 2001 06:40:13 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:60600 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S278428AbRLLLj6>; Wed, 12 Dec 2001 06:39:58 -0500
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "Miika Pekkarinen" <miipekk@ihme.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] /proc/net/dev counter fix, linux-2.5.0
Date: Wed, 12 Dec 2001 16:55:42 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBKEDCCAAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-0478e6b9-eef3-11d5-a216-0000e22173f5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0112121210500.972-100000@ihme.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-0478e6b9-eef3-11d5-a216-0000e22173f5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

--- linux-2.5.0or/include/linux/netdevice.h	Thu Nov 22 21:47:09 2001
+++ linux/include/linux/netdevice.h	Tue Dec 11 21:24:54 2001
@@ -97,8 +97,9 @@
 {
 	unsigned long	rx_packets;		/* total packets received	*/
 	unsigned long	tx_packets;		/* total packets transmitted	*/
-	unsigned long	rx_bytes;		/* total bytes received 	*/
-	unsigned long	tx_bytes;		/* total bytes transmitted	*/
+        /* rx and tx counters fixed up to 64-bit */
+        long long       rx_bytes;               /* total bytes received
*/
+        long long       tx_bytes;               /* total bytes transmitted
*/


It is better to define these as unsigned long long, you are anyway
printing them as unsigned long long. Its about time this was fixed,
I have Gigabit cards and it is very easy to produce an overflow.
I think the MAINTAINER for ifconfig(8) should be made aware of these
changes as well.

Balbir


------=_NextPartTM-000-0478e6b9-eef3-11d5-a216-0000e22173f5
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

------=_NextPartTM-000-0478e6b9-eef3-11d5-a216-0000e22173f5--
