Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWJVXfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWJVXfo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJVXfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:35:44 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:23740 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750751AbWJVXfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:35:43 -0400
Subject: [PATCH] Quieten Freezer if !CONFIG_PM_DEBUG
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 09:35:40 +1000
Message-Id: <1161560140.7438.56.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The freezer currently prints an '=' for every process that is frozen.
This is pretty pointless, as the equals sign says nothing about which
process is frozen, and makes logs look messier (especially if there were
a large number of processes running). All we really need to know is that
we started trying to freeze processes and what processes (if any) failed
to freeze, or that we succeeded.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 29be608..b0edfc6 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -40,7 +40,6 @@ void refrigerator(void)
 	long save;
 	save = current->state;
 	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
 
 	frozen_process(current);
 	spin_lock_irq(&current->sighand->siglock);


