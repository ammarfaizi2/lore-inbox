Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUHOOoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUHOOoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266726AbUHOOoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:44:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266721AbUHOOoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:44:00 -0400
Date: Sun, 15 Aug 2004 10:43:01 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: make sure we are looking at the low bits post error
Message-ID: <20040815144301.GA7165@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-io.c linux-2.6.8-rc3/drivers/ide/ide-io.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-io.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-io.c	2004-08-15 00:04:30.000000000 +0100
@@ -197,6 +197,8 @@
 				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
 			}
 			args->tfRegister[IDE_ERROR_OFFSET]   = err;
+			/* Be sure we're looking at the low order bits */
+			hwif->OUTB(drive->ctl & ~0x80,IDE_CONTROL_REG);
 			args->tfRegister[IDE_NSECTOR_OFFSET] = hwif->INB(IDE_NSECTOR_REG);
 			args->tfRegister[IDE_SECTOR_OFFSET]  = hwif->INB(IDE_SECTOR_REG);
 			args->tfRegister[IDE_LCYL_OFFSET]    = hwif->INB(IDE_LCYL_REG);


Signed-off-by: Alan Cox <alan@redhat.com> from an original bug report by
Brett Russ <russb@emc.com>

