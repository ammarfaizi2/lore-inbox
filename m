Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313534AbSDPDI4>; Mon, 15 Apr 2002 23:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313544AbSDPDIz>; Mon, 15 Apr 2002 23:08:55 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:11015 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S313534AbSDPDIy>;
	Mon, 15 Apr 2002 23:08:54 -0400
Date: Mon, 15 Apr 2002 21:59:33 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>, <fdavis@si.rr.com>
Subject: [PATCH] 2.5.8-dj1: net/atm/resources.c
Message-ID: <Pine.LNX.4.33.0204152150470.13897-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   I received the following while 'make bzImage', and have attached a 
patch that appears to fix it. Please review for inclusion.
Regards,
Frank

resources.c:86: parse error before `int'
resources.c: In function `atm_dev_register':
resources.c:87: number of arguments doesn't match prototype
/usr/src/linux/include/linux/atmdev.h:417: prototype declaration
resources.c:92: warning: implicit declaration of function `alloc_atm_dev'
resources.c:92: `type' undeclared (first use in this function)
resources.c:92: (Each undeclared identifier is reported only once
resources.c:92: for each function it appears in.)
resources.c:92: warning: assignment makes pointer from integer without a cast
resources.c:98: `number' undeclared (first use in this function)
resources.c:100: warning: implicit declaration of function `free_atm_dev'
resources.c:113: `ops' undeclared (first use in this function)
resources.c:114: `flags' undeclared (first use in this function)
resources.c: At top level:
resources.c:36: warning: `__alloc_atm_dev' defined but not used
make[3]: *** [resources.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/atm'

--- net/atm/resources.c.old	Mon Apr 15 21:42:25 2002
+++ net/atm/resources.c	Mon Apr 15 21:48:31 2002
@@ -82,14 +82,14 @@
 	return NULL;
 }
 
-struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops
+struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops,
 				int number, atm_dev_flags_t *flags)
 {
 	struct atm_dev *dev = NULL;
 
 	spin_lock(&atm_dev_lock);
 
-	dev = alloc_atm_dev(type);
+	dev = __alloc_atm_dev(type);
 	if (!dev) {
 		printk(KERN_ERR "atm_dev_register: no space for dev %s\n",
 		    type);


