Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbUJ3PWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUJ3PWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUJ3PVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:21:31 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:935 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261208AbUJ3OkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:40:19 -0400
Message-ID: <4183A7C4.8050204@kolivas.org>
Date: Sun, 31 Oct 2004 00:40:04 +1000
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
Subject: [PATCH][plugsched 18/28] Remove private proc entry
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig67E58F68F40A26F3F55B9E88"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67E58F68F40A26F3F55B9E88
Content-Type: multipart/mixed;
 boundary="------------020608000701000000070507"

This is a multi-part message in MIME format.
--------------020608000701000000070507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove private proc entry


--------------020608000701000000070507
Content-Type: text/x-patch;
 name="remove_specific_proc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_specific_proc.diff"

sleep_avg is no longer a meaningful value being non linear and scheduler
dependant. Remove it from proc.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm1/fs/proc/array.c
===================================================================
--- linux-2.6.10-rc1-mm1.orig/fs/proc/array.c	2004-10-27 22:40:25.587597899 +1000
+++ linux-2.6.10-rc1-mm1/fs/proc/array.c	2004-10-28 00:01:01.722069447 +1000
@@ -162,7 +162,6 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -170,7 +169,6 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	p->tgid,
 		p->pid, p->pid ? p->group_leader->real_parent->tgid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,


--------------020608000701000000070507--

--------------enig67E58F68F40A26F3F55B9E88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6fEZUg7+tp6mRURAr/hAJ4tTK2cQcDhn5d4jdb5a6vLwbqiOgCeOyxh
Xa3WZhRfgCb2B24T9GYVlmE=
=6P8P
-----END PGP SIGNATURE-----

--------------enig67E58F68F40A26F3F55B9E88--
