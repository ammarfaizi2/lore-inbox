Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVKLFzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVKLFzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVKLFzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:55:20 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:53383 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932084AbVKLFzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:55:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] I8K: fix /proc reporting of blank service tags
Date: Sat, 12 Nov 2005 00:55:15 -0500
User-Agent: KMail/1.8.3
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511120055.17019.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make /proc/i8k display '?' when service tag is blank in BIOS.
This fixes segfault in i8k gkrellm plugin.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/i8k.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: work/drivers/char/i8k.c
===================================================================
--- work.orig/drivers/char/i8k.c
+++ work/drivers/char/i8k.c
@@ -99,7 +99,9 @@ struct smm_regs {
 
 static inline char *i8k_get_dmi_data(int field)
 {
-	return dmi_get_system_info(field) ? : "N/A";
+	char *dmi_data = dmi_get_system_info(field);
+
+	return dmi_data && *dmi_data ? dmi_data : "?";
 }
 
 /*
@@ -396,7 +398,7 @@ static int i8k_proc_show(struct seq_file
 	return seq_printf(seq, "%s %s %s %d %d %d %d %d %d %d\n",
 			  I8K_PROC_FMT,
 			  bios_version,
-			  dmi_get_system_info(DMI_PRODUCT_SERIAL) ? : "N/A",
+			  i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
 			  cpu_temp,
 			  left_fan, right_fan, left_speed, right_speed,
 			  ac_power, fn_key);
