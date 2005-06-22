Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVFVGJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVFVGJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVFVFhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:37:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:57244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262821AbVFVFWU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:20 -0400
Cc: rvinson@mvista.com
Subject: [PATCH] I2C: Add support for Maxim/Dallas DS1374 Real-Time Clock Chip (2/2)
In-Reply-To: <1119417468520@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:48 -0700
Message-Id: <1119417468250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Add support for Maxim/Dallas DS1374 Real-Time Clock Chip (2/2)

This change provides support for the DS1374 Real-Time Clock chip present
on the MPC8349ADS board. It depends on a previous patch which adds I2C
support for the DS1374.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bdca3f0aedde85552099aa95ab1449bf81e4f6f5
tree 1016146e6b110707163777101436eb5b339d39bc
parent c124a78d8c7475ecc43f385f34112b638c4228d9
author Randy Vinson <rvinson@mvista.com> Fri, 03 Jun 2005 14:43:56 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:06 -0700

 arch/ppc/platforms/83xx/mpc834x_sys.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -185,6 +185,26 @@ mpc834x_sys_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
+extern ulong	ds1374_get_rtc_time(void);
+extern int	ds1374_set_rtc_time(ulong);
+
+static int __init
+mpc834x_rtc_hookup(void)
+{
+	struct timespec	tv;
+
+	ppc_md.get_rtc_time = ds1374_get_rtc_time;
+	ppc_md.set_rtc_time = ds1374_set_rtc_time;
+
+	tv.tv_nsec = 0;
+	tv.tv_sec = (ppc_md.get_rtc_time)();
+	do_settimeofday(&tv);
+
+	return 0;
+}
+late_initcall(mpc834x_rtc_hookup);
+#endif
 static __inline__ void
 mpc834x_sys_set_bat(void)
 {

