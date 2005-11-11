Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVKKIir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVKKIir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVKKIgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:10 -0500
Received: from i121.durables.org ([64.81.244.121]:7118 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932240AbVKKIgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:04 -0500
Date: Fri, 11 Nov 2005 02:35:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <5.282480653@selenic.com>
Message-Id: <6.282480653@selenic.com>
Subject: [PATCH 5/15] misc: Uninline some fslocks.c functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uninline some file locking functions

add/remove: 3/0 grow/shrink: 0/15 up/down: 256/-1525 (-1269)
function                                     old     new   delta
locks_free_lock                                -     134    +134
posix_same_owner                               -      69     +69
__locks_delete_block                           -      53     +53
posix_locks_conflict                         126     108     -18
locks_remove_posix                           266     237     -29
locks_wake_up_blocks                         121      87     -34
locks_block_on_timeout                        83      47     -36
locks_insert_block                           157     120     -37
locks_delete_block                            62      23     -39
posix_unblock_lock                           104      59     -45
posix_locks_deadlock                         162     100     -62
locks_delete_lock                            228     119    -109
sys_flock                                    338     217    -121
__break_lease                                600     474    -126
lease_init                                   252     122    -130
fcntl_setlk64                                793     649    -144
fcntl_setlk                                  793     649    -144
__posix_lock_file                           1477    1026    -451

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/fs/locks.c
===================================================================
--- 2.6.14-misc.orig/fs/locks.c	2005-11-01 10:54:33.000000000 -0800
+++ 2.6.14-misc/fs/locks.c	2005-11-09 11:19:44.000000000 -0800
@@ -154,7 +154,7 @@ static struct file_lock *locks_alloc_loc
 }
 
 /* Free a lock which is not in use. */
-static inline void locks_free_lock(struct file_lock *fl)
+static void locks_free_lock(struct file_lock *fl)
 {
 	if (fl == NULL) {
 		BUG();
@@ -475,8 +475,7 @@ static inline int locks_overlap(struct f
 /*
  * Check whether two locks have the same owner.
  */
-static inline int
-posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
 	if (fl1->fl_lmops && fl1->fl_lmops->fl_compare_owner)
 		return fl2->fl_lmops == fl1->fl_lmops &&
@@ -487,7 +486,7 @@ posix_same_owner(struct file_lock *fl1, 
 /* Remove waiter from blocker's block list.
  * When blocker ends up pointing to itself then the list is empty.
  */
-static inline void __locks_delete_block(struct file_lock *waiter)
+static void __locks_delete_block(struct file_lock *waiter)
 {
 	list_del_init(&waiter->fl_block);
 	list_del_init(&waiter->fl_link);
