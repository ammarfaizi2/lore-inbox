Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318401AbSGaWYk>; Wed, 31 Jul 2002 18:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSGaWYk>; Wed, 31 Jul 2002 18:24:40 -0400
Received: from www.transvirtual.com ([206.14.214.140]:51727 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318401AbSGaWYj>; Wed, 31 Jul 2002 18:24:39 -0400
Date: Wed, 31 Jul 2002 15:27:57 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] console part 2.
Message-ID: <Pine.LNX.4.44.0207311523540.21567-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the second patch. It has many fixes and alot of major changes
internally. Please test it out. It will break a few keyboard drivers due
to the struct kbd_struct changes. It will also break a few framebuffer
drivers as well since they touch console data structures. If you port your
fbdev driver to the new api you will not have to worry about this
(reason I developed this new api) :-)

 arch/mips/au1000/common/serial.c         |    2
 arch/parisc/kernel/pdc_cons.c            |    3
 arch/ppc/4xx_io/serial_sicc.c            |    2
 arch/ppc/8xx_io/uart.c                   |    2
 arch/ppc64/kernel/ioctl32.c              |   64
 arch/sparc64/kernel/ioctl32.c            |   23
 arch/x86_64/ia32/ia32_ioctl.c            |   20
 drivers/char/Makefile                    |   12
 drivers/char/console.c                   | 3032 -------------------------------
 drivers/char/console_macros.h            |  161 -
 drivers/char/consolemap.c                |  136 -
 drivers/char/decvte.c                    | 2054 +++++++++++++++++++++
 drivers/char/hvc_console.c               |    2
 drivers/char/keyboard.c                  |  595 +++---
 drivers/char/misc.c                      |    1
 drivers/char/selection.c                 |   63
 drivers/char/sysrq.c                     |   22
 drivers/char/tty_io.c                    |    2
 drivers/char/vc_screen.c                 |  115 -
 drivers/char/vt.c                        | 2753 +++++++++++++++++-----------
 drivers/char/vt_ioctl.c                  | 1443 ++++++++++++++
 drivers/s390/char/ctrlchar.c             |    2
 drivers/tc/zs.c                          |    2
 drivers/video/dummycon.c                 |    1
 drivers/video/fbcon-accel.c              |    5
 drivers/video/fbcon.c                    |   55
 drivers/video/mdacon.c                   |   21
 drivers/video/newport_con.c              |    1
 drivers/video/promcon.c                  |   33
 drivers/video/sticon-bmode.c             |    2
 drivers/video/sticon.c                   |    3
 drivers/video/vgacon.c                   |   21
 include/linux/console.h                  |   17
 include/linux/console_struct.h           |  110 -
 include/linux/consolemap.h               |    6
 include/linux/kbd_kern.h                 |   27
 include/linux/selection.h                |   23
 include/linux/tty.h                      |    8
 include/linux/vt_kern.h                  |  275 ++
 include/video/fbcon.h                    |    2
 45 files changed, 6214 insertions(+), 4923 deletions(-)

diff:
   http://www.transvirtual.com/~jsimmons/console.diff.gz

BK:
   http://linuxconsole.bkbits.net:8080/dev

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

