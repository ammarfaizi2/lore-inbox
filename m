Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263480AbUKBFcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUKBFcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S773903AbUKBFcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:32:42 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:42145 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S321288AbUKBFbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 00:31:47 -0500
Message-ID: <41871BB1.6020001@kolivas.org>
Date: Tue, 02 Nov 2004 16:31:29 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] remove sleep-avg stats
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C97E84FB5B272A83D0D42D6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C97E84FB5B272A83D0D42D6
Content-Type: multipart/mixed;
 boundary="------------080205080209040102070004"

This is a multi-part message in MIME format.
--------------080205080209040102070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

remove sleep-avg stats



--------------080205080209040102070004
Content-Type: text/x-patch;
 name="sched-remove_sleep-avg_stats.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-remove_sleep-avg_stats.diff"

sleep_avg is a non linear value which is only useful for debugging purposes
in the development of the interactivity estimator. 

Remove sleep_avg reporting from /proc.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/fs/proc/array.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/fs/proc/array.c	2004-11-02 13:19:18.000000000 +1100
+++ linux-2.6.10-rc1-mm2/fs/proc/array.c	2004-11-02 16:15:37.709154456 +1100
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


--------------080205080209040102070004--

--------------enig2C97E84FB5B272A83D0D42D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhxuxZUg7+tp6mRURAjvmAJ94p3hX8N49QCjAuj5ak3x+zcl+kQCeMKey
tnD+tlOEI5+1cPltEoWN40c=
=1Umh
-----END PGP SIGNATURE-----

--------------enig2C97E84FB5B272A83D0D42D6--
