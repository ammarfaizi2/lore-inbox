Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272289AbRH3PtL>; Thu, 30 Aug 2001 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272290AbRH3Psv>; Thu, 30 Aug 2001 11:48:51 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35807 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272289AbRH3Psk>; Thu, 30 Aug 2001 11:48:40 -0400
Subject: [PATCH] /proc/vmload memory_pressure meter
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 30 Aug 2001 10:47:46 +0000
Message-Id: <999168467.7844.23.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds /proc/vmload that reports the current value of
memory_pressure. The idea came from an enhancement proposed on the
linux-mm bugzilla (#3007, but it seems to be down atm).

This patch was made against 2.4.10-pre2.

-Paul Larson

diff -urN linux-2.4.10-pre2/fs/proc/proc_misc.c linux-2.4.10-pre2-vmload/fs/proc/proc_misc.c
--- linux-2.4.10-pre2/fs/proc/proc_misc.c	Thu Aug 30 09:51:47 2001
+++ linux-2.4.10-pre2-vmload/fs/proc/proc_misc.c	Thu Aug 30 09:55:10 2001
@@ -199,6 +199,15 @@
 #undef K
 }
 
+vmload_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data) {
+	int len = 0;
+ 
+	len += sprintf(page+len, "%d\n", memory_pressure);
+	*eof = 1;
+	return len;
+}
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -518,6 +527,7 @@
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
+		{"vmload",	vmload_read_proc},
 		{"version",	version_read_proc},
 		{"cpuinfo",	cpuinfo_read_proc},
 #ifdef CONFIG_PROC_HARDWARE

