Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVFUC7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVFUC7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVFUC6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:58:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:9188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261661AbVFTW7g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:36 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Don't reference NULL klist pointer in klist_remove().
In-Reply-To: <1119308365301@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <1119308366913@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Don't reference NULL klist pointer in klist_remove().

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/lib/klist.c b/lib/klist.c

---
commit 0293a509405dccecc30783a5d729d615b68d6a77
tree 69856eefdaba010e35dd7fbe2e5bb152a110d186
parent 0956af53afea290c5676c75249fc2c180d831375
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 18:59:59 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:19 -0700

 lib/klist.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/klist.c b/lib/klist.c
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -145,9 +145,10 @@ EXPORT_SYMBOL_GPL(klist_del);
 
 void klist_remove(struct klist_node * n)
 {
-	spin_lock(&n->n_klist->k_lock);
+	struct klist * k = n->n_klist;
+	spin_lock(&k->k_lock);
 	klist_dec_and_del(n);
-	spin_unlock(&n->n_klist->k_lock);
+	spin_unlock(&k->k_lock);
 	wait_for_completion(&n->n_removed);
 }
 

