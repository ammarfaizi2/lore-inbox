Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTJETBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTJETBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:01:11 -0400
Received: from gprs148-216.eurotel.cz ([160.218.148.216]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263383AbTJETBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:01:09 -0400
Date: Sun, 5 Oct 2003 21:00:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: paul.devriendt@amd.com, davej@redhat.com,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: powernow-k8: don't crash system at boot
Message-ID: <20031005190056.GA863@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

powernow-k8 module fails to initialize government on boot, leading to
nasty crash at boot.

This fixes it. Plus find_closest_find really wants to be static. Fix
it, too.
								Pavel

Index: arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/arch/i386/kernel/cpu/cpufreq/powernow-k8.c,v
retrieving revision 1.2
diff -u -u -r1.2 powernow-k8.c
--- arch/i386/kernel/cpu/cpufreq/powernow-k8.c	1 Oct 2003 17:33:23 -0000	1.2
+++ arch/i386/kernel/cpu/cpufreq/powernow-k8.c	5 Oct 2003 18:41:50 -0000
@@ -718,7 +718,7 @@
 
 /* Converts a frequency (that might not necessarily be a multiple of 200) */
 /* to a fid.                                                              */
-u32
+static u32
 find_closest_fid(u32 freq, int searchup)
 {
 	if (searchup == SEARCH_UP)
@@ -971,6 +971,7 @@
 	pol->cpuinfo.max_freq = 1000 * find_freq_from_fid(ppst[numps-1].fid);
 	pol->min = 1000 * find_freq_from_fid(ppst[0].fid);
 	pol->max = 1000 * find_freq_from_fid(ppst[batps - 1].fid);
+	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
 
 	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
 	       currfid, currvid);



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
