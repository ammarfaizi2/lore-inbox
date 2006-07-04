Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWGDPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWGDPZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWGDPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:25:10 -0400
Received: from oker.escape.de ([194.120.234.254]:31449 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S932209AbWGDPZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:25:07 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] RCU Documentation
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 04 Jul 2006 17:22:22 +0200
Message-ID: <m2sllh8kep.fsf@janus.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updater should use _rcu variant of list_del().


urs



Signed-off-by: Urs Thuermann <urs@isnogud.escape.de>

--- linux-2.6.17/Documentation/RCU/whatisRCU.txt.orig
+++ linux-2.6.17/Documentation/RCU/whatisRCU.txt
@@ -677,8 +677,9 @@
 	+	spin_lock(&listmutex);
 		list_for_each_entry(p, head, lp) {
 			if (p->key == key) {
-				list_del(&p->list);
+	-			list_del(&p->list);
 	-			write_unlock(&listmutex);
+	+			list_del_rcu(&p->list);
 	+			spin_unlock(&listmutex);
 	+			synchronize_rcu();
 				kfree(p);
@@ -726,7 +727,7 @@
  5   write_lock(&listmutex);            5   spin_lock(&listmutex);
  6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p, head, lp) {
  7     if (p->key == key) {             7     if (p->key == key) {
- 8       list_del(&p->list);            8       list_del(&p->list);
+ 8       list_del(&p->list);            8       list_del_rcu(&p->list);
  9       write_unlock(&listmutex);      9       spin_unlock(&listmutex);
                                        10       synchronize_rcu();
 10       kfree(p);                     11       kfree(p);
