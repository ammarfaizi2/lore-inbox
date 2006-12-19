Return-Path: <linux-kernel-owner+w=401wt.eu-S932875AbWLSSOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWLSSOT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbWLSSOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:14:19 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58421 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbWLSSOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:14:18 -0500
X-Originating-Ip: 24.163.66.209
Date: Tue, 19 Dec 2006 13:10:11 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Remove final traces of deprecated kmem_cache_t.
Message-ID: <Pine.LNX.4.64.0612191305490.10391@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-12.808, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the last use of kmem_cache_t and the deprecated typedef.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  without looking too deeply into it, it looks like the last
references to kmem_cache_t can be removed, although there are still
going to be online web pages that refer to it, like

  http://old.kernelnewbies.org/documents/kdoc/kernel-api/r2382.html


 fs/dlm/lowcomms-tcp.c |    2 +-
 include/linux/slab.h  |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)


diff --git a/fs/dlm/lowcomms-tcp.c b/fs/dlm/lowcomms-tcp.c
index 8f2791f..9be3a44 100644
--- a/fs/dlm/lowcomms-tcp.c
+++ b/fs/dlm/lowcomms-tcp.c
@@ -143,7 +143,7 @@ static DECLARE_WAIT_QUEUE_HEAD(lowcomms_recv_waitq);
 /* An array of pointers to connections, indexed by NODEID */
 static struct connection **connections;
 static DECLARE_MUTEX(connections_lock);
-static kmem_cache_t *con_cache;
+static struct kmem_cache *con_cache;
 static int conn_array_size;

 /* List of sockets that have reads pending */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1ef822e..b115541 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -14,8 +14,6 @@
 #include <linux/gfp.h>
 #include <linux/types.h>

-typedef struct kmem_cache kmem_cache_t __deprecated;
-
 /*
  * Flags to pass to kmem_cache_create().
  * The ones marked DEBUG are only valid if CONFIG_SLAB_DEBUG is set.
