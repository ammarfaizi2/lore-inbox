Return-Path: <linux-kernel-owner+willy=40w.ods.org-S518938AbUKBEIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S518938AbUKBEIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S519922AbUKBEIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:08:54 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:9917 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S518925AbUKBEHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:07:03 -0500
Message-ID: <418707DA.7020202@kolivas.org>
Date: Tue, 02 Nov 2004 15:06:50 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] alter kthread prio
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2DFA526B727BD59FC4B68D7C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DFA526B727BD59FC4B68D7C
Content-Type: multipart/mixed;
 boundary="------------010009030901010805040103"

This is a multi-part message in MIME format.
--------------010009030901010805040103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

alter kthread prio



--------------010009030901010805040103
Content-Type: text/x-patch;
 name="sched-alter_kthread_prio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-alter_kthread_prio.diff"

Timeslice proportion has been increased substantially for -niced tasks. As
a result of this kernel threads have much larger timeslices than they
previously had.

Change kernel threads' nice value to -5 to bring their timeslice back in line
with previous behaviour. This means kernel threads will be less likely to
cause large latencies under periods of system stress for normal nice 0
tasks.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/workqueue.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/workqueue.c	2004-11-02 13:19:19.000000000 +1100
+++ linux-2.6.10-rc1-mm2/kernel/workqueue.c	2004-11-02 14:13:13.196261374 +1100
@@ -188,7 +188,7 @@ static int worker_thread(void *__cwq)
 
 	current->flags |= PF_NOFREEZE;
 
-	set_user_nice(current, -10);
+	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);


--------------010009030901010805040103--

--------------enig2DFA526B727BD59FC4B68D7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhwfaZUg7+tp6mRURAt4tAJ9WjGnFeAiOUkAvMaxRfzdEAA6PIgCeImyk
sMpbMnwlHNQEqt965bm8pJ0=
=CBID
-----END PGP SIGNATURE-----

--------------enig2DFA526B727BD59FC4B68D7C--
