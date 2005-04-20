Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVDTWD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVDTWD1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 18:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDTWD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 18:03:27 -0400
Received: from mail.dif.dk ([193.138.115.101]:702 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261829AbVDTWDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 18:03:09 -0400
Date: Thu, 21 Apr 2005 00:06:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] rename "---help---" to "help" in Kconfig files
Message-ID: <Pine.LNX.4.62.0504202306350.2071@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll admit right up front that this is probably slightly 
controversial, and most certainly slightly silly as well, and my reasons 
for doing this may not be the best in the world, but let me try and 
explain the reasons for this patch.

What does it do? :  It renames all instances of "---help---" to simply 
"help" in all of the Kconfig files.

Why does it do this? :  There are two reasons for doing this;
1) Consistency. out of ~4000 help entries in 134 Kconfig files, 747 of 
those entries use "---help---" as the keyword, the rest use just "help". 
So the users of "---help---" are clearly a minority and by renaming them 
we make things consistent. - I hate inconsistency. :-)
2) By not using two different "keywords" I assume it will be posible to 
speed up kbuilds handling of Kconfig files slightly. That goal is not 
accomplished by this patch, but this patch is a prerequisite for making 
that change later.

Now I think I can already guess some of the arguments against this; 
a) this diff will clutter up the change history for those files. True, it 
will, but Kconfig files see releatively few changes so this shouldn't be a 
big deal.
b) This doesn't improve anything for the users of the Kconfig files. Again 
true, it will not, but if it leads to a slightly faster kbuild that /will/ 
benefit users if only ever so slightly).

Anyway, I made the patch, if it makes sense to the powers that be, then 
feel free to apply it, if not, then don't apply it and the world moves on 
:)  No need to make a big fuzz about it...

Since this patch is fairly huge (~250Kb) I've not included it inline, but 
you can find it at 
http://www.linuxtux.org/~juhl/kernel_patches/Kconfig-help-rewrite.patch

