Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVAZAha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVAZAha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVAZAhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:37:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:37281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262271AbVAZAeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:34:02 -0500
Date: Tue, 25 Jan 2005 16:33:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] some minor cleanups for audit_log_lost() messages
Message-ID: <20050125163357.O24171@build.pdx.osdl.net>
References: <20050125163247.N24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050125163247.N24171@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, Jan 25, 2005 at 04:32:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor cleanups for audit_log_lost() messages.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/audit.c 1.7 vs edited =====
--- 1.7/kernel/audit.c	2005-01-25 14:35:07 -08:00
+++ edited/kernel/audit.c	2005-01-25 14:35:54 -08:00
@@ -160,7 +160,7 @@ static void audit_panic(const char *mess
 		printk(KERN_ERR "audit: %s\n", message);
 		break;
 	case AUDIT_FAIL_PANIC:
-		panic(message);
+		panic("audit: %s\n", message);
 		break;
 	}
 }
@@ -663,10 +663,10 @@ struct audit_buffer *audit_log_start(str
 
 	if (!ab)
 		ab = kmalloc(sizeof(*ab), GFP_ATOMIC);
-	if (!ab)
-		audit_log_lost("audit: out of memory in audit_log_start");
-	if (!ab)
+	if (!ab) {
+		audit_log_lost("out of memory in audit_log_start");
 		return NULL;
+	}
 
 	atomic_inc(&audit_backlog);
 	skb_queue_head_init(&ab->sklist);
