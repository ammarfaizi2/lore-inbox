Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVJQHQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVJQHQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJQHQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:16:48 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39094 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751062AbVJQHQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:16:47 -0400
Date: Mon, 17 Oct 2005 16:10:50 +0900 (JST)
Message-Id: <20051017.161050.13020940.maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
References: <20051016154108.25735ee3.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Andrew Morton <akpm@osdl.org>
Subject: 2.6.14-rc4-mm1
Date: Sun, 16 Oct 2005 15:41:08 -0700

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
(snip)

I've seen the following compile error on ia64. 

arch/ia64/kernel/acpi-ext.c: In function `acpi_vendor_resource_match':
arch/ia64/kernel/acpi-ext.c:38: error: structure has no member named `id'
make[1]: *** [arch/ia64/kernel/acpi-ext.o] Error 1
make: *** [arch/ia64/kernel] Error 2

Attached patch fix the problem.

Thanks,
MAEDA Naoaki

------
This patch fix the following compile error on ia64.

arch/ia64/kernel/acpi-ext.c: In function `acpi_vendor_resource_match':
arch/ia64/kernel/acpi-ext.c:38: error: structure has no member named `id'

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com> 

Index: linux-2.6.13/arch/ia64/kernel/acpi-ext.c
===================================================================
--- linux-2.6.13.orig/arch/ia64/kernel/acpi-ext.c
+++ linux-2.6.13/arch/ia64/kernel/acpi-ext.c
@@ -35,7 +35,7 @@ acpi_vendor_resource_match(struct acpi_r
 	struct acpi_vendor_descriptor *descriptor;
 	u32 length;
 
-	if (resource->id != ACPI_RSTYPE_VENDOR)
+	if (resource->type != ACPI_RSTYPE_VENDOR)
 		return AE_OK;
 
 	vendor = (struct acpi_resource_vendor *)&resource->data;
