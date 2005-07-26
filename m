Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVGZRvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVGZRvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVGZRss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:48:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32903 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261974AbVGZRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:48:07 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/23] Use kernel_power_off in sysrq-o
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:47:32 -0600
In-Reply-To: <m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:45:31 -0600")
Message-ID: <m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We already do all of the gymnastics to run from process context
to call the power off code so call into the power off code cleanly.

This especially helps acpi as part of it's shutdown logic should
run acpi_shutdown called from device_shutdown which was not
being called from here.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 kernel/power/poweroff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

acf31d44f4864bf13fa5a9fe49e0cc9c0ec93cee
diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/workqueue.h>
+#include <linux/reboot.h>
 
 /*
  * When the user hits Sys-Rq o to power down the machine this is the
@@ -17,8 +18,7 @@
 
 static void do_poweroff(void *dummy)
 {
-	if (pm_power_off)
-		pm_power_off();
+	kernel_power_off();
 }
 
 static DECLARE_WORK(poweroff_work, do_poweroff, NULL);
