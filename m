Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUIARoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUIARoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIARnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:43:04 -0400
Received: from holomorphy.com ([207.189.100.168]:64454 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267314AbUIARh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:37:56 -0400
Date: Wed, 1 Sep 2004 10:37:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [7/7] remove casting of __detach_pid() results to void
Message-ID: <20040901173749.GK5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com> <20040901172839.GF5492@holomorphy.com> <20040901173027.GG5492@holomorphy.com> <20040901173218.GH5492@holomorphy.com> <20040901173327.GI5492@holomorphy.com> <20040901173529.GJ5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901173529.GJ5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:35:29AM -0700, William Lee Irwin III wrote:
> The renaming of ->pid_chain was spurious; the following patch backs it out.

Casting an expression to void to ignore the result is only necessary
for __must_check function calls and in the interior of nop macros. The
following patch backs out the addition of void casts on the result of
__detach_pid().


Index: kirill-2.6.9-rc1-mm2/kernel/pid.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/pid.c	2004-09-01 10:16:27.524209800 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/pid.c	2004-09-01 10:17:50.529591064 -0700
@@ -234,13 +234,13 @@
  */
 void switch_exec_pids(task_t *leader, task_t *thread)
 {
-	(void)__detach_pid(leader, PIDTYPE_PID);
-	(void)__detach_pid(leader, PIDTYPE_TGID);
-	(void)__detach_pid(leader, PIDTYPE_PGID);
-	(void)__detach_pid(leader, PIDTYPE_SID);
+	__detach_pid(leader, PIDTYPE_PID);
+	__detach_pid(leader, PIDTYPE_TGID);
+	__detach_pid(leader, PIDTYPE_PGID);
+	__detach_pid(leader, PIDTYPE_SID);
 
-	(void)__detach_pid(thread, PIDTYPE_PID);
-	(void)__detach_pid(thread, PIDTYPE_TGID);
+	__detach_pid(thread, PIDTYPE_PID);
+	__detach_pid(thread, PIDTYPE_TGID);
 
 	leader->pid = leader->tgid = thread->pid;
 	thread->pid = thread->tgid;
