Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVCPHur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVCPHur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 02:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVCPHur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 02:50:47 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:24964 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262289AbVCPHuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 02:50:39 -0500
Subject: softdog.c kernel 2.4.29
From: Jacques Basson <jacques_basson@myrealbox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 16 Mar 2005 09:50:27 +0200
Message-Id: <1110959428.10190.5.camel@lancelot.advanced-imaging-technologies>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

There is a bug in the softdog.c (v 0.05) in the 2.4 kernel series
(certainly in 2.4.29 and there are no references to it in the latest
Changelog) that won't reboot the machine if /dev/watchdog is closed
unexpectedly and nowayout is not set. The softdog.c (v 0.07) in 2.6.11
is not affected, but I have been informed by the vendor of analog output
cards that we use (ICP DAS) that they currently have no plans to port
their driver to the 2.6 series.

Anyway, here is a simple patch that does the job. I hope that it is of
use to someone:

diff -Naur softdog.c.orig softdog.c
--- softdog.c.orig      2003-11-28 20:26:20.000000000 +0200
+++ softdog.c   2005-03-16 09:12:34.000000000 +0200
@@ -124,7 +124,7 @@
         *      Shut off the timer.
         *      Lock it in if it's a module and we set nowayout
         */
-       if (expect_close || nowayout == 0) {
+       if (expect_close && nowayout == 0) {
                del_timer(&watchdog_ticktock);
        } else {
                printk(KERN_CRIT "SOFTDOG: WDT device closed
unexpectedly.  WDT will not stop!\n");

Jacques

