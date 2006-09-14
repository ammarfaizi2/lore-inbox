Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWINOex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWINOex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWINOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:34:52 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:26565 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750814AbWINOev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:34:51 -0400
Date: Thu, 14 Sep 2006 16:29:26 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [-mm patch 0/4] AVR32 MTD: Introduction
Message-ID: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and MTD people,

This patchset adds the necessary drivers and infrastructure to access
the external flash on the ATSTK1000 board through the MTD subsystem.

With this stuff in place, it will be possible to use a jffs2
filesystem stored in the external flash as a root filesystem. It might
also be possible to update the boot loader if you drop the write
protection of partition 0.

Andrew, can you apply this to -mm? They probably don't make sense for
the MTD tree until the rest of the AVR32 patches are merged into
mainline, but I'd really appreciate if someone could have a quick look
to see if I did something stupid.

This also needs two patches I've submitted earlier (included in
git-mtd.patch) in order to work, but it should still apply without
them. For the record, these are:
  MTD: Add lock/unlock operations for Atmel AT49BV6416
  MTD: Convert Atmel PRI information to AMD format

This patchset includes the following patches:

  AVR32 MTD: Static Memory Controller driver
  AVR32 MTD: Define struct flash_platform_data
  AVR32 MTD: Mapping driver for the ATSTK1000 board
  AVR32 MTD: AT49BV6416 platform device for atstk1000

And the combined diffstat looks like this:

 arch/avr32/boards/atstk1000/atstk1002.c |   46 ++++++++
 arch/avr32/mach-at32ap/Makefile         |    2 
 arch/avr32/mach-at32ap/at32ap7000.c     |   10 +
 arch/avr32/mach-at32ap/hsmc.c           |  164 +++++++++++++++++++++++++++++
 arch/avr32/mach-at32ap/hsmc.h           |  169 ++++++++++++++++++++++++++++++
 drivers/mtd/maps/Kconfig                |   10 +
 drivers/mtd/maps/Makefile               |    1 
 drivers/mtd/maps/atstk1000.c            |  179 ++++++++++++++++++++++++++++++++
 include/asm-avr32/arch-at32ap/board.h   |    7 +
 include/asm-avr32/arch-at32ap/smc.h     |   60 ++++++++++
 10 files changed, 647 insertions(+), 1 deletion(-)

Best regards,
Haavard
