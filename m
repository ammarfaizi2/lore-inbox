Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUGIKEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUGIKEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUGIKDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:03:36 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:24739 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264895AbUGIKA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:00:57 -0400
Message-ID: <40EE6CC2.8070001@kolivas.org>
Date: Fri, 09 Jul 2004 20:00:34 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Likelihood of rt_tasks
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F1C0C58E5451DB09962B8D5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F1C0C58E5451DB09962B8D5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A quick question about the usefulness of making rt_task() checks 
unlikely in sched-unlikely-rt_task.patch which is in -mm

quote:

diff -puN include/linux/sched.h~sched-unlikely-rt_task include/linux/sched.h
--- 25/include/linux/sched.h~sched-unlikely-rt_task	Fri Jul  2 16:33:01 2004
+++ 25-akpm/include/linux/sched.h	Fri Jul  2 16:33:01 2004
@@ -300,7 +300,7 @@ struct signal_struct {

  #define MAX_PRIO		(MAX_RT_PRIO + 40)

-#define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+#define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))

  /*
   * Some day this will be a full-fledged user tracking system..

---
While rt tasks are normally unlikely, what happens in the case when you 
are scheduling one or many running rt_tasks and the majority of your 
scheduling is rt? Would it be such a good idea in this setting that it 
is always hitting the slow path of branching all the time?

Con

--------------enig8F1C0C58E5451DB09962B8D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7mzCZUg7+tp6mRURAh+9AJ9JCt2kDXqQjDAwWfOR44F4meV29gCcC5ks
9WtSZZP40PVI1pJupzXQczk=
=k6qO
-----END PGP SIGNATURE-----

--------------enig8F1C0C58E5451DB09962B8D5--
