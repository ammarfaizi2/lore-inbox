Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSCAQkh>; Fri, 1 Mar 2002 11:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCAQkd>; Fri, 1 Mar 2002 11:40:33 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:47537 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S293315AbSCAQji>; Fri, 1 Mar 2002 11:39:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Frode Isaksen <fisaksen@bewan.com>
Reply-To: fisaksen@bewan.com
To: mitch@sfgoth.com
Subject: [PATCH] spinlock not locked when unlocking in atm_dev_register
Date: Fri, 1 Mar 2002 18:46:28 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020301163936.7FA725F963@postfix2-2.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you compile the kernel with SMP and spinlock debugging, BUG() will be 
called when registering your atm driver, since the "atm_dev_lock" spinlock is 
not locked when unlocking it.

kernel 2.4.18

Regards,
Frode

--- resources.c.orig	Fri Mar  1 18:34:02 2002
+++ resources.c	Fri Mar  1 18:34:17 2002
@@ -110,12 +110,10 @@
 		if (atm_proc_dev_register(dev) < 0) {
 			printk(KERN_ERR "atm_dev_register: "
 			    "atm_proc_dev_register failed for dev %s\n",type);
-			spin_unlock (&atm_dev_lock);	
 			free_atm_dev(dev);
 			return NULL;
 		}
 #endif
-	spin_unlock (&atm_dev_lock);		
 	return dev;
 }
