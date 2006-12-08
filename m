Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947545AbWLIACC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947545AbWLIACC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947554AbWLIACB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:02:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37661 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947548AbWLIABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:01:54 -0500
Message-Id: <20061209000234.680421000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, rjw@sisk.pl, pavel@ucw.cz
Subject: [patch 27/32] PM: Fix swsusp debug mode testproc
Content-Disposition: inline; filename=pm-fix-swsusp-debug-mode-testproc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Rafael J Wysocki <rjw@sisk.pl>

The 'testproc' swsusp debug mode thaws tasks twice in a row, which is _very_
confusing.  Fix that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/power/disk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.orig/kernel/power/disk.c
+++ linux-2.6.19/kernel/power/disk.c
@@ -127,7 +127,7 @@ int pm_suspend_disk(void)
 		return error;
 
 	if (pm_disk_mode == PM_DISK_TESTPROC)
-		goto Thaw;
+		return 0;
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);

--
