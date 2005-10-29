Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVJ2PQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVJ2PQl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 11:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVJ2PQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 11:16:40 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:49042 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751188AbVJ2PQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 11:16:40 -0400
From: larry.finger@att.net (Larry.Finger@lwfinger.net)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14 - Fix for incorrect CPU speed determination in powernow for i386
Date: Sat, 29 Oct 2005 15:16:37 +0000
Message-Id: <102920051516.7776.43639255000A849F00001E6021603762239D0A09020700D2979D9D0E04@att.net>
X-Mailer: AT&T Message Center Version 1 (Feb 14 2005)
X-Authenticated-Sender: bGFycnkuZmluZ2VyQGF0dC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser pointed out that my original patch unnecessarily initialized a variable that was already in the BSS section. I have therefore removed that hunk of the patch. The revised patch is given below.
 
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

---

diff --git a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c
+++ b/arch/i386/kernel/timers/common.c
@@ -151,7 +151,7 @@ unsigned long read_timer_tsc(void)
 /* calculate cpu_khz */
 void init_cpu_khz(void)
 {
-       if (cpu_has_tsc) {
+       if (cpu_has_tsc && !cpu_khz) {
                unsigned long tsc_quotient = calibrate_tsc();
                if (tsc_quotient) {
                        /* report CPU clock rate in Hz.



