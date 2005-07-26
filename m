Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVGZSET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVGZSET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVGZSEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:04:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48775 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261998AbVGZSDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:03:50 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/23] pcwd.c: Call kernel_power_off not machine_power_off
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
	<m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:03:08 -0600
In-Reply-To: <m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:01:17 -0600")
Message-ID: <m1ll3tbg2r.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The call appears to come from process context so kernel_power_off
should be safe.  And acpi_power_off won't necessarily work if you just
call machine_power_off.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/char/watchdog/pcwd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

b663accd4b051598a8c877aeb2e4ee7da94e3af3
diff --git a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c
+++ b/drivers/char/watchdog/pcwd.c
@@ -344,7 +344,7 @@ static int pcwd_get_status(int *status)
 			*status |= WDIOF_OVERHEAT;
 			if (temp_panic) {
 				printk (KERN_INFO PFX "Temperature overheat trip!\n");
-				machine_power_off();
+				kernel_power_off();
 			}
 		}
 	} else {
@@ -355,7 +355,7 @@ static int pcwd_get_status(int *status)
 			*status |= WDIOF_OVERHEAT;
 			if (temp_panic) {
 				printk (KERN_INFO PFX "Temperature overheat trip!\n");
-				machine_power_off();
+				kernel_power_off();
 			}
 		}
 	}
