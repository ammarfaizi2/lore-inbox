Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbTFRSLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265411AbTFRSLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:11:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27028 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265398AbTFRSLm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:11:42 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10559607092693@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.72
In-Reply-To: <10559607093836@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 18 Jun 2003 11:25:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318.3.7, 2003/06/17 15:34:14-07:00, azarah@gentoo.org

[PATCH] I2C: fix for previous W83627THF sensor chip patch

Ok, I was wrong in assuming that the W83627THF was on the I2C bus.
It is on the ISA bus, id 0x90 (thanks to Alex Van Kaam author of
MBM who corrected my assumption).


 drivers/i2c/chips/w83781d.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Jun 18 11:19:21 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Jun 18 11:19:21 2003
@@ -28,6 +28,7 @@
     asb100 "bach" (type_name = as99127f)	0x30	0x0694	yes	no
     w83781d	7	3	0	3	0x10	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)
+    w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
     w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
@@ -1285,7 +1286,7 @@
 			kind = w83782d;
 		else if (val1 == 0x40 && vendid == winbond && !is_isa)
 			kind = w83783s;
-		else if ((val1 == 0x20 || val1 == 0x72) && vendid == winbond)
+		else if ((val1 == 0x20 || val1 == 0x90) && vendid == winbond)
 			kind = w83627hf;
 		else if (val1 == 0x30 && vendid == asus && !is_isa)
 			kind = as99127f;
@@ -1309,7 +1310,10 @@
 	} else if (kind == w83783s) {
 		client_name = "W83783S chip";
 	} else if (kind == w83627hf) {
-		client_name = "W83627HF chip";
+		if (val1 == 0x90)
+			client_name = "W83627THF chip";
+		else
+			client_name = "W83627HF chip";
 	} else if (kind == as99127f) {
 		client_name = "AS99127F chip";
 	} else if (kind == w83697hf) {

