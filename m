Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUHVUvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUHVUvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUHVUvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:51:07 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:41959 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S265489AbUHVUvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:51:02 -0400
Message-ID: <412907A6.9000404@drzeus.cx>
Date: Sun, 22 Aug 2004 22:52:54 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] Split timer resources
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel currently allocates the range 0x40-0x5f for timer calls. This 
causes conflicts with other hardware using these ports (In my case a 
Winbond W83L519D SD/MMC card reader). This patch splits the resource 
into the ports actually needed.

diff -u linux-2.6.8.1{,-mmc}/arch/i386/kernel/setup.c --- 
linux-2.6.8.1/arch/i386/kernel/setup.c      2004-08-14 
12:55:32.000000000 +0200
+++ linux-2.6.8.1-mmc/arch/i386/kernel/setup.c  2004-08-20 
23:46:43.708979200 +0200
@@ -218,9 +218,14 @@
        .end    = 0x0021,
        .flags  = IORESOURCE_BUSY | IORESOURCE_IO
 }, {
-       .name   = "timer",
+       .name   = "timer0",
        .start  = 0x0040,
-       .end    = 0x005f,
+       .end    = 0x0043,
+       .flags  = IORESOURCE_BUSY | IORESOURCE_IO
+},{
+       .name   = "timer1",
+       .start  = 0x0050,
+       .end    = 0x0053,
        .flags  = IORESOURCE_BUSY | IORESOURCE_IO
 }, {
        .name   = "keyboard",

