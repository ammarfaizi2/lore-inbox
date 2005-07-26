Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVGZSO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVGZSO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVGZSMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:12:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56711 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261998AbVGZSKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:10:39 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 20/23] APM: Remove redundant call to set_cpus_allowed
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
	<m1d5p5bft6.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:10:02 -0600
In-Reply-To: <m1d5p5bft6.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:08:53 -0600")
Message-ID: <m18xztbfr9.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


machine_power_off now always switches to the boot cpu so there
is no reason for APM to also do that.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/apm.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

8e1e879e7ead62da7d2c2030eebbf8142547b619
diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -911,14 +911,7 @@ static void apm_power_off(void)
 		0xcd, 0x15		/* int   $0x15       */
 	};
 
-	/*
-	 * This may be called on an SMP machine.
-	 */
-#ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	set_cpus_allowed(current, cpumask_of_cpu(0));
-	BUG_ON(smp_processor_id() != 0);
-#endif
 	if (apm_info.realmode_power_off)
 	{
 		(void)apm_save_cpus();
