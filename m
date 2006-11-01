Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946544AbWKAFnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946544AbWKAFnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946532AbWKAFnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52955 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946524AbWKAFmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:42:35 -0500
Message-Id: <20061101054241.885074000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 41/61] x86-64: Fix C3 timer test
Content-Disposition: inline; filename=x86-64-fix-c3-timer-test.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andi Kleen <ak@suse.de>

There was a typo in the C3 latency test to decide of the TSC
should be used or not. It used the C2 latency threshold, not the
C3 one. Fix that.

This should fix the time on various dual core laptops.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/x86_64/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.18.1/arch/x86_64/kernel/time.c
@@ -960,7 +960,7 @@ __cpuinit int unsynchronized_tsc(void)
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 #ifdef CONFIG_ACPI
 		/* But TSC doesn't tick in C3 so don't use it there */
-		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
+		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 1000)
 			return 1;
 #endif
  		return 0;

--
