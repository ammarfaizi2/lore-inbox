Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVANGOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVANGOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVANGOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:14:05 -0500
Received: from opersys.com ([64.40.108.71]:62992 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261921AbVANGDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:03:54 -0500
Message-ID: <41E7628C.8070203@opersys.com>
Date: Fri, 14 Jan 2005 01:11:24 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 5/8 ] ltt for 2.6.10 : ipc/ events
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


signed-off-by: Karim Yaghmour (karim@opersys.com)

--- linux-2.6.10-relayfs/ipc/msg.c	2004-12-24 16:33:48.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/ipc/msg.c	2005-01-13 22:21:51.000000000 -0500
@@ -25,6 +25,7 @@
 #include <linux/security.h>
 #include <linux/sched.h>
 #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 #include "util.h"
@@ -229,6 +230,7 @@ asmlinkage long sys_msgget (key_t key, i
 		msg_unlock(msq);
 	}
 	up(&msg_ids.sem);
+	ltt_ev_ipc(LTT_EV_IPC_MSG_CREATE, ret, msgflg);
 	return ret;
 }

--- linux-2.6.10-relayfs/ipc/sem.c	2004-12-24 16:34:31.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/ipc/sem.c	2005-01-13 22:21:51.000000000 -0500
@@ -72,6 +72,7 @@
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
 #include <asm/uaccess.h>
 #include "util.h"

@@ -239,6 +240,7 @@ asmlinkage long sys_semget (key_t key, i
 	}

 	up(&sem_ids.sem);
+	ltt_ev_ipc(LTT_EV_IPC_SEM_CREATE, err, semflg);
 	return err;
 }

--- linux-2.6.10-relayfs/ipc/shm.c	2004-12-24 16:34:45.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/ipc/shm.c	2005-01-13 22:21:51.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
 #include <asm/uaccess.h>

 #include "util.h"
@@ -277,7 +278,7 @@ asmlinkage long sys_shmget (key_t key, s
 		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
-
+	ltt_ev_ipc(LTT_EV_IPC_SHM_CREATE, err, shmflg);
 	return err;
 }


