Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWF0SIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWF0SIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWF0SIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:08:16 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:29089 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932516AbWF0SIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:08:15 -0400
Date: Tue, 27 Jun 2006 13:08:48 -0500
From: minyard@acm.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] IPMI: tidy msghandler timer
Message-ID: <20060627180847.GA10805@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tidy up the timer usage in the IPMI driver.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -3741,11 +3741,8 @@ static int ipmi_init_msghandler(void)
 	proc_ipmi_root->owner = THIS_MODULE;
 #endif /* CONFIG_PROC_FS */
 
-	init_timer(&ipmi_timer);
-	ipmi_timer.data = 0;
-	ipmi_timer.function = ipmi_timeout;
-	ipmi_timer.expires = jiffies + IPMI_TIMEOUT_JIFFIES;
-	add_timer(&ipmi_timer);
+	setup_timer(&ipmi_timer, ipmi_timeout, 0);
+	mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
