Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbTHOSWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270695AbTHOSWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:22:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:25827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270692AbTHOSW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:22:29 -0400
Date: Fri, 15 Aug 2003 11:22:17 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kobject rename can take const char
Message-Id: <20030815112217.1c8c13e5.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_rename doesn't change the name string.

diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Fri Aug 15 11:19:55 2003
+++ b/include/linux/kobject.h	Fri Aug 15 11:19:55 2003
@@ -39,7 +39,7 @@
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern void kobject_rename(struct kobject *, char *new_name);
+extern void kobject_rename(struct kobject *, const char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Fri Aug 15 11:19:55 2003
+++ b/lib/kobject.c	Fri Aug 15 11:19:55 2003
@@ -319,7 +319,7 @@
  *	@new_name: object's new name
  */
 
-void kobject_rename(struct kobject * kobj, char *new_name)
+void kobject_rename(struct kobject * kobj, const char *new_name)
 {
 	kobj = kobject_get(kobj);
 	if (!kobj)
