Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUISUbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUISUbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUISUbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:31:48 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:20339 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263664AbUISUbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:31:46 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: mingo@elte.hu
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Date: Sun, 19 Sep 2004 22:32:20 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409192232.20139.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

things improved here after having applied 
swapspace-layout-improvements-2.6.9-rc1-bk12-A1.
I'm happily running jackd and clients realtime now without any dropouts even 
under heavy swapping pressure.
(Machine is a PIII@600MHz with 256MB RAM)
Could you please include the swapspace-layout-improvements in the 
voluntary-preempt patches?

Just 1 small correction:
>>>>
--- kernel/time.c~      2004-09-19 15:09:38.000000000 +0200
+++ kernel/time.c       2004-09-19 17:02:35.000000000 +0200
@@ -96,8 +96,10 @@
 asmlinkage long sys_gettimeofday(struct timeval __user *tv, struct timezone 
__user *tz)
 {
 #ifdef CONFIG_LATENCY_TRACE
-       if (!tv && ((long)tz == 1))
+       if (!tv && ((long)tz == 1)) {
                user_trace_start();
+               tz = NULL;
+       }
        if (!tv && !tz)
                user_trace_stop();
 #endif
<<<<

thanks for your splendid patches,
Karsten
