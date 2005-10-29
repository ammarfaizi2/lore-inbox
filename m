Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVJ2UwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVJ2UwN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVJ2UwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:52:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27401 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932154AbVJ2UwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:52:13 -0400
Date: Sat, 29 Oct 2005 21:52:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CFT] Move platform device to separate header
Message-ID: <20051029205207.GG14039@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch which moves the platform device out of device.h and
into linux/platform_device.h.  This patch is far too large for lkml
so can be downloaded from:

  http://zeniv.linux.org.uk/pub/people/rmk/drvmodel.diff

This patch is (probably) against -git1.

Diffstat:

 arch/arm/common/locomo.c                 |    2 +-
 arch/arm/common/sa1111.c                 |    2 +-
 arch/arm/common/scoop.c                  |    2 +-
 arch/arm/mach-aaec2000/core.c            |    2 +-
 arch/arm/mach-h720x/h7202-eval.c         |    2 +-
 arch/arm/mach-imx/generic.c              |    2 +-
 arch/arm/mach-imx/mx1ads.c               |    1 +
 arch/arm/mach-integrator/integrator_ap.c |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 arch/arm/mach-iop3xx/iop321-setup.c      |    2 +-
 arch/arm/mach-iop3xx/iop331-setup.c      |    2 +-
 arch/arm/mach-ixp2000/enp2611.c          |    2 +-
 arch/arm/mach-ixp2000/ixdp2x00.c         |    2 +-
 arch/arm/mach-ixp2000/ixdp2x01.c         |    2 +-
 arch/arm/mach-ixp4xx/common.c            |    1 +
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c    |    2 +-
 arch/arm/mach-omap1/board-h2.c           |    2 +-
 arch/arm/mach-omap1/board-h3.c           |    2 +-
 arch/arm/mach-omap1/board-innovator.c    |    2 +-
 arch/arm/mach-omap1/board-netstar.c      |    2 +-
 arch/arm/mach-omap1/board-osk.c          |    2 +-
 arch/arm/mach-omap1/board-perseus2.c     |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c    |    2 +-
 arch/arm/mach-omap1/devices.c            |    2 +-
 arch/arm/mach-pxa/corgi.c                |    2 +-
 arch/arm/mach-pxa/corgi_lcd.c            |    2 +-
 arch/arm/mach-pxa/corgi_ssp.c            |    2 +-
 arch/arm/mach-pxa/generic.c              |    2 +-
 arch/arm/mach-pxa/idp.c                  |    2 +-
 arch/arm/mach-pxa/lubbock.c              |    2 +-
 arch/arm/mach-pxa/mainstone.c            |    2 +-
 arch/arm/mach-pxa/poodle.c               |    2 +-
 arch/arm/mach-pxa/pxa27x.c               |    2 +-
 arch/arm/mach-pxa/spitz.c                |    2 +-
 arch/arm/mach-s3c2410/clock.c            |    2 +-
 arch/arm/mach-s3c2410/cpu.c              |    2 +-
 arch/arm/mach-s3c2410/devs.c             |    2 +-
 arch/arm/mach-s3c2410/devs.h             |    1 +
 arch/arm/mach-s3c2410/mach-anubis.c      |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c        |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c       |    1 +
 arch/arm/mach-s3c2410/mach-n30.c         |    2 +-
 arch/arm/mach-s3c2410/mach-nexcoder.c    |    2 +-
 arch/arm/mach-s3c2410/mach-otom.c        |    2 +-
 arch/arm/mach-s3c2410/mach-rx3715.c      |    1 +
 arch/arm/mach-s3c2410/mach-smdk2410.c    |    1 +
 arch/arm/mach-s3c2410/mach-smdk2440.c    |    1 +
 arch/arm/mach-s3c2410/s3c2410.c          |    2 +-
 arch/arm/mach-s3c2410/s3c2440.c          |    2 +-
 arch/arm/mach-sa1100/badge4.c            |    2 +-
 arch/arm/mach-sa1100/cerf.c              |    2 +-
 arch/arm/mach-sa1100/collie.c            |    2 +-
 arch/arm/mach-sa1100/generic.c           |    1 +
 arch/arm/mach-sa1100/jornada720.c        |    2 +-
 arch/arm/mach-sa1100/neponset.c          |    2 +-
 arch/arm/mach-sa1100/pleb.c              |    2 +-
 arch/arm/mach-sa1100/simpad.c            |    2 +-
 arch/arm/mach-versatile/core.c           |    1 +
 arch/arm/plat-omap/usb.c                 |    2 +-
 arch/m32r/kernel/setup_m32700ut.c        |    2 +-
 arch/m32r/kernel/setup_mappi.c           |    2 +-
 arch/m32r/kernel/setup_mappi2.c          |    2 +-
 arch/m32r/kernel/setup_mappi3.c          |    2 +-
 arch/m32r/kernel/setup_opsput.c          |    2 +-
 arch/mips/au1000/common/platform.c       |    2 +-
 arch/ppc/platforms/4xx/ibm440ep.c        |    1 +
 arch/ppc/platforms/4xx/ibmstb4.c         |    1 +
 arch/ppc/platforms/4xx/redwood5.c        |    2 +-
 arch/ppc/platforms/4xx/redwood6.c        |    2 +-
 arch/ppc/platforms/chrp_pegasos_eth.c    |    2 +-
 arch/ppc/platforms/cpci690.c             |    1 +
 arch/ppc/platforms/ev64260.c             |    1 +
 arch/ppc/platforms/ev64360.c             |    1 +
 arch/ppc/platforms/hdpu.c                |    1 +
 arch/ppc/platforms/katana.c              |    1 +
 arch/ppc/platforms/radstone_ppc7d.c      |    1 +
 arch/ppc/syslib/mpc52xx_devices.c        |    1 +
 arch/ppc/syslib/mv64x60.c                |    1 +
 arch/ppc/syslib/pq2_devices.c            |    2 +-
 arch/sh/boards/superh/microdev/setup.c   |    2 +-
 arch/um/drivers/net_kern.c               |    1 +
 arch/um/drivers/ubd_kern.c               |    1 +
 arch/xtensa/platform-iss/network.c       |    1 +
 drivers/base/platform.c                  |    2 +-
 drivers/block/floppy.c                   |    2 +-
 drivers/char/s3c2410-rtc.c               |    2 +-
 drivers/char/sonypi.c                    |    1 +
 drivers/char/tb0219.c                    |    2 +-
 drivers/char/vr41xx_giu.c                |    2 +-
 drivers/char/vr41xx_rtc.c                |    2 +-
 drivers/char/watchdog/mpcore_wdt.c       |    2 +-
 drivers/char/watchdog/mv64x60_wdt.c      |    2 ++
 drivers/char/watchdog/s3c2410_wdt.c      |    2 +-
 drivers/eisa/virtual_root.c              |    2 +-
 drivers/firmware/dcdbas.c                |    2 +-
 drivers/firmware/dell_rbu.c              |    2 +-
 drivers/hwmon/hdaps.c                    |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c          |    2 +-
 drivers/i2c/busses/i2c-isa.c             |    1 +
 drivers/i2c/busses/i2c-ixp2000.c         |    2 +-
 drivers/i2c/busses/i2c-ixp4xx.c          |    2 +-
 drivers/i2c/busses/i2c-mpc.c             |    2 ++
 drivers/i2c/busses/i2c-mv64xxx.c         |    2 ++
 drivers/i2c/busses/i2c-pxa.c             |    1 +
 drivers/i2c/busses/i2c-s3c2410.c         |    2 +-
 drivers/i2c/chips/isp1301_omap.c         |    2 +-
 drivers/i2c/i2c-core.c                   |    1 +
 drivers/i2c/i2c-dev.c                    |    1 +
 drivers/input/keyboard/corgikbd.c        |    2 +-
 drivers/input/keyboard/spitzkbd.c        |    2 +-
 drivers/input/serio/ct82c710.c           |    1 +
 drivers/input/serio/i8042.c              |    1 +
 drivers/input/serio/maceps2.c            |    2 +-
 drivers/input/serio/q40kbd.c             |    1 +
 drivers/input/serio/rpckbd.c             |    1 +
 drivers/input/touchscreen/corgi_ts.c     |    2 +-
 drivers/mfd/mcp-sa11x0.c                 |    2 +-
 drivers/misc/hdpuftrs/hdpu_cpustate.c    |    2 +-
 drivers/misc/hdpuftrs/hdpu_nexus.c       |    2 +-
 drivers/mmc/pxamci.c                     |    2 +-
 drivers/mmc/wbsd.c                       |    2 +-
 drivers/mtd/maps/bast-flash.c            |    2 +-
 drivers/mtd/maps/integrator-flash.c      |    2 +-
 drivers/mtd/maps/ixp2000.c               |    2 +-
 drivers/mtd/maps/ixp4xx.c                |    2 +-
 drivers/mtd/maps/omap_nor.c              |    2 +-
 drivers/mtd/maps/plat-ram.c              |    2 +-
 drivers/mtd/maps/sa1100-flash.c          |    2 +-
 drivers/mtd/nand/s3c2410.c               |    2 +-
 drivers/net/depca.c                      |    2 +-
 drivers/net/dm9000.c                     |    1 +
 drivers/net/gianfar.c                    |    2 +-
 drivers/net/gianfar_mii.c                |    1 +
 drivers/net/irda/pxaficp_ir.c            |    1 +
 drivers/net/irda/sa1100_ir.c             |    2 +-
 drivers/net/irda/smsc-ircc2.c            |    1 +
 drivers/net/jazzsonic.c                  |    2 +-
 drivers/net/macsonic.c                   |    2 +-
 drivers/net/mipsnet.c                    |    1 +
 drivers/net/mv643xx_eth.c                |    2 ++
 drivers/net/smc91x.c                     |    2 +-
 drivers/net/tokenring/proteon.c          |    1 +
 drivers/net/tokenring/skisa.c            |    1 +
 drivers/pcmcia/au1000_generic.c          |    2 +-
 drivers/pcmcia/hd64465_ss.c              |    2 +-
 drivers/pcmcia/i82365.c                  |    2 +-
 drivers/pcmcia/m32r_cfc.c                |    2 +-
 drivers/pcmcia/m32r_pcc.c                |    2 +-
 drivers/pcmcia/omap_cf.c                 |    2 +-
 drivers/pcmcia/pxa2xx_base.c             |    1 +
 drivers/pcmcia/pxa2xx_mainstone.c        |    2 +-
 drivers/pcmcia/pxa2xx_sharpsl.c          |    2 +-
 drivers/pcmcia/sa1100_generic.c          |    1 +
 drivers/pcmcia/tcic.c                    |    2 +-
 drivers/pcmcia/vrc4171_card.c            |    1 +
 drivers/scsi/hosts.c                     |    1 +
 drivers/serial/8250.c                    |    2 +-
 drivers/serial/imx.c                     |    2 +-
 drivers/serial/mpc52xx_uart.c            |    2 +-
 drivers/serial/mpsc.c                    |    2 ++
 drivers/serial/pxa.c                     |    2 +-
 drivers/serial/s3c2410.c                 |    2 +-
 drivers/serial/sa1100.c                  |    2 +-
 drivers/serial/vr41xx_siu.c              |    2 +-
 drivers/usb/gadget/dummy_hcd.c           |    2 +-
 drivers/usb/gadget/lh7a40x_udc.c         |    2 ++
 drivers/usb/gadget/omap_udc.c            |    2 +-
 drivers/usb/gadget/pxa2xx_udc.c          |    2 +-
 drivers/usb/host/isp116x-hcd.c           |    1 +
 drivers/usb/host/ohci-au1xxx.c           |    2 ++
 drivers/usb/host/ohci-lh7a404.c          |    2 ++
 drivers/usb/host/ohci-omap.c             |    2 ++
 drivers/usb/host/ohci-ppc-soc.c          |    2 ++
 drivers/usb/host/ohci-pxa27x.c           |    2 +-
 drivers/usb/host/ohci-s3c2410.c          |    2 ++
 drivers/usb/host/sl811-hcd.c             |    1 +
 drivers/usb/host/sl811_cs.c              |    1 +
 drivers/video/acornfb.c                  |    2 +-
 drivers/video/arcfb.c                    |    1 +
 drivers/video/backlight/corgi_bl.c       |    2 +-
 drivers/video/dnfb.c                     |    2 ++
 drivers/video/epson1355fb.c              |    2 ++
 drivers/video/gbefb.c                    |    2 +-
 drivers/video/imxfb.c                    |    2 +-
 drivers/video/pxafb.c                    |    2 +-
 drivers/video/q40fb.c                    |    1 +
 drivers/video/s1d13xxxfb.c               |    2 +-
 drivers/video/s3c2410fb.c                |    1 +
 drivers/video/sa1100fb.c                 |    2 +-
 drivers/video/sgivwfb.c                  |    2 ++
 drivers/video/vesafb.c                   |    2 ++
 drivers/video/vfb.c                      |    2 ++
 drivers/video/w100fb.c                   |    2 +-
 include/asm-ppc/ppc_sys.h                |    2 +-
 include/linux/device.h                   |   26 --------------------------
 include/linux/serial_8250.h              |    2 +-
 sound/arm/pxa2xx-ac97.c                  |    2 +-
 sound/core/init.c                        |    2 ++
 198 files changed, 214 insertions(+), 158 deletions(-)

From: Russell King: Sat Oct 29 19:07:23 BST 2005
	
	Create platform_device.h to contain all the platform device details.
	Convert everyone who uses platform_bus_type to include
	linux/platform_device.h.
	
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
