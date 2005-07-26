Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVGZSSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVGZSSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGZSQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:16:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61831 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262012AbVGZSQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:16:40 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 22/23] acpi_power_off: Don't switch to the boot cpu
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
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
	<m1ll3tbg2r.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hdehbfwa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5p5bft6.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xztbfr9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14qahbfk7.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:16:00 -0600
In-Reply-To: <m14qahbfk7.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:14:16 -0600")
Message-ID: <m1zms9a0wv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


machine_power_off on i386 and x86_64 now switch to the
boot cpu out of paranoia and because the MP Specification indicates it
is a good idea on reboot, so for those architectures it is a noop.
I can't see anything in the acpi spec that requires you to be on
the boot cpu to power off the system, so this should not be an issue
for ia64.  In addition ia64 has the altix a massive multi-node
system where switching to the boot cpu sounds insane as we may
hot removed the boot cpu.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/acpi/sleep/poweroff.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

c4ca5713b37cce7fcfdb8f212c789b552fc55e6f
diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -54,7 +54,6 @@ void acpi_power_off(void)
 	acpi_sleep_prepare(ACPI_STATE_S5);
 	local_irq_disable();
 	/* Some SMP machines only can poweroff in boot CPU */
-	set_cpus_allowed(current, cpumask_of_cpu(0));
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
