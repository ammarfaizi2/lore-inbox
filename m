Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVDFBki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVDFBki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVDFBki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:40:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:10962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbVDFBk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:40:28 -0400
Date: Tue, 5 Apr 2005 18:36:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: bunk@stusta.de, reuben-lkml@reub.net, len.brown@intel.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Message-Id: <20050405183655.0c778129.akpm@osdl.org>
In-Reply-To: <4252F090.4040605@mesatop.com>
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no>
	<42524D83.1080104@reub.net>
	<20050405121444.GB6885@stusta.de>
	<6.2.3.0.2.20050406002812.04393a30@tornado.reub.net>
	<20050405132417.GD6885@stusta.de>
	<4252F090.4040605@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> arch/i386/kernel/setup.c: In function 'setup_arch':
>  arch/i386/kernel/setup.c:1571: warning: implicit declaration of function 'acpi_boot_table_init'
>  arch/i386/kernel/setup.c:1572: warning: implicit declaration of function 'acpi_boot_init'


diff -puN include/linux/acpi.h~no-acpi-build-fix include/linux/acpi.h
--- 25/include/linux/acpi.h~no-acpi-build-fix	2005-04-05 00:14:46.000000000 -0700
+++ 25-akpm/include/linux/acpi.h	2005-04-05 00:23:39.000000000 -0700
@@ -418,16 +418,6 @@ extern int sbf_port ;
 
 #define acpi_mp_config	0
 
-static inline int acpi_boot_init(void)
-{
-	return 0;
-}
-
-static inline int acpi_boot_table_init(void)
-{
-	return 0;
-}
-
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
@@ -538,5 +528,18 @@ static inline int acpi_get_pxm(acpi_hand
 
 extern int pnpacpi_disabled;
 
+#else	/* CONFIG_ACPI */
+
+static inline int acpi_boot_init(void)
+{
+	return 0;
+}
+
+static inline int acpi_boot_table_init(void)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_ACPI */
+
 #endif	/* _LINUX_ACPI_H */
_

