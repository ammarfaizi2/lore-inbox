Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSKAAiP>; Thu, 31 Oct 2002 19:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbSKAAiO>; Thu, 31 Oct 2002 19:38:14 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:30597 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S265459AbSKAAiN>; Thu, 31 Oct 2002 19:38:13 -0500
Date: Thu, 31 Oct 2002 17:37:50 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: [BK console] console updates.
In-Reply-To: <20021030215258.A10037@infradead.org>
Message-ID: <Pine.LNX.4.33.0210311731420.2733-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Oct 30, 2002 at 01:56:38PM -0800, James Simmons wrote:
> > I doubt this code will go into 2.5.X but it is avaiable for anyone to play
> > with it.
>
> Why?  I don't want to live another release with the old, crappy console,
> and you've been working on this during almost all of 2.4 now..

Okay. Here is the new console system. The patch is against 2.5.45.
Please note only vgacon has been fixed to work with this new api.

http://phoenix.infradead.org/~jsimmons/console.diff.gz

Via BK bk://linuxconsole.bkbits.net/stable


Diff stats:

 arch/alpha/kernel/setup.c                   |   13
 arch/arm/kernel/setup.c                     |    9
 arch/i386/kernel/setup.c                    |    8
 arch/i386/vmlinux.lds.s                     |  109
 arch/ia64/kernel/setup.c                    |   16
 arch/m68k/amiga/config.c                    |    4
 arch/m68k/apollo/config.c                   |    3
 arch/m68k/atari/config.c                    |    5
 arch/m68k/hp300/config.c                    |    4
 arch/m68k/mac/config.c                      |    5
 arch/m68k/q40/config.c                      |    3
 arch/m68k/sun3/config.c                     |    4
 arch/m68k/sun3x/config.c                    |    3
 arch/mips/ddb5476/setup.c                   |    5
 arch/mips/dec/setup.c                       |    5
 arch/mips/ite-boards/generic/it8172_setup.c |    7
 arch/mips/jazz/setup.c                      |    4
 arch/mips/philips/nino/setup.c              |    7
 arch/mips/sgi/kernel/setup.c                |    6
 arch/mips/sni/setup.c                       |    4
 arch/mips64/kernel/ioctl32.c                |    3
 arch/mips64/sgi-ip22/ip22-setup.c           |    5
 arch/mips64/sgi-ip32/ip32-setup.c           |    6
 arch/parisc/kernel/setup.c                  |    8
 arch/ppc/amiga/config.c                     |    3
 arch/ppc/kernel/ppc4xx_setup.c              |    7
 arch/ppc/platforms/chrp_setup.c             |    8
 arch/ppc/platforms/k2_setup.c               |    6
 arch/ppc/platforms/lopec_setup.c            |    4
 arch/ppc/platforms/mcpn765_setup.c          |    6
 arch/ppc/platforms/menf1_setup.c            |    6
 arch/ppc/platforms/mvme5100_setup.c         |    6
 arch/ppc/platforms/pcore_setup.c            |    6
 arch/ppc/platforms/pmac_setup.c             |    5
 arch/ppc/platforms/pplus_setup.c            |    4
 arch/ppc/platforms/prep_setup.c             |    4
 arch/ppc/platforms/prpmc750_setup.c         |    6
 arch/ppc/platforms/prpmc800_setup.c         |    6
 arch/ppc/platforms/sandpoint_setup.c        |    5
 arch/ppc/platforms/spruce_setup.c           |    6
 arch/ppc64/kernel/chrp_setup.c              |    5
 arch/ppc64/kernel/ioctl32.c                 |   73
 arch/sh/kernel/setup.c                      |    8
 arch/sparc/kernel/setup.c                   |    5
 arch/sparc64/kernel/ioctl32.c               |   37
 arch/um/kernel/um_arch.c                    |    2
 arch/x86_64/kernel/setup.c                  |   10
 drivers/char/Kconfig                        |    5
 drivers/char/console_macros.h               |  166 -
 drivers/char/consolemap.c                   |  152 -
 drivers/char/decvte.c                       | 2065 ++++++++++++++++++
 drivers/char/keyboard.c                     |  327 +-
 drivers/char/misc.c                         |    3
 drivers/char/n_tty.c                        |   12
 drivers/char/selection.c                    |   83
 drivers/char/sysrq.c                        |   17
 drivers/char/tty_io.c                       |   48
 drivers/char/vc_screen.c                    |  124 -
 drivers/char/vt.c                           | 3178 ++++++++--------------------
 drivers/char/vt_ioctl.c                     | 1020 +++++---
 drivers/video/dummycon.c                    |    1
 drivers/video/mdacon.c                      |    3
 drivers/video/newport_con.c                 |    1
 drivers/video/promcon.c                     |   13
 drivers/video/sticon.c                      |    1
 drivers/video/vgacon.c                      |  162 -
 include/linux/console.h                     |   60
 include/linux/console_struct.h              |  110
 include/linux/consolemap.h                  |    6
 include/linux/kbd_kern.h                    |   96
 include/linux/selection.h                   |   32
 include/linux/tty.h                         |   19
 include/linux/vt_kern.h                     |  350 ++-
 include/video/fbcon.h                       |    2
 74 files changed, 4752 insertions(+), 3778 deletions(-)

