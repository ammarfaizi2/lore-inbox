Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319118AbSIJNh1>; Tue, 10 Sep 2002 09:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319121AbSIJNh1>; Tue, 10 Sep 2002 09:37:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63970 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319118AbSIJNh0>;
	Tue, 10 Sep 2002 09:37:26 -0400
Date: Tue, 10 Sep 2002 09:42:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Rusty Russell <rusty@rustcorp.com.au>, Jens Axboe <axboe@suse.de>,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Missing IDE partition 3 of 3 on 2.5.34?
In-Reply-To: <3D7DE25F.3269EBF7@aitel.hist.no>
Message-ID: <Pine.GSO.4.21.0209100940330.5825-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Sep 2002, Helge Hafting wrote:

> I see the same thing.  Both of my IDE drives comes up without
> the last partition. (Missing ide/host0/bus0/target0/lun0/part3
> and ide/host0/bus1/target0/lun0/part7, loosing /usr and /usr/src
> in my case.)
> 
> There's lots of updates in code that deals with partitions
> and devfs, I couldn't find anything obvious wrong though.

devfs side.  Fix:

--- C34/fs/partitions/check.c	Mon Sep  9 20:39:52 2002
+++ /tmp/check.c	Tue Sep 10 09:39:47 2002
@@ -327,7 +327,7 @@
 	devfs_auto_unregister(dev->disk_de, slave);
 	if (!(dev->flags & GENHD_FL_DEVFS))
 		devfs_auto_unregister (slave, dir);
-	for (part = 1, p++; part < max_p; part++, p++)
+	for (part = 1; part < max_p; part++, p++)
 		if (p->nr_sects)
 			devfs_register_partition(dev, part);
 #endif