Here's the diffstat : 

 arch/alpha/Kconfig                   |   12 +--
 arch/arm/Kconfig                     |   10 +-
 arch/arm/mach-clps711x/Kconfig       |    2 
 arch/arm/mach-footbridge/Kconfig     |    2 
 arch/arm26/Kconfig                   |    2 
 arch/cris/arch-v10/drivers/Kconfig   |    4 -
 arch/h8300/Kconfig                   |    6 -
 arch/i386/Kconfig                    |   30 ++++----
 arch/i386/kernel/cpu/cpufreq/Kconfig |    4 -
 arch/ia64/Kconfig                    |    2 
 arch/m32r/Kconfig                    |    4 -
 arch/m68k/Kconfig                    |   18 ++---
 arch/m68knommu/Kconfig               |    8 +-
 arch/mips/Kconfig                    |   12 +--
 arch/parisc/Kconfig                  |    4 -
 arch/ppc/Kconfig                     |   26 +++----
 arch/ppc64/Kconfig                   |    6 -
 arch/s390/Kconfig                    |    4 -
 arch/sh/Kconfig                      |    8 +-
 arch/sh/cchips/Kconfig               |    4 -
 arch/sparc/Kconfig                   |   14 ++--
 arch/sparc64/Kconfig                 |   18 ++---
 arch/um/Kconfig                      |    2 
 arch/x86_64/Kconfig                  |    8 +-
 drivers/acpi/Kconfig                 |   14 ++--
 drivers/atm/Kconfig                  |   16 ++--
 drivers/base/Kconfig                 |    2 
 drivers/block/Kconfig                |   24 +++---
 drivers/block/paride/Kconfig         |    8 +-
 drivers/cdrom/Kconfig                |   20 ++---
 drivers/char/Kconfig                 |   50 +++++++-------
 drivers/char/agp/Kconfig             |    6 -
 drivers/char/ftape/Kconfig           |   18 ++---
 drivers/char/tpm/Kconfig             |    6 -
 drivers/char/watchdog/Kconfig        |   34 ++++-----
 drivers/eisa/Kconfig                 |    8 +-
 drivers/fc4/Kconfig                  |    4 -
 drivers/i2c/Kconfig                  |    2 
 drivers/ide/Kconfig                  |   36 +++++-----
 drivers/infiniband/Kconfig           |    2 
 drivers/infiniband/hw/mthca/Kconfig  |    4 -
 drivers/infiniband/ulp/ipoib/Kconfig |    6 -
 drivers/input/Kconfig                |   12 +--
 drivers/input/gameport/Kconfig       |    2 
 drivers/input/joystick/Kconfig       |    6 -
 drivers/input/mouse/Kconfig          |    4 -
 drivers/input/serio/Kconfig          |   12 +--
 drivers/isdn/Kconfig                 |    4 -
 drivers/isdn/hisax/Kconfig           |    2 
 drivers/macintosh/Kconfig            |    2 
 drivers/md/Kconfig                   |   28 ++++----
 drivers/media/Kconfig                |    2 
 drivers/media/dvb/Kconfig            |    2 
 drivers/media/radio/Kconfig          |   30 ++++----
 drivers/media/video/Kconfig          |   28 ++++----
 drivers/message/fusion/Kconfig       |    6 -
 drivers/message/i2o/Kconfig          |    2 
 drivers/misc/Kconfig                 |    2 
 drivers/mtd/Kconfig                  |   16 ++--
 drivers/mtd/chips/Kconfig            |    2 
 drivers/mtd/devices/Kconfig          |   10 +-
 drivers/mtd/nand/Kconfig             |    2 
 drivers/net/Kconfig                  |  122 +++++++++++++++++------------------
 drivers/net/appletalk/Kconfig        |    2 
 drivers/net/arcnet/Kconfig           |    8 +-
 drivers/net/hamradio/Kconfig         |   16 ++--
 drivers/net/irda/Kconfig             |    8 +-
 drivers/net/pcmcia/Kconfig           |    4 -
 drivers/net/tokenring/Kconfig        |   12 +--
 drivers/net/tulip/Kconfig            |   14 ++--
 drivers/net/wan/Kconfig              |   26 +++----
 drivers/net/wireless/Kconfig         |   28 ++++----
 drivers/net/wireless/hostap/Kconfig  |   16 ++--
 drivers/parport/Kconfig              |    4 -
 drivers/pci/Kconfig                  |    4 -
 drivers/pci/hotplug/Kconfig          |    2 
 drivers/pcmcia/Kconfig               |    8 +-
 drivers/pnp/Kconfig                  |    2 
 drivers/pnp/pnpacpi/Kconfig          |    2 
 drivers/pnp/pnpbios/Kconfig          |    4 -
 drivers/s390/Kconfig                 |    2 
 drivers/scsi/Kconfig                 |   92 +++++++++++++-------------
 drivers/scsi/qla2xxx/Kconfig         |   10 +-
 drivers/serial/Kconfig               |   16 ++--
 drivers/telephony/Kconfig            |    4 -
 drivers/usb/Kconfig                  |    4 -
 drivers/usb/class/Kconfig            |    6 -
 drivers/usb/core/Kconfig             |    2 
 drivers/usb/host/Kconfig             |   14 ++--
 drivers/usb/image/Kconfig            |    2 
 drivers/usb/input/Kconfig            |   18 ++---
 drivers/usb/media/Kconfig            |   22 +++---
 drivers/usb/misc/Kconfig             |    4 -
 drivers/usb/misc/sisusbvga/Kconfig   |    2 
 drivers/usb/net/Kconfig              |   10 +-
 drivers/usb/serial/Kconfig           |   20 ++---
 drivers/usb/storage/Kconfig          |    4 -
 drivers/video/Kconfig                |   50 +++++++-------
 drivers/video/console/Kconfig        |    4 -
 drivers/video/geode/Kconfig          |    4 -
 drivers/w1/Kconfig                   |    2 
 drivers/zorro/Kconfig                |    2 
 fs/Kconfig                           |    8 +-
 fs/ncpfs/Kconfig                     |    2 
 fs/nls/Kconfig                       |   10 +-
 fs/partitions/Kconfig                |    6 -
 init/Kconfig                         |   12 +--
 kernel/power/Kconfig                 |    8 +-
 net/8021q/Kconfig                    |    2 
 net/Kconfig                          |    8 +-
 net/appletalk/Kconfig                |    2 
 net/atm/Kconfig                      |    2 
 net/ax25/Kconfig                     |    6 -
 net/bridge/Kconfig                   |    2 
 net/core/Kconfig                     |    4 -
 net/decnet/Kconfig                   |    4 -
 net/econet/Kconfig                   |    2 
 net/ieee80211/Kconfig                |   10 +-
 net/ipv4/Kconfig                     |   24 +++---
 net/ipv4/ipvs/Kconfig                |   36 +++++-----
 net/ipv4/netfilter/Kconfig           |   12 +--
 net/ipv6/Kconfig                     |   14 ++--
 net/ipv6/netfilter/Kconfig           |    2 
 net/ipx/Kconfig                      |    4 -
 net/irda/Kconfig                     |    4 -
 net/lapb/Kconfig                     |    2 
 net/packet/Kconfig                   |    2 
 net/sched/Kconfig                    |   50 +++++++-------
 net/sctp/Kconfig                     |    2 
 net/unix/Kconfig                     |    2 
 net/wanrouter/Kconfig                |    2 
 net/x25/Kconfig                      |    2 
 net/xfrm/Kconfig                     |    4 -
 sound/oss/Kconfig                    |   24 +++---
 134 files changed, 747 insertions(+), 747 deletions(-)


