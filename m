Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUJCArI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUJCArI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 20:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUJCArI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 20:47:08 -0400
Received: from main.gmane.org ([80.91.229.2]:35480 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267651AbUJCArD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 20:47:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: [PATCH 2.4] Use "sym53c8xx_2" as proc_name
Date: Sat, 02 Oct 2004 17:46:59 -0700
Message-ID: <pan.2004.10.03.00.46.58.30112@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-181-112.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

A month or so ago I wrote a patch against 2.6 that changed the proc_name
of each ESP variant to its actual module name, since our initrd creation
scripts use the contents of /proc/scsi to determine which modules to
include in the ramdisk. Now this is happening with sym53c8xx/sym53c8xx_2
as well. sym53c8xx_2 is detected as the appropriate module during the
install procedure, but appears in /proc/scsi as sym53c8xx, so the wrong
module is inserted into the ramdisk. This patch, against 2.4, changes
the NAME53C8XX #define to "sym53c8xx_2", which proc_name gets set to.

(It turns out that most of the time one gets lucky. sym53c8xx works in
many of the same cases that sym53c8xx_2 did. But one tester reported
that using sym53c8xx instead of sym53c8xx_2 caused his kernel to panic.
More on that perhaps later.)

Marcelo, please apply :)

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--- kernel-source-2.4.27-2.4.27/drivers/scsi/sym53c8xx_2/sym_glue.c~	2004-10-02 17:35:22.000000000 -0700
+++ kernel-source-2.4.27-2.4.27/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-10-02 17:35:38.000000000 -0700
@@ -55,7 +55,7 @@
 #include "sym_glue.h"
 
 #define NAME53C		"sym53c"
-#define NAME53C8XX	"sym53c8xx"
+#define NAME53C8XX	"sym53c8xx_2"
 
 /*
  *  Simple Wrapper to kernel PCI bus interface.


-- 
Joshua Kwan


