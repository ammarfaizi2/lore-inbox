Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWGBBjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWGBBjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 21:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGBBjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 21:39:20 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:47063 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751103AbWGBBjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 21:39:20 -0400
Message-ID: <19484194.1151804351308.JavaMail.tomcat@pne-ps3-sn2>
Date: Sun, 2 Jul 2006 03:39:11 +0200 (MEST)
From: Voluspa <lista1@comhem.se>
Reply-To: Voluspa <lista1@comhem.se>
To: arjan@infradead.org
Subject: Re: [patch 1/2] sLeAZY FPU feature - x86_64 support
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [83.249.195.206]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You have a very strange 2.6.17 kernel there. The include/linux/sched.h is so 
incompatible that the patching (with fuzz) places "unsigned char fpu_counter;" 
in a totally unrelated struct, and not in "struct task_struct  {".

Here's a working rebase of that part - sorry about mangling by this webmail 
client... Btw, the whole thing has no measurable effect on real world stuff 
like rendering through blender - on my machine, at least.

diff -Nur linux-2.6.17-git19-original/include/linux/sched.h linux-2.6.17-git19-
sleazyfpu/include/linux/sched.h
--- linux-2.6.17-git19-original/include/linux/sched.h   2006-07-02 01:17:
36.000000000 +0200
+++ linux-2.6.17-git19-sleazyfpu/include/linux/sched.h  2006-07-02 01:10:
42.000000000 +0200
@@ -926,6 +926,16 @@
         * cache last used pipe for splice
         */
        struct pipe_inode_info *splice_pipe;
+
+       /*
+       * fpu_counter contains the number of consecutive context switches
+       * that the FPU is used. If this is over a threshold, the lazy fpu
+       * saving becomes unlazy to save the trap. This is an unsigned char
+       * so that after 256 times the counter wraps and the behavior turns
+       * lazy again; this to deal with bursty apps that only use FPU for
+       * a short time
+       */
+       unsigned char fpu_counter;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)

Mvh
Mats Johannesson

