Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWBZWop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWBZWop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBZWop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:44:45 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:8703 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751419AbWBZWoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:44:44 -0500
Date: Sun, 26 Feb 2006 17:44:45 -0500
From: Brian Magnuson <magnuson@rcn.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix build for x86_64 for !CONFIG_HOTPLUG_CPU
Message-ID: <20060226224445.GA6425@tinygod.moriquendi.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e2c0388866dc12bef56b178b958f9b778fe6c687 added
setup_additional_cpus to setup.c but this is only defined if
CONFIG_HOTPLUG_CPU is set.  This patch changes the #ifdef to reflect that.

Signed-off-by: Brian Magnuson <magnuson@rcn.com>

--- linux-2.6.orig/arch/x86_64/kernel/setup.c   2006-02-26 17:03:26.000000000 -0500
+++ linux-2.6/arch/x86_64/kernel/setup.c        2006-02-26 17:33:05.000000000 -0500
@@ -424,7 +424,7 @@ static __init void parse_cmdline_early (
                        elfcorehdr_addr = memparse(from+11, &from);
 #endif

-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
                else if (!memcmp(from, "additional_cpus=", 16))
                        setup_additional_cpus(from+16);
 #endif


.
