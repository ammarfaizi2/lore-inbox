Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUJKRH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUJKRH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUJKRFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:05:17 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:14249 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S269072AbUJKREZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:04:25 -0400
Date: Mon, 11 Oct 2004 13:01:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] softdog.c (was: Kernel panic after rmmod softdog
  (2.6.8.1))
To: Michael Schierl <schierlm@gmx.de>
Cc: Joel Becker <joel.becker@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410111304_MC3-1-8C02-813F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schierl wrote:

> today, when testing the software watchdog, I accidentally removed the 
> software watchdog kernel module and got a kernel panic.

Does this fix it? (compiled but not tested)

--- linux-2.6.8.1/drivers/char/watchdog/softdog.c.orig  Sun Oct 10 23:08:24 2004
+++ linux-2.6.8.1/drivers/char/watchdog/softdog.c       Sun Oct 10 23:10:12 2004
@@ -135,8 +135,9 @@
 {
        if(test_and_set_bit(0, &timer_alive))
                return -EBUSY;
-       if (nowayout)
-               __module_get(THIS_MODULE);
+
+       __module_get(THIS_MODULE);
+
        /*
         *      Activate timer
         */
@@ -152,6 +153,7 @@
         */
        if (expect_close == 42) {
                softdog_stop();
+               module_put(THIS_MODULE);
        } else {
                printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
                softdog_keepalive();


--Chuck Ebbert  11-Oct-04  12:49:45
  Current book: Stephen King: Wizard and Glass
