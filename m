Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283057AbRLIGHh>; Sun, 9 Dec 2001 01:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283060AbRLIGHS>; Sun, 9 Dec 2001 01:07:18 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:37862 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S283057AbRLIGHG>; Sun, 9 Dec 2001 01:07:06 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 8 Dec 2001 22:06:57 -0800
Message-Id: <200112090606.WAA07320@adam.yggdrasil.com>
To: torvalds@transmeta.com
Subject: Re: PATCH: linux-2.5.1-pre7/drivers/block/xd.c compilation fix (version 2)
Cc: ankry@mif.pg.gda.pl, axboe@suse.de, linux-kernel@vger.kernel.org,
        pat@it.com.au, tfries@umr.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	Linus, if nobody says otherwise, I recommend that you apply
>> this patch.

>Well, I already applied your previous one, in fact, and it's in the
>just-uploaded pre8 kernel.

	Thanks!

>Mind verifying that and sending the incremental update?

	No problem.  I have attached the one line addition below.

>Btw, do you actually _have_ a machine that uses the xd driver, or was this
>patch done just out of some perverse joy in theoretical retrocomputing?

	Years ago, I submitted a patch to allow configuration of
the kernel with "./configure", which would configure every driver as
a module, aside from compiling in the initial ramdisk and the initial
ramdisk's filesystem.  I haven't configured a kernel for years; the
boot scripts and hot plugging software do that.  The same binary
build of the kernel can run on all of my x86 hardware.

	That is why I know that 92 files failed to compile on x86 in
2.5.1-pre7, and largely why I care about fixing xd.c.

	Anyhow, thanks for asking.  By the way, if you have any interest
in integrating my "./configure" functionality now, I would be happy to
clean it up and resubmit it.  (It is mostly a patch to scripts/Configure.)

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.5.1-pre8/drivers/block/xd.c	Sat Dec  8 21:29:50 2001
+++ linux/drivers/block/xd.c	Sat Dec  8 20:19:54 2001
@@ -287,6 +287,7 @@
 		INIT_REQUEST;	/* do some checking on the request structure */
 
 		if (CURRENT_DEV < xd_drives
+		    && (CURRENT->flags & REQ_CMD)
 		    && CURRENT->sector + CURRENT->nr_sectors
 		         <= xd_struct[MINOR(CURRENT->rq_dev)].nr_sects) {
 			block = CURRENT->sector;
