Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280937AbRKCKo3>; Sat, 3 Nov 2001 05:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280938AbRKCKoK>; Sat, 3 Nov 2001 05:44:10 -0500
Received: from wiproecmx2.wipro.com ([164.164.31.6]:42476 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S280937AbRKCKnu>; Sat, 3 Nov 2001 05:43:50 -0500
Reply-To: <sivakumar.kuppusamy@wipro.com>
From: "Sivakumar Kuppusamy" <sivakumar.kuppusamy@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Locks in kernel
Date: Fri, 2 Nov 2001 16:37:49 +0530
Message-ID: <001701c1638e$9bd332e0$5f08720a@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi All,
I am having doubts in locking mechanism in Linux 2.2 kernel code. 

We have done modifications in the Linux kernel code to support our
application which runs at the user space. The modification done in 
the Linux kernel is to maintain a table of data(like a routing table),
which will be updated by the applicaition with appropriate data. This
data will be used by the kernel for other processing. 

We are using "up" & "down" functions for locking global data in the kernel.
Our code in kernel will get called when a IP packet is received. During
that time we are trying to lock that global data and retrieve some
info from that. Is this a correct way to do. We are also locking 
the global data when it gets updated from the application. Since 
ip_rcv() gets called from bottom_half(), can we do any locking
stuff there? We faced kernel panicking when the application locked
the global data and got scheduled to continue later(with lock held). 
That time ip_rcv() got called and we are trying to acquire the lock
which is held by the scheduled process. This made the kernel panic.

How should we approach this problem? Shouldn't we use any locking in
the code which is called by the bottom_half()? 

Thanks in advance for your replies,
Siva

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
