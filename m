Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVAIIx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVAIIx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 03:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVAIIx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 03:53:56 -0500
Received: from mx1.mail.ru ([194.67.23.121]:52550 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262068AbVAIIxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 03:53:53 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] futex: s/0/NULL/ in pointer context
Date: Sun, 9 Jan 2005 11:23:31 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501091123.31402.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-2.6.10-bk11-warnings/kernel/futex.c
===================================================================
--- linux-2.6.10-bk11-warnings/kernel/futex.c	(revision 4)
+++ linux-2.6.10-bk11-warnings/kernel/futex.c	(revision 5)
@@ -236,7 +236,7 @@
  */
 static inline void get_key_refs(union futex_key *key)
 {
-	if (key->both.ptr != 0) {
+	if (key->both.ptr != NULL) {
 		if (key->both.offset & 1)
 			atomic_inc(&key->shared.inode->i_count);
 		else
@@ -250,7 +250,7 @@
  */
 static void drop_key_refs(union futex_key *key)
 {
-	if (key->both.ptr != 0) {
+	if (key->both.ptr != NULL) {
 		if (key->both.offset & 1)
 			iput(key->shared.inode);
 		else
@@ -445,7 +445,7 @@
 	/* In the common case we don't take the spinlock, which is nice. */
  retry:
 	lock_ptr = q->lock_ptr;
-	if (lock_ptr != 0) {
+	if (lock_ptr != NULL) {
 		spin_lock(lock_ptr);
 		/*
 		 * q->lock_ptr can change between reading it and
