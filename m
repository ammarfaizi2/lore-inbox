Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSJIMdf>; Wed, 9 Oct 2002 08:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbSJIMcV>; Wed, 9 Oct 2002 08:32:21 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:48256 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261623AbSJIMcO>;
	Wed, 9 Oct 2002 08:32:14 -0400
Date: Wed, 9 Oct 2002 07:37:53 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5.41-bk compile errors (fwd)
Message-ID: <Pine.LNX.4.44.0210090736420.1623-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I appear to be having mail problems so  I'm sending this again.  I 
apologize if anyone gets this twice.

---------- Forwarded message ----------
Date: Tue, 8 Oct 2002 22:23:25 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41-bk compile errors

In the latest bk tree the following patches were required:

A second instance of lock had been inadvertently added to v_midi.h

--- linux-2.5-tm/sound/oss/v_midi.h.orig	Tue Oct  8 21:42:56 2002
+++ linux-2.5-tm/sound/oss/v_midi.h	Tue Oct  8 21:43:37 2002
@@ -11,6 +11,5 @@
 	   int input_opened;
 	   int intr_active;
 	   void (*midi_input_intr) (int dev, unsigned char data);
-	   spinlock_t lock;
 	} vmidi_devc;
 

the netfilter ipt owner module still needs the following to compile

--- linux-2.5-tm/kernel/ksyms.c.orig	Sat Oct  5 19:43:21 2002
+++ linux-2.5-tm/kernel/ksyms.c	Sat Oct  5 20:04:00 2002
@@ -600,6 +600,8 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
+EXPORT_SYMBOL(find_task_by_pid);
+EXPORT_SYMBOL(next_thread);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif


