Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUJ3Ppz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUJ3Ppz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUJ3PeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:34:18 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:27371 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261199AbUJ3Oj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:39:26 -0400
Message-ID: <4183A785.1080107@kolivas.org>
Date: Sun, 31 Oct 2004 00:39:01 +1000
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
Subject: [PATCH][plugsched 12/28] Make miscellanous public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5517355128AFD20A7CC601B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5517355128AFD20A7CC601B
Content-Type: multipart/mixed;
 boundary="------------090905050608040803080103"

This is a multi-part message in MIME format.
--------------090905050608040803080103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make miscellanous public


--------------090905050608040803080103
Content-Type: text/x-patch;
 name="publicise_misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_misc.diff"

Other stuff that can be public -> scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:08.882439571 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:10.884127180 +1000
@@ -3253,15 +3253,6 @@ static void __devinit ingo_init_idle(tas
 #endif
 }
 
-/*
- * In a system that switches off the HZ timer nohz_cpu_mask
- * indicates which cpus entered this state. This is used
- * in the rcu update to wait only for active cpus. For system
- * which do not switch off the HZ timer nohz_cpu_mask should
- * always be CPU_MASK_NONE.
- */
-cpumask_t nohz_cpu_mask = CPU_MASK_NONE;
-
 #ifdef CONFIG_SMP
 /*
  * This is how migration works:
@@ -4087,15 +4078,6 @@ static void __init ingo_sched_init_smp(v
 }
 #endif /* CONFIG_SMP */
 
-int in_sched_functions(unsigned long addr)
-{
-	/* Linker adds these: start and end of __sched functions */
-	extern char __sched_text_start[], __sched_text_end[];
-	return in_lock_functions(addr) ||
-		(addr >= (unsigned long)__sched_text_start
-		&& addr < (unsigned long)__sched_text_end);
-}
-
 static void __init ingo_sched_init(void)
 {
 	runqueue_t *rq;
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:08.883439414 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:10.886126868 +1000
@@ -733,6 +733,24 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
+/*
+ * In a system that switches off the HZ timer nohz_cpu_mask
+ * indicates which cpus entered this state. This is used
+ * in the rcu update to wait only for active cpus. For system
+ * which do not switch off the HZ timer nohz_cpu_mask should
+ * always be CPU_MASK_NONE.
+ */
+cpumask_t nohz_cpu_mask = CPU_MASK_NONE;
+
+int in_sched_functions(unsigned long addr)
+{
+	/* Linker adds these: start and end of __sched functions */
+	extern char __sched_text_start[], __sched_text_end[];
+	return in_lock_functions(addr) ||
+		(addr >= (unsigned long)__sched_text_start
+		&& addr < (unsigned long)__sched_text_end);
+}
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------090905050608040803080103--

--------------enigF5517355128AFD20A7CC601B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6eFZUg7+tp6mRURAhWmAJ9Oat7Ud2JnZCLF5sePU0rJyymhjQCePJJR
Mx6mNHxzVp7setJmk4HT0VE=
=TO8s
-----END PGP SIGNATURE-----

--------------enigF5517355128AFD20A7CC601B--
