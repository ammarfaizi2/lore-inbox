Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUCUNLU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 08:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbUCUNLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 08:11:19 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:36366 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263644AbUCUNLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 08:11:17 -0500
Date: Mon, 22 Mar 2004 00:11:09 +1100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mochel@osdl.org
Subject: [PMDISK] Fix strcmp in sysfs store
Message-ID: <20040321131109.GA28413@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch fixes the sysfs store functions for pmdisk when the input
contains a trailing newline.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.5/kernel/power/disk.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/disk.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 disk.c
--- a/kernel-2.5/kernel/power/disk.c	11 Mar 2004 02:55:21 -0000	1.1.1.3
+++ b/kernel-2.5/kernel/power/disk.c	21 Mar 2004 13:00:40 -0000
@@ -285,11 +285,16 @@
 {
 	int error = 0;
 	int i;
+	int len;
+	char * p;
 	u32 mode = 0;
 
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf: n;
+
 	down(&pm_sem);
 	for (i = PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
-		if (!strcmp(buf,pm_disk_modes[i])) {
+		if (!strncmp(buf,pm_disk_modes[i],len)) {
 			mode = i;
 			break;
 		}
Index: kernel-2.5/kernel/power/main.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/main.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 main.c
--- a/kernel-2.5/kernel/power/main.c	28 Sep 2003 04:44:22 -0000	1.1.1.2
+++ b/kernel-2.5/kernel/power/main.c	21 Mar 2004 12:59:48 -0000
@@ -218,10 +218,15 @@
 {
 	u32 state = PM_SUSPEND_STANDBY;
 	char ** s;
+	char * p;
 	int error;
+	int len;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf: n;
 
 	for (s = &pm_states[state]; *s; s++, state++) {
-		if (!strcmp(buf,*s))
+		if (!strncmp(buf,*s,len))
 			break;
 	}
 	if (*s)

--jRHKVT23PllUwdXP--
