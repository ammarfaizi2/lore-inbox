Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbUKTFCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbUKTFCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbUKTCjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:39:36 -0500
Received: from baikonur.stro.at ([213.239.196.228]:38320 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263054AbUKTCbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:31:48 -0500
Subject: [patch 2/9]  list_for_each_entry: 	drivers-macintosh-via-pmu.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:31:45 +0100
Message-ID: <E1CVL2P-0000lQ-RB@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Make code more readable with list_for_each_entry.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/macintosh/via-pmu.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff -puN drivers/macintosh/via-pmu.c~list-for-each-entry-drivers_macintosh_via-pmu drivers/macintosh/via-pmu.c
--- linux-2.6.10-rc2-bk4/drivers/macintosh/via-pmu.c~list-for-each-entry-drivers_macintosh_via-pmu	2004-11-19 17:14:49.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/macintosh/via-pmu.c	2004-11-19 17:14:49.000000000 +0100
@@ -2054,12 +2054,9 @@ static LIST_HEAD(sleep_notifiers);
 int
 pmu_register_sleep_notifier(struct pmu_sleep_notifier *n)
 {
-	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+	list_for_each_entry(notifier, &sleep_notifiers, list) {
 		if (n->priority > notifier->priority)
 			break;
 	}
@@ -2085,8 +2082,7 @@ broadcast_sleep(int when, int fallback)
 	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
-	     list = list->prev) {
+	list_for_each_prev(list, &sleep_notifiers) {
 		notifier = list_entry(list, struct pmu_sleep_notifier, list);
 		ret = notifier->notifier_call(notifier, when);
 		if (ret != PBOOK_SLEEP_OK) {
@@ -2107,14 +2103,10 @@ static int __pmac
 broadcast_wake(void)
 {
 	int ret = PBOOK_SLEEP_OK;
-	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+	list_for_each_entry(notifier, &sleep_notifiers, list)
 		notifier->notifier_call(notifier, PBOOK_WAKE);
-	}
 	return ret;
 }
 
@@ -2727,15 +2719,13 @@ static void __pmac
 pmu_pass_intr(unsigned char *data, int len)
 {
 	struct pmu_private *pp;
-	struct list_head *list;
 	int i;
 	unsigned long flags;
 
 	if (len > sizeof(pp->rb_buf[0].data))
 		len = sizeof(pp->rb_buf[0].data);
 	spin_lock_irqsave(&all_pvt_lock, flags);
-	for (list = &all_pmu_pvt; (list = list->next) != &all_pmu_pvt; ) {
-		pp = list_entry(list, struct pmu_private, list);
+	list_for_each_entry(pp, &all_pmu_pvt, list) {
 		spin_lock(&pp->lock);
 		i = pp->rb_put + 1;
 		if (i >= RB_SIZE)
_
