Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268474AbTBNXuP>; Fri, 14 Feb 2003 18:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268063AbTBNXtv>; Fri, 14 Feb 2003 18:49:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26752 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268471AbTBNXsY>;
	Fri, 14 Feb 2003 18:48:24 -0500
Date: Fri, 14 Feb 2003 15:58:12 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 9/9] Update the Sun parallel port driver for new module API.
Message-ID: <20030214235812.GL13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below updates the Sun architecture parallel port driver to use the
new module interfaces.  This hasn't been test (sorry no hardware).

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
--- a/drivers/parport/parport_sunbpp.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/parport_sunbpp.c	Fri Feb 14 09:50:44 2003
@@ -249,18 +249,14 @@
 	parport_sunbpp_write_control(p, s->u.pc.ctr);
 }
 
-static void parport_sunbpp_inc_use_count(void)
+static int parport_sunbpp_inc_use_count(void)
 {
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
+	return try_module_get(THIS_MODULE);
 }
 
 static void parport_sunbpp_dec_use_count(void)
 {
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
+	module_put(THIS_MODULE);
 }
 
 static struct parport_operations parport_sunbpp_ops = 
