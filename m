Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTEIXkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTEIXkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:40:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61387 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263585AbTEIXk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:40:27 -0400
Date: Fri, 9 May 2003 16:53:46 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Driver core changes for 2.5.69
Message-ID: <20030509235346.GA3517@kroah.com>
References: <20030509235142.GA3506@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509235142.GA3506@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1096, 2003/05/09 16:25:57-07:00, corbet@lwn.net

[PATCH] cpufreq class fix


 include/linux/cpu.h |    1 +
 kernel/cpufreq.c    |    2 ++
 2 files changed, 3 insertions(+)


diff -Nru a/include/linux/cpu.h b/include/linux/cpu.h
--- a/include/linux/cpu.h	Fri May  9 16:40:39 2003
+++ b/include/linux/cpu.h	Fri May  9 16:40:39 2003
@@ -29,6 +29,7 @@
 };
 
 extern int register_cpu(struct cpu *, int, struct node *);
+extern struct class cpu_class;
 
 /* Stop CPUs going up and down. */
 extern struct semaphore cpucontrol;
diff -Nru a/kernel/cpufreq.c b/kernel/cpufreq.c
--- a/kernel/cpufreq.c	Fri May  9 16:40:39 2003
+++ b/kernel/cpufreq.c	Fri May  9 16:40:39 2003
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 /**
  * The "cpufreq driver" - the arch- or hardware-dependend low
@@ -115,6 +116,7 @@
 extern struct device_class cpu_devclass;
 
 static struct class_interface cpufreq_interface = {
+        .class =	&cpu_class,
         .add =		&cpufreq_add_dev,
         .remove =	&cpufreq_remove_dev,
 };
