Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTEIWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTEIWxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:53:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263567AbTEIWws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:52:48 -0400
Date: Fri, 9 May 2003 16:05:26 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Corey Minyard <minyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.69] IPMI warning removal
Message-Id: <20030509160526.4b5d6a60.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IPMI driver has warnings because it is putting interrupt mask into int
when it should be using a unsigned long.

diff -Nru a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
--- a/drivers/char/ipmi/ipmi_msghandler.c	Fri May  9 15:54:51 2003
+++ b/drivers/char/ipmi/ipmi_msghandler.c	Fri May  9 15:54:51 2003
@@ -174,7 +174,7 @@
 int
 ipmi_register_all_cmd_rcvr(ipmi_user_t user)
 {
-	int flags;
+	unsigned long flags;
 	int rv = -EBUSY;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
@@ -193,7 +193,7 @@
 int
 ipmi_unregister_all_cmd_rcvr(ipmi_user_t user)
 {
-	int flags;
+	unsigned long flags;
 	int rv = -EINVAL;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
@@ -1023,7 +1023,7 @@
 	int              rv;
 	ipmi_smi_t       new_intf;
 	struct list_head *entry;
-	unsigned int     flags;
+	unsigned long    flags;
 
 
 	/* Make sure the driver is actually initialized, this handles
