Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUI2GvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUI2GvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUI2GtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:49:11 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:36718 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268236AbUI2GsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/8] Guest protocol switch in synaptics
Date: Wed, 29 Sep 2004 01:43:09 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290141.48766.dtor_core@ameritech.net> <200409290142.33707.dtor_core@ameritech.net>
In-Reply-To: <200409290142.33707.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290143.11562.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1949, 2004-09-28 00:07:41-05:00, dtor_core@ameritech.net
  Input: synaptics - not only switch to 4-byte client protocol
         but also revert to 3-byte mode if client selected lower
         protocol.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru> 


 synaptics.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-09-29 01:16:30 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-09-29 01:16:30 -05:00
@@ -264,10 +264,14 @@
 	struct synaptics_data *priv = psmouse->private;
 
 	/* adjust the touchpad to child's choice of protocol */
-	if (child && child->type >= PSMOUSE_GENPS) {
-		priv->mode |= SYN_BIT_FOUR_BYTE_CLIENT;
+	if (child) {
+		if (child->type >= PSMOUSE_GENPS)
+			priv->mode |= SYN_BIT_FOUR_BYTE_CLIENT;
+		else
+			priv->mode &= ~SYN_BIT_FOUR_BYTE_CLIENT;
+
 		if (synaptics_mode_cmd(psmouse, priv->mode))
-			printk(KERN_INFO "synaptics: failed to enable 4-byte guest protocol\n");
+			printk(KERN_INFO "synaptics: failed to switch guest protocol\n");
 	}
 }
 
