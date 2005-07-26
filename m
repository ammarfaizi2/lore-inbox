Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVGZSMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVGZSMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVGZSJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:09:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53895 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262008AbVGZSJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:09:33 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 19/23] i386 machine_power_off cleanup
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
	<m1ll3tbg2r.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hdehbfwa.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:08:53 -0600
In-Reply-To: <m1hdehbfwa.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:07:01 -0600")
Message-ID: <m1d5p5bft6.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Call machine_shutdown() to move to the boot cpu
and disable apics.  Both acpi_power_off and
apm_power_off want to move to the boot cpu.
and we are already disabling the local apics
so calling machine_shutdown simply reuses
code.

ia64 doesn't have a special path in power_off
for efi so there is no reason i386 should.  If
we really need to call the efi power off path
the efi driver can set pm_power_off like everyone
else.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/reboot.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

9f163caa28f9d3392f0d8d3e5f131ea658a2a887
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -347,10 +347,8 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	lapic_shutdown();
+	machine_shutdown();
 
-	if (efi_enabled)
-		efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
 	if (pm_power_off)
 		pm_power_off();
 }
