Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVGZSSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVGZSSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVGZSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:17:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59783 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262035AbVGZSO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:14:56 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 21/23] x86_64 sync machine_power_off with i386
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
	<m18xztbfr9.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:14:16 -0600
In-Reply-To: <m18xztbfr9.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:10:02 -0600")
Message-ID: <m14qahbfk7.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i386 machine_power_off was disabling the local apic
and all of it's users wanted to be on the boot cpu.
So call machine_shutdown which places us on the boot
cpu and disables the apics.  This keeps us in sync
and reduces the number of cases we need to worry about in
the power management code.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/reboot.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

dbc7607f71b4c6e38b141340f7afd33248a4205a
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -153,6 +153,9 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
+	if (!reboot_force) {
+		machine_shutdown();
+	}
 	if (pm_power_off)
 		pm_power_off();
 }
