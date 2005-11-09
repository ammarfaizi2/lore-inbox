Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbVKISqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbVKISqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVKISqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:46:51 -0500
Received: from smtp-out.google.com ([216.239.45.12]:48655 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751523AbVKISqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:46:50 -0500
Date: Wed, 9 Nov 2005 10:46:23 -0800
From: Arun Sharma <arun.sharma@google.com>
To: akpm@osdl.org
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-ID: <20051109184623.GA21636@sharma-home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow shmctl to find out if a shmid corresponds to a HUGETLB segment

Signed-off-by: Arun Sharma <arun.sharma@google.com>
Acked-by: Rohit Seth <rohit.seth@intel.com>

--- a/ipc/shm.c	Tue Nov  8 20:58:38 2005
+++ b/ipc/shm.c	Wed Nov  9 10:26:37 2005
@@ -197,7 +197,7 @@
 		return -ENOMEM;
 
 	shp->shm_perm.key = key;
-	shp->shm_flags = (shmflg & S_IRWXUGO);
+	shp->shm_flags = (shmflg & (S_IRWXUGO | SHM_HUGETLB));
 	shp->mlock_user = NULL;
 
 	shp->shm_perm.security = NULL;
