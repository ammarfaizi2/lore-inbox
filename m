Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVKHJVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVKHJVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 04:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKHJVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 04:21:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24265 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965001AbVKHJVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 04:21:52 -0500
Date: Tue, 8 Nov 2005 10:21:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       shaohua.li@intel.com
Subject: [PATCH] sleep: Fix oops in enter_state
Message-ID: <20051108092137.GA16848@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ACPI sleep is not configured, but someone still wants to run
swsusp, he'd get oops in enter_state. This is regression since 2.6.14
and this fixes it. 

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -167,7 +167,7 @@ static int enter_state(suspend_state_t s
 {
 	int error;
 
-	if (pm_ops->valid && !pm_ops->valid(state))
+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
 		return -ENODEV;
 	if (down_trylock(&pm_sem))
 		return -EBUSY;

-- 
Thanks, Sharp!
