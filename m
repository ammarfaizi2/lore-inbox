Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268409AbTBNXrk>; Fri, 14 Feb 2003 18:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268466AbTBNXrd>; Fri, 14 Feb 2003 18:47:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24448 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268482AbTBNXpm>;
	Fri, 14 Feb 2003 18:45:42 -0500
Date: Fri, 14 Feb 2003 15:55:30 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 6/9] Update the Atari parallel port driver for new module API.
Message-ID: <20030214235530.GI13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below updates the Atari parallel port driver to use the new module
interfaces.  This hasn't been test (sorry no hardware).

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/parport/parport_atari.c b/drivers/parport/parport_atari.c
--- a/drivers/parport/parport_atari.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/parport_atari.c	Fri Feb 14 09:50:44 2003
@@ -147,16 +147,16 @@
 #endif
 }
 
-static void
+static int
 parport_atari_inc_use_count(void)
 {
-	MOD_INC_USE_COUNT;
+	return try_module_get(THIS_MODULE);
 }
 
 static void
 parport_atari_dec_use_count(void)
 {
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 }
 
 static struct parport_operations parport_atari_ops = {
