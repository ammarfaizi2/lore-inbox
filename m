Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSGXUF3>; Wed, 24 Jul 2002 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSGXUF3>; Wed, 24 Jul 2002 16:05:29 -0400
Received: from www.transvirtual.com ([206.14.214.140]:34065 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317590AbSGXUF1>; Wed, 24 Jul 2002 16:05:27 -0400
Date: Wed, 24 Jul 2002 13:08:33 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] Second set of console changes.
Message-ID: <Pine.LNX.4.44.0207241157540.9506-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set has various bug fixes and has nearly removed currcon. I also
moved data from console.h and console_struct.h into vt_kern.h. The move to
have struct vt_struct represent a display and struct vc_data represent the
set of VCs belonging to to a display. Also I'm begining the breakup of
console.c. The biggest change is struct kbd_struct has been moved into
struct vc_data.

This will break the following drivers:

drivers/sbus/char/sunkbd.c
drivers/macintosh/mac_keyb.c
drivers/sgi/char/streamable.c

Please port these drivers over to the input api. Soon I will move
keyboard.c over to the input api in the next few weeks anyways. This move
will break every keyboard driver not ported over to the input api.

diff:

   http://www.transvirtual.com/~jsimmons/console.diff.gz

BK:

   http://linuxconsole.bkbits.net:8080/dev


diffstat

 drivers/char/Makefile          |   12
 drivers/char/console.c         | 3032 -------------------------
 drivers/char/console_macros.h  |  155 -
 drivers/char/consolemap.c      |  121 -
 drivers/char/keyboard.c        |  583 ++--
 drivers/char/misc.c            |    1
 drivers/char/selection.c       |   21
 drivers/char/sysrq.c           |  486 ----
 drivers/char/tty_io.c          |    2
 drivers/char/vc_screen.c       |  105
 drivers/char/vt.c              | 4855 +++++++++++++++++++++++++++++++----------
 drivers/video/dummycon.c       |    1
 drivers/video/fbcon-accel.c    |    5
 drivers/video/fbcon.c          |   10
 drivers/video/mdacon.c         |    3
 drivers/video/newport_con.c    |    1
 drivers/video/promcon.c        |   23
 drivers/video/sticon.c         |    1
 drivers/video/vgacon.c         |    1
 include/linux/console.h        |   17
 include/linux/console_struct.h |  110
 include/linux/consolemap.h     |    6
 include/linux/kbd_kern.h       |   26
 include/linux/selection.h      |   24
 include/linux/tty.h            |    2
 include/linux/vt_kern.h        |  172 +
 include/video/fbcon.h          |    2
 27 files changed, 4550 insertions(+), 5227 deletions(-)


   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/




