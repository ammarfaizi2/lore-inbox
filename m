Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVCYGJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVCYGJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:09:26 -0500
Received: from digitalimplant.org ([64.62.235.95]:8147 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261402AbVCYFyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:55 -0500
Date: Thu, 24 Mar 2005 21:54:48 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [9/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242152350.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2247, 2005-03-24 18:59:59-08:00, mochel@digitalimplant.org
  [klist] Don't reference NULL klist pointer in klist_remove().


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/lib/klist.c b/lib/klist.c
--- a/lib/klist.c	2005-03-24 20:33:01 -08:00
+++ b/lib/klist.c	2005-03-24 20:33:01 -08:00
@@ -145,9 +145,10 @@

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

