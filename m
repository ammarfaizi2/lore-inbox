Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVLMIci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVLMIci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVLMIYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:24:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:32131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932543AbVLMIYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:43 -0500
Date: Tue, 13 Dec 2005 00:23:48 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dtor@mail.ru
Subject: [patch 22/26] I8K: fix /proc reporting of blank service tags
Message-ID: <20051213082348.GW5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i8k-fix-proc-reporting-of-blank-service-tags.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Dmitry Torokhov <dtor_core@ameritech.net>

[PATCH] I8K: fix /proc reporting of blank service tags

Make /proc/i8k display '?' when service tag is blank in BIOS.
This fixes segfault in i8k gkrellm plugin.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/char/i8k.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.14.3.orig/drivers/char/i8k.c
+++ linux-2.6.14.3/drivers/char/i8k.c
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

--
