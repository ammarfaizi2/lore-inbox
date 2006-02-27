Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWB0Wgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWB0Wgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWB0Wg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:36:27 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33409 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932387AbWB0Wby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:54 -0500
Message-Id: <20060227223354.715642000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, simon.vogl@researchstudios.at,
       tglx@linutronix.de
Subject: [patch 23/39] [PATCH] cfi: init wait queue in chip struct
Content-Disposition: inline; filename=cfi-init-wait-queue-in-chip-struct.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix a kernel oops for Intel P30 flashes, where the wait queue head was not
initialized for the flchip struct, which in turn caused a crash at the
first read operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/mtd/chips/cfi_cmdset_0001.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.15.4.orig/drivers/mtd/chips/cfi_cmdset_0001.c
+++ linux-2.6.15.4/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -408,6 +408,7 @@ struct mtd_info *cfi_cmdset_0001(struct 
 		cfi->chips[i].buffer_write_time = 1<<cfi->cfiq->BufWriteTimeoutTyp;
 		cfi->chips[i].erase_time = 1<<cfi->cfiq->BlockEraseTimeoutTyp;
 		cfi->chips[i].ref_point_counter = 0;
+		init_waitqueue_head(&(cfi->chips[i].wq));
 	}
 
 	map->fldrv = &cfi_intelext_chipdrv;

--
