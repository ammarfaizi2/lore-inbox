Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSFVKgz>; Sat, 22 Jun 2002 06:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSFVKgy>; Sat, 22 Jun 2002 06:36:54 -0400
Received: from pD9E235A7.dip.t-dialin.net ([217.226.53.167]:45786 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316860AbSFVKgx>; Sat, 22 Jun 2002 06:36:53 -0400
Date: Sat, 22 Jun 2002 04:36:53 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Q] change_parent() - would this work?
Message-ID: <Pine.LNX.4.44.0206220435310.4307-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My question is: would this work?

Index: thunder-2.5/include/linux/sched.h
===================================================================
RCS file: thunder-2.5/include/linux/sched.h,v
retrieving revision 1.2
diff -u -r1.2 thunder-2.5/include/linux/sched.h
--- thunder-2.5/include/linux/sched.h	22 Jun 2002 01:51:33 -0000	1.2
+++ thunder-2.5/include/linux/sched.h	22 Jun 2002 10:33:57 -0000
@@ -716,6 +716,7 @@
 
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
+#define change_parent(p)	list_move_tail(&(p)->sibling,&(parent)->children)
 
 #define REMOVE_LINKS(p) do {				\
 	list_del_init(&(p)->tasks);			\
Index: thunder-2.5/kernel/exit.c
===================================================================
RCS file: thunder-2.5/kernel/exit.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 thunder-2.5/kernel/exit.c
--- thunder-2.5/kernel/exit.c	20 Jun 2002 22:53:49 -0000	1.1.1.1
+++ thunder-2.5/kernel/exit.c	22 Jun 2002 10:33:57 -0000
@@ -636,8 +636,7 @@
 
 				/* move to end of parent's list to avoid starvation */
 				write_lock_irq(&tasklist_lock);
-				remove_parent(p);
-				add_parent(p, p->parent);
+				change_parent(p, p->parent);
 				write_unlock_irq(&tasklist_lock);
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0; 
 				if (!retval && stat_addr) 

							Regards,
							Thunder
--
"You must cut down the mighties tree in the forest with - a herring!"
					-- chief of the knights who to
					   recently said "NIH"

