Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbUKTCku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbUKTCku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUKTCkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:40:33 -0500
Received: from baikonur.stro.at ([213.239.196.228]:4822 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S263094AbUKTCcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:32:02 -0500
Subject: [patch 7/9]  list_for_each_entry: 	fs-coda-psdev.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:32:01 +0100
Message-ID: <E1CVL2f-0000wS-G0@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use list_for_each_entry_safe to make code more readable.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/fs/coda/psdev.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN fs/coda/psdev.c~list-for-each-entry-safe-fs_coda_psdev fs/coda/psdev.c
--- linux-2.6.10-rc2-bk4/fs/coda/psdev.c~list-for-each-entry-safe-fs_coda_psdev	2004-11-19 17:15:05.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/coda/psdev.c	2004-11-19 17:15:05.000000000 +0100
@@ -310,8 +310,7 @@ static int coda_psdev_open(struct inode 
 static int coda_psdev_release(struct inode * inode, struct file * file)
 {
         struct venus_comm *vcp = (struct venus_comm *) file->private_data;
-        struct upc_req *req;
-	struct list_head *lh, *next;
+        struct upc_req *req, *tmp;
 
 	lock_kernel();
 	if ( !vcp->vc_inuse ) {
@@ -326,8 +325,7 @@ static int coda_psdev_release(struct ino
 	}
         
         /* Wakeup clients so they can return. */
-	list_for_each_safe(lh, next, &vcp->vc_pending) {
-		req = list_entry(lh, struct upc_req, uc_chain);
+	list_for_each_entry_safe(req, tmp, &vcp->vc_pending, uc_chain) {
 		/* Async requests need to be freed here */
 		if (req->uc_flags & REQ_ASYNC) {
 			CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
_
