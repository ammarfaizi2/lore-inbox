Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315664AbSECTTG>; Fri, 3 May 2002 15:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315662AbSECTTF>; Fri, 3 May 2002 15:19:05 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:35872 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S315661AbSECTTB>; Fri, 3 May 2002 15:19:01 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A781780F2@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'sparclinux@vger.kernel.org'" <sparclinux@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: my slab cache broken on sparc64
Date: Fri, 3 May 2002 14:18:55 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to troubleshoot why in 2.5.13, (Though I also saw this in 2.5.7)
on my UltraSparc, why my slabcache is broken.  Has anyone else seen this?

During boot, dmesg displays all the caches as "Cache with size (%d) has lost
its name" where it appears that all my slabs are broken, displayed in my cat
/proc/slabinfo below.

I'm trying to trace back through the slabcache code, (I'm not too
knowledgeable about the slab code, so go easy on me :o)) to determine why
that is.  I see in the slab.c why this is displayed, in the below code, just
looking for pointers on why all mine may be breaking?  

        /* Need the semaphore to access the chain. */
        down(&cache_chain_sem);
        {
                struct list_head *p;
 
                list_for_each(p, &cache_chain) {
                        kmem_cache_t *pc = list_entry(p, kmem_cache_t,
next);
                        char tmp;
                        /* This happens when the module gets unloaded and
doesn't
                           destroy its slab cache and noone else reuses the
vmalloc
                           area of the module. Print a warning. */
                        if (__get_user(tmp,pc->name)) {
                                printk("SLAB: cache with size %d has lost
its name\n",
                                        pc->objsize);
                                continue;
                        }
                        if (!strcmp(pc->name,name)) {
                                printk("kmem_cache_create: duplicate cache
%s\n",name);
                                up(&cache_chain_sem);
                                BUG();
                        }
                }
        }

Thanks for any pointers.

Bruce H.

slabinfo - version: 1.1
broken                89    104    152    2    2    1
broken                 5    119     64    1    1    1
broken                 5     31    256    1    1    1
broken                 1     41    192    1    1    1
broken                 0      0    736    0    0    1
broken                 0      0    704    0    0    1
broken                 5      6   1248    1    1    1
broken                93    104    608    8    8    1
broken                 0      0    160    0    0    1
broken                10    226     32    1    1    1
broken                 0     61    128    0    1    1
broken                 0     81     96    0    1    1
broken                 9    226     32    1    1    1
broken                53     70    224    2    2    1
broken                 4     41    192    1    1    1
broken                 0      0    608    0    0    1
broken                 1     14    576    1    1    1
broken                18     21   1120    3    3    1
broken                 0      0     96    0    0    1
broken                32     35   3072    7    7    2
broken                32     35   1536    7    7    1
broken                32     40    768    4    4    1
broken                32     42    384    2    2    1
broken                32     41    192    1    1    1
broken               512    533    192   13   13    1
broken                 0      0    640    0    0    1
broken                 0      0    608    0    0    1
broken                 0      0    800    0    0    1
broken                 0      0    160    0    0    1
broken             30301  30312    672 2526 2526    1
broken                 0      0     48    0    0    1
broken                 6     49    160    1    1    1
broken                 0      0     24    0    0    1
broken               256    256   4096  128  128    1
broken               256    256   2048   64   64    1
broken               256    256   1024   32   32    1
broken               256    279    256    9    9    1
broken               256    357     64    3    3    1
broken               256    904     32    2    4    1
broken               256    567     96    4    7    1
broken                 3     10    768    1    1    1
broken                 1    119     64    1    1    1
broken               120    132    640   11   11    1
broken               161    245    224    7    7    1
broken                 2     15    512    1    1    1
broken                 3     26    608    2    2    1
broken                 1     58    136    1    1    1
broken              9681   9688   1056 1383 1384    1
broken                20    595     64    5    5    1
broken                 4     61    128    1    1    1
broken                12     61    128    1    1    1
broken               128    140    576   10   10    1
broken             25525  25543    192  623  623    1
broken               942    943    192   23   23    1
broken                 0      2   4096    0    1    1
broken            100388 102465     96 1265 1265    1
broken                46     62    256    2    2    1
broken              2639   2940    160   54   60    1
broken                45    119     64    1    1    1
broken                45     54    832    5    6    1
broken                48     54   2592   16   18    1
broken                53     63   1152    8    9    1
broken                 0      0 131072    0    0   16
broken                 0      0 131072    0    0   16
broken                 1      1  65536    1    1    8
broken                 1      1  65536    1    1    8
broken                 0      0  32768    0    0    4
broken                 9     10  32768    9   10    4
broken                 0      0  16384    0    0    2
broken                 2      3  16384    2    3    2
broken                 0      0   8192    0    0    1
broken                10     10   8192   10   10    1
broken                 0      0   4096    0    0    1
broken                32     38   4096   16   19    1
broken                 0      0   2048    0    0    1
broken                86     92   2048   22   23    1
broken                 0      0   1024    0    0    1
broken                29     40   1024    4    5    1
broken                 0      0    512    0    0    1
broken                55    105    512    5    7    1
broken                 0      0    256    0    0    1
broken                14     31    256    1    1    1
broken                 0      0    192    0    0    1
broken               506    574    192   13   14    1
broken                 0      0    128    0    0    1
broken                61     61    128    1    1    1
broken                 0      0     96    0    0    1
broken               114    162     96    2    2    1
broken                 0      0     64    0    0    1
broken              3918   4165     64   35   35    1


