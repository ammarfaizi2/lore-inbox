Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBVVFO>; Thu, 22 Feb 2001 16:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRBVVFD>; Thu, 22 Feb 2001 16:05:03 -0500
Received: from mailhost3.lanl.gov ([128.165.3.9]:12600 "EHLO
	mailhost3.lanl.gov") by vger.kernel.org with ESMTP
	id <S129261AbRBVVEu>; Thu, 22 Feb 2001 16:04:50 -0500
Message-ID: <3A957EEF.B6823940@lanl.gov>
Date: Thu, 22 Feb 2001 14:04:47 -0700
From: Eric Weigle <ehw@lanl.gov>
Organization: CCS-1 RADIANT team
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, es-ES, ex-MX, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Trivial bug/fix for shm.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't find the maintainer for this, so I'm sending it to the list.

Problem: ipc/shm.c currently assumes proc filesystem exists, so if
CONFIG_PROC_FS is not defined, it will not compile. The function shm_init calls
create_proc_read_entry without checking if CONFIG_PROC_FS defined; if it isn't
defined that functionality should not be referenced.

Solution: add appropriate #ifdef around that line:

--------------------------------------------------------------------------------
--- kernel-2.4.2/ipc/shm.c.orig Thu Feb 22 13:13:47 2001
+++ kernel-2.4.2/ipc/shm.c  Thu Feb 22 13:13:57 2001
@@ -71,7 +71,9 @@
 void __init shm_init (void)
 {
    ipc_init_ids(&shm_ids, 1);
+#ifdef CONFIG_PROC_FS
    create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
+#endif
 }

 static inline int shm_checkid(struct shmid_kernel *s, int id)
--------------------------------------------------------------------------------

I encountered this bug while creating a vastly hacked-down special purpose
kernel without /proc support.


Thanks,
-Eric Weigle

--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
