Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWB0Wgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWB0Wgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWB0Wga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:36:30 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55681 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932071AbWB0Wbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:53 -0500
Message-Id: <20060227223346.905003000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/39] [PATCH] [IA64] sys32_signal() forgets to initialize ->sa_mask
Content-Disposition: inline; filename=sys32_signal-forgets-to-initialize-sa_mask.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Pointed out by Oleg Nesterov <oleg@tv-sign.ru>, who in turn
got the hint from Linus.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/ia64/ia32/ia32_signal.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.15.4.orig/arch/ia64/ia32/ia32_signal.c
+++ linux-2.6.15.4/arch/ia64/ia32/ia32_signal.c
@@ -515,6 +515,7 @@ sys32_signal (int sig, unsigned int hand
 
 	sigact_set_handler(&new_sa, handler, 0);
 	new_sa.sa.sa_flags = SA_ONESHOT | SA_NOMASK;
+	sigemptyset(&new_sa.sa.sa_mask);
 
 	ret = do_sigaction(sig, &new_sa, &old_sa);
 

--
