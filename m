Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268472AbTBNXto>; Fri, 14 Feb 2003 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268135AbTBNXrz>; Fri, 14 Feb 2003 18:47:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25984 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268168AbTBNXrj>;
	Fri, 14 Feb 2003 18:47:39 -0500
Date: Fri, 14 Feb 2003 15:57:27 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 8/9] Update the Multiface 3 parallel port driver for new module API.
Message-ID: <20030214235727.GK13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below updates the Multiface 3 parallel port driver to use the
new module interfaces.  This hasn't been test (sorry no hardware).


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
--- a/drivers/parport/parport_mfc3.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/parport_mfc3.c	Fri Feb 14 09:50:44 2003
@@ -281,14 +281,14 @@
 	pia(p)->cra |= PIA_DDR;
 }
 
-static void mfc3_inc_use_count(void)
+static int mfc3_inc_use_count(void)
 {
-	MOD_INC_USE_COUNT;
+	return try_module_get(THIS_MODULE);
 }
 
 static void mfc3_dec_use_count(void)
 {
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 }
 
 static struct parport_operations pp_mfc3_ops = {
