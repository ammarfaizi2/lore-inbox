Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264764AbRFXVah>; Sun, 24 Jun 2001 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbRFXVa1>; Sun, 24 Jun 2001 17:30:27 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:22888
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264769AbRFXVaN>; Sun, 24 Jun 2001 17:30:13 -0400
Date: Sun, 24 Jun 2001 23:30:06 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: philb@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kmalloc check for drivers/media/video/i2c-parport.c (245ac16)
Message-ID: <20010624233006.I847@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch tries to avoid a potential null pointer
dereference. It applies against 245-ac16 and 246p6. The
dereference was originally reported by the Stanford team.


--- linux-245-ac16-clean/drivers/media/video/i2c-parport.c	Thu Jul 13 01:24:33 2000
+++ linux-245-ac16/drivers/media/video/i2c-parport.c	Sun Jun 24 23:22:19 2001
@@ -74,6 +74,10 @@
 {
   struct parport_i2c_bus *b = kmalloc(sizeof(struct parport_i2c_bus), 
 				      GFP_KERNEL);
+  if (!b) {
+	  printk(KERN_ERR __FUNCTION__ ": Memory allocation failed. Not attaching.\n");
+	  return;
+  }
   b->i2c = parport_i2c_bus_template;
   b->i2c.data = parport_get_port (port);
   strncpy(b->i2c.name, port->name, 32);
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"A statesman... is a dead politician. Lord knows, we need more statesmen." 
   -- Bloom County
