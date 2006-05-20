Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWETX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWETX7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWETX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 19:59:40 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:56704 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932215AbWETX7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 19:59:39 -0400
Date: Sat, 20 May 2006 19:59:17 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@sg1
To: linux-kernel@vger.kernel.org
Subject: [patch] i386 warning cleanups that work
Message-ID: <Pine.LNX.4.61.0605201957070.3380@sg1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a version that works, without the efi stuff that caused all the problems, and which I assumed after making the cpu and apm stuff work would work just as easily; just goes to show the
problems with lazyness.

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index df0e174..fc34cf2 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1063,7 +1063,7 @@ #if defined(CONFIG_APM_DISPLAY_BLANK) &&

  static int apm_console_blank(int blank)
  {
-	int error, i;
+	int error = 0, i;
  	u_short state;
  	static const u_short dev[3] = { 0x100, 0x1FF, 0x101 };

@@ -1282,7 +1282,7 @@ static void standby(void)
  static apm_event_t get_event(void)
  {
  	int		error;
-	apm_event_t	event;
+	apm_event_t	event = 0;
  	apm_eventinfo_t	info;

  	static int notified;
diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
index 7214c9b..0737890 100644
--- a/arch/i386/kernel/cpu/transmeta.c
+++ b/arch/i386/kernel/cpu/transmeta.c
@@ -9,7 +9,7 @@ static void __init init_transmeta(struct
  {
  	unsigned int cap_mask, uk, max, dummy;
  	unsigned int cms_rev1, cms_rev2;
-	unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
+	unsigned int cpu_rev, cpu_freq = 0, cpu_flags, new_cpu_rev;
  	char cpu_info[65];

  	get_model_name(c);	/* Same as AMD/Cyrix */
