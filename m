Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbUJ3PWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUJ3PWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUJ3PVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:21:13 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:2764 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261188AbUJ3Ok1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:40:27 -0400
Message-ID: <4183A7CF.8070902@kolivas.org>
Date: Sun, 31 Oct 2004 00:40:15 +1000
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
Subject: [PATCH][plugsched 19/28] Name and choose scheduler
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF39C225A81B1C376BBE969B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF39C225A81B1C376BBE969B0
Content-Type: multipart/mixed;
 boundary="------------010406030005060008080000"

This is a multi-part message in MIME format.
--------------010406030005060008080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Name and choose scheduler


--------------010406030005060008080000
Content-Type: text/x-patch;
 name="setup_scheduler.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup_scheduler.diff"

Add a scheduler name and the beginnings of bootparam checking to change
scheduler at boot time.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-29 21:47:52.739595073 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:48:05.209648954 +1000
@@ -1,5 +1,8 @@
+#define SCHED_NAME_MAX	(16)
+
 struct sched_drv
 {
+	char cpusched_name[SCHED_NAME_MAX];
 	int (*rt_task)(task_t *);
 	void (*wait_for_completion)(struct completion *);
 	void (*io_schedule)(void);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:52.743594449 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:48:05.211648642 +1000
@@ -4151,6 +4151,7 @@ void destroy_sched_domain_sysctl()
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.cpusched_name		= "ingosched",
 	.rt_task		= ingo_rt_task,
 	.wait_for_completion	= ingo_wait_for_completion,
 	.io_schedule		= ingo_io_schedule,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:49.051170701 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:48:05.212648486 +1000
@@ -878,7 +878,17 @@ void fastcall complete_all(struct comple
 EXPORT_SYMBOL(complete_all);
 
 extern struct sched_drv ingo_sched_drv;
-static const struct sched_drv *scheduler = &ingo_sched_drv;
+
+static struct sched_drv *scheduler = &ingo_sched_drv;
+
+static int __init scheduler_setup(char *str)
+{
+	if (!strcmp(str, "ingosched"))
+		scheduler = &ingo_sched_drv;
+	return 1;
+}
+
+__setup ("cpusched=", scheduler_setup);
 
 void fastcall __sched wait_for_completion(struct completion *x)
 {


--------------010406030005060008080000--

--------------enigF39C225A81B1C376BBE969B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6fPZUg7+tp6mRURAp6bAJ9LasYmMxDkfjc9Yy4WhT5Ia2DWRACglHSf
twORtiAH6QE3TNBleOTkSIU=
=VY7e
-----END PGP SIGNATURE-----

--------------enigF39C225A81B1C376BBE969B0--
