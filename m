Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317750AbSG2EBP>; Mon, 29 Jul 2002 00:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSG2EBP>; Mon, 29 Jul 2002 00:01:15 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:23685 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317750AbSG2EBO>;
	Mon, 29 Jul 2002 00:01:14 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.48701.985055.181673@argo.ozlabs.ibm.com>
Date: Mon, 29 Jul 2002 14:02:05 +1000 (EST)
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: superfluous hardirq_endlock in bh_action
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks to me like the call to hardirq_endlock in bh_action is
superfluous, since it doesn't match up with any hardirq_trylock call
that I could see.  Perhaps it should be removed?

Paul.

diff -urN linux-2.5/kernel/softirq.c pmac-2.5/kernel/softirq.c
--- linux-2.5/kernel/softirq.c	Sun Jul 28 22:47:57 2002
+++ pmac-2.5/kernel/softirq.c	Mon Jul 29 12:29:34 2002
@@ -293,7 +293,6 @@
 	if (bh_base[nr])
 		bh_base[nr]();
 
-	hardirq_endlock();
 	spin_unlock(&global_bh_lock);
 	return;
 
