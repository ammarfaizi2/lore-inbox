Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWIOOjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWIOOjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWIOOjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:39:14 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:29651 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751575AbWIOOjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:39:13 -0400
Date: Fri, 15 Sep 2006 16:31:02 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: [-mm patch 0/3] AVR32 MTD: Introduction (try 2)
Message-ID: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

This patchset adds the necessary drivers and infrastructure to access
the external flash on the ATSTK1000 board through the MTD subsystem.
With this stuff in place, it will be possible to use a jffs2 filesystem
stored in the external flash as a root filesystem. It might also be
possible to update the boot loader if you drop the write protection of
partition 0.

As suggested by David Woodhouse, I reworked the patches to use the
physmap driver instead of introducing a separate mapping driver for the
ATSTK1000. I've also cleaned up the hsmc header by removing useless
comments and converting spaces to tabs (my headerfile generator needs
some work.)

Unfortunately, I couldn't unlock the flash in fixup_use_atmel_lock
because the erase regions hadn't been set up yet, so I had to do it
from cfi_amdstd_setup instead.

This also needs two patches I've submitted earlier (included in
git-mtd.patch) in order to work, but it should still apply without
them. For the record, these are:

  MTD: Add lock/unlock operations for Atmel AT49BV6416
  MTD: Convert Atmel PRI information to AMD format

This patchset includes the following patches:

  AVR32 MTD: Static Memory Controller driver
  AVR32 MTD: Unlock flash if necessary
  AVR32 MTD: AT49BV6416 platform device for atstk1000

And the combined diffstat looks like this:

 arch/avr32/boards/atstk1000/Makefile |    2
 arch/avr32/boards/atstk1000/flash.c  |   95 ++++++++++++++++++++
 arch/avr32/mach-at32ap/Makefile      |    2
 arch/avr32/mach-at32ap/at32ap7000.c  |   10 ++
 arch/avr32/mach-at32ap/hsmc.c        |  164 +++++++++++++++++++++++++++++++++++
 arch/avr32/mach-at32ap/hsmc.h        |  127 +++++++++++++++++++++++++++
 drivers/mtd/chips/cfi_cmdset_0002.c  |    9 +
 include/asm-avr32/arch-at32ap/smc.h  |   60 ++++++++++++
 8 files changed, 467 insertions(+), 2 deletions(-)

Best regards,
Haavard
