Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbUAPUXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUAPUXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:23:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265751AbUAPUXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:23:39 -0500
Date: Fri, 16 Jan 2004 12:23:36 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: A little ctc cleanup
Message-Id: <20040116122336.66c48009.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin:

With the current state machine, doing fsm_event(DEV_EVENT_STOP) is an
exact equivalent of dev_action_stop, only it adds a (superfluous) debugging
tracepoint, which is useless anyway, because dev_action_restart is an action,
so its caller does the same.

My compliments to Fritz and please ask him to accept this.

-- Pete

--- linux-2.6.1-mm3/drivers/s390/net/ctcmain.c	2004-01-14 16:17:02.000000000 -0500
+++ linux-2.6.1-mm3-s390/drivers/s390/net/ctcmain.c	2004-01-16 11:12:29.000000000 -0500
@@ -2075,10 +2075,9 @@
 {
 	struct net_device *dev = (struct net_device *)arg;
 	struct ctc_priv *privptr = dev->priv;
-	
+
 	printk(KERN_DEBUG "%s: Restarting\n", dev->name);
 	dev_action_stop(fi, event, arg);
-	fsm_event(privptr->fsm, DEV_EVENT_STOP, dev);
 	fsm_addtimer(&privptr->restart_timer, CTC_TIMEOUT_5SEC,
 		     DEV_EVENT_START, dev);
 }

