Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVGZRzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVGZRzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVGZRxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:53:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36743 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261974AbVGZRvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:51:44 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/23] Update sysrq-B to use emergency_restart()
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:51:06 -0600
In-Reply-To: <m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:49:23 -0600")
Message-ID: <m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sysrq calls into the reboot path from an interrupt handler
we can either push the code do into process context and
call kernel_restart and get a clean reboot or we can simply
reboot the machine, and increase our chances of actually
rebooting.  emergency_reboot() seems like the closest match
to what we have previously done, and what we want.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/char/sysrq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d7b573e957fb71b166223ee15ea97c93c14f5faa
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -115,7 +115,7 @@ static void sysrq_handle_reboot(int key,
 				struct tty_struct *tty) 
 {
 	local_irq_enable();
-	machine_restart(NULL);
+	emergency_restart();
 }
 
 static struct sysrq_key_op sysrq_reboot_op = {
