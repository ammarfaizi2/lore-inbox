Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318339AbSG3QYu>; Tue, 30 Jul 2002 12:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSG3QYu>; Tue, 30 Jul 2002 12:24:50 -0400
Received: from [213.4.129.129] ([213.4.129.129]:49002 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S318339AbSG3QYa>;
	Tue, 30 Jul 2002 12:24:30 -0400
Date: Tue, 30 Jul 2002 15:56:49 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: rc3-ac4 compilation error
Message-Id: <20020730155649.7ed5253b.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've found a compilation error:


The problem seems to be in this changes from the -rc3-ac4 patch :
(in the drivers/char/drm/drmP.h)


                                /* Macros to make printk easier */
 #define DRM_ERROR(fmt, arg...) \
-       printk(KERN_ERR "[" DRM_NAME ":" __FUNCTION__ "] *ERROR* " fmt ,
##arg)+       printk(KERN_ERR "[" DRM_NAME ":%s] *ERROR* " fmt ,
__FUNCTION__, ##arg) #define DRM_MEM_ERROR(area, fmt, arg...) \
-       printk(KERN_ERR "[" DRM_NAME ":" __FUNCTION__ ":%s] *ERROR* "
fmt , \+       printk(KERN_ERR "[" DRM_NAME ":%s:%s] *ERROR* " fmt ,
__FUNCTION__, \               DRM(mem_stats)[area].name , ##arg)
 #define DRM_INFO(fmt, arg...)  printk(KERN_INFO "[" DRM_NAME "] " fmt ,
##arg)

make[3]: Entering directory `/usr/src/stable/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/stable/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE  -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=tdfx_drv 
-c -o tdfx_drv.o tdfx_drv.c In file included from tdfx_drv.c:80:
drm_context.h: In function `tdfx_context_switch':
drm_context.h:228: parse error before `)'
drm_context.h: In function `tdfx_context_switch_complete':
drm_context.h:259: parse error before `)'
drm_context.h: In function `tdfx_addctx':
drm_context.h:319: parse error before `)'
In file included from tdfx_drv.c:83:
drm_drv.h: In function `tdfx_setup':
drm_drv.h:323: parse error before `)'
drm_drv.h: In function `tdfx_takedown':
drm_drv.h:345: parse error before `)'
drm_drv.h: In function `drm_count_cards':
drm_drv.h:504: parse error before `)'
drm_drv.h: In function `drm_init':
drm_drv.h:537: parse error before `)'
drm_drv.h:595: parse error before `)'
drm_drv.h: In function `drm_cleanup':
drm_drv.h:622: parse error before `)'
drm_drv.h:627: parse error before `)'
drm_drv.h: In function `tdfx_ioctl':
drm_drv.h:888: parse error before `)'
drm_drv.h: In function `tdfx_unlock':
drm_drv.h:1043: parse error before `)'
In file included from tdfx_drv.c:104:
drm_fops.h: In function `tdfx_read':
drm_fops.h:135: parse error before `)'
drm_fops.h:143: parse error before `)'
drm_fops.h:148: parse error before `)'
drm_fops.h: In function `tdfx_write_string':
drm_fops.h:206: parse error before `)'
In file included from tdfx_drv.c:107:
drm_lock.h: In function `tdfx_block':
drm_lock.h:38: parse error before `)'
drm_lock.h: In function `tdfx_unblock':
drm_lock.h:45: parse error before `)'
drm_lock.h: In function `tdfx_flush_queue':
drm_lock.h:120: parse error before `)'
drm_lock.h: In function `tdfx_flush_unblock_queue':
drm_lock.h:151: parse error before `)'
drm_lock.h: In function `tdfx_flush_block_and_flush':
drm_lock.h:170: parse error before `)'
drm_lock.h: In function `tdfx_flush_unblock':
drm_lock.h:189: parse error before `)'
drm_lock.h: In function `tdfx_finish':
drm_lock.h:212: parse error before `)'
In file included from tdfx_drv.c:109:
drm_proc.h: In function `tdfx_proc_init':
drm_proc.h:87: parse error before `)'
In file included from tdfx_drv.c:111:
drm_stub.h: In function `tdfx_stub_register':
drm_stub.h:125: parse error before `)'
drm_stub.h:133: parse error before `)'
drm_stub.h:137: parse error before `)'
make[3]: *** [tdfx_drv.o] Error 1
make[3]: Leaving directory `/usr/src/stable/drivers/char/drm'
make[2]: *** [_modsubdir_drm] Error 2
make[2]: Leaving directory `/usr/src/stable/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/stable/drivers'
make: *** [_mod_drivers] Error 2
