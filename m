Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133024AbRDWNRX>; Mon, 23 Apr 2001 09:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRDWNRO>; Mon, 23 Apr 2001 09:17:14 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:33041 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S133024AbRDWNRA>; Mon, 23 Apr 2001 09:17:00 -0400
Date: Mon, 23 Apr 2001 21:16:45 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Jens Axboe <axboe@suse.de>, Ed Tomlinson <tomlins@cam.org>,
        <linux-kernel@vger.kernel.org>, <linux-openlvm@nl.linux.org>,
        <linux-lvm@sistina.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] lvm beta7 and ac11 problems
In-Reply-To: <3AE3ED20.FD685CE@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0104232109570.326-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Martin Dalecki wrote:

> > > depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac11/kernel/drivers/md/lvm-mod.o


try this (after you have applied the patch for lvm 0.9.1_beta7) ...

Jeff
[jchua@fedex.com]

--- /u2/src/linux/drivers/md/lvm.c.org  Mon Apr 23 21:11:32 2001
+++ /u2/src/linux/drivers/md/lvm.c      Mon Apr 23 21:12:27 2001
@@ -1791,7 +1791,7 @@
        int max_hardblocksize = 0, hardblocksize;

        for (le = 0; le < lv->lv_allocated_le; le++) {
-               hardblocksize =
get_hardblocksize(lv->lv_current_pe[le].dev);
+               hardblocksize =
get_hardsect_size(lv->lv_current_pe[le].dev);
                if (hardblocksize == 0)
                        hardblocksize = 512;
                if (hardblocksize > max_hardblocksize)
@@ -1801,7 +1801,7 @@
        if (lv->lv_access & LV_SNAPSHOT) {
                for (e = 0; e < lv->lv_remap_end; e++) {
                        hardblocksize =
-                               get_hardblocksize(
+                               get_hardsect_size(

lv->lv_block_exception[e].rdev_new);
                        if (hardblocksize == 0)
                                hardblocksize = 512;


