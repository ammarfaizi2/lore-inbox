Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUFNQY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUFNQY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUFNQY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:24:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:3773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263204AbUFNQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:24:25 -0400
Date: Mon, 14 Jun 2004 09:23:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Mika Kukkonen <mika@osdl.org>
Subject: [PATCH 1/3] __user annotation for shm_shmat hook declaration
Message-ID: <20040614092343.A21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper __user annotation for shm_shmat hook in security.h.

  CHECK   ipc/shm.c
include/linux/security.h:1831:38: warning: incorrect type in argument 2 (different address spaces)
include/linux/security.h:1831:38:    expected char *shmaddr
include/linux/security.h:1831:38:    got char [noderef] *shmaddr<asn:1>
  CC      ipc/shm.o

From: Mika Kukkonen <mika@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/linux/security.h 1.34 vs edited =====
--- 1.34/include/linux/security.h	2004-05-08 15:00:18 -07:00
+++ edited/include/linux/security.h	2004-06-14 08:56:50 -07:00
@@ -1172,7 +1172,7 @@
 	int (*shm_associate) (struct shmid_kernel * shp, int shmflg);
 	int (*shm_shmctl) (struct shmid_kernel * shp, int cmd);
 	int (*shm_shmat) (struct shmid_kernel * shp, 
-			  char *shmaddr, int shmflg);
+			  char __user *shmaddr, int shmflg);
 
 	int (*sem_alloc_security) (struct sem_array * sma);
 	void (*sem_free_security) (struct sem_array * sma);
