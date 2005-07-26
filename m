Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVGZRip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVGZRip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVGZR2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:28:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13959 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261914AbVGZR2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:28:10 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/23] Make ctrl_alt_del call kernel_restart to get a proper
 reboot.
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:27:34 -0600
In-Reply-To: <m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:24:14 -0600")
Message-ID: <m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is obvious we wanted to call kernel_restart here
but since we don't have it the code was expanded inline and hasn't
been correct since sometime in 2.4.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 kernel/sys.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

252e08b37dc29ce42a0aef357b75ec1882eb634c
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -502,8 +502,7 @@ asmlinkage long sys_reboot(int magic1, i
 
 static void deferred_cad(void *dummy)
 {
-	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-	machine_restart(NULL);
+	kernel_restart(NULL);
 }
 
 /*
