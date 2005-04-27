Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVD0Sg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVD0Sg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVD0Sg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:36:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:33963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261935AbVD0Sg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:36:27 -0400
Date: Wed, 27 Apr 2005 11:35:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [09/07] sparc64: use message queue compat syscalls
Message-ID: <20050427183551.GU493@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


A couple message queue system call entries for compat tasks
were not using the necessary compat_sys_*() functions, causing
some glibc test cases to fail.

From: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

===== arch/sparc64/kernel/systbls.S 1.69 vs edited =====
--- 1.69/arch/sparc64/kernel/systbls.S	2005-01-14 11:56:05 -08:00
+++ edited/arch/sparc64/kernel/systbls.S	2005-04-11 15:09:49 -07:00
@@ -75,7 +75,7 @@
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, sys32_timer_settime, compat_sys_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
-	.word sys_mq_timedsend, sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
+	.word compat_sys_mq_timedsend, compat_sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
 /*280*/	.word sys_ni_syscall, sys_add_key, sys_request_key, sys_keyctl
 
 #endif /* CONFIG_COMPAT */

