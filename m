Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWFRWQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWFRWQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWFRWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:16:45 -0400
Received: from mx1.suse.de ([195.135.220.2]:2501 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750936AbWFRWQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:16:45 -0400
Date: Sun, 18 Jun 2006 15:13:43 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060618221343.GA20277@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They are the same "delete devfs" patches that I submitted for 2.6.12 and
2.6.13 and 2.6.14 and 2.6.15 and 2.6.16.  It rips out all of devfs from
the kernel and ends up saving a lot of space.  Since 2.6.13 came out, I
have seen no complaints about the fact that devfs was not able to be
enabled anymore, and in fact, a lot of different subsystems have already
been deleting devfs support for a while now, with apparently no
complaints (due to the lack of users.)

This patchset has also been in the -mm tree, with no complaints or
issues for the past few months.

It's also been almost a full year past the date when we said we would
delete devfs from the kernel tree in the file,
Documentation/feature-removal-schedule.txt, almost two years since we
publicly announced to the world that devfs would be removed from the
kernel tree.  So I think people have had plenty of advance notice that
this was going to happen by now :)

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/

I've posted all of these patches before, but if people really want to look at them, they can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/

Also, if people _really_ are in love with the idea of an in-kernel
devfs, I have posted a patch that does this in about 300 lines of code,
called ndevfs.  It is available in the archives if anyone wants to use
that instead (it is quite easy to maintain that patch outside of the
kernel tree, due to it only needing 3 hooks into the main kernel tree.)

thanks,

