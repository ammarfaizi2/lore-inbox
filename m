Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUJ3Ox1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUJ3Ox1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUJ3Owz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:52:55 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:10644 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261189AbUJ3Olt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:41:49 -0400
Message-ID: <4183A81D.7050700@kolivas.org>
Date: Sun, 31 Oct 2004 00:41:33 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 26/28] Add description to proc
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69DD622ED3872C8840C78CDA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69DD622ED3872C8840C78CDA
Content-Type: multipart/mixed;
 boundary="------------040502090904030306010604"

This is a multi-part message in MIME format.
--------------040502090904030306010604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add description to proc


--------------040502090904030306010604
Content-Type: text/x-patch;
 name="add_proc_description.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_proc_description.diff"

Add an entry in /proc/scheduler which reads out the running cpu scheduler's
name.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/fs/proc/proc_misc.c	2004-10-30 00:19:30.452320081 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/fs/proc/proc_misc.c	2004-10-30 00:20:14.086339759 +1000
@@ -45,6 +45,7 @@
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -265,6 +266,18 @@ static int version_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+static int scheduler_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	char *sched_name = scheduler->cpusched_name;
+	int len;
+
+	strcpy(page, sched_name);
+	strcat(page, "\n");
+	len = strlen(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 extern struct seq_operations cpuinfo_op;
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
@@ -608,6 +621,7 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+		{"scheduler",	scheduler_read_proc},
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)


--------------040502090904030306010604--

--------------enig69DD622ED3872C8840C78CDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6gdZUg7+tp6mRURAmdwAJ9OALMIsDPNrn6uYHjA/4oTfYlkMACfWtOH
0A6aDtAe6XbqERHiOHOnodU=
=owCM
-----END PGP SIGNATURE-----

--------------enig69DD622ED3872C8840C78CDA--
