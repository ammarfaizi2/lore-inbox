Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVLLLHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVLLLHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVLLLHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:07:13 -0500
Received: from mail.gmx.de ([213.165.64.21]:27629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751226AbVLLLHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:07:12 -0500
X-Authenticated: #704063
Subject: [PATCH 1/2] Fix ipmi_msghandler compilation without procfs
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: sdake@mvista.com
Content-Type: text/plain
Date: Mon, 12 Dec 2005 12:07:08 +0100
Message-Id: <1134385628.30934.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes ipmi compilation when procfs is disabled


Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.15-rc5/drivers/char/ipmi/ipmi_msghandler.orig	2005-12-08 12:09:54.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/ipmi/ipmi_msghandler.c	2005-12-08 12:09:02.000000000 +0100
@@ -1529,6 +1529,7 @@ int ipmi_request_supply_msgs(ipmi_user_t
 			      -1, 0);
 }
 
+#ifdef CONFIG_PROC_FS
 static int ipmb_file_read_proc(char *page, char **start, off_t off,
 			       int count, int *eof, void *data)
 {
@@ -1616,6 +1617,7 @@ static int stat_file_read_proc(char *pag
 
 	return (out - ((char *) page));
 }
+#endif
 
 int ipmi_smi_add_proc_entry(ipmi_smi_t smi, char *name,
 			    read_proc_t *read_proc, write_proc_t *write_proc,
@@ -3297,6 +3299,8 @@ EXPORT_SYMBOL(ipmi_get_my_address);
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
+#ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(proc_ipmi_root);
+#endif
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
 EXPORT_SYMBOL(ipmi_free_recv_msg);


