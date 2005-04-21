Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVDUHqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVDUHqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVDUHo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:44:26 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:44983 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261446AbVDUHaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 6/22] W1: drop owner field from master and slave structures
Date: Thu, 21 Apr 2005 02:13:01 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210213.01427.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: drop owner field from w1_master and w1_slave structures.
    Just having it there does not magically fixes lifetime
    rules.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c     |    1 -
 w1.h     |    2 --
 w1_int.c |    1 -
 3 files changed, 4 deletions(-)

Index: dtor/drivers/w1/w1_int.c
===================================================================
--- dtor.orig/drivers/w1/w1_int.c
+++ dtor/drivers/w1/w1_int.c
@@ -60,7 +60,6 @@ struct w1_master * w1_alloc_dev(u32 id, 
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-	dev->owner		= THIS_MODULE;
 	dev->max_slave_count	= slave_count;
 	dev->slave_count	= 0;
 	dev->attempts		= 0;
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -407,7 +407,6 @@ static int w1_attach_slave_device(struct
 
 	memset(sl, 0, sizeof(*sl));
 
-	sl->owner = THIS_MODULE;
 	sl->master = dev;
 	set_bit(W1_SLAVE_ACTIVE, &sl->flags);
 
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -64,7 +64,6 @@ struct w1_reg_num
 
 struct w1_slave
 {
-	struct module		*owner;
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	node;
 	struct w1_reg_num	reg_num;
@@ -108,7 +107,6 @@ struct w1_bus_master
 struct w1_master
 {
 	struct list_head	node;
-	struct module		*owner;
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	slist;
 	int			max_slave_count, slave_count;
