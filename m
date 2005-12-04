Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVLDPeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVLDPeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVLDPeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:34:11 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:51112 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932254AbVLDPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:34:10 -0500
Date: Sun, 04 Dec 2005 10:34:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc5: off-line for a week
In-reply-to: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>
Message-id: <200512041034.14146.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 01:03, Linus Torvalds wrote:
>There's a rc5 out there now, largely because I'm going to be out of
> email contact for the next week, and while I wish people were
> religiously testing all the nightly snapshots, the fact is, you guys
> don't.

Ahh Linus, but sometimes we do!  In any case, rc5 is missing this patch,
the  "v4l_ena_tda9887.patch" reproduced below:

Index: linux/drivers/media/video/cx88/cx88-cards.c
===================================================================
RCS file:
/cvs/video4linux/v4l-dvb/linux/drivers/media/video/cx88/cx88-cards.c,v
retrieving revision 1.108
diff -u -p -r1.108 cx88-cards.c
--- linux/drivers/media/video/cx88/cx88-cards.c 25 Nov 2005 10:24:13
-0000      1.108
+++ linux/drivers/media/video/cx88/cx88-cards.c 1 Dec 2005 20:56:43
-0000
@@ -569,6 +569,7 @@ struct cx88_board cx88_boards[] = {
                .radio_type     = UNSET,
                .tuner_addr     = ADDR_UNSET,
                .radio_addr     = ADDR_UNSET,
+               .tda9887_conf   = TDA9887_PRESENT,
                .input          = {{
                        .type   = CX88_VMUX_TELEVISION,
                        .vmux   = 0,
----------
So my pcHDTV-3000 card is once again disabled.

>So making the current state available as an -rc makes sense, even
> though not a lot has changed since -rc4.
>
>That said, if you didn't test -rc4 _either_ - shame on you, and please
>do test -rc5.
>
>The diffstat says "4562 insertions(+), 4997 deletions(-)" since -rc4,
> but the bulk of those (by _far_) are the mips defconfig updates (and
> the removal of the sk98lin-specific hw checksum verifier, which the
> networking layer is better at anyway).
>
>So pretty much all of this is various one-liners etc, many of them in
> V4L.
>
>Shortlog and diffstat appended.
>
>		Linus
>
>--- shortlog ---
>Adrian Bunk:
>      V4L: Makes needlessly global code static
>      DVB: Small cleanups and CodeStyle fixes
>
>Al Viro:
>      [ACPI] IA64 build: blacklist.c is used only on X86
>
>Andreas Herrmann:
>      [SCSI] zfcp: fix adapter initialization
>      [SCSI] zfcp: fix return code of zfcp_scsi_slave_alloc
>
>Andrew de Quincey:
>      DVB: Fix locking problems and code cleanup
>
>Arthur Othieno:
>      [ARM] sema_count() removal
>
>Borislav Petkov:
>      [ACPI] delete "default y" on Kconfig for ibm_acpi extras driver
>
>Carlos Silva:
>      DVB: BUDGET CI card depends on STV0297 demodulator.
>
>Daniel Jacobowitz:
>      [MIPS] Generate SIGILL again
>
>David Howells:
>      Keys: Fix permissions check for update vs add
>
>David Shaohua Li:
>      [ACPI] properly detect pmtimer on ASUS a8v motherboard
>
>David Stevens:
>      [IGMP]: workaround for IGMP v1/v2 bug
>
>Denis Vlasenko:
>      DVB: Fixes ifs in ves1820 set symbolrate().
>
>Dwaine Garden:
>      V4L: Write cached value to correct register for SECAM
>
>Eugene Surovegin:
>      ibm_emac: fix graceful stop timeout handling
>      ppc32: fix treeboot image entrypoint
>
>Francois Romieu:
>      b44: early return in dev->do_ioctl when the device is not up
>      b44: increase version number
>
>Hans Verkuil:
>      V4L: Add workaround for Hauppauge PVR150 with certain NTSC tuner
> models V4L/dvb: fix kernel message (print of %s from random pointer)
>
>Heiko Carstens:
>      [SCSI] zfcp: fix spinlock initialization
>
>Herbert Xu:
>      [IPV4] Fix EPROTONOSUPPORT error in inet_create
>
>Hugh Dickins:
>      [SCSI] st: fix a bug in sgl_map_user_pages failure path
>      [SCSI] sg and st unmap_user_pages allow PageReserved
>      [SCSI] sg: fix a bug in st_map_user_pages failure path
>
>Ian Pickworth:
>      V4L: Fixes nicam sound
>
>Jack Morgenstein:
>      IB/uverbs: track multicast group membership for userspace QPs
>
>James Bottomley:
>      [SCSI] SPI DV: be more conservative about echo buffer usage
>
>Jeff Garzik:
>      [netdrvr skge] fix typo, fix build
>
>Jeff Hansen:
>      [ARM] Fix IXDP425 setup bug
>
>Jesse Brandeburg:
>      e1000: fix for dhcp issue
>
>Jozsef Kadlecsik:
>      [NETFILTER]: Ignore ACKs ACKs on half open connections in TCP
> conntrack
>
>Komuro:
>      [netdrvr fmvj18x_cs] fix multicast bug
>
>Linus Torvalds:
>      Revert "[SCSI] fix usb storage oops"
>      Add missing "local_irq_enable()" to C2/C3 exit logic
>      Make vm_insert_page() available to NVidia module
>      Link USB drivers later in the kernel
>      Linux v2.6.15-rc5
>
>Luiz Capitulino:
>      V4L: Fixes warning at bttv-driver.c
>
>Mark Haverkamp:
>      [SCSI] aacraid: Check scsi_bios_ptabe return code
>
>Mark Lord:
>      b44: missing netif_wake_queue() in b44_open()
>
>Matthew Wilcox:
>      [SCSI] sym2: Disable IU and QAS negotiation
>
>Matthieu CASTET:
>      [wireless airo] reset card in init
>
>Mauro Carvalho Chehab:
>      V4L: Removed audio DMA enabling from cx88-core
>      V4L: Enables audio DMA setting on cx88 chips, even when dma not
> in use V4L: Some funcions now static and I2C hw code for IR
>      V4L/DVB: SCM update
>
>Maxim Shchetynin:
>      [SCSI] zfcp: fix link down handling during firmware update
>
>Michael H. Schimek:
>      V4L: Bttv bytes per line fix
>      V4L: Fixes Bttv raw format to fix VIDIOCSPICT ioctl
>      V4L: Fix bttv ioctls VIDIOC_ENUMINPUT, VIDIOCGTUNER,
> VIDIOC_QUERYCAP
>
>Michael Krufky:
>      V4l/dvb: Fix typo, removing incorrect info from CONFIG_BT848_DVB
> kconfig entry.
>
>Michael S. Tsirkin:
>      IB/mthca: reset QP's last pointers when transitioning to reset
> state IB/umad: fix RMPP handling
>      IPoIB: reinitialize mcast structs' completions for every query
>      IPoIB: protect child list in ipoib_ib_dev_flush
>      IB/mthca: fix posting of send lists of length >= 255 on mem-free
> HCAs
>
>Mike Isely:
>      V4l/dvb: Restore missing tuner definition for Hauppauge tuner
> type 0x103
>
>Moore, Eric Dean:
>      [SCSI] mptfusion : dv performance fix
>      [SCSI] mptfusion: Add maintainers
>
>Neil Horman:
>      [SCTP]: Return socket errors only if the receive queue is empty.
>      [SCTP]: Fix getsockname for sctp when an ipv6 socket accepts a
> connection from
>
>Nick Piggin:
>      Fix TIF_POLLING_NRFLAG in ACPI idle routines
>      Fix up per-cpu page batch sizes
>
>Nickolay V. Shmyrev:
>      V4L: Fix read() bugs in bttv driver
>
>Oliver Endriss:
>      DVB: Fixed DiSEqC timing for saa7146-based budget cards
>
>Patrick Boettcher:
>      DVB: Fixed incorrect usage at the private state of the
> dvb-usb-devices
>
>Pavel Roskin:
>      orinoco: fix setting power management parameters
>
>Phil Oester:
>      [NETFILTER]: Fix recent match jiffies wrap mismatches
>
>Ralf Baechle:
>      mipsnet: Fix Copyright notice.
>      jazzsonic: Fix build error.
>      jazzsonic: Fix platform device code
>      [MIPS] JMR3927: Declare puts function.
>      [MIPS] R10000 and R12000 need to set MIPS_CPU_4K_CACHE ...
>      [MIPS] Use reset_page_mapcount to initialize empty_zero_page
> usage counter. [MIPS] Kconfig: Include init/Kconfig after we've set
> 32BIT / 64BIT. [MIPS] Qemu: Qemu is emulating a 1193.182kHz i8254 PIC.
>      [MIPS] Qemu: Accept kernel command line passed by the Emulator.
>      [MIPS] Fix return path of sysmips(MIPS_ATOMIC_SET, ...)
>      [MIPS] Alchemy: Fix BCSR accesses.
>      [MIPS] Alchemy: Set board type on initialization.
>      [MIPS] Fix register handling in syscalls when debugging.
>      [MIPS] Avoid duplicate do_syscall_trace calls on return from
> sigreturn. [MIPS] Update defconfigs to reflect Kconfig changes.
>
>Ralph Metzler:
>      DVB: Fix locking to prevent Oops on SMP systems
>
>Reimar Doeffinger:
>      V4L: Fix crash when not compiled as module
>
>Ricardo Cerqueira:
>      V4L: Fix hotplugging issues with saa7134
>
>Richard Purdie:
>      [ARM] 3188/1: Add missing i2c dependency for Akita
>
>Roland Dreier:
>      IPoIB: reinitialize path struct's completion for every query
>      IPoIB: always set path->query to NULL when query finishes
>      IPoIB: don't zero members after we allocate with kzalloc
>      IPoIB: fix error handling in ipoib_open
>
>Russell King:
>      [ARM SMP] Disable lazy flush_dcache_page for SMP
>      [ARM SMP] Use event instructions for spinlocks
>
>Sergei Shtylylov:
>      [MIPS] JMR3927 fixes.
>
>shemminger@osdl.org:
>      sk98lin: fix checksumming code
>      sk98lin: add permanent address support
>      sk98lin: avoid message confusion with skge
>
>Sigmund Augdal Helberg:
>      V4L: Fixes maximum number of VBI devices
>
>Stephen Hemminger:
>      skge: handle VLAN checksum correctly on yukon rev 0
>
>Steve Dickson:
>      NFS: Fix cache consistency regression
>
>Steven Toth:
>      V4: Include comments for DVB models and includes missing ones
>      V4L: tveeprom MAC address parsing/cleanup
>      V4L: Fixed eeprom handling for cx88 and added Nova-T PCI model
> 90003 DVB: Update Steve's email address.
>
>Tejun Heo:
>      libata: fix ata_scsi_pass_thru error handling
>
>Thomas Graf:
>      [NETLINK]: Fix processing of fib_lookup netlink messages
>
>Thomas Renninger:
>      [ACPI] fix HP nx8220 boot hang regression
>      [ACPI] Allow return to active cooling mode once passive mode is
> entered [ACPI] Fix Null pointer deref in video/lcd/brightness
>
>Tim Schmielau:
>      DVB: Include fixes for 2.6.15-rc1 for removing sched.h from
> module.h
>
>Trond Myklebust:
>      NFS: Fix a few further cache consistency regressions
>      SUNRPC: Fix Oopsable condition in rpc_pipefs
>      NFS: use set_page_writeback() in the appropriate places
>      NFS: Fix post-op attribute revalidation...
>      NFSv4: Fix an Oops in the synchronous write path
>
>Vasily Averin:
>      [SCSI] aic7xxx: reset handler selects a wrong command
>
>Venkatesh Pallipadi:
>      [ACPI] Prefer _CST over FADT for C-state capabilities
>      [ACPI] Add support for FADT P_LVL2_UP flag
>      [ACPI] fix 2.6.13 boot hang regression on HT box w/ broken BIOS
>
>Vitaly Bordug:
>      ppc32: Fix incorrect PCI frequency value
>
>YOSHIFUJI Hideaki:
>      [IPV6]: Load protocol module dynamically.
>
>--- diffstat ---
> MAINTAINERS                                    |   12
> Makefile                                       |    2
> arch/arm/configs/spitz_defconfig               |   19 -
> arch/arm/mach-ixp4xx/ixdp425-setup.c           |    2
> arch/arm/mach-pxa/Kconfig                      |    2
> arch/arm/mm/flush.c                            |    7
> arch/i386/kernel/acpi/boot.c                   |    7
> arch/mips/Kconfig                              |    4
> arch/mips/au1000/db1x00/board_setup.c          |    7
> arch/mips/au1000/db1x00/init.c                 |   12
> arch/mips/configs/atlas_defconfig              |  142 ++--
> arch/mips/configs/bigsur_defconfig             |  149 ++--
> arch/mips/configs/capcella_defconfig           |  143 ++--
> arch/mips/configs/cobalt_defconfig             |  131 ++--
> arch/mips/configs/db1000_defconfig             |  144 ++--
> arch/mips/configs/db1100_defconfig             |  144 ++--
> arch/mips/configs/db1200_defconfig             |  147 ++--
> arch/mips/configs/db1500_defconfig             |  143 ++--
> arch/mips/configs/db1550_defconfig             |  143 ++--
> arch/mips/configs/ddb5476_defconfig            |  131 ++--
> arch/mips/configs/ddb5477_defconfig            |  131 ++--
> arch/mips/configs/decstation_defconfig         |  146 ++--
> arch/mips/configs/e55_defconfig                |  144 ++--
> arch/mips/configs/ev64120_defconfig            |  143 ++--
> arch/mips/configs/ev96100_defconfig            |  144 ++--
> arch/mips/configs/ip22_defconfig               |  145 ++--
> arch/mips/configs/ip27_defconfig               |  146 ++--
> arch/mips/configs/ip32_defconfig               |  131 ++--
> arch/mips/configs/it8172_defconfig             |  146 ++--
> arch/mips/configs/ivr_defconfig                |  145 ++--
> arch/mips/configs/jaguar-atx_defconfig         |  139 ++--
> arch/mips/configs/jmr3927_defconfig            |  131 ++--
> arch/mips/configs/lasat200_defconfig           |  143 ++--
> arch/mips/configs/malta_defconfig              |  142 ++--
> arch/mips/configs/mipssim_defconfig            |  145 ++--
> arch/mips/configs/mpc30x_defconfig             |  143 ++--
> arch/mips/configs/ocelot_3_defconfig           |  145 ++--
> arch/mips/configs/ocelot_c_defconfig           |  129 ++--
> arch/mips/configs/ocelot_defconfig             |  132 ++--
> arch/mips/configs/ocelot_g_defconfig           |  129 ++--
> arch/mips/configs/pb1100_defconfig             |  144 ++--
> arch/mips/configs/pb1500_defconfig             |  143 ++--
> arch/mips/configs/pb1550_defconfig             |  143 ++--
> arch/mips/configs/pnx8550-jbs_defconfig        |  145 ++--
> arch/mips/configs/pnx8550-v2pci_defconfig      |  143 ++--
> arch/mips/configs/qemu_defconfig               |  129 ++--
> arch/mips/configs/rbhma4500_defconfig          |  143 ++--
> arch/mips/configs/rm200_defconfig              |  148 ++--
> arch/mips/configs/sb1250-swarm_defconfig       |  145 ++--
> arch/mips/configs/sead_defconfig               |  125 ++-
> arch/mips/configs/tb0226_defconfig             |  143 ++--
> arch/mips/configs/tb0229_defconfig             |  143 ++--
> arch/mips/configs/workpad_defconfig            |  144 ++--
> arch/mips/configs/yosemite_defconfig           |  145 ++--
> arch/mips/defconfig                            |  145 ++--
> arch/mips/jmr3927/rbhma3100/irq.c              |   28 +
> arch/mips/jmr3927/rbhma3100/setup.c            |    2
> arch/mips/kernel/cpu-probe.c                   |    4
> arch/mips/kernel/irixsig.c                     |    4
> arch/mips/kernel/scall32-o32.S                 |   18
> arch/mips/kernel/scall64-64.S                  |   18
> arch/mips/kernel/scall64-n32.S                 |    4
> arch/mips/kernel/scall64-o32.S                 |    4
> arch/mips/kernel/signal.c                      |    2
> arch/mips/kernel/signal32.c                    |    2
> arch/mips/kernel/traps.c                       |    5
> arch/mips/mm/init.c                            |    2
> arch/mips/qemu/q-firmware.c                    |   13
> arch/ppc/boot/simple/Makefile                  |    4
> arch/ppc/syslib/m82xx_pci.c                    |    3
> drivers/Makefile                               |    3
> drivers/acpi/Kconfig                           |    1
> drivers/acpi/Makefile                          |    2
> drivers/acpi/processor_core.c                  |   15
> drivers/acpi/processor_idle.c                  |   51 +
> drivers/acpi/processor_thermal.c               |   38 +
> drivers/acpi/scan.c                            |    2
> drivers/acpi/thermal.c                         |  163 ++--
> drivers/acpi/video.c                           |    2
> drivers/infiniband/core/user_mad.c             |   41 +
> drivers/infiniband/core/uverbs.h               |   11
> drivers/infiniband/core/uverbs_cmd.c           |   90 ++
> drivers/infiniband/core/uverbs_main.c          |   21 -
> drivers/infiniband/hw/mthca/mthca_qp.c         |   34 +
> drivers/infiniband/hw/mthca/mthca_wqe.h        |    3
> drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    4
> drivers/infiniband/ulp/ipoib/ipoib_main.c      |   11
> drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   10
> drivers/media/dvb/b2c2/flexcop-hw-filter.c     |    2
> drivers/media/dvb/dvb-core/dvb_ca_en50221.c    |   69 +-
> drivers/media/dvb/dvb-core/dvb_net.c           |   31 +
> drivers/media/dvb/dvb-usb/a800.c               |    2
> drivers/media/dvb/dvb-usb/dibusb-common.c      |   18
> drivers/media/dvb/dvb-usb/digitv.c             |    2
> drivers/media/dvb/dvb-usb/dvb-usb-init.c       |    2
> drivers/media/dvb/frontends/cx22702.c          |    2
> drivers/media/dvb/frontends/cx22702.h          |    2
> drivers/media/dvb/frontends/nxt200x.c          |    2
> drivers/media/dvb/frontends/ves1820.c          |   14
> drivers/media/dvb/ttpci/Kconfig                |    1
> drivers/media/dvb/ttpci/av7110_ca.c            |    1
> drivers/media/dvb/ttpci/budget-av.c            |    2
> drivers/media/dvb/ttpci/budget-ci.c            |    2
> drivers/media/dvb/ttpci/budget.c               |    2
> drivers/media/dvb/ttpci/ttpci-eeprom.c         |    1
> drivers/media/video/Kconfig                    |    3
> drivers/media/video/bttv-cards.c               |    6
> drivers/media/video/bttv-driver.c              |   67 +-
> drivers/media/video/cx25840/cx25840-core.c     |   38 +
> drivers/media/video/cx25840/cx25840.h          |    9
> drivers/media/video/cx88/cx88-cards.c          |   43 -
> drivers/media/video/cx88/cx88-core.c           |   35 +
> drivers/media/video/cx88/cx88-tvaudio.c        |   28 -
> drivers/media/video/cx88/cx88.h                |    4
> drivers/media/video/em28xx/em28xx-core.c       |    6
> drivers/media/video/em28xx/em28xx-video.c      |    2
> drivers/media/video/ir-kbd-i2c.c               |    2
> drivers/media/video/saa7115.c                  |   14
> drivers/media/video/saa711x.c                  |    2
> drivers/media/video/saa7127.c                  |    6
> drivers/media/video/saa7134/saa7134-alsa.c     |   36 +
> drivers/media/video/saa7134/saa7134-core.c     |   25 +
> drivers/media/video/saa7134/saa7134-oss.c      |   81 +-
> drivers/media/video/saa7134/saa7134.h          |    4
> drivers/media/video/tveeprom.c                 |   64 +-
> drivers/media/video/video-buf.c                |    9
> drivers/media/video/videodev.c                 |   26 -
> drivers/message/fusion/mptbase.c               |   64 ++
> drivers/message/fusion/mptbase.h               |    3
> drivers/message/fusion/mptscsih.c              |   10
> drivers/net/b44.c                              |   13
> drivers/net/e1000/e1000_main.c                 |   14
> drivers/net/ibm_emac/ibm_emac_core.c           |   38 +
> drivers/net/ibm_emac/ibm_emac_core.h           |    2
> drivers/net/jazzsonic.c                        |    4
> drivers/net/mipsnet.h                          |   30 -
> drivers/net/pcmcia/fmvj18x_cs.c                |   32 -
> drivers/net/sk98lin/Makefile                   |    5
> drivers/net/sk98lin/h/skdrv2nd.h               |    4
> drivers/net/sk98lin/skcsum.c                   |  871
> ------------------------ drivers/net/sk98lin/skethtool.c              
>  |    2
> drivers/net/sk98lin/skge.c                     |  174 +----
> drivers/net/skge.c                             |    4
> drivers/net/wireless/airo.c                    |    4
> drivers/net/wireless/orinoco.c                 |    3
> drivers/s390/scsi/zfcp_aux.c                   |   14
> drivers/s390/scsi/zfcp_dbf.c                   |    4
> drivers/s390/scsi/zfcp_erp.c                   |   94 +--
> drivers/s390/scsi/zfcp_fsf.c                   |  110 ++-
> drivers/s390/scsi/zfcp_scsi.c                  |    2
> drivers/scsi/aacraid/linit.c                   |    2
> drivers/scsi/aic7xxx/aic79xx_osm.c             |    2
> drivers/scsi/aic7xxx/aic7xxx_osm.c             |    2
> drivers/scsi/libata-scsi.c                     |    9
> drivers/scsi/scsi_lib.c                        |    9
> drivers/scsi/scsi_transport_spi.c              |   28 +
> drivers/scsi/sg.c                              |    6
> drivers/scsi/st.c                              |    3
> drivers/scsi/sym53c8xx_2/sym_glue.c            |    5
> fs/nfs/dir.c                                   |    3
> fs/nfs/inode.c                                 |   55 +-
> fs/nfs/nfs4proc.c                              |   11
> fs/nfs/proc.c                                  |    1
> fs/nfs/write.c                                 |    6
> include/asm-arm/semaphore.h                    |    5
> include/asm-arm/spinlock.h                     |   26 +
> include/asm-mips/mach-qemu/timex.h             |   16
> include/linux/i2c-id.h                         |    1
> include/media/tveeprom.h                       |    4
> mm/memory.c                                    |    2
> mm/page_alloc.c                                |   16
> net/ipv4/af_inet.c                             |    7
> net/ipv4/fib_frontend.c                        |    8
> net/ipv4/igmp.c                                |    5
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c    |   29 +
> net/ipv4/netfilter/ipt_recent.c                |    1
> net/ipv6/af_inet6.c                            |   47 +
> net/ipv6/mcast.c                               |    5
> net/netfilter/nf_conntrack_proto_tcp.c         |   29 +
> net/sctp/socket.c                              |   10
> net/sctp/transport.c                           |    3
> net/sunrpc/rpc_pipe.c                          |    2
> security/keys/keyring.c                        |    2
> 183 files changed, 4562 insertions(+), 4997 deletions(-)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

