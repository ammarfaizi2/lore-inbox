Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUFUVNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUFUVNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUFUVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:13:18 -0400
Received: from baikonur.stro.at ([213.239.196.228]:30170 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266474AbUFUVNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:13:02 -0400
Date: Mon, 21 Jun 2004 23:13:01 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch-kj] kernel_thread() audit return code i2o_core.c
Message-ID: <20040621211301.GN1545@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Audited for kernel_thread() return values. Did it backwards last
time. *^_^*
Oh, yeah; compiles just fine as module or built-in.


Description  : Audited for kernel_thread() return code in i2o_sys_init()

Signed-off-by: MJK <mkemp@cs.nmsu.edu>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-max/drivers/message/i2o/i2o_core.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN drivers/message/i2o/i2o_core.c~kernel_thread-i2o_core drivers/message/i2o/i2o_core.c
--- linux-2.6.7/drivers/message/i2o/i2o_core.c~kernel_thread-i2o_core	2004-06-18 10:30:08.000000000 +0200
+++ linux-2.6.7-max/drivers/message/i2o/i2o_core.c	2004-06-18 10:31:20.000000000 +0200
@@ -2234,6 +2234,13 @@ rebuild_sys_tab:
 		/* Create a kernel thread to deal with dynamic LCT updates */
 		iop->lct_pid = kernel_thread(i2o_dyn_lct, iop, CLONE_SIGHAND);
 	
+		if (iop->lct_pid < 0) {
+			printk(KERN_ERR "Couldn't spawn thread for %s.\n",
+					iop->name);
+			i2o_sys_shutdown();
+			return;
+		}
+
 		/* Update change ind on DLCT */
 		iop->dlct->change_ind = iop->lct->change_ind;
 

_
