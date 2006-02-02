Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWBBXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWBBXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWBBXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:45:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932479AbWBBXpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:45:07 -0500
Date: Thu, 2 Feb 2006 18:45:02 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Fix build failure in recent pm_prepare_* changes.
Message-ID: <20060202234501.GA4091@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/power.h:49: error: static declaration of 'pm_prepare_console' follows non-static declaration
include/linux/suspend.h:46: error: previous declaration of 'pm_prepare_console' was here
kernel/power/power.h:50: error: static declaration of 'pm_restore_console' follows non-static declaration
include/linux/suspend.h:47: error: previous declaration of 'pm_restore_console' was here

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/include/linux/suspend.h~	2006-02-02 16:27:38.000000000 -0500
+++ linux-2.6.15.noarch/include/linux/suspend.h	2006-02-02 16:28:07.000000000 -0500
@@ -42,10 +42,6 @@ extern void mark_free_pages(struct zone 
 #ifdef CONFIG_PM
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
-
-extern int pm_prepare_console(void);
-extern void pm_restore_console(void);
-
 #else
 static inline int software_suspend(void)
 {
