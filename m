Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWG3B0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWG3B0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 21:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWG3B0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 21:26:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750942AbWG3B0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 21:26:00 -0400
Subject: Re: [PATCH 00/23] V4L/DVB fixes
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <20060725180311.PS54604900000@infradead.org>
References: <20060725180311.PS54604900000@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 29 Jul 2006 22:25:16 -0300
Message-Id: <1154222716.27019.39.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I've added 3 more fixes to the tree:

   - Correctly handle sysfs error leg file removal in pvrusb2
   - Videodev: Check return value of class_device_register() correctly
   - Bttv: Revert VBI_OFFSET to previous value, it works better

Please pull these (and the other ones) from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Cheers,
Mauro.

Em Ter, 2006-07-25 às 15:03 -0300, mchehab@infradead.org escreveu:
> Linus,
> 
> Please pull those fixes from master branch at:
>         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
> 
> It contains the following stuff:
> 
>    - Add dvbpll i2c device check.
>    - Fix DISEQC regression
>    - Fix unstable DISEQC behaviour on budget cards.
>    - Fix broken tda665x PLL definition.
>    - Fix typo in comment for TDA9819
>    - Remove stradis MODULE_DEVICE_INFO definition
>    - Check all __must_check warnings in bttv.
>    - Support non interlaced capture by default for saa713x
>    - Saa7134: rename dmasound_{init, exit}
>    - Bugfix for keycode calculation on NPG remotes
>    - Set the Auxiliary Byte when tuning LG H06xF in analog mode
>    - Check __must_check warnings
>    - [budget/budget-av/budget-ci/budget-patch drivers] fixed DMA start/stop code
>    - Refine dead code elimination in pvrusb2
>    - Fix possible dvb-pll oops
>    - Fix dvb-pll autoprobing
>    - VIDIOCSMICROCODE were missing on compat_ioctl32
>    - Fix ext_controls align on 64 bit architectures
>    - Fix for compilation without V4L1 or V4L1_COMPAT
>    - Fix broken dependencies on media Kconfig
>    - OVERLAY flag were enabled by mistake
>    - Videodev: Handle class_device related errors
>    - Bttv: use class_device_create_file and handle errors
> 
> Cheers,
> Mauro.
> 
> V4L/DVB development is hosted at http://linuxtv.org
> ---
> 
>  drivers/media/dvb/dvb-core/dvb_frontend.c    |   15 +++--
>  drivers/media/dvb/frontends/dvb-pll.c        |   48 ++++++++++------
>  drivers/media/dvb/ttpci/av7110.c             |    4 -
>  drivers/media/dvb/ttpci/av7110_v4l.c         |   12 ++--
>  drivers/media/dvb/ttpci/budget-av.c          |    3 +
>  drivers/media/dvb/ttpci/budget-ci.c          |    2 
>  drivers/media/dvb/ttpci/budget-core.c        |   57 ++++++++++++++-----
>  drivers/media/dvb/ttpci/budget-patch.c       |    2 
>  drivers/media/dvb/ttpci/budget.c             |    5 -
>  drivers/media/dvb/ttpci/budget.h             |    7 +-
>  drivers/media/video/Kconfig                  |    4 -
>  drivers/media/video/bt8xx/Kconfig            |    2 
>  drivers/media/video/bt8xx/bttv-driver.c      |   31 +++++++---
>  drivers/media/video/compat_ioctl32.c         |   24 ++++++++
>  drivers/media/video/cpia2/Kconfig            |    2 
>  drivers/media/video/cx88/cx88-input.c        |    2 
>  drivers/media/video/cx88/cx88-video.c        |    5 -
>  drivers/media/video/msp3400-driver.c         |   10 +++
>  drivers/media/video/pvrusb2/pvrusb2-hdw.c    |    8 ++
>  drivers/media/video/pvrusb2/pvrusb2-io.c     |    9 ++-
>  drivers/media/video/pvrusb2/pvrusb2-io.h     |    2 
>  drivers/media/video/pvrusb2/pvrusb2-ioread.c |    5 +
>  drivers/media/video/pvrusb2/pvrusb2-sysfs.c  |   33 +++++++++--
>  drivers/media/video/saa7134/saa7134-alsa.c   |   10 +--
>  drivers/media/video/saa7134/saa7134-core.c   |   16 ++---
>  drivers/media/video/saa7134/saa7134-oss.c    |   10 +--
>  drivers/media/video/saa7134/saa7134-video.c  |    6 +-
>  drivers/media/video/saa7134/saa7134.h        |    4 -
>  drivers/media/video/stradis.c                |    1 
>  drivers/media/video/tuner-core.c             |   31 ++++------
>  drivers/media/video/tuner-simple.c           |   19 +++++-
>  drivers/media/video/usbvideo/Kconfig         |    8 +-
>  drivers/media/video/v4l2-common.c            |   24 ++++----
>  drivers/media/video/videodev.c               |   37 +++++++++---
>  drivers/media/video/vivi.c                   |    4 -
>  include/linux/videodev.h                     |    7 +-
>  include/linux/videodev2.h                    |    2 
>  include/media/v4l2-dev.h                     |    7 +-
>  38 files changed, 323 insertions(+), 155 deletions(-)
> 
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
Cheers, 
Mauro.

