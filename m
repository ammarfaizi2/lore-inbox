Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265551AbTFRViG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbTFRViF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:38:05 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7884 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265552AbTFRVh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:37:26 -0400
Date: Wed, 18 Jun 2003 14:51:22 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306182151.h5ILpMcx022062@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: add /proc/sys/kernel/cache_decay_ticks
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/sys/kernel/cache_decay_ticks allows runtime tuning of the
scheduler.  The earlier patch collided with the C99-ification of the
file, so here is a retransmit.

	--david

diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Wed Jun 18 13:32:49 2003
+++ b/include/linux/sysctl.h	Wed Jun 18 13:32:49 2003
@@ -130,6 +130,7 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_CACHEDECAYTICKS=58, /* ulong: value for cache_decay_ticks (EXPERIMENTAL!) */
 };
 
 
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed Jun 18 13:32:49 2003
+++ b/kernel/sysctl.c	Wed Jun 18 13:32:49 2003
@@ -551,6 +551,16 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_SMP
+	{
+		.ctl_name	= KERN_CACHEDECAYTICKS,
+		.procname	= "cache_decay_ticks",
+		.data		= &cache_decay_ticks,
+		.maxlen		= sizeof(cache_decay_ticks),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
