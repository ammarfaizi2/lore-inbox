Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUHHTRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUHHTRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUHHTRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:17:13 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:9663 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264183AbUHHTRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:17:11 -0400
Message-ID: <41167CC7.5020102@colorfullife.com>
Date: Sun, 08 Aug 2004 21:19:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove magic +1 from shm segment count
Content-Type: multipart/mixed;
 boundary="------------090302000302030702050309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090302000302030702050309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Michael Kerrisk found a bug in the shm accounting code:
sysv shm allows to create SHMMNI+1 shared memory segments, instead of 
SHMMNI segments. The +1 is probably from the first shared anonymous 
mapping implementation that used the sysv code to implement shared anon 
mappings.
The implementation got replaced, it's now the other way around (sysv 
uses the shared anon code), but the +1 remained.

Andrew - could you add the patch to your tree?

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

--------------090302000302030702050309
Content-Type: text/plain;
 name="patch-ipcshm-count"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipcshm-count"

--- 2.6/ipc/shm.c	2004-08-07 11:14:24.000000000 +0200
+++ build-2.6/ipc/shm.c	2004-08-08 21:10:02.156421648 +0200
@@ -78,7 +78,7 @@
 
 static inline int shm_addid(struct shmid_kernel *shp)
 {
-	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
+	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni);
 }
 
 

--------------090302000302030702050309--
