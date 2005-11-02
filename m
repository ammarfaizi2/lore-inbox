Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVKBHOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVKBHOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVKBHOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:14:25 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:25777 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932611AbVKBHOY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:14:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TowAEAuqVdabx6BsEm/hnEiwzDy2qxQARF9dHZQhWEKvEp2nHSGyk5q2ucq2A4zCtgYTm8f7diAZeb1x+/tjgcUnpm45L7RgFUP5xS+pqmTYYixHAOntuVnbWGG8SasnNJFfs3xxGalNXl26NKhABzWR/VDEefoBN/VvZj12U7w=
Message-ID: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>
Date: Wed, 2 Nov 2005 12:44:21 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: rick@remotepoint.com, davej@suse.de, acme@conectiva.com.br,
       linux-net@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are not enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes compiler warnings when CONFIG_ISA and CONFIG_PCI are
not enabled in the dgrc network driver.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

--
diff -Naurp linux-2.6.14/drivers/net/dgrs.c
linux-2.6.14-git1/drivers/net/dgrs.c---
linux-2.6.14/drivers/net/dgrs.c     2005-10-28 05:32:08.000000000
+0530
+++ linux-2.6.14-git1/drivers/net/dgrs.c        2005-11-01
10:30:03.000000000 +0530
@@ -1549,8 +1549,12 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
 static int __init dgrs_init_module (void)  {
        int     i;
-       int eisacount = 0, pcicount = 0;
-
+#ifdef CONFIG_EISA
+       int eisacount = 0;
+#endif
+#ifdef CONFIG_PCI
+       int pcicount = 0;
+#endif
        /*
         *      Command line variable overrides
         *              debug=NNN
