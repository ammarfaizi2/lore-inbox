Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUACMlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbUACMlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:41:00 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:58752 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263185AbUACMk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:40:57 -0500
Date: Sat, 3 Jan 2004 13:42:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       cpufreq@www.linux.org.uk
Subject: do not leak memory in powernow-k8
Message-ID: <20040103124213.GA423@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This prevents memory leak if something goes wrong. Please apply,

								Pavel

Index: linux.new/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
--- linux.new.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2003-12-25 13:28:48.000000000 +0100
+++ linux.new/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2003-12-25 13:29:08.000000000 +0100
@@ -687,11 +687,13 @@
 			if (ppst[j].vid < rvo) {	/* vid+rvo >= 0 */
 				printk(KERN_ERR BFX
 				       "0 vid exceeded with pstate %d\n", j);
+				kfree(ppst);
 				return -ENODEV;
 			}
 			if (ppst[j].vid < maxvid+rvo) { /* vid+rvo >= maxvid */
 				printk(KERN_ERR BFX
 				       "maxvid exceeded with pstate %d\n", j);
+				kfree(ppst);
 				return -ENODEV;
 			}
 		}
@@ -706,7 +708,7 @@
 
 		for (j = 0; j < numps; j++)
 			if ((ppst[j].fid==currfid) && (ppst[j].vid==currvid))
-				return (0);
+				return 0;
 
 		printk(KERN_ERR BFX "currfid/vid do not match PST, ignoring\n");
 		return 0;


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
