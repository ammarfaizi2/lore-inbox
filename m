Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318907AbSIIXKk>; Mon, 9 Sep 2002 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSIIXKk>; Mon, 9 Sep 2002 19:10:40 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:23567 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S318907AbSIIXKj>;
	Mon, 9 Sep 2002 19:10:39 -0400
Date: Mon, 9 Sep 2002 19:03:53 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <jt@bougret.hpl.hp.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.34 : drivers/net/irda/irtty.c __FUNCTION__ fix
Message-ID: <Pine.LNX.4.44.0209091859290.973-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
     The following patch fixes several __FUNCTION__ related errors. Please 
review for inclusion. 

Regards,
Frank

--- linux/drivers/net/irda/irtty.c.old	Thu Jun 20 19:57:59 2002
+++ linux/drivers/net/irda/irtty.c	Mon Sep  9 18:51:29 2002
@@ -118,9 +118,7 @@
 	
 	/* Unregister tty line-discipline */
 	if ((ret = tty_register_ldisc(N_IRDA, NULL))) {
-		ERROR(__FUNCTION__ 
-		      "(), can't unregister line discipline (err = %d)\n",
-		      ret);
+		   ERROR("%s (), can't unregister line discipline (err = %d)\n", __FUNCTION, ret);
 	}
 
 	/*
@@ -226,7 +224,7 @@
 	self->rx_buff.data = self->rx_buff.head;
 	
 	if (!(dev = dev_alloc("irda%d", &err))) {
-		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
+		ERROR(" %s (), dev_alloc() failed!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -245,7 +243,7 @@
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err) {
-		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
+		ERROR(" %s (), register_netdev() failed!\n", __FUNCTION__);
 		return -1;
 	}
 
@@ -451,8 +449,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		break;
 	case IRDA_TASK_CHILD_WAIT:
-		WARNING(__FUNCTION__ 
-			"(), changing speed of dongle timed out!\n");
+		WARNING(" %s (), changing speed of dongle timed out!\n", __FUNCTION__);
 		ret = -1;		
 		break;
 	case IRDA_TASK_CHILD_DONE:
@@ -463,7 +460,7 @@
 		self->task = NULL;
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR(" %s (), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->task = NULL;
 		ret = -1;

