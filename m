Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279084AbRJ2JAM>; Mon, 29 Oct 2001 04:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279085AbRJ2I75>; Mon, 29 Oct 2001 03:59:57 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:34300 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S279084AbRJ2I7l>; Mon, 29 Oct 2001 03:59:41 -0500
Date: Mon, 29 Oct 2001 14:30:03 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: <linux-kernel@vger.kernel.org>
cc: <linux-abi-devel@lists.sourceforge.net>
Subject: [Patch] small fix for warning in exec_domain.c
Message-ID: <Pine.GSO.4.33.0110291428230.20450-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When support for Kernel modules is not configured, we get
a warning. This fix solves that.

thanks
Manik Raina

Index: exec_domain.c
===================================================================
RCS file: /vger/linux/kernel/exec_domain.c,v
retrieving revision 1.21
diff -u -r1.21 exec_domain.c
--- exec_domain.c	25 Oct 2001 20:23:02 -0000	1.21
+++ exec_domain.c	29 Oct 2001 08:40:02 -0000
@@ -77,7 +77,6 @@
 lookup_exec_domain(u_long personality)
 {
 	struct exec_domain *	ep;
-	char			buffer[30];
 	u_long			pers = personality(personality);

 	read_lock(&exec_domains_lock);
@@ -89,8 +88,11 @@

 #ifdef CONFIG_KMOD
 	read_unlock(&exec_domains_lock);
-	sprintf(buffer, "personality-%ld", pers);
-	request_module(buffer);
+	{
+		char buffer[30];
+		sprintf(buffer, "personality-%ld", pers);
+		request_module(buffer);
+	}
 	read_lock(&exec_domains_lock);

 	for (ep = exec_domains; ep; ep = ep->next) {

