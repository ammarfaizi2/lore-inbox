Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265692AbUFXPmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUFXPmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUFXPmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:42:36 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:33585 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265692AbUFXPm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:42:29 -0400
Subject: [PATCH] 2.6.7-bk7 ppp_generic.c get_filter made conditional
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Organization: 
Message-Id: <1088091747.2017.2.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jun 2004 10:42:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add #ifdef CONFIG_PPP_FILTER around get_filter implementation
which is only used when this option is enabled. This
prevents compiler warning (unused function) when
CONFIG_PPP_FILTER is not defined.

--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.7/drivers/net/ppp_generic.c	2004-06-24 09:41:43.000000000 -0500
+++ linux-2.6.7-mg1/drivers/net/ppp_generic.c	2004-06-24 10:37:22.580842447 -0500
@@ -494,6 +494,7 @@
 	return mask;
 }
 
+#ifdef CONFIG_PPP_FILTER
 static int get_filter(void __user *arg, struct sock_filter **p)
 {
 	struct sock_fprog uprog;
@@ -530,6 +531,7 @@
 	*p = code;
 	return uprog.len;
 }
+#endif /* CONFIG_PPP_FILTER */
 
 static int ppp_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)



