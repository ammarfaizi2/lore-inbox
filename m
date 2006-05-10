Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWEJC5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWEJC5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWEJC5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:11 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:13886 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932452AbWEJC5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:57:02 -0400
Date: Tue, 9 May 2006 19:55:56 -0700
Message-Id: <200605100255.k4A2tumv031649@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: faith@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] audit_filter_user gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

kernel/auditfilter.c: In function ‘audit_filter_user’:
kernel/auditfilter.c:762: warning: ‘state’ is used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/kernel/auditfilter.c
===================================================================
--- linux-2.6.16.orig/kernel/auditfilter.c
+++ linux-2.6.16/kernel/auditfilter.c
@@ -753,7 +753,7 @@ static int audit_filter_user_rules(struc
 int audit_filter_user(struct netlink_skb_parms *cb, int type)
 {
 	struct audit_entry *e;
-	enum audit_state   state;
+	enum audit_state state = AUDIT_DISABLED;
 	int ret = 1;
 
 	rcu_read_lock();
