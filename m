Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313787AbSDPRtR>; Tue, 16 Apr 2002 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313789AbSDPRtQ>; Tue, 16 Apr 2002 13:49:16 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:31678 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313787AbSDPRtP>;
	Tue, 16 Apr 2002 13:49:15 -0400
Date: Tue, 16 Apr 2002 19:49:14 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204161749.TAA16333@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.8 IDE oops (TCQ breakage?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:

	if (drive->using_tcq) {
		int tag = ide_get_tag(drive);

		BUG_ON(drive->tcq->active_tag != -1);

Relevant .config is
# CONFIG_PCI is not set
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
(That's it. No chipset support selected; neither I nor Linux
has ever detected any known IDE chipset in this box...)

Why is drive->using_tcq non-zero when CONFIG_BLK_DEV_IDE_TCQ=n
and the disk is an early/mid-90s 500MB WD drive?

/Mikael
