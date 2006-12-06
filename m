Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933283AbWLFPHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbWLFPHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933336AbWLFPHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:07:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52373 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933283AbWLFPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:07:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <24327.1165348363@redhat.com> 
References: <24327.1165348363@redhat.com>  <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Subject: GIT pull on work_struct reduction tree 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 15:06:59 +0000
Message-ID: <28046.1165417619@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I've brought the work_struct reduction patches up to date once again.

David
---
The following changes since commit ec0bf39a471bf6fcd01def2bd677128cea940b73:
  Linus Torvalds:
        Merge master.kernel.org:/.../jejb/scsi-misc-2.6

are found in the git repository at:

  git://git.infradead.org/users/dhowells/workq-2.6.git

David Howells:
      WorkStruct: Separate delayable and non-delayable events.
      WorkStruct: Typedef the work function prototype
      WorkStruct: Merge the pending bit into the wq_data pointer
      WorkStruct: Pass the work_struct pointer instead of context data
      WorkStruct: make allyesconfig
      Merge branch 'master' of git://git.kernel.org/.../torvalds/linux-2.6
      Merge branch 'master' of git://git.kernel.org/.../torvalds/linux-2.6
      WorkQueue: Fix up arch-specific work items where possible
      Merge branch 'master' of git://git.kernel.org/.../torvalds/linux-2.6
      Actually update the fixed up compile failures.

 arch/arm/common/sharpsl_pm.c                    |   22 +-
 arch/arm/mach-omap1/board-h3.c                  |    3 
 arch/arm/mach-omap1/board-nokia770.c            |    6 -
 arch/arm/mach-omap1/leds-osk.c                  |    4 
 arch/arm/mach-omap2/board-h4.c                  |    3 
 arch/arm/mach-pxa/akita-ioexp.c                 |    6 -
 arch/i386/kernel/cpu/mcheck/non-fatal.c         |    6 -
 arch/i386/kernel/smpboot.c                      |   11 +
 arch/i386/kernel/tsc.c                          |    4 
 arch/ia64/hp/sim/simserial.c                    |    4 
 arch/ia64/kernel/mca.c                          |    8 -
 arch/ia64/kernel/smpboot.c                      |   12 +
 arch/mips/kernel/kspd.c                         |    4 
 arch/powerpc/platforms/embedded6xx/ls_uart.c    |    4 
 arch/powerpc/platforms/powermac/backlight.c     |   12 +
 arch/powerpc/platforms/pseries/eeh_event.c      |    6 -
 arch/ppc/8260_io/fcc_enet.c                     |   21 +-
 arch/ppc/8xx_io/fec.c                           |   21 +-
 arch/s390/appldata/appldata_base.c              |    6 -
 arch/um/drivers/chan_kern.c                     |    2 
 arch/um/drivers/mconsole_kern.c                 |    4 
 arch/um/drivers/net_kern.c                      |    1 
 arch/um/drivers/port_kern.c                     |    4 
 arch/x86_64/kernel/mce.c                        |    6 -
 arch/x86_64/kernel/smpboot.c                    |   12 +
 arch/x86_64/kernel/time.c                       |    4 
 block/as-iosched.c                              |    7 -
 block/cfq-iosched.c                             |    8 +
 block/ll_rw_blk.c                               |    8 -
 crypto/cryptomgr.c                              |    7 -
 drivers/acpi/osl.c                              |   25 +--
 drivers/ata/libata-core.c                       |   25 +--
 drivers/ata/libata-eh.c                         |    2 
 drivers/ata/libata-scsi.c                       |   14 +
 drivers/ata/libata.h                            |    4 
 drivers/atm/idt77252.c                          |    9 +
 drivers/block/aoe/aoe.h                         |    2 
 drivers/block/aoe/aoecmd.c                      |    4 
 drivers/block/aoe/aoedev.c                      |    2 
 drivers/block/floppy.c                          |   10 +
 drivers/block/paride/pd.c                       |    8 -
 drivers/block/paride/pseudo.h                   |   10 +
 drivers/block/sx8.c                             |    7 -
 drivers/block/ub.c                              |    8 -
 drivers/bluetooth/bcm203x.c                     |    7 -
 drivers/char/cyclades.c                         |    9 +
 drivers/char/drm/via_dmablit.c                  |    6 -
 drivers/char/epca.c                             |    8 -
 drivers/char/esp.c                              |   14 +
 drivers/char/genrtc.c                           |    4 
 drivers/char/hvsi.c                             |   16 +-
 drivers/char/ip2/i2lib.c                        |   12 +
 drivers/char/ip2/ip2main.c                      |   23 +-
 drivers/char/isicom.c                           |   12 +
 drivers/char/moxa.c                             |    8 -
 drivers/char/mxser.c                            |    9 +
 drivers/char/pcmcia/synclink_cs.c               |    8 -
 drivers/char/random.c                           |    6 -
 drivers/char/sonypi.c                           |    4 
 drivers/char/specialix.c                        |   14 +
 drivers/char/synclink.c                         |    9 +
 drivers/char/synclink_gt.c                      |   10 +
 drivers/char/synclinkmp.c                       |    8 -
 drivers/char/sysrq.c                            |    4 
 drivers/char/tpm/tpm.c                          |    6 -
 drivers/char/tty_io.c                           |   31 ++-
 drivers/char/vt.c                               |    6 -
 drivers/connector/cn_queue.c                    |    8 +
 drivers/connector/connector.c                   |   31 ++-
 drivers/cpufreq/cpufreq.c                       |   10 +
 drivers/cpufreq/cpufreq_conservative.c          |    7 -
 drivers/cpufreq/cpufreq_ondemand.c              |   28 ++-
 drivers/i2c/chips/ds1374.c                      |   12 +
 drivers/ieee1394/hosts.c                        |    9 +
 drivers/ieee1394/hosts.h                        |    2 
 drivers/ieee1394/sbp2.c                         |   28 ++-
 drivers/ieee1394/sbp2.h                         |    2 
 drivers/infiniband/core/addr.c                  |    6 -
 drivers/infiniband/core/cache.c                 |    7 -
 drivers/infiniband/core/cm.c                    |   19 +-
 drivers/infiniband/core/cma.c                   |   10 +
 drivers/infiniband/core/iwcm.c                  |    6 -
 drivers/infiniband/core/mad.c                   |   25 +--
 drivers/infiniband/core/mad_priv.h              |    2 
 drivers/infiniband/core/mad_rmpp.c              |   18 +-
 drivers/infiniband/core/sa_query.c              |   10 +
 drivers/infiniband/core/uverbs_mem.c            |    7 -
 drivers/infiniband/hw/ipath/ipath_user_pages.c  |    7 -
 drivers/infiniband/hw/mthca/mthca_catas.c       |    4 
 drivers/infiniband/ulp/ipoib/ipoib.h            |   16 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c         |   25 +--
 drivers/infiniband/ulp/ipoib/ipoib_main.c       |   10 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c  |   22 +-
 drivers/infiniband/ulp/iser/iser_verbs.c        |   10 +
 drivers/infiniband/ulp/srp/ib_srp.c             |    7 -
 drivers/input/keyboard/atkbd.c                  |    6 -
 drivers/input/keyboard/lkkbd.c                  |    6 -
 drivers/input/keyboard/sunkbd.c                 |    6 -
 drivers/input/mouse/psmouse-base.c              |    7 -
 drivers/input/serio/libps2.c                    |    6 -
 drivers/isdn/act2000/capi.c                     |    4 
 drivers/isdn/act2000/capi.h                     |    2 
 drivers/isdn/act2000/module.c                   |   18 +-
 drivers/isdn/capi/kcapi.c                       |   14 +
 drivers/isdn/hisax/amd7930_fn.c                 |    7 -
 drivers/isdn/hisax/config.c                     |    9 +
 drivers/isdn/hisax/hfc4s8s_l1.c                 |    5 -
 drivers/isdn/hisax/hfc_2bds0.c                  |    9 +
 drivers/isdn/hisax/hfc_pci.c                    |    6 -
 drivers/isdn/hisax/hfc_sx.c                     |    6 -
 drivers/isdn/hisax/icc.c                        |    6 -
 drivers/isdn/hisax/isac.c                       |    6 -
 drivers/isdn/hisax/isar.c                       |    6 -
 drivers/isdn/hisax/isdnl1.c                     |    6 -
 drivers/isdn/hisax/w6692.c                      |    6 -
 drivers/isdn/i4l/isdn_net.c                     |    6 -
 drivers/isdn/pcbit/drv.c                        |    4 
 drivers/isdn/pcbit/layer2.c                     |    6 -
 drivers/isdn/pcbit/pcbit.h                      |    2 
 drivers/macintosh/rack-meter.c                  |   16 +-
 drivers/macintosh/smu.c                         |    4 
 drivers/md/dm-crypt.c                           |    8 -
 drivers/md/dm-mpath.c                           |   18 +-
 drivers/md/dm-raid1.c                           |    4 
 drivers/md/dm-snap.c                            |    9 +
 drivers/md/kcopyd.c                             |    4 
 drivers/media/dvb/b2c2/flexcop-pci.c            |    9 +
 drivers/media/dvb/cinergyT2/cinergyT2.c         |   18 +-
 drivers/media/dvb/dvb-core/dvb_net.c            |   19 +-
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c      |    7 -
 drivers/media/dvb/dvb-usb/dvb-usb.h             |    2 
 drivers/media/video/cpia_pp.c                   |   20 ++
 drivers/media/video/cx88/cx88-input.c           |    6 -
 drivers/media/video/ir-kbd-i2c.c                |    6 -
 drivers/media/video/pvrusb2/pvrusb2-context.c   |   13 +
 drivers/media/video/saa6588.c                   |    6 -
 drivers/media/video/saa7134/saa7134-empress.c   |    9 +
 drivers/message/fusion/mptfc.c                  |   14 +
 drivers/message/fusion/mptlan.c                 |   29 ++-
 drivers/message/fusion/mptsas.c                 |   25 +--
 drivers/message/fusion/mptspi.c                 |   14 +
 drivers/message/i2o/driver.c                    |    2 
 drivers/message/i2o/exec-osm.c                  |   13 +
 drivers/message/i2o/i2o_block.c                 |   15 +-
 drivers/message/i2o/i2o_block.h                 |    2 
 drivers/misc/tifm_7xx1.c                        |   18 +-
 drivers/mmc/mmc.c                               |   14 +
 drivers/mmc/mmc.h                               |    2 
 drivers/mmc/mmc_sysfs.c                         |   10 -
 drivers/mmc/tifm_sd.c                           |   28 ++-
 drivers/net/8139too.c                           |   26 +--
 drivers/net/bnx2.c                              |    6 -
 drivers/net/cassini.c                           |    6 -
 drivers/net/chelsio/common.h                    |    2 
 drivers/net/chelsio/cphy.h                      |    2 
 drivers/net/chelsio/cxgb2.c                     |   16 +-
 drivers/net/chelsio/my3126.c                    |    8 +
 drivers/net/e100.c                              |    8 -
 drivers/net/e1000/e1000_main.c                  |   10 +
 drivers/net/ehea/ehea_main.c                    |    9 +
 drivers/net/hamradio/baycom_epp.c               |   14 +
 drivers/net/irda/mcs7780.c                      |    6 -
 drivers/net/irda/sir-dev.h                      |    2 
 drivers/net/irda/sir_dev.c                      |    8 -
 drivers/net/iseries_veth.c                      |   12 +
 drivers/net/ixgb/ixgb_main.c                    |   10 +
 drivers/net/myri10ge/myri10ge.c                 |    7 -
 drivers/net/netxen/netxen_nic.h                 |    3 
 drivers/net/netxen/netxen_nic_init.c            |    5 -
 drivers/net/netxen/netxen_nic_main.c            |   19 +-
 drivers/net/ns83820.c                           |   10 +
 drivers/net/pcmcia/xirc2ps_cs.c                 |   12 +
 drivers/net/phy/phy.c                           |    9 +
 drivers/net/plip.c                              |   38 ++--
 drivers/net/qla3xxx.c                           |   20 +-
 drivers/net/qla3xxx.h                           |    4 
 drivers/net/r8169.c                             |   23 +-
 drivers/net/s2io.c                              |   16 +-
 drivers/net/s2io.h                              |    2 
 drivers/net/sis190.c                            |   13 +
 drivers/net/skge.c                              |   15 +-
 drivers/net/skge.h                              |    2 
 drivers/net/smc91x.c                            |   15 +-
 drivers/net/spider_net.c                        |    9 +
 drivers/net/sungem.c                            |    6 -
 drivers/net/tg3.c                               |    6 -
 drivers/net/tlan.c                              |   23 ++
 drivers/net/tlan.h                              |    1 
 drivers/net/tulip/21142.c                       |    7 -
 drivers/net/tulip/timer.c                       |    7 -
 drivers/net/tulip/tulip.h                       |    7 -
 drivers/net/tulip/tulip_core.c                  |    3 
 drivers/net/wan/pc300_tty.c                     |   23 +-
 drivers/net/wireless/bcm43xx/bcm43xx.h          |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     |   20 +-
 drivers/net/wireless/hostap/hostap.h            |    2 
 drivers/net/wireless/hostap/hostap_ap.c         |   19 +-
 drivers/net/wireless/hostap/hostap_hw.c         |   21 +-
 drivers/net/wireless/hostap/hostap_info.c       |    6 -
 drivers/net/wireless/hostap/hostap_main.c       |    8 -
 drivers/net/wireless/ipw2100.c                  |   47 +++--
 drivers/net/wireless/ipw2100.h                  |   10 +
 drivers/net/wireless/ipw2200.c                  |  227 ++++++++++++-----------
 drivers/net/wireless/ipw2200.h                  |   16 +-
 drivers/net/wireless/orinoco.c                  |   28 ++-
 drivers/net/wireless/prism54/isl_ioctl.c        |    8 +
 drivers/net/wireless/prism54/isl_ioctl.h        |    4 
 drivers/net/wireless/prism54/islpci_dev.c       |    5 -
 drivers/net/wireless/prism54/islpci_eth.c       |    4 
 drivers/net/wireless/prism54/islpci_eth.h       |    2 
 drivers/net/wireless/prism54/islpci_mgt.c       |    2 
 drivers/net/wireless/zd1211rw/zd_mac.c          |   30 ++-
 drivers/net/wireless/zd1211rw/zd_mac.h          |    6 -
 drivers/oprofile/cpu_buffer.c                   |    9 +
 drivers/oprofile/cpu_buffer.h                   |    2 
 drivers/pci/hotplug/shpchp.h                    |    4 
 drivers/pci/hotplug/shpchp_core.c               |    2 
 drivers/pci/hotplug/shpchp_ctrl.c               |   19 +-
 drivers/pci/pcie/aer/aerdrv.c                   |    2 
 drivers/pci/pcie/aer/aerdrv.h                   |    2 
 drivers/pci/pcie/aer/aerdrv_core.c              |    8 -
 drivers/pcmcia/ds.c                             |    7 -
 drivers/rtc/rtc-dev.c                           |    7 -
 drivers/scsi/NCR5380.c                          |   11 +
 drivers/scsi/NCR5380.h                          |    4 
 drivers/scsi/aha152x.c                          |    4 
 drivers/scsi/aic94xx/aic94xx_scb.c              |    9 +
 drivers/scsi/imm.c                              |   12 +
 drivers/scsi/ipr.c                              |    9 +
 drivers/scsi/libiscsi.c                         |    7 -
 drivers/scsi/libsas/sas_discover.c              |   22 +-
 drivers/scsi/libsas/sas_event.c                 |   14 +
 drivers/scsi/libsas/sas_init.c                  |    6 -
 drivers/scsi/libsas/sas_internal.h              |   12 +
 drivers/scsi/libsas/sas_phy.c                   |   45 +++--
 drivers/scsi/libsas/sas_port.c                  |   30 ++-
 drivers/scsi/libsas/sas_scsi_host.c             |    4 
 drivers/scsi/ppa.c                              |   12 +
 drivers/scsi/qla4xxx/ql4_os.c                   |    7 -
 drivers/scsi/scsi_scan.c                        |    7 -
 drivers/scsi/scsi_sysfs.c                       |   10 +
 drivers/scsi/scsi_tgt_lib.c                     |   15 +-
 drivers/scsi/scsi_transport_fc.c                |   60 +++---
 drivers/scsi/scsi_transport_iscsi.c             |    8 +
 drivers/scsi/scsi_transport_spi.c               |    7 -
 drivers/spi/pxa2xx_spi.c                        |    9 +
 drivers/spi/spi_bitbang.c                       |    7 -
 drivers/usb/atm/cxacru.c                        |   12 +
 drivers/usb/atm/speedtch.c                      |   15 +-
 drivers/usb/atm/ueagle-atm.c                    |    6 -
 drivers/usb/class/cdc-acm.c                     |    6 -
 drivers/usb/core/hub.c                          |   20 +-
 drivers/usb/core/message.c                      |    7 -
 drivers/usb/core/usb.c                          |    9 +
 drivers/usb/gadget/ether.c                      |    6 -
 drivers/usb/host/u132-hcd.c                     |   62 ++----
 drivers/usb/input/hid-core.c                    |    7 -
 drivers/usb/misc/appledisplay.c                 |   11 +
 drivers/usb/misc/ftdi-elan.c                    |   86 +++------
 drivers/usb/misc/phidgetkit.c                   |   21 +-
 drivers/usb/misc/phidgetmotorcontrol.c          |   11 +
 drivers/usb/net/kaweth.c                        |    9 +
 drivers/usb/net/pegasus.c                       |    6 -
 drivers/usb/net/pegasus.h                       |    2 
 drivers/usb/net/usbnet.c                        |    7 -
 drivers/usb/serial/aircable.c                   |   13 +
 drivers/usb/serial/digi_acceleport.c            |   14 +
 drivers/usb/serial/ftdi_sio.c                   |   19 +-
 drivers/usb/serial/keyspan_pda.c                |   22 +-
 drivers/usb/serial/usb-serial.c                 |    7 -
 drivers/usb/serial/whiteheat.c                  |   15 +-
 drivers/video/console/fbcon.c                   |    6 -
 drivers/video/pxafb.c                           |    7 -
 fs/9p/mux.c                                     |   16 +-
 fs/aio.c                                        |   16 +-
 fs/bio.c                                        |    6 -
 fs/file.c                                       |    6 -
 fs/gfs2/glock.c                                 |    8 -
 fs/ncpfs/inode.c                                |    8 -
 fs/ncpfs/sock.c                                 |   20 +-
 fs/nfs/client.c                                 |    2 
 fs/nfs/namespace.c                              |    8 -
 fs/nfs/nfs4_fs.h                                |    2 
 fs/nfs/nfs4renewd.c                             |    5 -
 fs/nfsd/nfs4state.c                             |    7 -
 fs/ocfs2/alloc.c                                |    9 +
 fs/ocfs2/cluster/heartbeat.c                    |   10 +
 fs/ocfs2/cluster/quorum.c                       |    4 
 fs/ocfs2/cluster/tcp.c                          |   78 ++++----
 fs/ocfs2/cluster/tcp_internal.h                 |    8 -
 fs/ocfs2/dlm/dlmcommon.h                        |    2 
 fs/ocfs2/dlm/dlmdomain.c                        |    2 
 fs/ocfs2/dlm/dlmrecovery.c                      |    5 -
 fs/ocfs2/dlm/userdlm.c                          |   10 +
 fs/ocfs2/journal.c                              |    7 -
 fs/ocfs2/journal.h                              |    2 
 fs/ocfs2/ocfs2.h                                |    2 
 fs/ocfs2/super.c                                |    2 
 fs/reiserfs/journal.c                           |   12 +
 fs/xfs/linux-2.6/xfs_aops.c                     |   21 +-
 fs/xfs/linux-2.6/xfs_buf.c                      |    9 +
 include/asm-arm/arch-omap/irda.h                |    2 
 include/linux/aio.h                             |    2 
 include/linux/connector.h                       |    4 
 include/linux/i2o.h                             |    2 
 include/linux/kbd_kern.h                        |    2 
 include/linux/libata.h                          |    7 -
 include/linux/mmc/host.h                        |    2 
 include/linux/ncp_fs_sb.h                       |    8 -
 include/linux/netpoll.h                         |    2 
 include/linux/nfs_fs_sb.h                       |    2 
 include/linux/reiserfs_fs_sb.h                  |    3 
 include/linux/relay.h                           |    2 
 include/linux/sunrpc/rpc_pipe_fs.h              |    2 
 include/linux/sunrpc/xprt.h                     |    2 
 include/linux/tty.h                             |    2 
 include/linux/usb.h                             |    2 
 include/linux/workqueue.h                       |  145 ++++++++++++---
 include/net/ieee80211softmac.h                  |    4 
 include/net/inet_timewait_sock.h                |    2 
 include/net/sctp/structs.h                      |    2 
 include/scsi/libsas.h                           |   25 ++-
 include/scsi/scsi_transport_fc.h                |    4 
 include/scsi/scsi_transport_iscsi.h             |    2 
 include/sound/ac97_codec.h                      |    2 
 include/sound/ak4114.h                          |    2 
 ipc/util.c                                      |    7 +
 kernel/kmod.c                                   |   16 +-
 kernel/kthread.c                                |   13 +
 kernel/power/poweroff.c                         |    4 
 kernel/relay.c                                  |   10 +
 kernel/sys.c                                    |    4 
 kernel/workqueue.c                              |  109 +++++++----
 mm/slab.c                                       |   12 +
 mm/swap.c                                       |    4 
 net/atm/lec.c                                   |    9 +
 net/atm/lec.h                                   |    2 
 net/bluetooth/hci_sysfs.c                       |   12 +
 net/bridge/br_if.c                              |   10 +
 net/bridge/br_private.h                         |    2 
 net/core/link_watch.c                           |   13 +
 net/core/netpoll.c                              |   11 +
 net/dccp/minisocks.c                            |    3 
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   18 +-
 net/ieee80211/softmac/ieee80211softmac_auth.c   |   23 +-
 net/ieee80211/softmac/ieee80211softmac_event.c  |   12 +
 net/ieee80211/softmac/ieee80211softmac_module.c |    4 
 net/ieee80211/softmac/ieee80211softmac_priv.h   |   13 +
 net/ieee80211/softmac/ieee80211softmac_scan.c   |   13 +
 net/ieee80211/softmac/ieee80211softmac_wx.c     |    6 -
 net/ipv4/inet_timewait_sock.c                   |    5 -
 net/ipv4/ipvs/ip_vs_ctl.c                       |    6 -
 net/ipv4/tcp_minisocks.c                        |    3 
 net/irda/ircomm/ircomm_tty.c                    |   11 +
 net/sctp/associola.c                            |   11 +
 net/sctp/endpointola.c                          |   10 +
 net/sctp/inqueue.c                              |    9 -
 net/sunrpc/cache.c                              |    8 -
 net/sunrpc/rpc_pipe.c                           |    8 +
 net/sunrpc/sched.c                              |    8 -
 net/sunrpc/xprt.c                               |    7 -
 net/sunrpc/xprtsock.c                           |   20 +-
 net/xfrm/xfrm_policy.c                          |    8 -
 net/xfrm/xfrm_state.c                           |    8 -
 security/keys/key.c                             |    6 -
 sound/aoa/aoa-gpio.h                            |    2 
 sound/aoa/core/snd-aoa-gpio-feature.c           |   16 +-
 sound/aoa/core/snd-aoa-gpio-pmf.c               |   16 +-
 sound/i2c/other/ak4114.c                        |    8 -
 sound/pci/ac97/ac97_codec.c                     |    7 -
 sound/pci/hda/hda_codec.c                       |   10 +
 sound/pci/hda/hda_local.h                       |    1 
 sound/ppc/tumbler.c                             |    8 +
 373 files changed, 2361 insertions(+), 1863 deletions(-)
