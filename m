Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbUCYRq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbUCYRq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:46:56 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:35524 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S263455AbUCYRqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:46:52 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove <asm/setup.h> from cmdlinepart.c
Date: Thu, 25 Mar 2004 10:46:45 -0700
User-Agent: KMail/1.6.1
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403251046.45232.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove include of <asm/setup.h> from cmdlinepart.c.  This
is not be needed for i386 (it builds fine with this patch),
and ia64 doesn't supply a setup.h.

asm/setup.h contains a hodge-podge of stuff with no real
consistency between architectures.  It appears to be
included mainly by arch-specific drivers:
	acsi (Atari disks)
	amiflop (Amiga floppy)
	z2ram (ZorroII ram disk)
	amiserial (Amiga serial)
	...
and under arch-specific #ifdefs:
	fbcon (under __mc68000__ or CONFIG_APUS)
	fonts (ditto)
	logo (CONFIG_M68K)
	...

===== drivers/mtd/cmdlinepart.c 1.5 vs edited =====
--- 1.5/drivers/mtd/cmdlinepart.c	Wed May 28 09:01:08 2003
+++ edited/drivers/mtd/cmdlinepart.c	Wed Mar 24 11:48:19 2004
@@ -28,7 +28,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <asm/setup.h>
 #include <linux/bootmem.h>
 
 /* error message prefix */
