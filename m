Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSHCFL4>; Sat, 3 Aug 2002 01:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSHCFLz>; Sat, 3 Aug 2002 01:11:55 -0400
Received: from smtp.comcast.net ([24.153.64.2]:41571 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S317472AbSHCFLv>;
	Sat, 3 Aug 2002 01:11:51 -0400
Date: Sat, 03 Aug 2002 01:15:15 -0400
From: Milosz Tanski <milosz@comcast.net>
Subject: Fix: DEVFS compile failuer [2.5.30]
To: linux-kernel@vger.kernel.org
Message-id: <1028351716.6004.4.camel@milosz.home.com>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8
Content-type: multipart/mixed; boundary="Boundary_(ID_jWMZBun5Pg++SzKCpN26+g)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_jWMZBun5Pg++SzKCpN26+g)
Content-type: text/plain
Content-transfer-encoding: 7BIT

There is a compile time error in Linux 2.5.30 in fs/partitions/check.c,
in function devfs_register_partitions. The line 470 contains an error,
dev->part[p].de = NULL; p is a pointer to a structure (hd_stuct). I
searched around 2.4.18, and it is  dev->part[part + minor].de = NULL; I
tried changing that line, and I investigated, now it compiles and works.
A patch is attached, thx.


--Boundary_(ID_jWMZBun5Pg++SzKCpN26+g)
Content-type: text/plain; name=devfs-array.patch; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=devfs-array.patch

--- fs/partitions/check.c.orig	2002-08-01 17:16:19.000000000 -0400
+++ fs/partitions/check.c	2002-08-03 00:51:49.000000000 -0400
@@ -467,7 +467,7 @@
 	for (part = 1; part < max_p; part++) {
 		if ( unregister || (p[part].nr_sects < 1) ) {
 			devfs_unregister(p[part].de);
-			dev->part[p].de = NULL;
+			dev->part[part + minor].de = NULL;
 			continue;
 		}
 		devfs_register_partition (dev, minor, part);

--Boundary_(ID_jWMZBun5Pg++SzKCpN26+g)--
