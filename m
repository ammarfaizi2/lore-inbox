Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbQLVQii>; Fri, 22 Dec 2000 11:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132065AbQLVQi2>; Fri, 22 Dec 2000 11:38:28 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:1927 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S132044AbQLVQiL>;
	Fri, 22 Dec 2000 11:38:11 -0500
Message-Id: <m149Uj9-000OXLC@amadeus.home.nl>
Date: Fri, 22 Dec 2000 17:07:27 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Subject: Re: test13-pre4
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com> <3A43506B.6CEF84BB@eyal.emu.id.au>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A43506B.6CEF84BB@eyal.emu.id.au> you wrote:
> Linus Torvalds wrote:
>>  - pre4:
>>    - Andrea Arkangeli: update to LVM-0.9

> lvm.c: In function `lvm_do_create_proc_entry_of_lv':

[snip]

Hi,

The patch below fixes this.

Greetings,
    Arjan van de Ven

diff -ur linux/drivers/md/lvm.c /mnt/raid/0/linux/drivers/md/lvm.c
--- linux/drivers/md/lvm.c	Fri Dec 22 17:05:20 2000
+++ /mnt/raid/0/linux/drivers/md/lvm.c	Fri Dec 22 12:39:37 2000
@@ -2021,7 +2021,9 @@
 		for (p = 0; p < vg_ptr->pv_max; p++) {
 			if ( ( pv_ptr = vg_ptr->pv[p]) == NULL) {
 				ret = lvm_do_pv_create(arg, vg_ptr, p);
+#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
 				lvm_do_create_proc_entry_of_pv ( vg_ptr, pv_ptr);
+#endif
 				if ( ret != 0) return ret;
 	
 				/* We don't need the PE list
@@ -3002,6 +3004,8 @@
 } /* lvm_do_pv_status() */
 
 
+#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+
 
 /*
  * create a /proc entry for a logical volume
@@ -3021,8 +3025,6 @@
 		}
 	}
 }
-
-
 /*
  * remove a /proc entry for a logical volume
  */
@@ -3038,6 +3040,7 @@
 }
 
 
+
 /*
  * create a /proc entry for a physical volume
  */
@@ -3074,7 +3077,6 @@
 /*
  * create a /proc entry for a volume group
  */
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
 void lvm_do_create_proc_entry_of_vg ( vg_t *vg_ptr) {
 	int l, p;
 	pv_t *pv_ptr;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
