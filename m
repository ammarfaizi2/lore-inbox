Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWEJC4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWEJC4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWEJC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:38 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51005 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932417AbWEJC4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:20 -0400
Date: Tue, 9 May 2006 19:56:08 -0700
Message-Id: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings,

ipc/sem.c: In function 'sys_semctl':
ipc/sem.c:810: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.mode' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/ipc/sem.c
===================================================================
--- linux-2.6.16.orig/ipc/sem.c
+++ linux-2.6.16/ipc/sem.c
@@ -807,7 +807,7 @@ static int semctl_down(int semid, int se
 {
 	struct sem_array *sma;
 	int err;
-	struct sem_setbuf setbuf;
+	struct sem_setbuf setbuf = {0, 0, 0};
 	struct kern_ipc_perm *ipcp;
 
 	if(cmd == IPC_SET) {
