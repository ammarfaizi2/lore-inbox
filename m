Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262267AbSJIWQf>; Wed, 9 Oct 2002 18:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSJIWQe>; Wed, 9 Oct 2002 18:16:34 -0400
Received: from ce00521-p19-hertas5.cenara.com ([195.38.1.140]:18560 "EHLO
	ce00521-p19-hertas5.cenara.com") by vger.kernel.org with ESMTP
	id <S262267AbSJIWQd>; Wed, 9 Oct 2002 18:16:33 -0400
Date: Thu, 10 Oct 2002 00:22:05 +0200 (CEST)
From: =?iso-8859-1?Q?Per_Lid=E9n?= <per@fukt.bth.se>
X-X-Sender: per@ce00521-p19-hertas5.cenara.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] root kernel option with devfs
Message-ID: <Pine.LNX.4.44.0210092352320.192-100000@ce00521-p19-hertas5.cenara.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "root=" kernel option doesn't work when used together with devfs
device names, e.g. root=/dev/discs/disc0/part1. It appears as if the
string "discs/disc0/part1" will incorrectly be interpreted as a
hex-number, which results in a kernel panic "VFS: Unable to mount root fs
on ...". This has been broken since 2.4.19.

This patch has been submitted to lkml before (don't remember by who), and
I've only been updated it to apply cleanly on 2.4.20-pre10. It would be
very nice if this problem was solved before 2.4.20 was released.

/Per


--- linux-2.4.20-pre10/init/do_mounts.c.old	2002-10-09 23:04:59.000000000 +0200
+++ linux-2.4.20-pre10/init/do_mounts.c	2002-10-09 23:50:46.000000000
+0200
@@ -258,6 +258,8 @@
 			}
 			dev++;
 		} while (dev->name);
+		if (!(dev->name))
+			return to_kdev_t(0);
 	}
 	return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
 }

