Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757962AbWLCRRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbWLCRRy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758009AbWLCRRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:17:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:6600 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1757962AbWLCRRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:17:53 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 12:14:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipc:  Convert kmalloc()+memset() to kzalloc() in ipc/.
Message-ID: <Pine.LNX.4.64.0612031211560.4877@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Convert the single changeable instance of kmalloc() + memset() to
kzalloc() in the ipc/ directory.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  ok, i *think* this one's valid.  now i'll go work on something else.

diff --git a/ipc/sem.c b/ipc/sem.c
index 21b3289..3c23dc9 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1070,14 +1070,13 @@ static struct sem_undo *find_undo(struct
 	ipc_rcu_getref(sma);
 	sem_unlock(sma);

-	new = (struct sem_undo *) kmalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	new = (struct sem_undo *) kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
 	if (!new) {
 		ipc_lock_by_ptr(&sma->sem_perm);
 		ipc_rcu_putref(sma);
 		sem_unlock(sma);
 		return ERR_PTR(-ENOMEM);
 	}
-	memset(new, 0, sizeof(struct sem_undo) + sizeof(short)*nsems);
 	new->semadj = (short *) &new[1];
 	new->semid = semid;

