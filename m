Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWALOTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWALOTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWALOTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:19:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52658 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030409AbWALOTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:19:12 -0500
Date: Thu, 12 Jan 2006 15:19:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Kedar Sovani <kedars@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] sem2mutex bdev->bd_sem
Message-ID: <20060112141919.GA8547@elte.hu>
References: <5edf7fc90601120610h70b824ccs9b1ac0fe955dd1b3@mail.gmail.com> <20060112141606.GO3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112141606.GO3945@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> On Thu, Jan 12 2006, Kedar Sovani wrote:
> > Here is an obvious sem2mutex patch for the bd_sem relative to 2.6.15.
> > 
> > 
> > Kedar.
> > 
> > 
> > Use mutex instead of semaphore.
> > 
> > Signed-Off-by: Kedar Sovani <ksovani@kernelcorp.com>
> 
> Please compile the patches you submit, there are far too many "sem to 
> mutex" conversion patches being sent that aren't properly tested. And 
> my eye spots that this is one of them.

FYI, Arjan, Jes and me are doing automated conversions to mutexes, with 
build testing and automatic validation of the result as well. Arjan has 
done the bd_sem one today, and sent it to aviro. Below is a (fast 
growing) list of code we've already converted and validated.

	Ingo

 Documentation/synchro-test.txt                 |   59 ++
 Makefile                                       |    2 
 arch/arm/common/rtctime.c                      |   15 
 arch/arm/kernel/ecard.c                        |    7 
 arch/arm/mach-aaec2000/clock.c                 |   15 
 arch/arm/mach-integrator/clock.c               |   15 
 arch/arm/mach-pxa/ssp.c                        |   17 
 arch/arm/mach-realview/clock.c                 |   15 
 arch/arm/mach-s3c2410/clock.c                  |   11 
 arch/arm/mach-versatile/clock.c                |   15 
 arch/arm/plat-omap/clock.c                     |   15 
 arch/arm26/kernel/traps.c                      |   13 
 arch/i386/Kconfig                              |    4 
 arch/i386/kernel/apic.c                        |    2 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c     |    9 
 arch/i386/kernel/cpu/mtrr/main.c               |   11 
 arch/i386/kernel/microcode.c                   |    7 
 arch/i386/kernel/nmi.c                         |   69 ++-
 arch/ia64/Kconfig                              |    4 
 arch/ia64/hp/sim/simserial.c                   |    1 
 arch/ia64/ia32/sys_ia32.c                      |   28 -
 arch/ia64/kernel/perfmon.c                     |   11 
 arch/ia64/kernel/salinfo.c                     |    2 
 arch/ia64/kernel/semaphore.c                   |    8 
 arch/mips/lasat/sysctl.c                       |   63 +-
 arch/powerpc/mm/imalloc.c                      |   19 
 arch/powerpc/platforms/cell/spu_base.c         |   23 -
 arch/powerpc/platforms/powermac/cpufreq_64.c   |    7 
 arch/ppc/4xx_io/serial_sicc.c                  |    3 
 arch/x86_64/Kconfig                            |    4 
 block/genhd.c                                  |   25 -
 drivers/acpi/osl.c                             |   12 
 drivers/acpi/processor_perflib.c               |   23 -
 drivers/acpi/scan.c                            |    3 
 drivers/base/attribute_container.c             |   27 -
 drivers/base/bus.c                             |   16 
 drivers/base/class.c                           |   22 -
 drivers/base/core.c                            |    2 
 drivers/base/dd.c                              |   36 -
 drivers/base/dmapool.c                         |   15 
 drivers/base/firmware_class.c                  |   21 
 drivers/base/map.c                             |   20 
 drivers/base/memory.c                          |    6 
 drivers/base/power/resume.c                    |    4 
 drivers/base/power/suspend.c                   |    4 
 drivers/base/sys.c                             |   23 -
 drivers/block/floppy.c                         |   17 
 drivers/block/pktcdvd.c                        |   27 -
 drivers/cdrom/cdu31a.c                         |   51 +-
 drivers/char/agp/frontend.c                    |   28 -
 drivers/char/amiserial.c                       |    3 
 drivers/char/esp.c                             |    3 
 drivers/char/generic_serial.c                  |    5 
 drivers/char/istallion.c                       |    3 
 drivers/char/nwflash.c                         |   11 
 drivers/char/raw.c                             |   23 -
 drivers/char/riscom8.c                         |    3 
 drivers/char/specialix.c                       |    5 
 drivers/char/stallion.c                        |    3 
 drivers/char/synclink.c                        |    3 
 drivers/char/sysrq.c                           |   17 
 drivers/char/watchdog/pcwd_usb.c               |    7 
 drivers/connector/connector.c                  |   15 
 drivers/cpufreq/cpufreq.c                      |   19 
 drivers/cpufreq/cpufreq_conservative.c         |   52 +-
 drivers/cpufreq/cpufreq_ondemand.c             |   41 -
 drivers/cpufreq/cpufreq_userspace.c            |   25 -
 drivers/firmware/dcdbas.c                      |   23 -
 drivers/hwmon/adm1021.c                        |   13 
 drivers/hwmon/adm1025.c                        |   25 -
 drivers/hwmon/adm1026.c                        |   87 ++--
 drivers/hwmon/adm1031.c                        |   49 +-
 drivers/hwmon/adm9240.c                        |   29 -
 drivers/hwmon/asb100.c                         |   45 +-
 drivers/hwmon/atxp1.c                          |    9 
 drivers/hwmon/ds1621.c                         |   13 
 drivers/hwmon/fscher.c                         |   41 -
 drivers/hwmon/fscpos.c                         |   29 -
 drivers/hwmon/gl518sm.c                        |   25 -
 drivers/hwmon/gl520sm.c                        |   45 +-
 drivers/hwmon/hdaps.c                          |   37 -
 drivers/hwmon/it87.c                           |   61 +-
 drivers/hwmon/lm63.c                           |   29 -
 drivers/hwmon/lm75.c                           |   13 
 drivers/hwmon/lm77.c                           |   21 
 drivers/hwmon/lm78.c                           |   47 +-
 drivers/hwmon/lm80.c                           |   27 -
 drivers/hwmon/lm83.c                           |   13 
 drivers/hwmon/lm85.c                           |   67 +--
 drivers/hwmon/lm87.c                           |   39 -
 drivers/hwmon/lm90.c                           |   21 
 drivers/hwmon/lm92.c                           |   17 
 drivers/hwmon/max1619.c                        |   13 
 drivers/hwmon/pc87360.c                        |   61 +-
 drivers/hwmon/sis5595.c                        |   47 +-
 drivers/hwmon/smsc47b397.c                     |   17 
 drivers/hwmon/smsc47m1.c                       |   41 -
 drivers/hwmon/via686a.c                        |   33 -
 drivers/hwmon/vt8231.c                         |   51 +-
 drivers/hwmon/w83627ehf.c                      |   33 -
 drivers/hwmon/w83627hf.c                       |   57 +-
 drivers/hwmon/w83781d.c                        |   55 +-
 drivers/hwmon/w83792d.c                        |    9 
 drivers/hwmon/w83l785ts.c                      |    9 
 drivers/i2c/busses/i2c-ali1535.c               |    7 
 drivers/i2c/chips/ds1374.c                     |   11 
 drivers/i2c/chips/m41t00.c                     |   11 
 drivers/i2c/i2c-core.c                         |   23 -
 drivers/ide/ide-cd.c                           |   11 
 drivers/ide/ide-disk.c                         |   11 
 drivers/ide/ide-floppy.c                       |   11 
 drivers/ide/ide-tape.c                         |   19 
 drivers/ieee1394/hosts.c                       |    7 
 drivers/ieee1394/ieee1394_types.h              |    2 
 drivers/ieee1394/nodemgr.c                     |    2 
 drivers/ieee1394/raw1394-private.h             |    2 
 drivers/infiniband/core/device.c               |   22 -
 drivers/infiniband/core/ucm.c                  |   23 -
 drivers/infiniband/ulp/ipoib/ipoib.h           |    7 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   19 
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   12 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   27 -
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    8 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |   10 
 drivers/input/gameport/gameport.c              |   21 
 drivers/input/input.c                          |   15 
 drivers/input/joystick/amijoy.c                |   11 
 drivers/input/serio/serio.c                    |   31 -
 drivers/input/serio/serio_raw.c                |   23 -
 drivers/isdn/capi/kcapi.c                      |   17 
 drivers/macintosh/smu.c                        |    9 
 drivers/md/dm-table.c                          |   11 
 drivers/md/dm.c                                |   19 
 drivers/md/kcopyd.c                            |   28 -
 drivers/md/md.c                                |   11 
 drivers/media/dvb/dvb-core/dvb_frontend.c      |    2 
 drivers/media/dvb/dvb-core/dvb_frontend.h      |    2 
 drivers/media/dvb/dvb-core/dvbdev.c            |   21 
 drivers/media/video/bttv-driver.c              |   60 +-
 drivers/media/video/bttvp.h                    |    5 
 drivers/media/video/cx88/cx88-core.c           |   15 
 drivers/media/video/em28xx/em28xx-video.c      |    7 
 drivers/media/video/saa7134/saa7134-core.c     |   19 
 drivers/media/video/videodev.c                 |   27 -
 drivers/media/video/zoran.h                    |    2 
 drivers/media/video/zoran_card.c               |   11 
 drivers/media/video/zoran_driver.c             |  227 +++++-----
 drivers/mfd/ucb1x00-core.c                     |   27 -
 drivers/mmc/mmc_block.c                        |   11 
 drivers/mtd/devices/doc2000.c                  |    7 
 drivers/net/3c527.c                            |    2 
 drivers/net/8139too.c                          |    2 
 drivers/net/cassini.c                          |   40 -
 drivers/net/cassini.h                          |    2 
 drivers/net/hamradio/6pack.c                   |    2 
 drivers/net/hamradio/mkiss.c                   |    2 
 drivers/net/irda/irtty-sir.c                   |   19 
 drivers/net/irda/sir_dongle.c                  |   19 
 drivers/net/plip.c                             |    5 
 drivers/net/ppp_async.c                        |    2 
 drivers/net/ppp_generic.c                      |   25 -
 drivers/net/ppp_synctty.c                      |    2 
 drivers/net/sungem.c                           |   37 -
 drivers/net/sungem.h                           |    6 
 drivers/net/wan/dscc4.c                        |    7 
 drivers/net/wireless/ipw2100.c                 |  119 ++---
 drivers/net/wireless/ipw2100.h                 |    4 
 drivers/net/wireless/ipw2200.c                 |  294 ++++++-------
 drivers/net/wireless/ipw2200.h                 |    3 
 drivers/parport/share.c                        |   19 
 drivers/pci/hotplug/cpci_hotplug_core.c        |    4 
 drivers/pci/hotplug/cpqphp_ctrl.c              |    4 
 drivers/pci/hotplug/ibmphp_hpc.c               |    2 
 drivers/pci/hotplug/pciehp_ctrl.c              |    4 
 drivers/pci/hotplug/rpadlpar_core.c            |   13 
 drivers/pci/hotplug/sgi_hotplug.c              |   19 
 drivers/pci/hotplug/shpchp_ctrl.c              |    4 
 drivers/pcmcia/cs.c                            |   40 -
 drivers/pcmcia/ds.c                            |   15 
 drivers/pcmcia/pcmcia_ioctl.c                  |   12 
 drivers/pcmcia/rsrc_nonstatic.c                |   41 -
 drivers/pcmcia/socket_sysfs.c                  |    8 
 drivers/pnp/isapnp/core.c                      |    7 
 drivers/s390/char/raw3270.c                    |   39 -
 drivers/sbus/char/aurora.c                     |    3 
 drivers/scsi/3w-9xxx.c                         |    7 
 drivers/scsi/3w-9xxx.h                         |    2 
 drivers/scsi/3w-xxxx.c                         |    7 
 drivers/scsi/3w-xxxx.h                         |    2 
 drivers/scsi/aacraid/aacraid.h                 |    4 
 drivers/scsi/aic7xxx/aic79xx_osm.h             |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.h             |    2 
 drivers/scsi/ch.c                              |   33 -
 drivers/scsi/dpt_i2o.c                         |   35 -
 drivers/scsi/hosts.c                           |    8 
 drivers/scsi/ide-scsi.c                        |   11 
 drivers/scsi/iscsi_tcp.c                       |   37 -
 drivers/scsi/iscsi_tcp.h                       |    2 
 drivers/scsi/megaraid.c                        |    6 
 drivers/scsi/megaraid.h                        |    4 
 drivers/scsi/megaraid/megaraid_sas.c           |    7 
 drivers/scsi/qla2xxx/qla_def.h                 |    2 
 drivers/scsi/scsi.c                            |   13 
 drivers/scsi/scsi_proc.c                       |   11 
 drivers/scsi/scsi_scan.c                       |   16 
 drivers/scsi/scsi_sysfs.c                      |    4 
 drivers/scsi/scsi_transport_iscsi.c            |   17 
 drivers/scsi/scsi_transport_spi.c              |   10 
 drivers/scsi/sd.c                              |   21 
 drivers/scsi/sr.c                              |   17 
 drivers/scsi/st.c                              |   17 
 drivers/serial/8250.c                          |   11 
 drivers/serial/crisv10.c                       |   11 
 drivers/serial/pmac_zilog.c                    |   23 -
 drivers/serial/serial_core.c                   |   15 
 drivers/serial/serial_txx9.c                   |   11 
 drivers/telephony/phonedev.c                   |   21 
 drivers/usb/atm/cxacru.c                       |    4 
 drivers/usb/atm/ueagle-atm.c                   |   27 -
 drivers/usb/atm/usbatm.c                       |   24 -
 drivers/usb/atm/usbatm.h                       |    3 
 drivers/usb/class/cdc-acm.c                    |   19 
 drivers/usb/class/usblp.c                      |   15 
 drivers/usb/core/devices.c                     |    7 
 drivers/usb/core/devio.c                       |    4 
 drivers/usb/core/hcd.c                         |   25 -
 drivers/usb/core/hcd.h                         |    2 
 drivers/usb/core/hub.c                         |   11 
 drivers/usb/core/notify.c                      |   15 
 drivers/usb/core/usb.c                         |    5 
 drivers/usb/image/mdc800.c                     |   63 +-
 drivers/usb/input/ati_remote.c                 |    2 
 drivers/usb/media/dabusb.c                     |   31 -
 drivers/usb/media/dabusb.h                     |    2 
 drivers/usb/media/ov511.c                      |   91 ++--
 drivers/usb/media/ov511.h                      |   11 
 drivers/usb/media/se401.c                      |   12 
 drivers/usb/media/se401.h                      |    3 
 drivers/usb/media/sn9c102.h                    |    5 
 drivers/usb/media/sn9c102_core.c               |  158 +++----
 drivers/usb/media/stv680.c                     |   13 
 drivers/usb/media/stv680.h                     |    2 
 drivers/usb/media/usbvideo.c                   |   28 -
 drivers/usb/media/usbvideo.h                   |    5 
 drivers/usb/media/vicam.c                      |   21 
 drivers/usb/media/w9968cf.c                    |   94 ++--
 drivers/usb/media/w9968cf.h                    |   10 
 drivers/usb/misc/idmouse.c                     |   25 -
 drivers/usb/misc/ldusb.c                       |   11 
 drivers/usb/misc/legousbtower.c                |   11 
 drivers/usb/mon/mon_main.c                     |   19 
 drivers/usb/mon/mon_text.c                     |   21 
 drivers/usb/mon/usb_mon.h                      |    2 
 drivers/usb/serial/pl2303.c                    |    2 
 drivers/usb/storage/scsiglue.c                 |    9 
 drivers/usb/storage/usb.c                      |   25 -
 drivers/usb/storage/usb.h                      |    7 
 fs/9p/mux.c                                    |   11 
 fs/char_dev.c                                  |   17 
 fs/cramfs/inode.c                              |   31 -
 fs/dcookies.c                                  |   19 
 fs/dquot.c                                     |  120 ++---
 fs/ext3/super.c                                |    4 
 fs/inode.c                                     |    2 
 fs/inotify.c                                   |  110 ++---
 fs/jffs2/compr_zlib.c                          |   19 
 fs/jfs/jfs_logmgr.c                            |   27 -
 fs/lockd/host.c                                |   19 
 fs/lockd/svc.c                                 |   17 
 fs/lockd/svcsubs.c                             |   17 
 fs/nfs/callback.c                              |   11 
 fs/nfsd/nfs4state.c                            |    9 
 fs/partitions/devfs.c                          |   13 
 fs/quota.c                                     |    6 
 fs/quota_v2.c                                  |    2 
 fs/super.c                                     |   11 
 fs/xfs/linux-2.6/sema.h                        |    2 
 fs/xfs/linux-2.6/xfs_buf.h                     |    4 
 include/asm-i386/semaphore.h                   |   52 +-
 include/asm-ia64/semaphore.h                   |   58 +-
 include/asm-x86_64/semaphore.h                 |   61 +-
 include/linux/agpgart.h                        |    3 
 include/linux/cpufreq.h                        |    2 
 include/linux/device.h                         |    5 
 include/linux/fs.h                             |    2 
 include/linux/input.h                          |    2 
 include/linux/jffs2_fs_i.h                     |   10 
 include/linux/jffs2_fs_sb.h                    |    6 
 include/linux/kobj_map.h                       |    4 
 include/linux/memory.h                         |    5 
 include/linux/mutex.h                          |  147 ++++++
 include/linux/parport.h                        |    2 
 include/linux/quota.h                          |    7 
 include/linux/rtnetlink.h                      |   13 
 include/linux/semaphore.h                      |   30 +
 include/linux/usb.h                            |    6 
 include/net/xfrm.h                             |    3 
 include/pcmcia/ss.h                            |    3 
 include/scsi/scsi_host.h                       |    3 
 include/scsi/scsi_transport_spi.h              |    2 
 kernel/Makefile                                |    4 
 kernel/cpu.c                                   |   10 
 kernel/cpuset.c                                |  192 ++++-----
 kernel/kthread.c                               |    7 
 kernel/module.c                                |   56 +-
 kernel/mutex.c                                 |   68 +++
 kernel/posix-timers.c                          |    1 
 kernel/power/pm.c                              |   21 
 kernel/printk.c                                |    7 
 kernel/profile.c                               |   11 
 kernel/rcupdate.c                              |   10 
 kernel/synchro-test.c                          |  527 +++++++++++++++++++++++++
 kernel/sysctl.c                                |    2 
 kernel/time.c                                  |   79 +++
 lib/Kconfig.debug                              |   60 ++
 lib/kernel_lock.c                              |    2 
 lib/reed_solomon/reed_solomon.c                |   11 
 lib/semaphore-sleepers.c                       |   16 
 mm/slab.c                                      |   46 +-
 mm/swapfile.c                                  |   17 
 net/atm/ioctl.c                                |   15 
 net/bluetooth/rfcomm/core.c                    |    8 
 net/core/dev.c                                 |    7 
 net/core/flow.c                                |    7 
 net/core/pktgen.c                              |    7 
 net/core/rtnetlink.c                           |    8 
 net/ipv4/ipcomp.c                              |   17 
 net/ipv4/ipvs/ip_vs_ctl.c                      |   11 
 net/ipv4/netfilter/ip_queue.c                  |   11 
 net/ipv4/netfilter/ipt_hashlimit.c             |    9 
 net/ipv4/xfrm4_tunnel.c                        |   11 
 net/ipv6/ipcomp6.c                             |   15 
 net/ipv6/netfilter/ip6_queue.c                 |   11 
 net/ipv6/xfrm6_tunnel.c                        |   11 
 net/key/af_key.c                               |    4 
 net/netfilter/nf_sockopt.c                     |   25 -
 net/netlink/genetlink.c                        |    9 
 net/socket.c                                   |   32 -
 net/sunrpc/cache.c                             |   17 
 net/sunrpc/sched.c                             |   11 
 net/unix/garbage.c                             |    7 
 net/xfrm/xfrm_policy.c                         |    4 
 net/xfrm/xfrm_user.c                           |    4 
 security/keys/process_keys.c                   |    7 
 security/selinux/selinuxfs.c                   |   19 
 security/selinux/ss/services.c                 |    7 
 sound/arm/pxa2xx-ac97.c                        |   13 
 sound/core/hwdep.c                             |   29 -
 sound/core/info.c                              |   21 
 sound/core/info_oss.c                          |   13 
 sound/core/memalloc.c                          |   23 -
 sound/core/pcm.c                               |   35 -
 sound/core/rawmidi.c                           |   34 -
 sound/core/seq/oss/seq_oss.c                   |   27 -
 sound/core/seq/seq_device.c                    |   33 -
 sound/core/seq/seq_midi.c                      |   21 
 sound/core/sound.c                             |   23 -
 sound/core/sound_oss.c                         |   23 -
 sound/core/timer.c                             |   61 +-
 sound/oss/ac97_codec.c                         |   25 -
 sound/oss/dmasound/dmasound_awacs.c            |   11 
 sound/usb/usbaudio.c                           |   15 
 362 files changed, 4691 insertions(+), 3342 deletions(-)
