Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263882AbTCUTll>; Fri, 21 Mar 2003 14:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263886AbTCUTkp>; Fri, 21 Mar 2003 14:40:45 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:2688 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S263882AbTCUTkU>;
	Fri, 21 Mar 2003 14:40:20 -0500
Date: Fri, 21 Mar 2003 20:51:14 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix kobject_get oopses triggered by i2c in 2.5.65-bk
Message-ID: <20030321195114.GA1313@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  
i2c initialization must not use module_init now, when it was converted
to the kobject interface. There are dozens of users which need it working
much sooner. i2c is subsystem after all, isn't it?

Fixes kernel oopses in kobject_get during system init which were happening
to me.

						Petr Vandrovec
						vandrove@vc.cvut.cz

--- vger/drivers/i2c/i2c-core.c	2003-03-21 19:06:32.000000000 +0100
+++ linux/drivers/i2c/i2c-core.c	2003-03-21 20:42:13.000000000 +0100
@@ -675,7 +675,7 @@
 	bus_unregister(&i2c_bus_type);
 }
 
-module_init(i2c_init);
+subsys_initcall(i2c_init);
 module_exit(i2c_exit);
 
 /* ----------------------------------------------------
