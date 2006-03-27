Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWC0IlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWC0IlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWC0IlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:41:21 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11660 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750800AbWC0IlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:41:21 -0500
Message-Id: <200603270840.k2R8e92V024551@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linda Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.16 Block I/O Schedulers - document runtime selection
In-Reply-To: Your message of "Sun, 26 Mar 2006 22:19:52 PST."
             <20060326221952.6f0e20a2.rdunlap@xenotime.net> 
From: Valdis.Kletnieks@vt.edu
References: <4426377C.7000605@tlinx.org> <200603260706.k2Q76thB030947@turing-police.cc.vt.edu> <442759FB.8090309@tlinx.org>
            <20060326221952.6f0e20a2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143448808_18690P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 03:40:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1143448808_18690P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Mar 2006 22:19:52 PST, "Randy.Dunlap" said:

> Patches accepted... Please summarize what you have found, even if not in
> patch format (and I'll make it a patch).

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

We added the ability to change a block device's IO elevator scheduler both
at kernel boot and on-the-fly, but we only documented the elevator= boot
parameter.  Add a quick how-to on doing it on the fly.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
--- linux-2.6.16-mm1/Documentation/block/switching-sched.txt.new	2006-03-27 03:26:25.000000000 -0500
+++ linux-2.6.16-mm1/Documentation/block/switching-sched.txt	2006-03-27 03:33:39.000000000 -0500
@@ -0,0 +1,22 @@
+As of the Linux 2.6.mumble kernel, it is now possible to change the
+IO scheduler for a given block device on the fly (thus making it possible,
+for instance, to set the CFQ scheduler for the system default, but
+set a specific device to use the anticipatory or noop schedulers - which
+can improve that device's throughput).
+
+To set a specific scheduler, simply do this:
+
+echo SCHEDNAME > /sys/block/DEV/queue/scheduler
+
+where SCHEDNAME is the name of a defined IO scheduler, and DEV is the
+device name (hda, hdb, sga, or whatever you happen to have).
+
+The list of defined schedulers can be found by simply doing
+a "cat /sys/block/DEV/queue/scheduler" - the list of valid names
+will be displayed, with the currently selected scheduler in brackets:
+
+# cat /sys/block/hda/queue/scheduler
+noop anticipatory deadline [cfq]
+# echo anticipatory > /sys/block/hda/queue/scheduler
+# cat /sys/block/hda/queue/scheduler
+noop [anticipatory] deadline cfq




--==_Exmh_1143448808_18690P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEJ6TocC3lWbTT17ARAjClAKD308kG9z4z0XYNVjchBMOgQwJ7bgCcDdIY
GT4R8EJSfWS41FEPUIt8uhg=
=WL79
-----END PGP SIGNATURE-----

--==_Exmh_1143448808_18690P--
