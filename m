Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272816AbTHKQwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272815AbTHKQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:50:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1625 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272816AbTHKQtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:31 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse annotations for ipc/sem
Message-Id: <E19mFqr-00068H-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/ipc/sem.c linux-2.5/ipc/sem.c
--- bk-linus/ipc/sem.c	2003-07-08 18:31:55.000000000 +0100
+++ linux-2.5/ipc/sem.c	2003-07-13 16:55:51.000000000 +0100
@@ -425,7 +425,7 @@ static void freeary (struct sem_array *s
 	ipc_rcu_free(sma, size);
 }
 
-static unsigned long copy_semid_to_user(void *buf, struct semid64_ds *in, int version)
+static unsigned long copy_semid_to_user(void __user *buf, struct semid64_ds *in, int version)
 {
 	switch(version) {
 	case IPC_64:
@@ -686,7 +686,7 @@ struct sem_setbuf {
 	mode_t	mode;
 };
 
-static inline unsigned long copy_semid_from_user(struct sem_setbuf *out, void *buf, int version)
+static inline unsigned long copy_semid_from_user(struct sem_setbuf *out, void __user *buf, int version)
 {
 	switch(version) {
 	case IPC_64:
@@ -960,13 +960,13 @@ out:
 	return un;
 }
 
-asmlinkage long sys_semop (int semid, struct sembuf *tsops, unsigned nsops)
+asmlinkage long sys_semop (int semid, struct sembuf __user *tsops, unsigned nsops)
 {
 	return sys_semtimedop(semid, tsops, nsops, NULL);
 }
 
-asmlinkage long sys_semtimedop(int semid, struct sembuf *tsops,
-			unsigned nsops, const struct timespec *timeout)
+asmlinkage long sys_semtimedop(int semid, struct sembuf __user *tsops,
+			unsigned nsops, const struct timespec __user *timeout)
 {
 	int error = -EINVAL;
 	struct sem_array *sma;