greg k-h


 Documentation/Changes                             |   15 
 Documentation/DocBook/kernel-api.tmpl             |    5 
 Documentation/README.DAC960                       |    6 
 Documentation/feature-removal-schedule.txt        |   11 
 Documentation/filesystems/devfs/ChangeLog         | 1977 ---------------
 Documentation/filesystems/devfs/README            | 1959 ---------------
 Documentation/filesystems/devfs/ToDo              |   40 
 Documentation/filesystems/devfs/boot-options      |   65 
 Documentation/initrd.txt                          |   24 
 Documentation/ioctl-number.txt                    |    1 
 Documentation/kernel-parameters.txt               |    4 
 arch/cris/arch-v10/kernel/debugport.c             |    2 
 arch/cris/arch-v32/kernel/debugport.c             |    2 
 arch/i386/kernel/microcode.c                      |    1 
 arch/ppc/4xx_io/serial_sicc.c                     |    2 
 arch/sh/kernel/cpu/sh4/sq.c                       |    1 
 arch/sparc64/solaris/socksys.c                    |    4 
 arch/um/drivers/line.c                            |    2 
 arch/um/drivers/ssl.c                             |    1 
 arch/um/drivers/stdio_console.c                   |    1 
 arch/um/drivers/ubd_kern.c                        |   18 
 arch/um/include/line.h                            |    1 
 drivers/block/DAC960.c                            |    1 
 drivers/block/acsi.c                              |    5 
 drivers/block/acsi_slm.c                          |   10 
 drivers/block/cciss.c                             |    1 
 drivers/block/cpqarray.c                          |    5 
 drivers/block/floppy.c                            |   55 
 drivers/block/loop.c                              |    6 
 drivers/block/nbd.c                               |    5 
 drivers/block/paride/pg.c                         |   18 
 drivers/block/paride/pt.c                         |   21 
 drivers/block/pktcdvd.c                           |    1 
 drivers/block/ps2esdi.c                           |    1 
 drivers/block/rd.c                                |    5 
 drivers/block/swim3.c                             |    4 
 drivers/block/sx8.c                               |    5 
 drivers/block/ub.c                                |    6 
 drivers/block/umem.c                              |    1 
 drivers/block/viodasd.c                           |    3 
 drivers/block/xd.c                                |    1 
 drivers/block/z2ram.c                             |    1 
 drivers/cdrom/aztcd.c                             |    1 
 drivers/cdrom/cdu31a.c                            |    1 
 drivers/cdrom/cm206.c                             |    1 
 drivers/cdrom/gscd.c                              |    1 
 drivers/cdrom/mcdx.c                              |    1 
 drivers/cdrom/optcd.c                             |    1 
 drivers/cdrom/sbpcd.c                             |    6 
 drivers/cdrom/sjcd.c                              |    1 
 drivers/cdrom/sonycd535.c                         |    1 
 drivers/cdrom/viocd.c                             |    3 
 drivers/char/cyclades.c                           |    1 
 drivers/char/dsp56k.c                             |   10 
 drivers/char/dtlk.c                               |    5 
 drivers/char/epca.c                               |    1 
 drivers/char/esp.c                                |    1 
 drivers/char/ftape/zftape/zftape-init.c           |   25 
 drivers/char/hvc_console.c                        |    1 
 drivers/char/hvcs.c                               |    1 
 drivers/char/hvsi.c                               |    1 
 drivers/char/ip2/ip2main.c                        |   24 
 drivers/char/ipmi/ipmi_devintf.c                  |    8 
 drivers/char/isicom.c                             |    1 
 drivers/char/istallion.c                          |   13 
 drivers/char/lp.c                                 |    7 
 drivers/char/mem.c                                |    6 
 drivers/char/misc.c                               |   15 
 drivers/char/mmtimer.c                            |    2 
 drivers/char/moxa.c                               |    1 
 drivers/char/ppdev.c                              |   15 
 drivers/char/pty.c                                |    8 
 drivers/char/raw.c                                |   15 
 drivers/char/riscom8.c                            |    1 
 drivers/char/rocket.c                             |    5 
 drivers/char/serial167.c                          |    1 
 drivers/char/stallion.c                           |   14 
 drivers/char/tipar.c                              |   17 
 drivers/char/tty_io.c                             |   17 
 drivers/char/vc_screen.c                          |   11 
 drivers/char/viocons.c                            |    1 
 drivers/char/viotape.c                            |   10 
 drivers/char/vme_scc.c                            |    1 
 drivers/char/vt.c                                 |    2 
 drivers/ide/ide-cd.c                              |    2 
 drivers/ide/ide-disk.c                            |    2 
 drivers/ide/ide-floppy.c                          |    1 
 drivers/ide/ide-probe.c                           |   11 
 drivers/ide/ide-tape.c                            |   12 
 drivers/ide/ide.c                                 |   10 
 drivers/input/serio/serio_raw.c                   |    1 
 drivers/isdn/capi/capi.c                          |    5 
 drivers/isdn/gigaset/bas-gigaset.c                |    4 
 drivers/isdn/gigaset/common.c                     |    4 
 drivers/isdn/gigaset/gigaset.h                    |    3 
 drivers/isdn/gigaset/interface.c                  |    6 
 drivers/isdn/gigaset/usb-gigaset.c                |    4 
 drivers/isdn/hardware/eicon/divamnt.c             |    3 
 drivers/isdn/hardware/eicon/divasi.c              |    3 
 drivers/isdn/hardware/eicon/divasmain.c           |    3 
 drivers/isdn/i4l/isdn_tty.c                       |    3 
 drivers/macintosh/adb.c                           |    3 
 drivers/md/dm-ioctl.c                             |   30 
 drivers/md/dm.c                                   |    2 
 drivers/md/md.c                                   |   30 
 drivers/media/dvb/dvb-core/dvbdev.c               |   13 
 drivers/media/dvb/dvb-core/dvbdev.h               |    1 
 drivers/media/dvb/ttpci/av7110.h                  |    4 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   11 
 drivers/media/radio/miropcm20-rds.c               |    1 
 drivers/media/video/arv.c                         |    1 
 drivers/media/video/videodev.c                    |    8 
 drivers/message/i2o/i2o_block.c                   |    1 
 drivers/mmc/mmc_block.c                           |    4 
 drivers/net/ppp_generic.c                         |    9 
 drivers/net/tun.c                                 |    1 
 drivers/net/wan/cosa.c                            |   14 
 drivers/s390/block/dasd.c                         |    4 
 drivers/s390/block/dasd_genhd.c                   |    2 
 drivers/s390/block/dasd_int.h                     |    1 
 drivers/s390/block/xpram.c                        |    6 
 drivers/s390/char/monreader.c                     |    1 
 drivers/s390/char/tty3270.c                       |    3 
 drivers/s390/crypto/z90main.c                     |    1 
 drivers/s390/net/ctctty.c                         |    2 
 drivers/sbus/char/bpp.c                           |    9 
 drivers/sbus/char/vfc.h                           |    2 
 drivers/sbus/char/vfc_dev.c                       |    7 
 drivers/serial/21285.c                            |    1 
 drivers/serial/8250.c                             |    1 
 drivers/serial/at91_serial.c                      |    1 
 drivers/serial/crisv10.c                          |    2 
 drivers/serial/dz.c                               |    4 
 drivers/serial/imx.c                              |    1 
 drivers/serial/ip22zilog.c                        |    1 
 drivers/serial/m32r_sio.c                         |    1 
 drivers/serial/mcfserial.c                        |    1 
 drivers/serial/mpc52xx_uart.c                     |    1 
 drivers/serial/mpsc.c                             |    2 
 drivers/serial/pmac_zilog.c                       |    1 
 drivers/serial/pxa.c                              |    1 
 drivers/serial/s3c2410.c                          |    2 
 drivers/serial/sa1100.c                           |    1 
 drivers/serial/serial_core.c                      |    5 
 drivers/serial/serial_txx9.c                      |    3 
 drivers/serial/sh-sci.c                           |    3 
 drivers/serial/sunhv.c                            |    1 
 drivers/serial/sunsab.c                           |    1 
 drivers/serial/sunsu.c                            |    1 
 drivers/serial/sunzilog.c                         |    1 
 drivers/serial/v850e_uart.c                       |    1 
 drivers/serial/vr41xx_siu.c                       |    1 
 drivers/tc/zs.c                                   |    3 
 drivers/telephony/phonedev.c                      |    4 
 drivers/usb/class/cdc-acm.c                       |    3 
 drivers/usb/gadget/serial.c                       |    3 
 drivers/usb/serial/usb-serial.c                   |    3 
 drivers/video/fbmem.c                             |    5 
 fs/Makefile                                       |    1 
 fs/block_dev.c                                    |    1 
 fs/char_dev.c                                     |    1 
 fs/coda/psdev.c                                   |   23 
 fs/compat_ioctl.c                                 |    1 
 fs/devfs/Makefile                                 |    8 
 fs/devfs/base.c                                   | 2836 ----------------------
 fs/devfs/util.c                                   |   97 
 fs/partitions/Makefile                            |    1 
 fs/partitions/check.c                             |   32 
 fs/partitions/devfs.c                             |  130 -
 fs/partitions/devfs.h                             |   10 
 include/asm-ppc/ocp.h                             |    1 
 include/linux/compat_ioctl.h                      |    5 
 include/linux/devfs_fs.h                          |   41 
 include/linux/devfs_fs_kernel.h                   |   58 
 include/linux/fb.h                                |    1 
 include/linux/genhd.h                             |    2 
 include/linux/ide.h                               |    1 
 include/linux/miscdevice.h                        |    1 
 include/linux/serial_core.h                       |    1 
 include/linux/tty_driver.h                        |   14 
 include/linux/videodev2.h                         |    1 
 init/Makefile                                     |    1 
 init/do_mounts.c                                  |    8 
 init/do_mounts.h                                  |   16 
 init/do_mounts_devfs.c                            |  137 -
 init/do_mounts_initrd.c                           |    6 
 init/do_mounts_md.c                               |    7 
 init/do_mounts_rd.c                               |    4 
 init/main.c                                       |    1 
 mm/shmem.c                                        |    5 
 mm/tiny-shmem.c                                   |    4 
 net/bluetooth/rfcomm/tty.c                        |    3 
 net/irda/ircomm/ircomm_tty.c                      |    1 
 net/irda/irnet/irnet.h                            |    1 
 sound/core/info.c                                 |    1 
 sound/core/sound.c                                |   24 
 sound/oss/soundcard.c                             |   16 
 sound/sound_core.c                                |    6 
 198 files changed, 96 insertions(+), 8274 deletions(-)

