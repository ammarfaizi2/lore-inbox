Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965503AbWI0KEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965503AbWI0KEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 06:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbWI0KEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 06:04:16 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:773 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S965503AbWI0KEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 06:04:15 -0400
Date: Wed, 27 Sep 2006 12:04:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C patches for 2.6.18
Message-Id: <20060927120415.6a6ee5c2.khali@linux-fr.org>
In-Reply-To: <20060927010044.GA9136@kroah.com>
References: <20060927010044.GA9136@kroah.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are some i2c patches for 2.6.18.  They include a new driver, a
> bunch of warning fixes, and some other odd changes detailed below.
> 
> They all have been in the -mm tree for a while.
> 
> Please pull from:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> or from:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> if it isn't synced up yet.
> 
> The full patch series will sent to the sensors mailing list, if anyone
> wants to see them.

Greg, i2c patches should be sent to the new i2c mailing list, rather
than the lm-sensors list, please!
http://lists.lm-sensors.org/mailman/listinfo/i2c

Other than that, everything looks correct and in sync with my own patch
stack, thanks.

>  Documentation/feature-removal-schedule.txt |    9 
>  Documentation/i2c/busses/i2c-viapro        |    7 
>  Documentation/i2c/i2c-stub                 |   15 +
>  drivers/acorn/char/i2c.c                   |    1 
>  drivers/acpi/i2c_ec.c                      |    2 
>  drivers/hwmon/it87.c                       |    1 
>  drivers/hwmon/lm78.c                       |    1 
>  drivers/hwmon/pc87360.c                    |    1 
>  drivers/hwmon/sis5595.c                    |    1 
>  drivers/hwmon/smsc47b397.c                 |    1 
>  drivers/hwmon/smsc47m1.c                   |    1 
>  drivers/hwmon/via686a.c                    |    1 
>  drivers/hwmon/vt8231.c                     |    1 
>  drivers/hwmon/w83627ehf.c                  |    1 
>  drivers/hwmon/w83627hf.c                   |    1 
>  drivers/hwmon/w83781d.c                    |    1 
>  drivers/i2c/Kconfig                        |    2 
>  drivers/i2c/algos/Kconfig                  |    6 
>  drivers/i2c/algos/Makefile                 |    1 
>  drivers/i2c/algos/i2c-algo-bit.c           |   23 -
>  drivers/i2c/algos/i2c-algo-pca.c           |    2 
>  drivers/i2c/algos/i2c-algo-pcf.c           |    2 
>  drivers/i2c/algos/i2c-algo-sgi.c           |    2 
>  drivers/i2c/algos/i2c-algo-sibyte.c        |  215 ---------
>  drivers/i2c/busses/Kconfig                 |   34 +
>  drivers/i2c/busses/Makefile                |    1 
>  drivers/i2c/busses/i2c-ali1535.c           |    2 
>  drivers/i2c/busses/i2c-ali1563.c           |    2 
>  drivers/i2c/busses/i2c-ali15x3.c           |    2 
>  drivers/i2c/busses/i2c-amd756.c            |    2 
>  drivers/i2c/busses/i2c-amd8111.c           |    2 
>  drivers/i2c/busses/i2c-au1550.c            |   21 +
>  drivers/i2c/busses/i2c-elektor.c           |    1 
>  drivers/i2c/busses/i2c-hydra.c             |    1 
>  drivers/i2c/busses/i2c-i801.c              |    2 
>  drivers/i2c/busses/i2c-i810.c              |    2 
>  drivers/i2c/busses/i2c-ibm_iic.c           |    2 
>  drivers/i2c/busses/i2c-iop3xx.c            |    2 
>  drivers/i2c/busses/i2c-isa.c               |   42 +-
>  drivers/i2c/busses/i2c-ixp2000.c           |    1 
>  drivers/i2c/busses/i2c-ixp4xx.c            |    1 
>  drivers/i2c/busses/i2c-mpc.c               |    2 
>  drivers/i2c/busses/i2c-mv64xxx.c           |    2 
>  drivers/i2c/busses/i2c-nforce2.c           |    2 
>  drivers/i2c/busses/i2c-ocores.c            |    2 
>  drivers/i2c/busses/i2c-omap.c              |  676 ++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-parport-light.c     |    1 
>  drivers/i2c/busses/i2c-parport.c           |    1 
>  drivers/i2c/busses/i2c-piix4.c             |    2 
>  drivers/i2c/busses/i2c-powermac.c          |    2 
>  drivers/i2c/busses/i2c-prosavage.c         |    1 
>  drivers/i2c/busses/i2c-pxa.c               |    2 
>  drivers/i2c/busses/i2c-s3c2410.c           |    2 
>  drivers/i2c/busses/i2c-savage4.c           |    1 
>  drivers/i2c/busses/i2c-sibyte.c            |  160 ++++++-
>  drivers/i2c/busses/i2c-sis5595.c           |    2 
>  drivers/i2c/busses/i2c-sis630.c            |    2 
>  drivers/i2c/busses/i2c-sis96x.c            |    2 
>  drivers/i2c/busses/i2c-stub.c              |   21 +
>  drivers/i2c/busses/i2c-via.c               |    1 
>  drivers/i2c/busses/i2c-viapro.c            |   10 
>  drivers/i2c/busses/i2c-voodoo3.c           |    2 
>  drivers/i2c/busses/scx200_acb.c            |    2 
>  drivers/i2c/busses/scx200_i2c.c            |   12 
>  drivers/i2c/chips/eeprom.c                 |    8 
>  drivers/i2c/chips/max6875.c                |   25 +
>  drivers/i2c/chips/pca9539.c                |   11 
>  drivers/i2c/chips/pcf8574.c                |   22 +
>  drivers/i2c/chips/pcf8591.c                |   58 ++
>  drivers/i2c/i2c-core.c                     |   72 ++-
>  drivers/i2c/i2c-dev.c                      |  109 ++---
>  drivers/ieee1394/pcilynx.c                 |    1 
>  drivers/media/video/bt8xx/bttv-i2c.c       |    1 
>  drivers/media/video/cx88/cx88-i2c.c        |    1 
>  drivers/media/video/cx88/cx88-vp3054-i2c.c |    1 
>  drivers/media/video/zoran_card.c           |    1 
>  drivers/video/i810/i810-i2c.c              |    1 
>  drivers/video/matrox/i2c-matroxfb.c        |   12 
>  drivers/video/savage/savagefb-i2c.c        |    1 
>  include/linux/i2c-algo-bit.h               |    1 
>  include/linux/i2c-algo-pcf.h               |    1 
>  include/linux/i2c-algo-sibyte.h            |   33 -
>  include/linux/i2c.h                        |   14 -
>  83 files changed, 1219 insertions(+), 482 deletions(-)
>  delete mode 100644 drivers/i2c/algos/i2c-algo-sibyte.c
>  create mode 100644 drivers/i2c/busses/i2c-omap.c
>  delete mode 100644 include/linux/i2c-algo-sibyte.h
> 
> ---------------
> 
> Adrian Bunk:
>       i2c-algo-pcf: Discard the mdelay data struct member
> 
> Arthur Othieno:
>       i2c: Fix copy-n-paste in subsystem Kconfig
> 
> David Brownell:
>       i2c: Let drivers constify i2c_algorithm data
> 
> David Hubbard:
>       i2c-isa: Fail adding driver on attach_adapter error
> 
> Domen Puncer:
>       i2c-au1550: Fix timeout problem
>       i2c-au1550: Add SMBus functionality flag
>       i2c-au1550: Add I2C support for Au1200
> 
> Jean Delvare:
>       i2c-dev: Cleanups
>       i2c-dev: Use a list for data storage
>       i2c-dev: Drop the client template
>       i2c: __must_check fixes (core drivers)
>       i2c: __must_check fixes, i2c-dev
>       i2c-algo-sibyte: Cleanups
>       i2c-algo-sibyte: Merge into i2c-sibyte
>       i2c-sibyte: Kip Walker is gone
>       i2c-matroxfb: Struct init conversion
>       i2c-algo-bit: Discard the mdelay data struct member
>       i2c: Plan i2c-isa for removal
>       i2c-stub: Chip address as a module parameter
>       i2c-dev: attach/detach_adapter cleanups
>       i2c: __must_check fixes (chip drivers)
>       i2c-algo-bit: Cleanups
>       i2c-core: Drop useless bitmaskings
>       i2c: Warn on i2c client creation failure
>       i2c-isa: Restore driver owner
>       i2c: Constify i2c_algorithm declarations, part 1
>       i2c: Constify i2c_algorithm declarations, part 2
>       i2c: Drop unimplemented slave functions
> 
> Komal Shah:
>       i2c: New bus driver for TI OMAP boards
> 
> Rudolf Marek:
>       i2c-viapro: Add support for the VT8237A and VT8251


-- 
Jean Delvare
