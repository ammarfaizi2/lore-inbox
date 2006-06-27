Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWF0UT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWF0UT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWF0UTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:19:55 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27521 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030339AbWF0UTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:19:52 -0400
Message-Id: <20060627201723.258325000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, anton@samba.org
Subject: [PATCH 22/25] Link error when futexes are disabled on 64bit architectures
Content-Disposition: inline; filename=link-error-when-futexes-are-disabled-on-64bit-architectures.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Anton Blanchard <anton@samba.org>

If futexes are disabled we fail to link on ppc64.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/exit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/kernel/exit.c
+++ linux-2.6.17.1/kernel/exit.c
@@ -899,7 +899,7 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 	if (unlikely(tsk->robust_list))
 		exit_robust_list(tsk);
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_FUTEX) && defined(CONFIG_COMPAT)
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif

--
