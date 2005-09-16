Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbVIPQSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbVIPQSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 12:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbVIPQSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 12:18:46 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:18625 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1161176AbVIPQSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 12:18:45 -0400
Date: Sat, 17 Sep 2005 01:17:15 +0900 (JST)
Message-Id: <20050917.011715.41182516.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org, macro@linux-mips.org, akpm@osdl.org,
       roland@redhat.com, dev@sw.ru, Heiko.Carstens@de.ibm.com
Subject: Re: [PATCH] more sigkill priority fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050908.012450.41200025.anemo@mba.ocn.ne.jp>
References: <20050908.012450.41200025.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Kirill Korotaev and Heiko Carstens to CC.

>>>>> On Thu, 08 Sep 2005 01:24:50 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> On Linux/MIPS, a simple test program can create unkillable
anemo> process.  The "sigkill priority fix" was introduced in 2.6.12,
anemo> but it does not effective for signals sent by force_sig() in
anemo> kernel.  For detailed behavior and testcase, please look at
anemo> this thread in linux-mips ML:

This is fixed by another way in 2.6.14-rc1 for i386 (Thanks, Roland).
The changelog line is:

>    [PATCH] i386: Don't miss pending signals returning to user mode after signal processing
>    Signed-off-by: Roland McGrath <roland@redhat.com>

And now similar fix for mips is already in Linux/MIPS CVS tree too.

--- linux-mips/arch/mips/kernel/entry.S	2005-03-04 22:17:29.000000000 +0900
+++ linux/arch/mips/kernel/entry.S	2005-09-16 01:04:52.365022536 +0900
@@ -105,7 +105,7 @@
 	move	a0, sp
 	li	a1, 0
 	jal	do_notify_resume	# a2 already loaded
-	j	restore_all
+	j	resume_userspace
 
 FEXPORT(syscall_exit_work_partial)
 	SAVE_STATIC


I suppose the original problem on s390 (reported by Heiko Carstens)
could be fixed same way.  Then 'sigkill priority fix' would be
reverted safely.

---
Atsushi Nemoto
