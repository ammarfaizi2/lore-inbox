Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWJPQAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWJPQAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWJPQAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:00:37 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64368 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422693AbWJPQAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:00:36 -0400
Date: Mon, 16 Oct 2006 09:01:46 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: bugzilla@bencastricum.nl
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] fix epoll_pwait when EPOLL=n
Message-Id: <20061016090146.7f64489a.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=7371

sys_epoll_pwait needs to be listed as a conditional (weak)
entry point for CONFIG_EPOLL=n.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kernel/sys_ni.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2619-rc2-pv.orig/kernel/sys_ni.c
+++ linux-2619-rc2-pv/kernel/sys_ni.c
@@ -49,6 +49,7 @@ cond_syscall(compat_sys_get_robust_list)
 cond_syscall(sys_epoll_create);
 cond_syscall(sys_epoll_ctl);
 cond_syscall(sys_epoll_wait);
+cond_syscall(sys_epoll_pwait);
 cond_syscall(sys_semget);
 cond_syscall(sys_semop);
 cond_syscall(sys_semtimedop);


---
