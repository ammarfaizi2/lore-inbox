Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317789AbSGPIeV>; Tue, 16 Jul 2002 04:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSGPIeU>; Tue, 16 Jul 2002 04:34:20 -0400
Received: from holomorphy.com ([66.224.33.161]:46465 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317789AbSGPIeT>;
	Tue, 16 Jul 2002 04:34:19 -0400
Date: Tue, 16 Jul 2002 01:37:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: NFS nonzero preempt_count 1/2
Message-ID: <20020716083714.GN1022@holomorphy.com>
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

Patch attempting to do this for rpciod below.


Cheers,
Bill


===== net/sunrpc/sched.c 1.15 vs edited =====
--- 1.15/net/sunrpc/sched.c	Fri May  3 18:52:12 2002
+++ edited/net/sunrpc/sched.c	Tue Jul 16 02:00:32 2002
@@ -1088,6 +1088,7 @@
 	wake_up(assassin);
 
 	dprintk("RPC: rpciod exiting\n");
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
