Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWGKGFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWGKGFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWGKGFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:05:35 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:51589 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S932503AbWGKGFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:05:34 -0400
Subject: [PATCH 2/4] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_processor_id_voyager
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 11 Jul 2006 15:05:32 +0900
Message-Id: <1152597932.2414.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"safe_smp_processor_id" implementation for i386-Voyager.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc1/arch/i386/mach-voyager/voyager_smp.c linux-2.6.18-rc1-sof/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.18-rc1/arch/i386/mach-voyager/voyager_smp.c	2006-07-11 10:11:38.000000000 +0900
+++ linux-2.6.18-rc1-sof/arch/i386/mach-voyager/voyager_smp.c	2006-07-11 14:09:15.000000000 +0900
@@ -99,6 +99,7 @@ static void do_boot_cpu(__u8 cpuid);
 static void do_quad_bootstrap(void);
 
 int hard_smp_processor_id(void);
+int safe_smp_processor_id(void);
 
 /* Inline functions */
 static inline void
@@ -1247,6 +1248,12 @@ hard_smp_processor_id(void)
 	return 0;
 }
 
+int
+safe_smp_processor_id(void)
+{
+	return hard_smp_processor_id();
+}
+
 /* broadcast a halt to all other CPUs */
 void
 smp_send_stop(void)


