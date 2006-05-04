Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWEDNFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWEDNFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWEDNFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:05:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:37863 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750997AbWEDNFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:05:23 -0400
Date: Thu, 4 May 2006 15:10:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: [patch] fix unlikely profiling & vsyscalls on x86_64
Message-ID: <20060504131014.GA17036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix unlikely profiling in vsyscalls ...

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/x86_64/kernel/vsyscall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -107,7 +107,7 @@ static __always_inline long time_syscall
 
 int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
 {
-	if (unlikely(!__sysctl_vsyscall))
+	if (!__sysctl_vsyscall)
 		return gettimeofday(tv,tz);
 	if (tv)
 		do_vgettimeofday(tv);
@@ -120,7 +120,7 @@ int __vsyscall(0) vgettimeofday(struct t
  * unlikely */
 time_t __vsyscall(1) vtime(time_t *t)
 {
-	if (unlikely(!__sysctl_vsyscall))
+	if (!__sysctl_vsyscall)
 		return time_syscall(t);
 	else if (t)
 		*t = __xtime.tv_sec;		
