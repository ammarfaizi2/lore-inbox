Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272124AbRHVVIm>; Wed, 22 Aug 2001 17:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272121AbRHVVIc>; Wed, 22 Aug 2001 17:08:32 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:56239 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272122AbRHVVIS>; Wed, 22 Aug 2001 17:08:18 -0400
Date: Wed, 22 Aug 2001 17:08:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: dag@brattli.net
Cc: linux-kernel@vger.kernel.org
Subject: IrDA gcc warnings in 2.4.8-ac9
Message-ID: <20010822170833.A26433@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case anyone cares about such minor things as warnings...

--- linux-2.4.8-ac9/init/main.c	Wed Aug 22 11:02:12 2001
+++ linux-2.4.8-ac9-niph/init/main.c	Wed Aug 22 12:09:23 2001
@@ -67,6 +67,7 @@
 
 #ifdef CONFIG_IRDA
 #include <net/irda/irda_device.h>
+extern int irda_proto_init(void);
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
--- linux-2.4.8-ac9/net/irda/irda_device.c	Wed Apr 18 14:40:07 2001
+++ linux-2.4.8-ac9-niph/net/irda/irda_device.c	Wed Aug 22 12:11:47 2001
@@ -457,15 +457,17 @@
 dongle_t *irda_device_dongle_init(struct net_device *dev, int type)
 {
 	struct dongle_reg *reg;
-	char modname[32];
 	dongle_t *dongle;
 
 	ASSERT(dev != NULL, return NULL;);
 
 #ifdef CONFIG_KMOD
+	{
+	char modname[32];
 	/* Try to load the module needed */
 	sprintf(modname, "irda-dongle-%d", type);
 	request_module(modname);
+	}
 #endif /* CONFIG_KMOD */
 
 	if (!(reg = hashbin_find(dongles, type, NULL))) {

