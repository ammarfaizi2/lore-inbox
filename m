Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131491AbQK0OW4>; Mon, 27 Nov 2000 09:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131404AbQK0OWg>; Mon, 27 Nov 2000 09:22:36 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:4605 "EHLO
        passion.cygnus") by vger.kernel.org with ESMTP id <S131120AbQK0OWZ>;
        Mon, 27 Nov 2000 09:22:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of gratiutous panic()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Nov 2000 13:51:58 +0000
Message-ID: <29143.975333118@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: kernel/module.c
===================================================================
RCS file: /inst/cvs/linux/kernel/module.c,v
retrieving revision 1.1.1.1.2.11
diff -u -r1.1.1.1.2.11 module.c
--- kernel/module.c	2000/11/10 14:56:37	1.1.1.1.2.11
+++ kernel/module.c	2000/11/27 13:50:32
@@ -100,7 +100,8 @@
 			spin_unlock(&ime_lock);
 			kfree(ime_new);
 			/* Program logic error, fatal */
-			panic("inter_module_register: duplicate im_name '%s'", im_name);
+			printk(KERN_ERR "inter_module_register: duplicate im_name '%s'", im_name);
+			BUG();
 		}
 	}
 	list_add(&(ime_new->list), &ime_list);
@@ -140,7 +141,8 @@
 	}
 	else {
 		/* Program logic error, fatal */
-		panic("inter_module_unregister: no entry for '%s'", im_name);
+		printk(KERN_ERR "inter_module_unregister: no entry for '%s'", im_name);
+		BUG();
 	}
 }
 
@@ -211,7 +213,8 @@
 		}
 	}
 	spin_unlock(&ime_lock);
-	panic("inter_module_put: no entry for '%s'", im_name);
+	printk(KERN_ERR "inter_module_put: no entry for '%s'", im_name);
+	BUG();
 }
 
 



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
