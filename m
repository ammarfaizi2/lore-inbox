Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSHCXGf>; Sat, 3 Aug 2002 19:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSHCXGe>; Sat, 3 Aug 2002 19:06:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22034 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318116AbSHCXGQ>; Sat, 3 Aug 2002 19:06:16 -0400
Date: Sun, 4 Aug 2002 00:09:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Recent patches.
Message-ID: <20020804000946.B25024@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anyones wondering what's going on, I'm trying to get as much stuff
out of my -rmk patches (for the ARM architecture) as possible.  Even
after the 14 I've sent tonight, there's still a fair amount of stuff
left.

Some of it is stuff people won't want to take (because they want
compatibility across multiple kernel versions more than clean code),
a lot of it is now down to ARM drivers that need to be sorted out.
Other stuff is random ARM drivers.  There's still the odd fix buried
in here as well, or other ARM specific change.

I'm aiming to cut the -rmk patch down to something reasonable.  It's
been sitting at around 2MB uncompressed for months now.  With the
serial stuff going in, its around 1.7MB, but this diffstat below only
accounts for 584KB.  (its in http://www.arm.linux.org.uk/cvs/2.5.29-rmk1
if anyone wants to take a peek)  It's not all in a mergable state though
(eg, the cyberpro video grabber stuff was functional when i2c-old.h
was present.)

