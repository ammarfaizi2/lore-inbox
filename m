Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWBMEDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWBMEDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 23:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWBMEDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 23:03:22 -0500
Received: from ozlabs.org ([203.10.76.45]:43412 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750855AbWBMEDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 23:03:22 -0500
Date: Mon, 13 Feb 2006 15:00:13 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Roger Leigh <rleigh@whinlatter.ukfsn.org>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, debian-powerpc@lists.debian.org
Subject: [PATCH] powerpc: dont allow old RTC to be selected
Message-ID: <20060213040013.GC7922@krispykreme>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org> <20060212161326.279fcb9f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212161326.279fcb9f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've had several spates of time-going-nuts on ppc64.  The most recent one
> was because someone went and fiddled with Kconfig naming and I lost the RTC
> driver.

This might help a bit:


Now powerpc uses the generic RTC stuff we should not enable the old
RTC. Doing so will result in hangs at boot.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/drivers/char/Kconfig
===================================================================
--- build.orig/drivers/char/Kconfig	2006-02-09 11:35:15.000000000 +1100
+++ build/drivers/char/Kconfig	2006-02-13 14:55:22.000000000 +1100
@@ -695,7 +695,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV
+	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
