Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVEaAD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVEaAD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVEaAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:03:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45706 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261840AbVE3XwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:52:19 -0400
Date: Tue, 31 May 2005 01:52:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: more thread_info patches
In-Reply-To: <Pine.LNX.4.61.0505310113370.10977@scrub.home>
Message-ID: <Pine.LNX.4.61.0505310143200.10977@scrub.home>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
 <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
 <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0505310113370.10977@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the final patch to remove the thread_info field.
It probably shouldn't be applied until the previous one is dealt with and 
is mostly merged.

bye, Roman

---

 include/linux/init_task.h |    1 -
 include/linux/sched.h     |    1 -
 kernel/fork.c             |    1 -
 3 files changed, 3 deletions(-)

Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-05-31 01:20:37.374145520 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-05-31 01:20:41.599419704 +0200
@@ -616,7 +616,6 @@ struct mempolicy;
 
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	struct thread_info *thread_info;
 	void *stack;
 	atomic_t usage;
 	unsigned long flags;	/* per process flags, defined below */
Index: linux-2.6-mm/include/linux/init_task.h
===================================================================
--- linux-2.6-mm.orig/include/linux/init_task.h	2005-05-31 01:19:05.913856451 +0200
+++ linux-2.6-mm/include/linux/init_task.h	2005-05-31 01:20:41.599419704 +0200
@@ -70,7 +70,6 @@ extern struct group_info init_groups;
 #define INIT_TASK(tsk)	\
 {									\
 	.state		= 0,						\
-	.thread_info	= &init_thread_info,				\
 	.stack		= &init_stack,					\
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-05-31 01:20:29.560487745 +0200
+++ linux-2.6-mm/kernel/fork.c	2005-05-31 01:20:41.600419532 +0200
@@ -172,7 +172,6 @@ static struct task_struct *dup_task_stru
 
 	*tsk = *orig;
 	tsk->stack = stack;
-	tsk->thread_info = stack;
 	setup_thread_stack(tsk, orig);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