I'm going to be spending the next day or so trying to sort more of
this patch out, and then it'll be onto sorting out the first 2.4.19
-rmk patch, and maybe trying to do the same thing there (it's more
or less the same sort of story...)

 Documentation/l3/structure                      |   36 
 drivers/Makefile                                |   10 
 drivers/char/Config.help                        |   10 
 drivers/char/Config.in                          |   17 
 drivers/char/Makefile                           |   30 
 drivers/char/anakin_ts.c                        |  208 +++
 drivers/char/cerf_keyb.c                        |  380 ++++++
 drivers/char/clps711x_keyb.c                    |  547 ++++++++
 drivers/char/edb7211_keyb.c                     |  335 +++++
 drivers/char/gc_kbmap.h                         |  162 ++
 drivers/char/gc_keyb.c                          | 1145 ++++++++++++++++++
 drivers/char/gckeymap.c                         |  262 ++++
 drivers/char/gckeymap.map                       |  357 +++++
 drivers/char/generic_serial.c                   |   15 
 drivers/char/mem.c                              |    6 
 drivers/char/sa1100-rtc.c                       |  475 +++++++
 drivers/char/sa1100_wdt.c                       |  182 ++
 drivers/char/sysrq.c                            |    2 
 drivers/char/tty_io.c                           |   38 
 drivers/i2c/Config.in                           |    3 
 drivers/i2c/Makefile                            |    6 
 drivers/i2c/i2c-algo-bit.c                      |   19 
 drivers/i2c/i2c-algo-pcf.c                      |   18 
 drivers/i2c/i2c-core.c                          |  114 -
 drivers/i2c/i2c-dev.c                           |   42 
 drivers/i2c/i2c-elektor.c                       |   26 
 drivers/i2c/i2c-elv.c                           |   27 
 drivers/i2c/i2c-philips-par.c                   |   17 
 drivers/i2c/i2c-velleman.c                      |   27 
 drivers/l3/Config.in                            |   21 
 drivers/l3/Makefile                             |   17 
 drivers/l3/l3-algo-bit.c                        |  175 ++
 drivers/l3/l3-bit-sa1100.c                      |  277 ++++
 drivers/l3/l3-core.c                            |  376 ++++++
 drivers/l3/l3-sa1111.c                          |  119 +
 drivers/misc/Config.help                        |   21 
 drivers/misc/Config.in                          |   23 
 drivers/misc/Makefile                           |   17 
 drivers/misc/mcp-core.c                         |  155 ++
 drivers/misc/mcp-sa1100.c                       |  185 +++
 drivers/misc/mcp.h                              |   44 
 drivers/misc/switches-core.c                    |  199 +++
 drivers/misc/switches-sa1100.c                  |  315 +++++
 drivers/misc/switches-ucb1x00.c                 |  203 +++
 drivers/misc/switches.h                         |   28 
 drivers/misc/ucb1x00-assabet.c                  |  114 +
 drivers/misc/ucb1x00-audio.c                    |  368 +++++
 drivers/misc/ucb1x00-core.c                     |  519 ++++++++
 drivers/misc/ucb1x00-input.h                    |  233 +++
 drivers/misc/ucb1x00-ts.c                       |  450 +++++++
 drivers/misc/ucb1x00.h                          |  231 +++
 drivers/net/Config.help                         |   10 
 drivers/net/Config.in                           |    3 
 drivers/net/Makefile                            |    1 
 drivers/net/cs89x0.c                            |   11 
 drivers/net/ether00.c                           | 1025 ++++++++++++++++
 drivers/net/irda/w83977af_ir.c                  |    4 
 drivers/net/smc9194.c                           | 1475 +++++++++++++++---------
 drivers/net/smc9194.h                           |  101 -
 drivers/pcmcia/Config.in                        |    5 
 drivers/pcmcia/Makefile                         |    3 
 drivers/pcmcia/clps6700.c                       |  499 ++++++++
 drivers/pcmcia/clps6700.h                       |   85 +
 drivers/pcmcia/cs.c                             |   11 
 drivers/pcmcia/ds.c                             |   14 
 drivers/pcmcia/i82365.c                         |   32 
 drivers/pcmcia/rsrc_mgr.c                       |   20 
 drivers/pld/Makefile                            |   28 
 drivers/pld/pld_epxa.c                          |  375 ++++++
 drivers/pld/pld_hotswap.c                       |  154 ++
 drivers/usb/Makefile                            |    1 
 drivers/usb/host/ohci-sa1111.c                  |    4 
 drivers/video/Config.help                       |    6 
 drivers/video/Config.in                         |   25 
 drivers/video/clps711xfb.c                      |  177 ++
 drivers/video/fbmem.c                           |    2 
 drivers/video/sa1100fb.c                        |   37 
 fs/adfs/super.c                                 |    6 
 fs/binfmt_aout.c                                |   11 
 fs/exec.c                                       |    1 
 fs/partitions/Config.in                         |    2 
 fs/partitions/acorn.c                           |  234 ++-
 fs/partitions/acorn.h                           |   59 
 fs/partitions/check.c                           |   99 -
 fs/partitions/efi.h                             |    2 
 include/asm-alpha/ide.h                         |   46 
 include/asm-i386/ide.h                          |   49 
 include/asm-mips/ide.h                          |    2 
 include/asm-sparc64/ide.h                       |   23 
 include/linux/ide.h                             |   11 
 include/linux/l3/algo-bit.h                     |   39 
 include/linux/l3/l3.h                           |  208 +++
 include/linux/l3/uda1341.h                      |   50 
 include/linux/mm.h                              |    6 
 include/linux/netfilter_ipv4/ip_conntrack.h     |    3 
 include/linux/netfilter_ipv4/ip_conntrack_ftp.h |    2 
 include/linux/netfilter_ipv4/ip_nat_irc.h       |   34 
 include/linux/pld/pld_epxa.h                    |   35 
 include/linux/pld/pld_hotswap.h                 |   83 +
 include/linux/switches.h                        |   74 +
 mm/Makefile                                     |    1 
 mm/debug.c                                      |  160 ++
 net/irda/af_irda.c                              |    9 
 net/irda/iriap.c                                |   13 
 net/irda/irlan/irlan_common.c                   |    3 
 net/irda/irlap_frame.c                          |   36 
 sound/oss/Config.help                           |   24 
 sound/oss/Config.in                             |   24 
 sound/oss/Makefile                              |   11 
 sound/oss/assabet-uda1341.c                     |  409 ++++++
 sound/oss/h3600-uda1341.c                       |  357 +++++
 sound/oss/pangolin-uda1341.c                    |  327 +++++
 sound/oss/sa1100-audio.c                        | 1138 ++++++++++++++++++
 sound/oss/sa1100-audio.h                        |   68 +
 sound/oss/sa1100ssp.c                           |  184 ++
 sound/oss/sa1111-sac.h                          |   21 
 sound/oss/sa1111-uda1341.c                      |  466 +++++++
 sound/oss/stork-uda1341.c                       |  280 ++++
 sound/oss/uda1341.c                             |  511 ++++++++
 119 files changed, 16641 insertions, 1194 deletions

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

