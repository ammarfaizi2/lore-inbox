Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759205AbWLDDaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205AbWLDDaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 22:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759206AbWLDDaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 22:30:00 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:8138 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1759205AbWLDDaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 22:30:00 -0500
Date: Sun, 3 Dec 2006 19:30:29 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: minyard@acm.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] IPMI: fix PROC_FS=n warnings
Message-Id: <20061203193029.a6d117e2.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix build warnings for PROC_FS=n.

drivers/char/ipmi/ipmi_poweroff.c:707: warning: label 'out_err' defined but not used

drivers/char/ipmi/ipmi_msghandler.c:1774: warning: 'ipmb_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1790: warning: 'version_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1801: warning: 'stat_file_read_proc' defined but not used

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/ipmi/ipmi_msghandler.c |    2 ++
 drivers/char/ipmi/ipmi_poweroff.c   |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.19-git4.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.19-git4/drivers/char/ipmi/ipmi_poweroff.c
@@ -702,9 +702,9 @@ static int ipmi_poweroff_init (void)
 		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
 		goto out_err;
 	}
-#endif
 
  out_err:
+#endif
 	return rv;
 }
 
--- linux-2.6.19-git4.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19-git4/drivers/char/ipmi/ipmi_msghandler.c
@@ -1769,6 +1769,7 @@ int ipmi_request_supply_msgs(ipmi_user_t
 			      -1, 0);
 }
 
+#ifdef CONFIG_PROC_FS
 static int ipmb_file_read_proc(char *page, char **start, off_t off,
 			       int count, int *eof, void *data)
 {
@@ -1857,6 +1858,7 @@ static int stat_file_read_proc(char *pag
 
 	return (out - ((char *) page));
 }
+#endif /* CONFIG_PROC_FS */
 
 int ipmi_smi_add_proc_entry(ipmi_smi_t smi, char *name,
 			    read_proc_t *read_proc, write_proc_t *write_proc,

---
