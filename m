Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRBZF3X>; Mon, 26 Feb 2001 00:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbRBZF3O>; Mon, 26 Feb 2001 00:29:14 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:27454 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130159AbRBZF27>; Mon, 26 Feb 2001 00:28:59 -0500
Date: Mon, 26 Feb 2001 00:28:16 -0500
From: Bill Nottingham <notting@redhat.com>
To: scott@spiteful.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE support for opl3sa2 driver
Message-ID: <20010226002816.A22386@nostromo.devel.redhat.com>
Mail-Followup-To: scott@spiteful.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached adds MODULE_DEVICE_TABLE support to the ISAPnP support
in the opl3sa2 driver, so it can get picked up by modutils and
the like.

Bill

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.2-opl3sa2-isapnp.patch"

--- linux/drivers/sound/opl3sa2.c.foo	Mon Feb 26 00:19:33 2001
+++ linux/drivers/sound/opl3sa2.c	Mon Feb 26 00:25:53 2001
@@ -806,6 +806,16 @@
 
 
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+
+struct isapnp_device_id isapnp_opl3sa2_list[] __initdata = {
+	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021),
+		NULL },
+	{0}
+};
+
+MODULE_DEVICE_TABLE(isapnp, isapnp_opl3sa2_list);
+
 static int __init opl3sa2_isapnp_probe(struct address_info* hw_cfg,
 				       struct address_info* mss_cfg,
 				       struct address_info* mpu_cfg,

--vtzGhvizbBRQ85DL--
