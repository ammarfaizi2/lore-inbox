Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSIEVwW>; Thu, 5 Sep 2002 17:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSIEVwL>; Thu, 5 Sep 2002 17:52:11 -0400
Received: from hermes.domdv.de ([193.102.202.1]:38409 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318196AbSIEVvS>;
	Thu, 5 Sep 2002 17:51:18 -0400
Message-ID: <3D77C532.3050806@domdv.de>
Date: Thu, 05 Sep 2002 22:57:22 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compiler warning fix for irtty.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090103040802030002080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103040802030002080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch fixes deprecated usage warnings for __FUNCTION__ in 
irtty.c.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------090103040802030002080109
Content-Type: text/plain;
 name="irtty.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irtty.c.diff"

--- drivers/net/irda/irtty.c.orig	2002-09-05 22:49:01.000000000 +0200
+++ drivers/net/irda/irtty.c	2002-09-05 22:53:51.000000000 +0200
@@ -121,9 +121,8 @@
 	
 	/* Unregister tty line-discipline */
 	if ((ret = tty_register_ldisc(N_IRDA, NULL))) {
-		ERROR(__FUNCTION__ 
-		      "(), can't unregister line discipline (err = %d)\n",
-		      ret);
+		ERROR("%s(), can't unregister line discipline (err = %d)\n",
+		      __FUNCTION__,ret);
 	}
 
 	/*
@@ -230,7 +229,7 @@
 	self->rx_buff.data = self->rx_buff.head;
 	
 	if (!(dev = dev_alloc("irda%d", &err))) {
-		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
+		ERROR("%s(), dev_alloc() failed!\n",__FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -249,7 +248,7 @@
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err) {
-		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
+		ERROR("%s(), register_netdev() failed!\n",__FUNCTION__);
 		return -1;
 	}
 
@@ -455,8 +454,8 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		break;
 	case IRDA_TASK_CHILD_WAIT:
-		WARNING(__FUNCTION__ 
-			"(), changing speed of dongle timed out!\n");
+		WARNING("%s(), changing speed of dongle timed out!\n",
+			__FUNCTION__);
 		ret = -1;		
 		break;
 	case IRDA_TASK_CHILD_DONE:
@@ -467,7 +466,7 @@
 		self->task = NULL;
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->task = NULL;
 		ret = -1;

--------------090103040802030002080109--


