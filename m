Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWBHGmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWBHGmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWBHGmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:42:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21635 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1030575AbWBHGmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:35 -0500
Message-Id: <20060208064854.827463000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 04/23] seclvl settime fix
Content-Disposition: inline; filename=seclvl-settime-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Don't try to "validate" a non-existing timeval.

settime() with a NULL timeval is silly but legal.

Noticed by Dave Jones <davej@redhat.com>

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
[chrisw: seclvl only]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 security/seclvl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15.3/security/seclvl.c
===================================================================
--- linux-2.6.15.3.orig/security/seclvl.c
+++ linux-2.6.15.3/security/seclvl.c
@@ -369,7 +369,7 @@ static int seclvl_capable(struct task_st
 static int seclvl_settime(struct timespec *tv, struct timezone *tz)
 {
 	struct timespec now;
-	if (seclvl > 1) {
+	if (tv && seclvl > 1) {
 		now = current_kernel_time();
 		if (tv->tv_sec < now.tv_sec ||
 		    (tv->tv_sec == now.tv_sec && tv->tv_nsec < now.tv_nsec)) {

--
