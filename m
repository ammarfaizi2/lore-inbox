Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSHBAFu>; Thu, 1 Aug 2002 20:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSHBAFu>; Thu, 1 Aug 2002 20:05:50 -0400
Received: from mx3.fuse.net ([216.68.1.123]:50584 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S317767AbSHBAFt>;
	Thu, 1 Aug 2002 20:05:49 -0400
Message-ID: <3D49CDAD.6080503@fuse.net>
Date: Thu, 01 Aug 2002 20:09:17 -0400
From: Nathaniel <wfilardo@fuse.net>
Organization: BentTroll Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] 2.5.30 - Build error in fs/partition/check.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   gcc -Wp,-MD,./.check.o.d -D__KERNEL__ -I/home/nwf/src/kernel/linux-2.5.30/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=check -DEXPORT_SYMTAB  -c -o check.o check.c
check.c: In function `devfs_register_partitions':
check.c:470: array subscript is not an integer
make[2]: *** [check.o] Error 1
make[2]: Leaving directory `/home/nwf/src/kernel/linux-2.5.30/fs/partitions'
make[1]: *** [partitions] Error 2
make[1]: Leaving directory `/home/nwf/src/kernel/linux-2.5.30/fs'
make: *** [fs] Error 2

--- linux-2.5.30/fs/partitions/check.c.orig-nwf Thu Aug  1 20:03:25 2002
+++ linux-2.5.30/fs/partitions/check.c  Thu Aug  1 20:07:13 2002
@@ -467,7 +467,7 @@
         for (part = 1; part < max_p; part++) {
                 if ( unregister || (p[part].nr_sects < 1) ) {
                         devfs_unregister(p[part].de);
-                       dev->part[p].de = NULL;
+                       p[part].de = NULL;
                         continue;
                 }
                 devfs_register_partition (dev, minor, part);

That look right?
--Nathan


