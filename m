Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279548AbRKHN3f>; Thu, 8 Nov 2001 08:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279599AbRKHN3Q>; Thu, 8 Nov 2001 08:29:16 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:16275 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S279588AbRKHN3M>; Thu, 8 Nov 2001 08:29:12 -0500
Message-ID: <3BEA865F.4040909@wipro.com>
Date: Thu, 08 Nov 2001 18:49:27 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More dependencies on CONFIG_SMP
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Looking at arch/i386/config.in

if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
   define_bool CONFIG_HAVE_DEC_LOCK y
fi
endmenu

and arch/i386/lib/Makefile

.obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o

We need to have SMP set inorder to use dec_and_lock. The file fs/dcache.c
in function dput uses a function atomic_dec_and_lock function, which is
defined in dec_and_lock.c. I think the SMP dependency should go

If this patch is ok, please apply

--- config.in.org       Thu Nov  8 18:43:49 2001
+++ config.in   Thu Nov  8 18:44:04 2001
@@ -183,7 +183,7 @@
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
-if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
+if [ "$CONFIG_X86_CMPXCHG" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
 fi



--------------InterScan_NT_MIME_Boundary
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

--------------InterScan_NT_MIME_Boundary--
