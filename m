Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUDHRsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDHRsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:48:38 -0400
Received: from 213-0-217-98.dialup.nuria.telefonica-data.net ([213.0.217.98]:41352
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262077AbUDHRsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:48:35 -0400
Date: Thu, 8 Apr 2004 19:48:23 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Cc: Nick.Holloway@pyrites.org.uk
Subject: [PATCH 2.6] Add missing MODULE_PARAM to dummy.c (and MAINTAINERShip)
Message-ID: <20040408174823.GA13335@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Nick.Holloway@pyrites.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

It seems the "dummy" network interface driver is missing some MODULE_*
macros, needed with kernel 2.6.x and module-init-tools to show
information about the module (parameters, author, description, etc).

A patch follows to (hopefully) correct this. Another patch includes an
entry in the MAINTAINERS file for the "dummy" module. However, I suppose 
the module author (Nick Holloway) will come up and say if he should
still be considered as the module maintainer, so to add the correct
information to the MAINTAINERS file.

Hope the patchs are correct, or at least useful to note the missing bits
I was trying to "patch" and someone else does the "technical" work :-)

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.5)


diff -Nrup linux-2.6.5/drivers/net/dummy.c linux-2.6.5-new/drivers/net/dummy.c
--- linux-2.6.5/drivers/net/dummy.c	2004-04-04 17:45:54.000000000 +0200
+++ linux-2.6.5-new/drivers/net/dummy.c	2004-04-08 19:23:23.000000000 +0200
@@ -89,7 +89,8 @@ static struct net_device_stats *dummy_ge
 static struct net_device **dummies;
 
 /* Number of dummy devices to be set up by this module. */
-module_param(numdummies, int, 0);
+MODULE_PARM(numdummies, "i");
+MODULE_PARM_DESC(numdummies, "Maximum number of dummy devices (defaults to one)");
 
 static int __init dummy_init_one(int index)
 {
@@ -144,3 +145,5 @@ static void __exit dummy_cleanup_module(
 module_init(dummy_init_module);
 module_exit(dummy_cleanup_module);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Dummy network interface driver");
+MODULE_AUTHOR("Nick Holloway <Nick.Holloway@pyrites.org.uk>");

diff -Nrup linux-2.6.5/MAINTAINERS linux-2.6.5-new/MAINTAINERS
--- linux-2.6.5/MAINTAINERS	2004-04-04 17:49:26.000000000 +0200
+++ linux-2.6.5-new/MAINTAINERS	2004-04-08 19:22:01.000000000 +0200
@@ -707,6 +707,12 @@ M:	romieu@cogenit.fr
 M:	romieu@ensta.fr
 S:	Maintained
 
+DUMMY NETWORK INTERFACE DRIVER
+P:	Nick Holloway
+M:	Nick.Holloway@pyrites.org.uk
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+
 DVB SUBSYSTEM AND DRIVERS
 P:	LinuxTV.org Project
 M: 	linux-dvb-maintainer@linuxtv.org
