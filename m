Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWIZFjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWIZFjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWIZFiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:48097 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751318AbWIZFih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:37 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/47] make suspend quieter
Date: Mon, 25 Sep 2006 22:37:31 -0700
Message-Id: <115924911859-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491152668-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Fix a goof in Linus' recent PM API updates:  don't emit any messages in the
typical NOP "already suspended it" late suspend case.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/suspend.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 10e8032..0bda4a7 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -102,11 +102,6 @@ static int suspend_device_late(struct de
 {
 	int error = 0;
 
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend_late %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
-
 	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
 		dev_dbg(dev, "LATE %s%s\n",
 			suspend_verb(state.event),
-- 
1.4.2.1

