Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSGPIhR>; Tue, 16 Jul 2002 04:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317801AbSGPIhQ>; Tue, 16 Jul 2002 04:37:16 -0400
Received: from holomorphy.com ([66.224.33.161]:48001 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317793AbSGPIhO>;
	Tue, 16 Jul 2002 04:37:14 -0400
Date: Tue, 16 Jul 2002 01:40:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: NFS nonzero preempt_count 2/2
Message-ID: <20020716084009.GO1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When unmounting an NFS filesystem, I saw printk's reporting that NFS
daemons exited with nonzero preempt_counts. Fixing this up so they
no longer give the warning seems like a good idea.

Patch attempting to do this for lockd below.


Cheers,
Bill


===== fs/lockd/svc.c 1.10 vs edited =====
--- 1.10/fs/lockd/svc.c	Mon Feb 25 10:35:33 2002
+++ edited/fs/lockd/svc.c	Tue Jul 16 02:08:23 2002
@@ -203,6 +203,7 @@
 	rpciod_down();
 
 	/* Release module */
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 }
 