---------------

Greg Kroah-Hartman:
      devfs: Remove devfs from the kernel tree
      devfs: Remove devfs documentation from the kernel tree
      devfs: Remove devfs from the partition code
      devfs: Remove devfs from the init code
      devfs: Remove devfs support from the serial subsystem
      devfs: Remove devfs support from the ide subsystem.
      devfs: Remove devfs support from the sound subsystem
      devfs: Remove devfs_*_tape() functions from the kernel tree
      devfs: Remove devfs_mk_dir() function from the kernel tree
      devfs: Remove devfs_mk_symlink() function from the kernel tree
      devfs: Remove devfs_mk_bdev() function from the kernel tree
      devfs: Remove devfs_mk_cdev() function from the kernel tree
      devfs: Remove devfs_remove() function from the kernel tree
      devfs: Remove the devfs_fs_kernel.h file from the tree
      devfs: Remove the miscdevice devfs_name field as it's no longer needed
      devfs: Remove the gendisk devfs_name field as it's no longer needed
      devfs: Remove the videodevice devfs_name field as it's no longer needed
      devfs: Remove the line_driver devfs_name field as it's no longer needed
      devfs: Remove the tty_driver devfs_name field as it's no longer needed
      devfs: Rename TTY_DRIVER_NO_DEVFS to TTY_DRIVER_DYNAMIC_DEV
      devfs: Last little devfs cleanups throughout the kernel tree.
      devfs: Remove it from the feature_removal.txt file

