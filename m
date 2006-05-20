Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWETXA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWETXA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 19:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWETXA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 19:00:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64405 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S964800AbWETXA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 19:00:57 -0400
Message-ID: <446F6F46.9090605@m1k.net>
Date: Sat, 20 May 2006 15:34:30 -0400
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, akpm@osdl.org,
       video4linux-list@redhat.com
Subject: Re: [v4l-dvb-maintainer] [PATCH 00/33] V4L/DVB bug fixes
References: <20060513094537.PS23916900000@infradead.org>
In-Reply-To: <20060513094537.PS23916900000@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:

>Please pull these from master branch at:
>        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
>  
>
Linus,

A week has gone by... Do you intend to merge these bug fixes into your tree?

These changesets fix a whole bunch of serious bugs that have been 
introduced in 2.6.17, and a good many of these bugfixes have been 
sitting around, waiting to be merged since 2.6.17-rc1, not to mention 
the fixes that have already been merged much earlier in 2.6.16.y

Please merge these before 2.6.17-rc5

We have already eliminated as many patches as we possibly could.  It all 
comes down to these.  Everything else has been held back until the 
2.6.18 merge window.

If you are nacking these fixes, then I would have to call 2.6.17 a 
broken kernel, when it comes to multimedia :-(

Please merge.

Regards,

Michael Krufky

>Mostly are just small patches to fix bugs. The most changed driver is cx24123 
>frontend, since it had several precision loss at math operations, resulting on
>several digital TV stations not being seen (from my tests, without the patch, 
>only 8 TV stations were available, of a total of 28 ones with the patch).
>
>We are also including some changes at Multimedia Kconfig menu to allow disabling
>drivers based at V4L1 API. This api were used until kernel 2.4, without providing
>enough capability to handle all analog TV video/audio standards. The removal of this
>feature is marked to July/2006. We intend to keep for a while a compatibility layer, 
>already at V4L core, that converts V4L1 calls into V4L2 ones.
>
>This patch series contains the following stuff:
>
>   - Fix some errors on bttv_risc_overlay
>   - Fix mutex in dvb_register_device to work.
>   - Fix TT budget-ci 1.1 CI slots
>   - Kbuild: drivers/media/video/bt8xx: remove $(src) from include path
>   - Saa7134: Fix oops with disable_ir=1
>   - Fix oops in budget-av with CI
>   - Set tone/voltage again if the frontend was reinitialised
>   - Fix some more potential oopses
>   - Fix a bug at pluto2 Makefile
>   - Bug fix: Wrong tuner was used pcHDTV HD-3000 card
>   - Correct buffer size calculations in cx88-core.c
>   - fix Pvr350 tv out (saa7127)
>   - Create V4L1 config options
>   - Add VIVI Kconfig stuff
>   - Removed uneeded stuff from pwc Makefile
>   - Fix compilation with V4L1_COMPAT
>   - Use after free in drivers/media/video/em28xx/em28xx-video.c
>   - Kbuild: DVB_BT8XX must select DVB_ZL10353
>   - Fix for CX24123 & low symbol rates
>   - Add several debug messages to cx24123 code
>   - Always wait for diseqc queue to become ready before transmitting a diseqc message
>   - Various correctness fixes to tuning.
>   - Tweak bandselect setup fox cx24123
>   - Add support for TCL M2523_5N_E tuner.
>   - Cxusb-bluebird: bug-fix: power down corrupts frontend
>   - Remove broken 'fast firmware load' from cx25840.
>   - Saa7134: Missing 'break' in Terratec Cinergy 400 TV initialization
>   - Fix frequency values in the ranges structures of the LG TDVS H06xF tuners
>   - Get_dvb_firmware: download nxt2002 firmware from new driver location
>   - Sparc32 vivi fix
>   - Vivi build fix
>   - Bt8xx/bttv-cards.c: fix off-by-one errors
>   - Fix CONFIG_VIDEO_VIVI=y build bug
>
>Cheers,
>Mauro.
>
>V4L/DVB development is hosted at http://linuxtv.org
>---
>
> Documentation/dvb/get_dvb_firmware                |    8 
> drivers/media/Kconfig                             |   45 -
> drivers/media/common/Kconfig                      |    1 
> drivers/media/dvb/bt8xx/Kconfig                   |    1 
> drivers/media/dvb/cinergyT2/cinergyT2.c           |    5 
> drivers/media/dvb/dvb-core/dvb_frontend.c         |   12 
> drivers/media/dvb/dvb-core/dvbdev.c               |    4 
> drivers/media/dvb/dvb-usb/cxusb.c                 |   17 
> drivers/media/dvb/frontends/cx24123.c             |  617 +++++++++-----
> drivers/media/dvb/frontends/dvb-pll.c             |    4 
> drivers/media/dvb/pluto2/Makefile                 |    2 
> drivers/media/dvb/ttpci/Kconfig                   |   12 
> drivers/media/dvb/ttpci/budget-av.c               |    6 
> drivers/media/dvb/ttpci/budget-ci.c               |  105 +-
> drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    6 
> drivers/media/radio/Kconfig                       |   30 
> drivers/media/video/Kconfig                       |   81 +
> drivers/media/video/Makefile                      |    7 
> drivers/media/video/bt8xx/Kconfig                 |    2 
> drivers/media/video/bt8xx/Makefile                |    2 
> drivers/media/video/bt8xx/bttv-cards.c            |    4 
> drivers/media/video/bt8xx/bttv-risc.c             |   14 
> drivers/media/video/cx25840/cx25840-firmware.c    |   49 -
> drivers/media/video/cx88/cx88-cards.c             |    2 
> drivers/media/video/cx88/cx88-core.c              |   16 
> drivers/media/video/cx88/cx88-dvb.c               |    2 
> drivers/media/video/cx88/cx88-video.c             |    2 
> drivers/media/video/em28xx/Kconfig                |    2 
> drivers/media/video/em28xx/em28xx-video.c         |   10 
> drivers/media/video/et61x251/Kconfig              |    2 
> drivers/media/video/pwc/Kconfig                   |    2 
> drivers/media/video/pwc/Makefile                  |   17 
> drivers/media/video/saa7127.c                     |    1 
> drivers/media/video/saa7134/saa7134-cards.c       |    1 
> drivers/media/video/saa7134/saa7134-core.c        |    6 
> drivers/media/video/saa7134/saa7134-video.c       |    2 
> drivers/media/video/sn9c102/Kconfig               |    2 
> drivers/media/video/tuner-types.c                 |    4 
> drivers/media/video/tveeprom.c                    |    2 
> drivers/media/video/usbvideo/Kconfig              |    6 
> drivers/media/video/vivi.c                        |    5 
> drivers/media/video/zc0301/Kconfig                |    2 
> include/linux/videodev2.h                         |    5 
> 43 files changed, 729 insertions(+), 396 deletions(-)
>
>
>_______________________________________________
>v4l-dvb-maintainer mailing list
>v4l-dvb-maintainer@linuxtv.org
>http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer
>  
>


