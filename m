Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUIWUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUIWUYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUIWUVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:21:48 -0400
Received: from baikonur.stro.at ([213.239.196.228]:422 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S265795AbUIWUTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:19:41 -0400
Subject: [patch 1/5]  use list_for_each() drivers/pcmcia/rsrc_mgr.c
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:19:41 +0200
Message-ID: <E1CAa45-00074X-KK@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use list_for_each() where applicable
- for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
+ list_for_each(list, &ymf_devs) {
pure cosmetic change, defined as a preprocessor macro in:
include/linux/list.h


Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/pcmcia/rsrc_mgr.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/pcmcia/rsrc_mgr.c~list_for_each-pcmcia-rsrc_mgr drivers/pcmcia/rsrc_mgr.c
--- linux-2.6.9-rc2-bk7/drivers/pcmcia/rsrc_mgr.c~list_for_each-pcmcia-rsrc_mgr	2004-09-21 20:46:36.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/pcmcia/rsrc_mgr.c	2004-09-21 20:46:36.000000000 +0200
@@ -469,7 +469,7 @@ static void validate_mem(struct pcmcia_s
     }
     if (lo++)
 	goto out;
-    for (m = mem_db.next; m != &mem_db; m = mm.next) {
+    list_for_each(m, &mem_db) {
 	mm = *m;
 	/* Only probe < 1 MB */
 	if (mm.base >= 0x100000) continue;
@@ -501,7 +501,7 @@ static void validate_mem(struct pcmcia_s
     
     if (done++ == 0) {
 	down(&rsrc_sem);
-	for (m = mem_db.next; m != &mem_db; m = mm.next) {
+	list_for_each(m, &mem_db) {
 	    mm = *m;
 	    if (do_mem_probe(mm.base, mm.num, s))
 		break;
@@ -985,11 +985,11 @@ void release_resource_db(void)
 {
     resource_map_t *p, *q;
     
-    for (p = mem_db.next; p != &mem_db; p = q) {
+    list_for_each(p, &mem_db) {
 	q = p->next;
 	kfree(p);
     }
-    for (p = io_db.next; p != &io_db; p = q) {
+    list_for_each(p, &io_db) {
 	q = p->next;
 	kfree(p);
     }
_
