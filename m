Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVGZSEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVGZSEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVGZSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:02:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47751 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261991AbVGZSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:01:57 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/23] swpsuspend:  Have suspend to disk use factors of
 sys_reboot
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
	<m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
	<m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:01:17 -0600
In-Reply-To: <m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:59:54 -0600")
Message-ID: <m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The suspend to disk code was a poor copy of the code in
sys_reboot now that we have kernel_power_off, kernel_restart
and kernel_halt use them instead of poorly duplicating them inline.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 kernel/power/disk.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

78a2f83d732e327874fe73728d5667875dfeea46
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -59,16 +59,13 @@ static void power_down(suspend_disk_meth
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
-		printk("Powering off system\n");
-		device_shutdown();
-		machine_power_off();
+		kernel_power_off();
 		break;
 	case PM_DISK_REBOOT:
-		device_shutdown();
-		machine_restart(NULL);
+		kernel_restart(NULL);
 		break;
 	}
-	machine_halt();
+	kernel_halt();
 	/* Valid image is on the disk, if we continue we risk serious data corruption
 	   after resume. */
 	printk(KERN_CRIT "Please power me down manually\n");
