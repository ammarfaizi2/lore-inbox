Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSFIKYu>; Sun, 9 Jun 2002 06:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317594AbSFIKYt>; Sun, 9 Jun 2002 06:24:49 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:23458
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S317593AbSFIKYs>; Sun, 9 Jun 2002 06:24:48 -0400
Message-ID: <3D032CDE.7000307@st-peter.stw.uni-erlangen.de>
Date: Sun, 09 Jun 2002 12:24:30 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Gustafsson <andersg@0x63.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.20]newbee call for help getting lvm working
In-Reply-To: <3CFF9590.5030504@st-peter.stw.uni-erlangen.de> <20020608222628.GA10981@h55p111.delphi.afb.lu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *17GzsB-0005lh-00*A5Km3VbGr36* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Gustafsson wrote:

>On Thu, Jun 06, 2002 at 07:02:08PM +0200, Svetoslav Slavtchev wrote:
>  
>
>>Hi ,
>>i was trying to get the patch from Anders Gustafsson working in 2.5.20,
>>but i'm getting  by compilation:
>>....
>>lvm.c: In function `__update_hardsectsize':
>>lvm.c:2021: warning: implicit declaration of function `get_hardsect_size'
>>    
>>
>
>
>[.. snip ..]
>
>  
>
>>   /* only perform this operation on active snapshots */
>>   if ((lv->lv_access & LV_SNAPSHOT) &&
>>       (lv->lv_status & LV_ACTIVE)) {
>>       for (e = 0; e < lv->lv_remap_end; e++) {
>>           hardsectsize =  get_hardsect_size( 
>>lv->lv_block_exception[e].rdev_new);
>>    
>>
>
>snapshotting doesn't work anyhow, so this block could be removed 'til
>its unbroked.
>
thanks, i had a similar solution , but i wasn't shure
i'll try it with a 2.5.20-dj3 or dj4

--- linux-2.5.18/drivers/md/lvm.c    2002-06-04 17:25:40.000000000 +0200
+++ linux-2.5.20-dj3-lvm-xfs-w3/drivers/md/lvm.c    2002-06-08 
19:08:41.000000000 +0200
@@ -216,6 +216,7 @@
 #include <linux/stat.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
+#include <linux/buffer_head.h> /* for invalidate_buffers */
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
 #include <linux/devfs_fs_kernel.h>

@@ -2014,17 +2015,23 @@
             max_hardsectsize = hardsectsize;
     }
 
+
+    /* FROM ME SVETLJO, otherweise it doesnt compile
+     * get_hardsect_size had disapeared in 2.5.18
+     */
     /* only perform this operation on active snapshots */
-    if ((lv->lv_access & LV_SNAPSHOT) &&
+/*    if ((lv->lv_access & LV_SNAPSHOT) &&
         (lv->lv_status & LV_ACTIVE)) {
         for (e = 0; e < lv->lv_remap_end; e++) {
-            hardsectsize = get_hardsect_size( 
lv->lv_block_exception[e].rdev_new);
+           hardsectsize = get_hardsect_size( 
lv->lv_block_exception[e].rdev_new);
             if (hardsectsize == 0)
                 hardsectsize = 512;
             if (hardsectsize > max_hardsectsize)
                 max_hardsectsize = hardsectsize;
         }
     }
+*/
+
 }

 /*



