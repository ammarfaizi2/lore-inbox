Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUIPCLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUIPCLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUIPCLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:11:47 -0400
Received: from mail.renesas.com ([202.234.163.13]:56273 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S265999AbUIPCK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:10:29 -0400
From: takata@linux-m32r.org
Date: Thu, 16 Sep 2004 11:09:19 +0900 (JST)
Message-Id: <20040916.110919.884032883.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: [PATCH 2.6.9-rc1-mm5 1/3] [m32r] Remove network drivers under 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/m32r/drivers/ (was Re: 2.6.9-rc1-mm3)
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
 takata@linux-m32r.org
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20040916.110622.640922499.takata.hirokazu@renesas.com>
References: <20040916.110622.640922499.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

This patch is huge, but some files are just deleted.
So I attatched patches for just modifications.
Should I send complete patch, again?

Sorry, for my late reply to the following comments:

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.9-rc1-mm3
Date: Fri, 3 Sep 2004 10:42:39 +0100
> Just from looking at the diffstat and not actual code:
> 
>  - it adds new drivers under arch/m32r instead of drivers/

Date: Mon, 6 Sep 2004 14:02:09 -0700
> Were you planning to address Christoph's earlier review comments?  One of
> which was that the m32r-specific drivers are in the wrong directory? 
> Please do.

>From: Zwane Mwaikambo <zwane@linuxpower.ca>
>Subject: Re: 2.6.9-rc1-mm3
>Date: Fri, 3 Sep 2004 08:48:27 -0400 (EDT)
>> - There appears to be yet another smc 91C111 driver in there, Takata,
>>   there should be a unified one in drivers/net/smc91x.c.
>Yes.  I would like to use drivers/net/smc91x.c.  Now investigating it...

Thank you, again.

--
[PATCH 2.6.9-rc1-mm5 1/3] [m32r] Remove network drivers under 
arch/m32r/drivers/
  This patch removes local network drivers under arch/m32r/drivers/
  as follows:
     arch/m32r/drivers/8390.c
     arch/m32r/drivers/8390.h
     arch/m32r/drivers/smc91111.c
     arch/m32r/drivers/smc91111.copying
     arch/m32r/drivers/smc91111.h
     arch/m32r/drivers/smc91111.readme.txt
     arch/m32r/drivers/mappi_ne.c

  Instead of smc91111.c and mappi_ne.c, we use drivers/net/smc91x.c and
  drivers/net/ne.c, respectively.

 arch/m32r/drivers/8390.c              |    1 
 arch/m32r/drivers/8390.h              |    1 
 arch/m32r/drivers/Kconfig             |    8 
 arch/m32r/drivers/Makefile            |    2 
 arch/m32r/drivers/mappi_ne.c          |  861 -------
 arch/m32r/drivers/smc91111.c          | 3894 ----------------------------------
 arch/m32r/drivers/smc91111.copying    |  352 ---
 arch/m32r/drivers/smc91111.h          |  570 ----
 arch/m32r/drivers/smc91111.readme.txt |  561 ----
 9 files changed, 6250 deletions(-)

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---


diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/8390.c linux-2.6.9-rc1-mm5/arch/m32r/drivers/8390.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/8390.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/drivers/8390.c	1970-01-01 09:00:00.000000000 +0900
@@ -1 +0,0 @@
-#include "../../../drivers/net/8390.c"
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/8390.h linux-2.6.9-rc1-mm5/arch/m32r/drivers/8390.h
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/8390.h	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/drivers/8390.h	1970-01-01 09:00:00.000000000 +0900
@@ -1 +0,0 @@
-#include "../../../drivers/net/8390.h"
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/Kconfig linux-2.6.9-rc1-mm5/arch/m32r/drivers/Kconfig
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/Kconfig	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/drivers/Kconfig	2004-09-14 16:24:28.000000000 +0900
@@ -9,10 +9,6 @@ config M32RPCC
 	bool "M32R PCMCIA I/F"
 	depends on CHIP_M32700
 
-config M32R_NE2000
-	bool "On board NE2000 Network Interface Chip"
-	depends on PLAT_MAPPI || PLAT_OAKS32R
-
 config M32R_CFC
 	bool "CF I/F Controller"
 	depends on PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT
@@ -31,10 +27,6 @@ config MTD_M32R
 	bool "Flash device mapped on M32R"
 	depends on PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2
 
-config M32R_SMC91111
-	bool "On board SMC91111 Network Interface Chip"
-	depends on PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT
-
 config M32700UT_DS1302
 	bool "DS1302 Real Time Clock support"
 	depends on PLAT_M32700UT || PLAT_OPSPUT
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/Makefile linux-2.6.9-rc1-mm5/arch/m32r/drivers/Makefile
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/drivers/Makefile	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/drivers/Makefile	2004-09-14 16:24:28.000000000 +0900
@@ -2,8 +2,6 @@
 # Makefile for the Linux/M32R driver
 #
 
-obj-$(CONFIG_M32R_SMC91111)	+= smc91111.o
-obj-$(CONFIG_M32R_NE2000)	+= mappi_ne.o 8390.o
 obj-$(CONFIG_M32RPCC)		+= m32r_pcc.o
 obj-$(CONFIG_M32R_CFC)		+= m32r_cfc.o
 obj-$(CONFIG_M32700UT_DS1302)	+= ds1302.o

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
