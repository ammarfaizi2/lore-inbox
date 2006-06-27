Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161274AbWF0URH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbWF0URH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWF0URG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:17:06 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61568 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161272AbWF0URA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:17:00 -0400
Message-Id: <20060627201423.217921000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 15/25] UML: fix uptime
Content-Disposition: inline; filename=uml-fix-uptime.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jeff Dike <jdike@addtoit.com>

The use of signed instead of unsigned here broke the calculations on
negative numbers that are involved in calculating wall_to_monotonic.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/um/kernel/time_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/arch/um/kernel/time_kern.c
+++ linux-2.6.17.1/arch/um/kernel/time_kern.c
@@ -87,7 +87,7 @@ void timer_irq(union uml_pt_regs *regs)
 
 void time_init_kern(void)
 {
-	unsigned long long nsecs;
+	long long nsecs;
 
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,

--
