Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284414AbRLJV7V>; Mon, 10 Dec 2001 16:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283773AbRLJV7L>; Mon, 10 Dec 2001 16:59:11 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:55266 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281568AbRLJV7F>; Mon, 10 Dec 2001 16:59:05 -0500
Date: Mon, 10 Dec 2001 15:57:56 -0600 (CST)
From: <bottchen@earthlink.net>
X-X-Sender: <adam@scully.>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>
Subject: Sorry to be annoying, but "PATCH for shmdt"
Message-ID: <Pine.LNX.4.33.0112101516500.26955-100000@scully.>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Unfortunately the patch I submitted for shmdt has been overlooked.
It's not a very exciting patch, but it does bring the code into agreement
with the manpage.  Here is an version of the patch updated for 2.4.16.

--- linux-2.4.16old/ipc/shm.c   Mon Dec  10 11:53:12 2001
+++ linux-2.4.16/ipc/shm.c      Mon Dec  10 15:08:51 2001
@@ -651,16 +651,19 @@
 {
        struct mm_struct *mm = current->mm;
        struct vm_area_struct *shmd, *shmdnext;
+       int retcode=-EINVAL;

        down_write(&mm->mmap_sem);
        for (shmd = mm->mmap; shmd; shmd = shmdnext) {
                shmdnext = shmd->vm_next;
                if (shmd->vm_ops == &shm_vm_ops
-                   && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) ==
(ulong) shmaddr)
+                   && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) ==
(ulong) shmaddr) {
                        do_munmap(mm, shmd->vm_start, shmd->vm_end -
shmd->vm_start);
+                       retcode=0;
+               }
        }
        up_write(&mm->mmap_sem);
-       return 0;
+       return retcode;
 }

 #ifdef CONFIG_PROC_FS


