Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWAVUWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWAVUWH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAVUWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:22:07 -0500
Received: from mail.suse.de ([195.135.220.2]:16803 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750719AbWAVUWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:22:06 -0500
Date: Sun, 22 Jan 2006 21:22:04 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] disable per cpu intr in /proc/stat
Message-ID: <20060122202204.GA26295@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(No bugzilla or benchmark)

From: schwab@suse.de
Subject: Reading /proc/stat is slooow

Don't compute and display the per-irq sums on ia64 either, too much
overhead for mostly useless figures.

--- linux-2.6.14/fs/proc/proc_misc.c.~1~	2005-12-06 18:12:28.840059961 +0100
+++ linux-2.6.14/fs/proc/proc_misc.c	2005-12-06 18:13:51.211896515 +0100
@@ -498,7 +498,7 @@ static int show_stat(struct seq_file *p,
 	}
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
 
-#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA) && !defined(CONFIG_IA64)
 	for (i = 0; i < NR_IRQS; i++)
 		seq_printf(p, " %u", kstat_irqs(i));
 #endif
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
