Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135531AbRDSDeY>; Wed, 18 Apr 2001 23:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135533AbRDSDeQ>; Wed, 18 Apr 2001 23:34:16 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:14089 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135531AbRDSDd5> convert rfc822-to-8bit;
	Wed, 18 Apr 2001 23:33:57 -0400
Date: Wed, 18 Apr 2001 23:34:45 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Cross-referencing frenzy
Message-ID: <20010418233445.A28628@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So.  I've written a cross-reference analyzer for the configuration symbol
namespace.  It's included with CML 1.2.0, which I just released.  The
main reason I wrote it was to detect broken symbols.

A symbol is non-broken when:
	* It is used in either code or a Makefile
	* It is set in a (CML1) configuration file
	* It is either derived from other non-broken symbols 
          or described in Configure.help

If it fails any one of these conditions, it's cruft that makes the kernel
code harder to maintain and understand.  The least bad way to be broken is
to be useful but not documented.  The most bad way is to lurk in code, doing
nothing but making the code harder to understand and maintain.

There are 731 apparently broken symbols out of 2096 total in the
2.4.4pre4 -- more than one-third of the entire namespace!  Here's a
cross-reference report.  Read it and weep...even given that a couple
dozen of these are things like CONFIG_PARTITION_ADVANCED that are CML1
derived symbols, there are a lot of "most bad" broken symbols out
there.

Especially look for CONFIG_* symbols that only occur in .c or .h files.
I think almost every one of those lines represents a bug that needs to be
fixed.

CONFIG_KHTTPD_NUMCPU: net/khttpd/datasending.c net/khttpd/main.c net/khttpd/prototypes.h net/khttpd/waitheaders.c
CONFIG_SGI_IO: include/asm-mips64/sn/addrs.h include/asm-mips64/sn/arch.h include/asm-mips64/sn/io.h include/asm-mips64/sn/klconfig.h include/asm-mips64/sn/kldir.h
CONFIG_GENRTC: arch/parisc/defconfig
CONFIG_ARCH_EBSA285_HOST: arch/arm/config.in arch/arm/def-configs/footbridge Documentation/Configure.help
CONFIG_COBALT_LCD: arch/mips/config.in arch/mips/defconfig-cobalt
CONFIG_LOCKED: drivers/pcmcia/cs.c drivers/pcmcia/cs_internal.h
CONFIG_NLS_ABC: fs/nls/Makefile
CONFIG_SMB_NLS_DEFAULT: fs/Config.in arch/sparc/defconfig arch/mips/defconfig-cobalt Documentation/Configure.help
CONFIG_PP04: arch/ppc/8xx_io/uart.c
CONFIG_FREQ_RTC: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_PARTITION_ADVANCED: fs/partitions/Config.in arch/i386/defconfig arch/alpha/defconfig arch/sparc/defconfig arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/ia64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/s390/defconfig arch/parisc/defconfig arch/cris/defconfig arch/s390x/defconfig Documentation/Configure.help
CONFIG_LOWLEVEL_SOUND: Documentation/sound/Wavefront
CONFIG_MDISK: init/main.c drivers/block/ll_rw_blk.c
CONFIG_PACKET_MULTICAST: net/packet/af_packet.c
CONFIG_WARNING: drivers/net/tokenring/smctr.h
CONFIG_BLK_DEV_FLASH: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/cris/kernel/setup.c
CONFIG_DE_AOC: drivers/isdn/Config.in arch/mips/defconfig-cobalt Documentation/Configure.help
CONFIG_SCSI_DECSII: drivers/scsi/Config.in arch/mips/defconfig-decstation
CONFIG_VIDEO_VESA: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_FB_PCI: drivers/video/Config.in arch/sparc64/defconfig
CONFIG_IPV6_SUBTREES: net/ipv6/ip6_fib.c net/ipv6/route.c
CONFIG_CPU_ARM10_I_CACHE_ON: arch/arm/config.in
CONFIG_B1DMA_POLLDEBUG: drivers/isdn/avmb1/b1dma.c
CONFIG_BOGUS: Documentation/kbuild/config-language.txt
CONFIG_ELF_KERNEL: arch/mips/config.in arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_VIDEO_LML33: drivers/media/video/Makefile drivers/media/video/i2c-old.c
CONFIG_NET_QOS: net/sched/Config.in Documentation/Configure.help
CONFIG_FT_STD_FDC: drivers/char/ftape/Config.in Documentation/Configure.help
CONFIG_NINO: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_HCL_DEBUG: arch/ia64/sn/io/hcl.c
CONFIG_CS4232: include/asm-ppc/dma.h
CONFIG_BLK_DEV_HD_IDE: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/shark arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/sh/defconfig arch/ia64/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_SA1100_FREQUENCY_SCALE: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_ST_EXTRA_DEVS: arch/sparc/config.in arch/sparc/defconfig arch/m68k/config.in arch/m68k/defconfig arch/sparc64/config.in arch/sparc64/defconfig
CONFIG_VIDEO_SVGA: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_SB_DMA: drivers/sound/trix.c
CONFIG_IP_ROUTER: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/defconfig arch/arm/defconfig arch/arm/def-configs/empeg arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark
CONFIG_NET_SCH_HFCS: net/sched/Config.in
CONFIG_SOUND_ES1371_JOYPORT_BOOT: drivers/sound/es1371.c
CONFIG_IP6_NF_MATCH_STATE: net/ipv6/netfilter/Config.in
CONFIG_INFO_OFFSET: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_NET_POCKET: drivers/net/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_GVPIOEXT_LP: arch/ppc/config.in arch/ppc/configs/apus_defconfig arch/m68k/config.in arch/m68k/defconfig
CONFIG_IP6_NF_MATCH_TOS: net/ipv6/netfilter/Config.in
CONFIG_PRINTER_READBACK: arch/m68k/config.in Documentation/Configure.help Documentation/video4linux/CQcam.txt
CONFIG_CPU_ARM720: arch/arm/mm/fault-armv.c arch/arm/def-configs/lusl7200 arch/arm/def-configs/integrator
CONFIG_IP_ACCEPT_UNSOLICITED_ARP: net/ipv4/arp.c
CONFIG_IP_ALIAS: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/defconfig arch/arm/defconfig arch/arm/def-configs/empeg arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark
CONFIG_SASH: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_CMD64X_RAID: arch/arm/defconfig arch/ia64/defconfig
CONFIG_KEYBOARD_L7200_NORM: Documentation/Configure.help
CONFIG_CMD: drivers/net/3c507.c arch/i386/kernel/pci-pc.c arch/i386/kernel/pci-visws.c arch/sparc/kernel/pcic.c arch/arm/kernel/via82c505.c arch/sh/kernel/pci_st40.c
CONFIG_APM_IGNORE_SUSPEND_BOUNCE: arch/i386/kernel/apm.c
CONFIG_EXT2_CHECK: fs/ext2/super.c fs/ext2/ialloc.c fs/ext2/balloc.c
CONFIG_SERIAL_GSC: drivers/char/serial.c arch/parisc/defconfig
CONFIG_WAN_ROUTER_DRIVERS: drivers/net/wan/Config.in Documentation/Configure.help
CONFIG_SF: include/linux/ps2esdi.h drivers/block/ps2esdi.c
CONFIG_FT_NORMAL_DEBUG: drivers/char/ftape/Config.in Documentation/Configure.help
CONFIG_DEVFS_TTY_COMPAT: Documentation/filesystems/devfs/ChangeLog
CONFIG_ROM_KERNEL: arch/arm/Makefile
CONFIG_NOHIGHMEM: arch/i386/config.in arch/i386/defconfig Documentation/Configure.help
CONFIG_C4_DEBUG: drivers/isdn/avmb1/c4.c
CONFIG_CPU_ADVANCED: arch/mips/config.in arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_AIRONET4500_I365: drivers/net/Config.in Documentation/Configure.help
CONFIG_IP_FIREWALL_VERBOSE: net/ipv4/netfilter/ipfwadm_core.c
CONFIG_ATM_TNETA1570_DEBUG: drivers/atm/Config.in
CONFIG_SERIAL_AMBA: drivers/char/Makefile arch/arm/def-configs/integrator
CONFIG_USE_SERIAL_CONSOLE: arch/cris/config.in arch/cris/defconfig
CONFIG_12P4I: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_MTD_SA1100: arch/cris/defconfig
CONFIG_NLS_CODEPAGE_1258: fs/nls/Makefile
CONFIG_MTD_CSTM_CFI_JEDEC: arch/cris/defconfig
CONFIG_NLS_CODEPAGE_1252: fs/nls/Makefile
CONFIG_NLS_CODEPAGE_1250: fs/nls/Makefile
CONFIG_NLS_CODEPAGE_1257: fs/nls/Makefile
CONFIG_NLS_CODEPAGE_1256: fs/nls/Makefile
CONFIG_NLS_CODEPAGE_1254: fs/nls/Makefile
CONFIG_SCSI_FD_8xx: drivers/scsi/Makefile
CONFIG_ISDN_CAPI_CAPIFS_BOOL: drivers/isdn/Config.in
CONFIG_APFDDI: drivers/net/Space.c
CONFIG_USB_MPC8xx: arch/ppc/8xx_io/uart.c
CONFIG_DMB_TRAP: arch/parisc/kernel/sba_iommu.c
CONFIG_SA1100_THINCLIENT: arch/arm/def-configs/brutus arch/arm/def-configs/lart arch/arm/def-configs/cerf
CONFIG_H8_DISPLAY_BLANK: drivers/char/h8.c
CONFIG_S390_PARTITION: Documentation/Configure.help
CONFIG_BLK_DEV_IDEDISK_VENDOR: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/shark arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_PAS_BASE: drivers/sound/sound_config.h
CONFIG_USB_OHCI_VROOTHUB: Documentation/usb/ohci.txt
CONFIG_WDT_500: drivers/char/wd501p.h
CONFIG_PARPORT_AX: Documentation/Configure.help
CONFIG_IGNORE_NMI: Documentation/mca.txt
CONFIG_HTDMSOUND: include/asm-ppc/rpxclassic.h
CONFIG_NETBEUI: net/Config.in
CONFIG_FPROM_CYC: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_SA1100_CERF_CMDLINE: arch/arm/def-configs/cerf
CONFIG_SOFTOSS_RATE: Documentation/sound/README.OSS
CONFIG_HARD_PPS: drivers/char/serial.c drivers/char/ChangeLog drivers/char/serial_amba.c drivers/char/synclink.c drivers/char/amiserial.c drivers/sbus/char/su.c arch/ppc/8xx_io/uart.c arch/ppc/8260_io/uart.c
CONFIG_ETRAX100_SERIAL_RX_TIMEOUT_TICKS: arch/cris/drivers/serial.c
CONFIG_DYNAMIC_QUEUE_MIN_SIZE: drivers/s390/block/dasd.c
CONFIG_X86_UP_IOAPIC: arch/i386/config.in Documentation/Configure.help
CONFIG_FBCON_FONTS: drivers/video/Config.in arch/sparc/defconfig arch/mips/defconfig-ddb5476 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig arch/m68k/defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/neponset Documentation/Configure.help
CONFIG_ISDN_WITH_ABC_CH_EXTINUSE: include/linux/isdn.h
CONFIG_SERIAL_PROC_ENTRY: arch/cris/drivers/serial.c
CONFIG_RTL8129: arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig arch/arm/defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/lart arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/parisc/defconfig
CONFIG_ACCESSBUS: arch/mips/config.in
CONFIG_IO_DEBUG: arch/i386/kernel/i386_ksyms.c
CONFIG_SERIAL_RSA: drivers/char/serial.c
CONFIG_ISDN_WITH_ABC_UDP_CHECK_DIAL: include/linux/isdn.h
CONFIG_FLAGS_ADDR: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_IP_LOCAL_RT_POLICY: Documentation/networking/policy-routing.txt
CONFIG_NET_VENDOR_3COM: drivers/net/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_ISDN_WITH_ABC: drivers/isdn/Makefile
CONFIG_NET_VENDOR_SMC: drivers/net/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_IS: include/linux/ps2esdi.h drivers/block/ps2esdi.c
CONFIG_IN: scripts/Configure scripts/Menuconfig
CONFIG_DATA: drivers/char/rio/rioinit.c
CONFIG_DEFAULT_FLASH_COUNT: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_USB_STORAGE_SDDR09: drivers/usb/storage/Makefile drivers/usb/storage/transport.h drivers/usb/storage/usb.c drivers/usb/storage/dpcm.c drivers/usb/storage/unusual_devs.h
CONFIG_VIDEO_RETAIN: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_SERIAL_PORT_CUSTOM: Documentation/kbuild/config-language.txt
CONFIG_SIMETH: arch/ia64/config.in
CONFIG_IP35: include/asm-ia64/sn/arch.h
CONFIG_SCSI_DC390T_TRADMAP: drivers/scsi/tmscsim.c
CONFIG_SOUND_VIA82CXXX_PROCFS: drivers/sound/via82cxxx_audio.c Documentation/DocBook/via-audio.tmpl
CONFIG_12P4I_NODE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_H: scripts/Configure scripts/Menuconfig
CONFIG_ISDN_WITH_ABC_RAWIPCOMPRESS: include/linux/isdn.h
CONFIG_IP6_NF_QUEUE: net/ipv6/netfilter/Config.in
CONFIG_SGI_SN0_XXL: arch/mips64/config.in
CONFIG_SERIAL_EXTENDED: drivers/char/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/config.in arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/ia64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_SH_STB1_HARP: include/asm-sh/io.h arch/sh/kernel/pci_st40.c
CONFIG_LVM_PROC_FS: arch/alpha/defconfig arch/sparc/config.in arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig
CONFIG_IP_ROUTE_PERVASIVE: net/ipv4/fib_semantics.c
CONFIG_ARCH_CLPS7110: arch/arm/kernel/arch.c
CONFIG_ECC_ENABLE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_SYNERGY_SETUP: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_IA64_SOFTSDV: arch/ia64/Makefile
CONFIG_MAC_KEYBOARD: Documentation/Configure.help
CONFIG_PARIDE_PARPORT: drivers/block/paride/Config.in drivers/block/paride/rules.cml arch/arm/defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_ACPI_INTERPRETER: arch/ia64/config.in
CONFIG_REG_1: drivers/net/eth16i.c
CONFIG_REG_0: drivers/net/eth16i.c
CONFIG_MTD_ELAN_104NC: arch/cris/defconfig
CONFIG_NFS_SNAPSHOT: fs/nfs/inode.c
CONFIG_SHELL: Makefile Rules.make drivers/scsi/aic7xxx/Makefile arch/sparc/kernel/Makefile arch/sparc64/kernel/Makefile Documentation/kbuild/makefiles.txt
CONFIG_SYNC_ISC_PARANOIA: drivers/s390/s390io.c
CONFIG_CPU_MIPS32: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/mm/Makefile arch/mips/kernel/setup.c arch/mips/mips-boards/generic/time.c
CONFIG_RADIO_EMPEG: arch/arm/def-configs/empeg
CONFIG_IPDDP_DECAP: drivers/net/appletalk/Config.in Documentation/Configure.help
CONFIG_ARCH_EBSA285_ADDIN: arch/arm/config.in arch/arm/def-configs/footbridge
CONFIG_X86_USE_3DNOW_AND_WORKS: arch/i386/lib/usercopy.c
CONFIG_FB_TBOX: drivers/video/Config.in
CONFIG_USB_CPIA: arch/arm/defconfig
CONFIG_0: drivers/net/at1700.c drivers/net/fmv18x.c drivers/net/pcmcia/fmvj18x_cs.c
CONFIG_1: drivers/net/at1700.c drivers/net/fmv18x.c drivers/net/pcmcia/fmvj18x_cs.c
CONFIG_SGI_IO_ERROR_HANDLING: include/asm-ia64/sn/ioerror_handling.h arch/ia64/sn/io/pcibr.c arch/ia64/sn/io/pciio.c
CONFIG_SOUND_SOFTOSS: drivers/sound/vidc.c arch/arm/defconfig arch/arm/def-configs/lart arch/arm/def-configs/shark Documentation/sound/Wavefront
CONFIG_FREQ_HUB: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_HPT366_FIP: arch/arm/defconfig arch/ia64/defconfig
CONFIG_STAT1: drivers/video/atyfb.c drivers/video/aty.h
CONFIG_KDB: arch/ia64/defconfig
CONFIG_WATCHDOG: drivers/char/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/config.in arch/m68k/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/ia64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_M68030_ONLY: include/asm-cris/setup.h
CONFIG_IRTTY: net/irda/irsyms.c
CONFIG_USB_WMFORCE: arch/arm/defconfig Documentation/Configure.help
CONFIG_PCMCIA_SCSICARD: drivers/scsi/pcmcia/Config.in
CONFIG_SASH_PATH: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_CPU_RM7000: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/mm/Makefile
CONFIG_SB_BASE: Documentation/kbuild/config-language.txt
CONFIG_SERIAL_NOPAUSE_IO: drivers/char/serial.c drivers/isdn/hisax/elsa_ser.c drivers/sbus/char/su.c arch/mips/baget/vacserial.c arch/ppc/8xx_io/uart.c arch/ppc/8260_io/uart.c
CONFIG_PPSCSI: Documentation/Configure.help
CONFIG_PPSCSI_ONSCSI: Documentation/Configure.help
CONFIG_xxxx: arch/arm/tools/mach-types
CONFIG_CPU_ARM3: arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_DEBUG_CRW: drivers/s390/s390io.c
CONFIG_CPU_ARM7: arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/clps7500 arch/arm/def-configs/sherman
CONFIG_RADIO_CADET_PORT: drivers/media/radio/radio-cadet.c
CONFIG_ISDN_WITH_ABC_IPV4_DYNADDR: include/linux/isdn.h
CONFIG_GEMINI: arch/ppc/configs/ibmchrp_defconfig
CONFIG_MTD_NAND_ECC: include/linux/mtd/nand.h
CONFIG_TQM855L: arch/ppc/config.in arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_ISDN_WITH_ABC_CONN_ERROR: include/linux/isdn.h
CONFIG_IRLAN_SEND_GRATUITOUS_ARP: net/irda/irlan/irlan_common.c
CONFIG_PCI_CONSOLE: arch/alpha/config.in arch/ia64/config.in
CONFIG_FB_MQ200: arch/arm/def-configs/assabet arch/arm/def-configs/neponset
CONFIG_NET_PCI: drivers/net/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_SUN_MOUSE: arch/sparc/config.in arch/sparc/defconfig arch/m68k/config.in arch/m68k/defconfig arch/sparc64/config.in arch/sparc64/defconfig
CONFIG_MSS_DMA2: include/asm-ppc/dma.h
CONFIG_SMB_NLS: fs/nls/Config.in arch/i386/defconfig arch/sparc/defconfig arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/sparc64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/s390/defconfig arch/s390x/defconfig
CONFIG_SOUND_AEDSP16_SBPRO: drivers/sound/aedsp16.c
CONFIG_RXXON: drivers/char/rio/cirrus.h
CONFIG_FUNC_SIZE: arch/parisc/kernel/sba_iommu.c
CONFIG_KCORE_ELF: arch/i386/config.in arch/i386/defconfig arch/alpha/config.in arch/alpha/defconfig arch/sparc/config.in arch/sparc/defconfig arch/mips/config.in arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/config.in arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/config.in arch/m68k/defconfig arch/sparc64/config.in arch/sparc64/defconfig arch/arm/config.in arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/config.in arch/sh/defconfig arch/ia64/config.in arch/ia64/defconfig arch/mips64/config.in arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/s390/config.in arch/s390/defconfig arch/s390x/config.in arch/s390x/defconfig Documentation/Configure.help
CONFIG_IRQ_REQ: drivers/pcmcia/cs.c drivers/pcmcia/cs_internal.h
CONFIG_IP6_NF_FTP: net/ipv6/netfilter/Config.in
CONFIG_INPUT_MOUSEDEV_SCREEN_: Documentation/usb/input.txt
CONFIG_PROFILE_SHIFT: arch/cris/config.in
CONFIG_CPU_SUBTYPE_ST40STB1: include/asm-sh/irq.h include/asm-sh/pci.h drivers/char/sh-sci.c drivers/char/sh-sci.h arch/sh/kernel/Makefile arch/sh/kernel/time.c arch/sh/mm/cache.c
CONFIG_FORWARD_KEYBOARD: arch/mips/config.in arch/mips/defconfig arch/mips/defconfig-ip22 arch/mips/defconfig-orion
CONFIG_xxx: arch/m68k/kernel/head.S Documentation/networking/8139too.txt
CONFIG_HD64465_IOBASE: include/asm-sh/hd64465.h arch/sh/kernel/io_hd64465.c arch/sh/kernel/setup_hd64465.c
CONFIG_SCSI_NCR53C8XX_PROFILE: drivers/scsi/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig arch/sparc64/config.in arch/sparc64/defconfig arch/parisc/config.in arch/parisc/defconfig Documentation/Configure.help
CONFIG_INPUT_MOUSEDEV_MIX: arch/arm/defconfig
CONFIG_MCKINLEY: arch/ia64/config.in
CONFIG_RPC_FASTSCHED: include/linux/sunrpc/sched.h
CONFIG_BLK_DEV_IDEDMA_PCI: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/footbridge arch/ia64/defconfig Documentation/Configure.help
CONFIG_AT1500: drivers/net/Makefile drivers/net/Space.c
CONFIG_READA_SMALL: mm/filemap.c
CONFIG_PCMCIA_SERIAL_CB: Documentation/Configure.help
CONFIG_SCSI_CPQFCTS: drivers/scsi/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig arch/mips64/defconfig arch/mips64/defconfig-ip27
CONFIG_NETWINDER_TX_DMA_PROBLEMS: drivers/net/irda/w83977af_ir.c
CONFIG_SCSI_NCR53C8XX_PROFILE_SUPPORT: drivers/scsi/README.ncr53c8xx
CONFIG_MIPS_RTC: arch/mips/config.in
CONFIG_AWE32_MIDIEMU: drivers/sound/awe_wave.c drivers/sound/awe_wave.h Documentation/sound/README.awe
CONFIG_BLK_DEV_COMMERIAL: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/shark arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_DASD_DYNAMIC: include/asm-s390/dasd.h include/asm-s390x/dasd.h drivers/s390/block/dasd.c drivers/s390/block/dasd_eckd.c drivers/s390/block/dasd_fba.c
CONFIG_LOCK_MANDATORY: fs/locks.c
CONFIG_WDT_501_FAN: drivers/char/Config.in Documentation/Configure.help
CONFIG_PMAC: scripts/tkparse.h Documentation/Configure.help
CONFIG_VIA82CXXX_TUNING: Documentation/Configure.help
CONFIG_IP6_NF_MATCH_UNCLEAN: net/ipv6/netfilter/Config.in
CONFIG_MACH_TYPE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_NCPFS_NDS_DOMAINS: arch/alpha/defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/clps7500 arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_CPU_ARM1020: arch/arm/config.in
CONFIG_UNIX_98_PTYS: drivers/char/tty_io.c
CONFIG_MAD16_BASE: Documentation/sound/README.OSS
CONFIG_SCSI_: drivers/scsi/ChangeLog
CONFIG_NLS_CODEPAGE_1253: fs/nls/Makefile
CONFIG_ALPHA_EISA: arch/alpha/config.in
CONFIG_NET_SCH_HFSC: net/sched/Makefile net/sched/sch_api.c
CONFIG_DEVFS_BOOT_OPTIONS: Documentation/filesystems/devfs/ChangeLog
CONFIG_DS1302: include/asm-cris/rtc.h arch/cris/drivers/i2c.c
CONFIG_USB_CLIENT_MPC8xx: arch/ppc/8xx_io/uart.c
CONFIG_PORT: include/asm-sh/smc37c93x.h arch/sh/kernel/setup_se.c
CONFIG_ARCH_LACIE_NAS: arch/arm/kernel/arch.c
CONFIG_IP_ACCT: include/linux/netfilter_ipv4/ipfwadm_core.h net/ipv4/netfilter/ipfwadm_core.c
CONFIG_BLK_DEV_IDEDISK_MAXTOR: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_BIGPHYS_AREA: drivers/media/video/zr36120_mem.c
CONFIG_MOUSE: drivers/char/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/ia64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_IP_PNP_DYNAMIC: net/ipv4/ipconfig.c
CONFIG_ATARI_MFPSER: arch/m68k/config.in Documentation/Configure.help
CONFIG_IDE_CHIPSETS: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/shark arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/sh/defconfig arch/ia64/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_FEC_LXT970: arch/ppc/8xx_io/fec.c
CONFIG_BLK_DEV_HD_ONLY: drivers/ide/Config.in Documentation/Configure.help
CONFIG_BLK_DEV_IDEDISK_IBM: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_ATARI_ONLY: include/asm-cris/setup.h
CONFIG_MIPS_UNCACHED: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_FT_TWO_DRIVES: drivers/char/ftape/lowlevel/ftape-ctl.c
CONFIG_DRM_SIS: drivers/char/drm/drm.h
CONFIG_SCSI_NCR53C8XX_DISABLE_PARITY_CHECK: drivers/scsi/sym53c8xx_defs.h
CONFIG_DEVFS_DISABLE_OLD_NAMES: Documentation/filesystems/devfs/ChangeLog
CONFIG_MAD16_MPU_BASE: Documentation/sound/README.OSS
CONFIG_AIRONET4500_365: drivers/net/aironet4500_card.c
CONFIG_IP_PIMSM: net/ipv4/ipmr.c
CONFIG_ETRAX_PA_BUTTON_BITMASK: arch/cris/defconfig arch/cris/drivers/Config.in
CONFIG_FLASH: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_CPU_IS_SLOW: arch/arm/def-configs/empeg
CONFIG_NET_VENDOR_RACAL: drivers/net/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_SYNERGY_ENABLE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_IA64_AZUSA_HACKS: Documentation/Configure.help
CONFIG_M68040_OR_M68060_ONLY: include/asm-cris/setup.h
CONFIG_FB_AMIGA_OCS_ONLY: drivers/video/amifb.c
CONFIG_LMC_IGNORE_HARDWARE_HANDSHAKE: drivers/net/wan/lmc/lmc_media.c
CONFIG_BRIDGE_PARMS: drivers/net/tokenring/tms380tr.h
CONFIG_STAT0: drivers/video/atyfb.c drivers/video/aty.h
CONFIG_MSS_DMA: include/asm-ppc/dma.h
CONFIG_BOOM: Documentation/CodingStyle
CONFIG_FIREWALL: arch/arm/def-configs/empeg
CONFIG_BLK_DEV_IT8172: arch/mips/defconfig-it8172 arch/mips/ite-boards/generic/it8172_setup.c
CONFIG_ISDN_WITH_ABC_OUTGOING_EAZ: include/linux/isdn.h
CONFIG_IRLAN_GRATUITOUS_ARP: net/irda/irlan/irlan_client.c
CONFIG_BLK_DEV_ETRAXIDE: arch/cris/kernel/head.S
CONFIG_APOLLO_ELPLUS: arch/m68k/config.in Documentation/Configure.help
CONFIG_T1PCI_POLLDEBUG: drivers/isdn/avmb1/t1pci.c
CONFIG_QIC117: drivers/char/ftape/RELEASE-NOTES
CONFIG_SH_STB1_OVERDRIVE: include/asm-sh/io.h arch/sh/kernel/pci_st40.c
CONFIG_IPV6_NETLINK: net/ipv6/Config.in Documentation/Configure.help
CONFIG_ALPHA_XLT: include/asm-alpha/irq.h arch/alpha/kernel/Makefile arch/alpha/kernel/sys_alcor.c
CONFIG_IHPIB: include/linux/dio.h drivers/dio/dio.c
CONFIG_JOYSTICK: drivers/char/joystick/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/ia64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_M68020_ONLY: include/asm-cris/setup.h
CONFIG_LL_DEBUG: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_KMI_MOUSE: arch/arm/config.in
CONFIG_IP_FIREWALL_NETLINK: net/ipv4/netfilter/ipfwadm_core.c
CONFIG_TIME_CONST: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_CACHE_LINE_SHIFT: arch/ia64/config.in
CONFIG_M68040_ONLY: include/asm-cris/setup.h
CONFIG_IP_MASQUERADE: include/linux/netfilter_ipv4/ipchains_core.h include/linux/netfilter_ipv4/ipfwadm_core.h net/ipv4/netfilter/ipfwadm_core.c
CONFIG_MTD_NAND_SPIA: arch/cris/defconfig
CONFIG_SH_7750_OVERDRIVE: include/asm-sh/io.h include/asm-sh/pci.h
CONFIG_LNEXT: drivers/char/rio/cirrus.h
CONFIG_PDC202XX_MASTER: drivers/ide/pdc202xx.c arch/arm/defconfig arch/ia64/defconfig
CONFIG_IP6_NF_CONNTRACK: net/ipv6/netfilter/Config.in
CONFIG_QTRONIX_KEYBOARD: drivers/char/qtronix.c arch/mips/defconfig-it8172
CONFIG_IP6_NF_TARGET_MIRROR: net/ipv6/netfilter/Config.in
CONFIG_TCP_NAGLE_OFF: Documentation/Configure.help
CONFIG_NVRAM_NOT_DEFINED: drivers/video/atyfb.c
CONFIG_USB_SERIAL_SOMTHING: drivers/usb/serial/usbserial.c
CONFIG_STAT2: drivers/video/aty.h
CONFIG_UART_ENABLE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_CPU_ARM920_FORCE_WRITE_THROUGH: arch/arm/mm/proc-arm920.S
CONFIG_DE650: drivers/net/Makefile
CONFIG_MAD16_DMA: Documentation/sound/README.OSS
CONFIG_NFSD_TCP: fs/lockd/svc.c Documentation/Configure.help
CONFIG_MAGIC: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_SHARE_SHLIB_CORE: include/asm-cris/eshlibld.h
CONFIG_LASI_82596: arch/parisc/config.in arch/parisc/defconfig
CONFIG_HIL: arch/parisc/defconfig
CONFIG_IT8172_REVC: arch/mips/defconfig-it8172 arch/mips/ite-boards/generic/it8172_setup.c
CONFIG_IP_TRANSPARENT_PROXY: net/ipv4/netfilter/ipfwadm_core.c
CONFIG_MSND_WRITE_NDELAY: drivers/sound/msnd_pinnacle.c
CONFIG_BINFMT_SOM: arch/parisc/config.in arch/parisc/defconfig
CONFIG_PCI_GODIRECT: arch/i386/config.in arch/i386/defconfig arch/sh/config.in Documentation/kbuild/config-language.txt
CONFIG_FADS: include/asm-ppc/mpc8xx.h
CONFIG_IP6_NF_MATCH_OWNER: net/ipv6/netfilter/Config.in
CONFIG_KEYBOARD_L7200: Documentation/Configure.help
CONFIG_BLK_DEV_IDEDMA_TIMEOUT: drivers/ide/ide-dma.c
CONFIG_RADIO_SF16MI_PORT: drivers/media/radio/radio-sf16fmi.c
CONFIG_NET_ISA: drivers/net/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_SKB_LARGE: arch/m68k/defconfig arch/arm/defconfig arch/arm/def-configs/empeg Documentation/Configure.help
CONFIG_B1DMA_DEBUG: drivers/isdn/avmb1/b1dma.c
CONFIG_IRDA_DYNAMIC_WINDOW: include/net/irda/irlap.h net/irda/irlap.c net/irda/irlap_event.c net/irda/qos.c
CONFIG_ISDN_WITH_ABC_ICALL_BIND: include/linux/isdn.h
CONFIG_KALLSYMS: kernel/module.c
CONFIG_VIDEO_COMPACT: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_COMX_PROTO_HDLC: drivers/net/wan/comx.c
CONFIG_MIPS_FPU_EMULATOR: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/kernel/ptrace.c arch/mips/kernel/traps.c arch/mips/kernel/process.c arch/mips/kernel/branch.c
CONFIG_CPU_nn: arch/arm/lib/io-acorn.S arch/arm/lib/ecard.S
CONFIG_KERNEL_IFCONFIG: arch/cris/config.in arch/cris/defconfig
CONFIG_ARC_CONSOLE: arch/mips/arc/Makefile arch/mips/arc/console.c arch/mips64/sgi-ip22/ip22-setup.c
CONFIG_ATM_FIRESTREAM: drivers/atm/Config.in Documentation/Configure.help
CONFIG_DASD_FAST_IO: Documentation/Configure.help
CONFIG_CPU_32v5: arch/arm/Makefile
CONFIG_FOO: scripts/header.tk scripts/tkparse.c scripts/mkdep.c Documentation/kbuild/cml2-reference.sgml Documentation/DocBook/kernel-hacking.tmpl
CONFIG_FLAGS_NODE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_MPU_IRQ: drivers/sound/trix.c
CONFIG_USERIAL: arch/m68k/config.in arch/m68k/defconfig
CONFIG_IPL_RDR: Documentation/Configure.help
CONFIG_USB_xxx: arch/ppc/8xx_io/uart.c
CONFIG_ISDN_WITH_ABC_UDP_CHECK_HANGUP: include/linux/isdn.h
CONFIG_HPT366_MODE3: arch/arm/defconfig arch/ia64/defconfig
CONFIG_RPXLCD: include/asm-ppc/rpxclassic.h
CONFIG_DECNET_FW: net/decnet/Makefile
CONFIG_M68020_OR_M68030_ONLY: include/asm-cris/setup.h
CONFIG_ADDIN_FOOTBRIDGE: arch/arm/defconfig
CONFIG_SUNRPC_SECURE: include/linux/sunrpc/auth.h
CONFIG_DS1302_SCLBIT: arch/cris/drivers/i2c.c
CONFIG_IDEDMA_PCI_AUTO: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/footbridge arch/ia64/defconfig Documentation/Configure.help
CONFIG_CHRONTEL_7003: include/asm-arm/arch-cl7500/acornfb.h arch/arm/def-configs/clps7500
CONFIG_POWER: include/asm-ppc/time.h
CONFIG_SCSI_PPA_HAVE_PEDANTIC: drivers/scsi/ppa.h drivers/scsi/imm.h
CONFIG_ROTTEN_IRQ: arch/mips/defconfig-ddb5476
CONFIG_FPROM_ENABLE: include/asm-ia64/sn/sn1/ip27config.h arch/ia64/sn/io/hubspc.c
CONFIG_FB_CLPS711X: arch/arm/def-configs/footbridge arch/arm/def-configs/rpc
CONFIG_IP_NOSIOCRT: net/ipv4/fib_frontend.c net/ipv4/fib_semantics.c
CONFIG_WDT501_FAN: drivers/char/wd501p.h
CONFIG_ATARI_SCC: arch/m68k/config.in Documentation/Configure.help
CONFIG_ISDN_WITH_ABC_LCR_SUPPORT: include/linux/isdn.h
CONFIG_DMA_MEMCPY: arch/cris/kernel/head.S
CONFIG_SCSI_NCR53C8XX_IARB: drivers/scsi/sym53c8xx_defs.h
CONFIG_I8259: include/asm-mips64/irq.h arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_JULIETTE_SS1M: arch/cris/defconfig
CONFIG_SB_IRQ: drivers/sound/trix.c
CONFIG_FLAGS: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_IRDA_BZIP2: net/irda/compressors/Config.in
CONFIG_ACORNSCSI_CONSTANTS: drivers/acorn/scsi/acornscsi.c
CONFIG_MTD_CFI_GEOMETRY: arch/cris/defconfig
CONFIG_MEMSIZE: drivers/video/aty128fb.c drivers/video/aty128.h
CONFIG_ISDN_WITH_ABC_IPTABLES_NETFILTER: include/linux/isdn.h
CONFIG_IO_REQ: drivers/pcmcia/cs.c drivers/pcmcia/cs_internal.h
CONFIG_SCSI_NCR53C8XX_DISABLE_MPARITY_CHECK: drivers/scsi/sym53c8xx_defs.h
CONFIG_SA1100_PCMCIA: arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_GSC_DINO: arch/parisc/config.in arch/parisc/defconfig
CONFIG_IA64_SOFTSDV_HACKS: drivers/video/vgacon.c Documentation/Configure.help
CONFIG_SERIAL_PORT: Documentation/kbuild/config-language.txt
CONFIG_PCI_EPIC: arch/parisc/config.in
CONFIG_ITANIUM_B2_SPECIFIC: arch/ia64/config.in
CONFIG_SA1101: include/asm-arm/arch-sa1100/hardware.h
CONFIG_SUN3X_ZS: arch/m68k/config.in arch/m68k/defconfig
CONFIG_DDV: drivers/block/ll_rw_blk.c
CONFIG_TEXT_SECTIONS: arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman Documentation/Configure.help
CONFIG_VIDEO_G364: arch/mips/config.in Documentation/kbuild/config-language.txt
CONFIG_AEDSP16_BASE: drivers/sound/aedsp16.c
CONFIG_CHECK_SUM_ADJ: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_FEC_PACKETHOOK: arch/ppc/8xx_io/fec.c
CONFIG_IGNORE_FIQ: arch/arm/kernel/traps.c
CONFIG_EMPEG_IR: arch/arm/def-configs/empeg
CONFIG_DS1302_SDABIT: arch/cris/drivers/i2c.c
CONFIG_TXXOFF: drivers/char/rio/cirrus.h
CONFIG_JULIETTE_CCD: arch/cris/defconfig
CONFIG_IP6_NF_TARGET_TOS: net/ipv6/netfilter/Config.in
CONFIG_DDB5476: include/asm-mips/pci.h arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/ddb5476/dbg_io.c
CONFIG_ZD: include/linux/ps2esdi.h drivers/block/ps2esdi.c
CONFIG_IT8712: arch/mips/defconfig-it8172
CONFIG_USER_DEBUG: drivers/scsi/scsi.h drivers/scsi/scsi_debug.c
CONFIG_MAD16: Documentation/sound/MAD16 Documentation/sound/Opti
CONFIG_FPROM_SETUP: include/asm-ia64/sn/sn1/ip27config.h arch/ia64/sn/io/hubspc.c
CONFIG_DEVFS_DISABLE_OLD_TTY_NAMES: Documentation/filesystems/devfs/ChangeLog
CONFIG_SOUND_YMPCI: arch/ppc/configs/power3_defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/lart arch/arm/def-configs/shark
CONFIG_CPU_MODE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_MVME162: arch/m68k/kernel/head.S
CONFIG_AEDSP16_SBPRO: drivers/sound/Config.in Documentation/Configure.help
CONFIG_ACER_PICA_61: arch/mips/config.in arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 Documentation/Configure.help
CONFIG_DATA_SIZE: drivers/net/eepro100.c
CONFIG_BLK_DEV_IDEDISK_SEAGATE: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_TXXON: drivers/char/rio/cirrus.h
CONFIG_FB_SIS_LINUXBIOS: drivers/video/sis/sis.h drivers/video/sis/sis_300.c drivers/video/sis/sis_300.h drivers/video/sis/sis_301.c drivers/video/sis/sis_301.h drivers/video/sis/sis_main.c
CONFIG_CLPS7500_FLASH: arch/arm/def-configs/clps7500
CONFIG_IA64_SGI_SYNERGY_PERF: include/asm-ia64/sn/nodepda.h include/asm-ia64/sn/synergy.h arch/ia64/sn/sn1/synergy.c arch/ia64/sn/io/ml_SN_init.c arch/ia64/sn/io/sgi_io_init.c
CONFIG_SCSI_53C8XX_SYMBIOS_COMPAT: drivers/scsi/README.ncr53c8xx
CONFIG_BLK_DEV_IDEDISK_WD: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_STALDRV: drivers/char/Config.in arch/arm/def-configs/footbridge arch/arm/def-configs/lusl7200 Documentation/Configure.help
CONFIG_UART_SETUP: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_FB_STI: drivers/video/fbmem.c
CONFIG_MISC_RADIO: drivers/char/misc.c
CONFIG_WDT_501_PCI: drivers/char/wdt_pci.c
CONFIG_WANPIPE_CARDS: drivers/net/wan/sdlamain.c Documentation/networking/wan-router.txt Documentation/networking/wanpipe.txt
CONFIG_T1PCI_DEBUG: drivers/isdn/avmb1/t1pci.c
CONFIG_SERIAL_INTEGRATOR: drivers/char/serial_amba.c arch/arm/def-configs/integrator
CONFIG_CPU_R3912: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/mm/Makefile arch/mips/lib/Makefile
CONFIG_FR: include/linux/ps2esdi.h drivers/block/ps2esdi.c
CONFIG_HD64461_IOBASE: include/asm-sh/hd64461.h drivers/video/hitfb.c arch/sh/kernel/io_hd64461.c arch/sh/kernel/setup_hd64461.c
CONFIG_MIPS_INSANE_LARGE: arch/mips64/config.in arch/mips64/defconfig arch/mips64/defconfig-ip27 Documentation/Configure.help
CONFIG_SA1100_VOLTAGE_SCALE: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_MSS: include/asm-ppc/dma.h Documentation/sound/Opti
CONFIG_USB_UHCI_ALT_UNLINK_OPTIMIZE: Documentation/Configure.help
CONFIG_MAC_FLOPPY_IWM: drivers/block/ll_rw_blk.c
CONFIG_HOST_FOOTBRIDGE: drivers/char/vt.c arch/arm/defconfig Documentation/Configure.help
CONFIG_CMDLINE_BOOL: arch/ppc/config.in arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig
CONFIG_BINFMT_JAVA: arch/parisc/config.in arch/parisc/defconfig arch/cris/config.in arch/cris/defconfig
CONFIG_VERSION: Documentation/kbuild/config-language.txt
CONFIG_ARCH_xxxx: arch/arm/kernel/entry-armv.S
CONFIG_COR4: drivers/char/rio/cirrus.h
CONFIG_M68020_OR_M68030: include/asm-cris/setup.h
CONFIG_VIDEO_: arch/i386/boot/video.S
CONFIG_GSC: arch/parisc/config.in arch/parisc/defconfig
CONFIG_DEVFS_ONLY: Documentation/filesystems/devfs/ChangeLog
CONFIG_SYSCTRL_CUDA: arch/ppc/config.in
CONFIG_PCI_GOANY: arch/i386/config.in arch/i386/defconfig arch/sh/config.in Documentation/kbuild/config-language.txt
CONFIG_FREQ_CPU: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_IT8172_CIR: arch/mips/defconfig-it8172 arch/mips/ite-boards/generic/Makefile arch/mips/ite-boards/generic/it8172_cir.c arch/mips/ite-boards/generic/it8172_setup.c
CONFIG_FOO_AUTOFROB: Documentation/smart-config.txt
CONFIG_HISAX_QUADRO: drivers/isdn/hisax/config.c
CONFIG_APBLOCK: drivers/block/ll_rw_blk.c
CONFIG_3C589: drivers/net/Makefile
CONFIG_C4_POLLDEBUG: drivers/isdn/avmb1/c4.c
CONFIG_DEBUG_USER_BACKTRACE: arch/arm/def-configs/empeg
CONFIG_PREP: drivers/video/clgenfb.c
CONFIG_ERROR: drivers/net/tokenring/smctr.h
CONFIG_IA64_SGI_IO: arch/ia64/sn/io/pci_dma.c
CONFIG_ADLIB: Documentation/sound/MAD16 Documentation/sound/Opti
CONFIG_APUS_FAST_EXCEPT: include/asm-ppc/processor.h include/asm-ppc/amigahw.h arch/ppc/kernel/head.S arch/ppc/amiga/chipram.c arch/m68k/amiga/chipram.c
CONFIG_FT_: drivers/char/ftape/RELEASE-NOTES drivers/char/ftape/lowlevel/fdc-io.c
CONFIG_PCI_GOBIOS: arch/i386/config.in arch/i386/defconfig arch/sh/config.in Documentation/Configure.help Documentation/kbuild/config-language.txt
CONFIG_PPSCSI_SPARCSI: Documentation/Configure.help
CONFIG_GSC_PS2: arch/parisc/config.in arch/parisc/defconfig
CONFIG_USE_INTERNAL_TIMER: drivers/net/irda/w83977af_ir.c
CONFIG_MTD_ARM: arch/arm/def-configs/integrator
CONFIG_USB_STORAGE_SHUTTLE_COMPACTFLASH: drivers/usb/storage/Makefile
CONFIG_PARISC: arch/parisc/config.in arch/parisc/defconfig
CONFIG_RXBAUD: drivers/char/rio/cirrus.h
CONFIG_SCSI_PCMCIA: drivers/scsi/pcmcia/Config.in arch/i386/defconfig Documentation/Configure.help
CONFIG_SH_CAT68701: include/asm-sh/io.h include/asm-sh/irq.h arch/sh/kernel/Makefile
CONFIG_SGI_IP37: include/asm-ia64/sn/arch.h
CONFIG_IP_FIREWALL: include/linux/netfilter_ipv4/ipfwadm_core.h net/ipv4/netfilter/ipfwadm_core.c
CONFIG_FB_RADEON: drivers/video/fbmem.c
CONFIG_CPU_ARM10_FORCE_WRITE_THROUGH: arch/arm/config.in
CONFIG_IDEDMA_PCI_EXPERIMENTAL: arch/arm/defconfig arch/ia64/defconfig
CONFIG_VIDEO_GFX_HACK: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_SPARC32: arch/sparc/config.in arch/sparc/defconfig
CONFIG_IRDA_OPTIONS: net/irda/Config.in arch/arm/def-configs/footbridge Documentation/Configure.help
CONFIG_CYCLOMX_CARDS: drivers/net/wan/cycx_main.c
CONFIG_SCSI_LASI: arch/parisc/config.in arch/parisc/defconfig
CONFIG_GDB_STUB_VBR: arch/sh/defconfig
CONFIG_ATARI_SCC_DMA: arch/m68k/config.in Documentation/Configure.help
CONFIG_GVPIOEXT_PLIP: arch/ppc/config.in arch/ppc/configs/apus_defconfig arch/m68k/config.in arch/m68k/defconfig
CONFIG_ASH: arch/arm/def-configs/clps7500 arch/arm/def-configs/shark
CONFIG_ENTER: include/asm-sh/smc37c93x.h arch/sh/kernel/setup_se.c
CONFIG_ATM_TNETA1570: drivers/atm/Config.in
CONFIG_TOUCHSCREEN_BITSY: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_SUN3X_ONLY: include/asm-m68k/setup.h
CONFIG_SERIAL_SGI_L1_PROTOCOL: arch/ia64/sn/sn1/setup.c arch/ia64/sn/io/eeprom.c arch/ia64/sn/io/hubspc.c arch/ia64/sn/io/l1.c
CONFIG_IP6_NF_TARGET_REJECT: net/ipv6/netfilter/Config.in
CONFIG_M68060_ONLY: include/asm-cris/setup.h
CONFIG_SCSI_NCR53C8XX_INTEGRITY_CHECK: drivers/scsi/sym53c8xx_defs.h
CONFIG_AIC7XXX_PROC_STATS: drivers/scsi/aic7xxx/aic7xxx_linux.c
CONFIG_ETRAX_RX_TIMEOUT_TICKS: arch/cris/drivers/serial.c
CONFIG_CPU_ARM920_WRITETHROUGH: arch/arm/config.in arch/arm/def-configs/integrator
CONFIG_RADIO_TYPHOON_: drivers/media/radio/radio-typhoon.c
CONFIG_PROFILE: arch/cris/config.in arch/cris/defconfig
CONFIG_ANYLAN: drivers/i2o/i2o_lan.c
CONFIG_AP1000: arch/m68k/sun3/prom/init.c arch/m68k/sun3/prom/printf.c
CONFIG_PPSCSI_EPSA2: Documentation/Configure.help
CONFIG_LAN_SAA9730: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_PCI_INTEGRATOR: arch/arm/config.in arch/arm/def-configs/integrator Documentation/Configure.help
CONFIG_AMIGA_ONLY: include/asm-cris/setup.h
CONFIG_MD_BOOT: arch/ppc/configs/power3_defconfig
CONFIG_OBSOLETE: drivers/net/Config.in drivers/char/Config.in arch/arm/config.in arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin Documentation/Configure.help
CONFIG_CPU_R4x00: arch/mips/dec/prom/init.c
CONFIG_ADR: drivers/scsi/i91uscsi.h drivers/scsi/i60uscsi.h
CONFIG_SKB_BELOW_4GB: Documentation/Configure.help
CONFIG_CPU_ARM2: arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_IDEDMA_PCI_WIP: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/footbridge arch/ia64/defconfig Documentation/Configure.help
CONFIG_IPLABLE: Documentation/Configure.help
CONFIG_IRDA_RECYCLE_RR: net/irda/irlap.c
CONFIG_FLAGS_ADDR_NODE: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_APM_POWER_OFF: arch/i386/kernel/apm.c
CONFIG_FEC_LXT971: arch/ppc/8xx_io/fec.c
CONFIG_CONTROL: arch/alpha/kernel/smc37c93x.c
CONFIG_MCKINLEY_ASTEP_SPECIFIC: arch/ia64/config.in
CONFIG_RT: include/linux/ps2esdi.h drivers/block/ps2esdi.c
CONFIG_SOUND_AEDSP16_MSS: drivers/sound/aedsp16.c
CONFIG_NCPFS_MOUNT_SUBDIR: arch/alpha/defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/clps7500 arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_OFF_KEY: arch/alpha/kernel/smc37c93x.c
CONFIG_SERIAL_SA1100: drivers/char/Makefile arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman Documentation/Configure.help
CONFIG_IPLABE: Documentation/Configure.help
CONFIG_BLK_DEV_IDEDISK_QUANTUM: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_VICTOR_BOARD1: arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_MIPS_EV64120: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_VIRTUAL_BUS: include/pcmcia/bus_ops.h arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_PANEL_LG: drivers/video/aty.h
CONFIG_TOUCHSCREEN_UCB1200: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_NCPFS_DEBUGDENTRY: fs/ncpfs/ncplib_kernel.c
CONFIG_AWE32_MIXER: drivers/sound/awe_wave.c drivers/sound/awe_wave.h Documentation/sound/README.awe
CONFIG_MSND_CALSIGNAL: drivers/sound/msnd_pinnacle.c
CONFIG_FLUSH_DMA_FAST: arch/cris/drivers/serial.c
CONFIG_EXPERT: Documentation/Configure.help
CONFIG_BLK_DEV_AEC6210: arch/ia64/defconfig
CONFIG_PATH_MTU_DISCOVERY: Documentation/Configure.help
CONFIG_MTD_DC21285: arch/cris/defconfig
CONFIG_SOUND_SA1100_SSP: arch/arm/def-configs/assabet arch/arm/def-configs/lart
CONFIG_PPSCSI_VPI0: Documentation/Configure.help
CONFIG_IP_ADVANCED_ROUTER: net/ipv4/Config.in arch/i386/defconfig arch/alpha/defconfig arch/sparc/defconfig arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/s390/defconfig arch/parisc/defconfig arch/cris/defconfig arch/s390x/defconfig Documentation/Configure.help
CONFIG_PCI_QSPAN: arch/ppc/config.in arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig Documentation/Configure.help
CONFIG_SH_ORION: arch/sh/kernel/setup_od.c
CONFIG_IP_PNP_ARP: net/ipv4/Config.in
CONFIG_DIO_CONSTANTS: drivers/dio/dio.c
CONFIG_FB_AMIGA_AGA_ONLY: drivers/video/amifb.c
CONFIG_SERIAL_AMBA_CONSOLE: drivers/char/tty_io.c drivers/char/serial_amba.c arch/arm/def-configs/integrator
CONFIG_DONGLE: drivers/net/irda/Config.in arch/arm/def-configs/footbridge Documentation/Configure.help
CONFIG_xx: drivers/sound/CHANGELOG
CONFIG_CPU_ARM10_D_CACHE_ON: arch/arm/config.in
CONFIG_SCCx_ENET: arch/ppc/8xx_io/enet.c
CONFIG_BLK_DEV_Q40IDE: drivers/ide/ide.c drivers/ide/Makefile
CONFIG_JULIETTE_MEGCCD: arch/cris/defconfig
CONFIG_COBALT_SERIAL: arch/mips/config.in arch/mips/defconfig-cobalt
CONFIG_CNTL: drivers/video/aty.h drivers/video/aty128fb.c drivers/video/aty128.h
CONFIG_KEYBOARD_L7200_DEMO: Documentation/Configure.help
CONFIG_S390_TAPE_DYNAMIC: drivers/s390/char/tape.c drivers/s390/char/tape.h drivers/s390/char/tape34xx.c drivers/s390/char/tapedefs.h
CONFIG_IT8172_SCR0: arch/mips/defconfig-it8172 arch/mips/ite-boards/generic/it8172_setup.c
CONFIG_IT8172_SCR1: arch/mips/defconfig-it8172 arch/mips/ite-boards/generic/it8172_setup.c
CONFIG_APM_SUSPEND_BOUNCE: arch/i386/kernel/apm.c
CONFIG_FBCON_ADVANCED: drivers/video/Config.in arch/sparc/defconfig arch/mips/defconfig-ddb5476 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig arch/m68k/defconfig arch/sparc64/defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/neponset Documentation/Configure.help
CONFIG_RXXOFF: drivers/char/rio/cirrus.h
CONFIG_FRAME_POINTER: arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman
CONFIG_SGI_IP35: include/asm-ia64/sn/addrs.h include/asm-ia64/sn/agent.h include/asm-ia64/sn/arch.h include/asm-ia64/sn/intr.h include/asm-ia64/sn/intr_public.h include/asm-ia64/sn/io.h include/asm-ia64/sn/kldir.h include/asm-ia64/sn/klconfig.h include/asm-ia64/sn/module.h include/asm-ia64/sn/nodemask.h include/asm-ia64/sn/nodepda.h include/asm-ia64/sn/router.h include/asm-ia64/sn/slotnum.h include/asm-ia64/sn/vector.h include/asm-ia64/sn/sn1/bedrock.h include/asm-ia64/sn/xtalk/xtalkaddrs.h include/asm-mips64/sn/addrs.h include/asm-mips64/sn/agent.h include/asm-mips64/sn/klconfig.h include/asm-mips64/sn/kldir.h arch/ia64/sn/io/hubspc.c arch/ia64/sn/io/ip37.c arch/ia64/sn/io/klconflib.c arch/ia64/sn/io/klgraph.c arch/ia64/sn/io/ml_SN_init.c arch/ia64/sn/io/ml_iograph.c arch/ia64/sn/io/pcibr.c arch/ia64/sn/io/pciio.c arch/ia64/sn/io/pciba.c
CONFIG_NFS: Documentation/kbuild/makefiles.txt
CONFIG_TAU: arch/ppc/kernel/irq.c
CONFIG_SA1100_DEFAULT_BAUDRATE: arch/arm/boot/compressed/setup-sa1100.S arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_VIDEO_LOCAL: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_BAGETBSM: arch/mips64/config.in
CONFIG_SERIAL_NONSTANDARD: drivers/char/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman arch/ia64/defconfig arch/mips64/defconfig arch/mips64/defconfig-ip22 arch/mips64/defconfig-ip27 arch/parisc/defconfig arch/cris/defconfig Documentation/Configure.help
CONFIG_MIPS_ITE8172: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/lib/kbd-std.c arch/mips/ite-boards/generic/it8172_setup.c
CONFIG_NETDEVICE: drivers/Makefile
CONFIG_ATM_FORE200E_MAYBE: drivers/atm/Config.in Documentation/Configure.help
CONFIG_SERIAL_SA1100_CONSOLE: drivers/char/tty_io.c arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman Documentation/Configure.help
CONFIG_MAC_SCC: arch/m68k/config.in
CONFIG_DTOP_MOUSE: arch/mips/config.in
CONFIG_JULIETTE_VIDEO: arch/cris/defconfig
CONFIG_AMD_FLASH: arch/ppc/configs/SM850_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_ADDRESS: drivers/char/rio/rioinit.c
CONFIG_ARCNET_ETH: Documentation/Configure.help
CONFIG_CERF_CS8900A: arch/arm/def-configs/cerf
CONFIG_ISDN_WITH_ABC_RCV_NO_HUPTIMER: include/linux/isdn.h
CONFIG_EXIT: include/asm-sh/smc37c93x.h arch/sh/kernel/setup_se.c
CONFIG_FEC_QS6612: arch/ppc/8xx_io/fec.c
CONFIG_MIPS_IVR: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_VIDEO_CYBERPRO: arch/arm/def-configs/footbridge
CONFIG_PPSCSI_T358: Documentation/Configure.help
CONFIG_SERIAL_CONSOLE_PORT: arch/ppc/8xx_io/uart.c arch/ppc/8260_io/uart.c
CONFIG_MROUTE: Documentation/filesystems/proc.txt Documentation/networking/ip-sysctl.txt
CONFIG_CPU_R5432: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/mm/Makefile
CONFIG_USB_STORAGE_HP8200e: drivers/usb/storage/Makefile drivers/usb/storage/transport.h drivers/usb/storage/usb.c drivers/usb/storage/unusual_devs.h
CONFIG_SCSI_ZALON: arch/parisc/config.in arch/parisc/defconfig
CONFIG_USB_UHCI_HIGH_BANDWIDTH: drivers/usb/usb-uhci.c
CONFIG_INPUT_MOUSEDEV_DIGITIZER: arch/arm/defconfig
CONFIG_MD_STRIPED: arch/arm/defconfig arch/arm/def-configs/lusl7200
CONFIG_PPSCSI_EPST: Documentation/Configure.help
CONFIG_GVPIOEXT: arch/ppc/config.in arch/ppc/configs/apus_defconfig arch/m68k/config.in arch/m68k/defconfig Documentation/Configure.help
CONFIG_SB: Documentation/sound/Opti
CONFIG_COBALT_27: arch/mips/config.in arch/mips/defconfig-cobalt
CONFIG_SOFTOSS_VOICES: Documentation/sound/README.OSS
CONFIG_GEN_RTC: arch/m68k/config.in
CONFIG_SA1100_CERF_32MB: arch/arm/def-configs/cerf
CONFIG_SERIAL_21285_OLD: drivers/char/Config.in
CONFIG_COBALT_28: arch/mips/config.in arch/mips/defconfig-cobalt
CONFIG_COMX_DEBUG_RAW: drivers/net/wan/comx.h
CONFIG_APM_IGNORE_MULTIPLE_SUSPENDS: arch/i386/kernel/apm.c
CONFIG_COR2: drivers/char/rio/cirrus.h
CONFIG_IA64_SGI_AUTOTEST: arch/ia64/sn/sn1/Makefile arch/ia64/sn/sn1/llsc4.c arch/ia64/sn/sn1/sn1_asm.S
CONFIG_IA64_FW_EMU: arch/ia64/kernel/head.S
CONFIG_ETRAX_SERIAL_RX_TIMEOUT_TICKS: arch/cris/drivers/serial.c
CONFIG_OLD_BELKIN: net/irda/irda_device.c
CONFIG_MTD_PMC551_APERTURE_SIZE: drivers/mtd/pmc551.c
CONFIG_BLK_DEV_FLD7500: arch/arm/def-configs/clps7500
CONFIG_NF_DEBUG: include/linux/netfilter_ipv4/ip_conntrack.h
CONFIG_CPU_ARM6: arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_SERIAL_L7200_CONSOLE: arch/arm/def-configs/lusl7200 Documentation/Configure.help
CONFIG_ETRAX_SERIAL_FLUSH_DMA_FAST: arch/cris/drivers/serial.c
CONFIG_MIPS_MALTA: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/mips-boards/generic/init.c arch/mips/mips-boards/generic/memory.c arch/mips/mips-boards/generic/mipsIRQ.S arch/mips/mips-boards/generic/pci.c arch/mips/mips-boards/generic/reset.c arch/mips/mips-boards/generic/time.c
CONFIG_RWSEM_GENERIC: include/linux/rwsem.h
CONFIG_DN_SERIAL: arch/m68k/config.in
CONFIG_KERNEL_ELF: arch/ppc/config.in arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/oak_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/est8260_defconfig arch/ppc/configs/walnut_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/ibmchrp_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_AVMB1_COMPAT: drivers/isdn/avmb1/kcapi.c
CONFIG_A2232: arch/m68k/config.in
CONFIG_TP34V_SCSI: drivers/scsi/sim710.c
CONFIG_ETRAX100LX: arch/cris/config.in arch/cris/defconfig
CONFIG_MIPS: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_6xx_GENERIC: symbols.cml drivers/char/rules.cml arch/ppc/rules.cml
CONFIG_PCMCIA_APA1480: Documentation/Configure.help
CONFIG_BLK_DEV_TIVO: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_AEDSP16_MSS: drivers/sound/Config.in Documentation/Configure.help
CONFIG_PCMCIA_DEBUG: arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_MTD_NAND: arch/cris/defconfig
CONFIG_SIM_SERIAL: arch/ia64/config.in
CONFIG_YM3812: Documentation/sound/MAD16 Documentation/sound/Opti Documentation/sound/OPL3-SA
CONFIG_EMPEG_USB: arch/arm/def-configs/empeg
CONFIG_VIDEO_HACK: Documentation/svga.txt
CONFIG_ETRAX_PARALLEL_PORT0: arch/cris/kernel/head.S
CONFIG_EXT_FS: Documentation/kbuild/makefiles.txt
CONFIG_BLK_DEV_MAC_MEDIABAY: drivers/ide/macide.c
CONFIG_SCSI_NCR53C8XX_TAGGED_QUEUE: drivers/scsi/sym53c8xx_defs.h
CONFIG_FB_DAFB: drivers/video/Config.in
CONFIG_PPSCSI_T348: Documentation/Configure.help
CONFIG_ITANIUM_CSTEP_SPECIFIC: arch/ia64/config.in
CONFIG_ISDN_WITH_ABC_IPV4_TCP_KEEPALIVE: include/linux/isdn.h
CONFIG_SOCK_PACKET: net/packet/af_packet.c
CONFIG_EMPEG_HENRY: arch/arm/def-configs/empeg
CONFIG_USE_W977_PNP: drivers/net/irda/w83977af_ir.c
CONFIG_IP6_NF_TARGET_LOG: net/ipv6/netfilter/Config.in
CONFIG_BLK_DEV_IDEDISK_FUJITSU: drivers/ide/Config.in arch/i386/defconfig arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/apus_defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/IVMS8_defconfig arch/sparc64/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/sh/defconfig arch/cris/defconfig
CONFIG_VIDEO_400_HACK: arch/i386/boot/video.S Documentation/svga.txt
CONFIG_COR1: drivers/char/rio/cirrus.h
CONFIG_DEVFS: Documentation/filesystems/devfs/ChangeLog
CONFIG_HPDCA: arch/m68k/config.in Documentation/Configure.help
CONFIG_AEDSP16_MPU401: drivers/sound/Config.in Documentation/Configure.help
CONFIG_ETRAX100_SERIAL_FLUSH_DMA_FAST: arch/cris/drivers/serial.c
CONFIG_ADVANCED: arch/m68k/config.in arch/m68k/defconfig Documentation/Configure.help
CONFIG_MAD16_IRQ: Documentation/sound/README.OSS
CONFIG_FPROM_WR: include/asm-ia64/sn/sn1/ip27config.h
CONFIG_MIPS_MAGNUM_4000: arch/mips/config.in arch/mips/defconfig arch/mips/defconfig-decstation arch/mips/defconfig-ip22 arch/mips/defconfig-cobalt arch/mips/defconfig-rm200 arch/mips/defconfig-orion arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 Documentation/Configure.help
CONFIG_ETRAX_PARALLEL_PORT1: arch/cris/kernel/head.S
CONFIG_SCSI_ACORNSCSI_LINK: drivers/acorn/scsi/acornscsi.c
CONFIG_SOUND_ES1370_JOYPORT_BOOT: drivers/sound/es1370.c
CONFIG_SINGLE_SIGITF: net/atm/svc.c
CONFIG_MTD_SHARP: arch/cris/defconfig
CONFIG_SGI_IP32: include/asm-ia64/sn/pci/pci_defs.h
CONFIG_DASD_CKD: drivers/s390/Config.in Documentation/Configure.help
CONFIG_IRDA_BSD: net/irda/compressors/Config.in
CONFIG_NWFPE: arch/arm/defconfig arch/arm/kernel/entry-armv.S arch/arm/kernel/entry-armo.S arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman
CONFIG_CHIP_ID: drivers/video/atyfb.c drivers/video/aty.h
CONFIG_KERNELD: fs/devfs/base.c drivers/char/n_hdlc.c drivers/md/lvm.c Documentation/modules.txt Documentation/filesystems/devfs/ChangeLog
CONFIG_USB_STORAGE_DPCM: drivers/usb/storage/Makefile drivers/usb/storage/usb.c drivers/usb/storage/unusual_devs.h
CONFIG_MIPS_EV96100: drivers/net/gt96100eth.h arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_AEC6210_TUNING: arch/ia64/defconfig
CONFIG_FOO_MODEL_TWO: Documentation/smart-config.txt
CONFIG_MAD16_MPU_IRQ: Documentation/sound/README.OSS
CONFIG_CYBERSTORMIII_SCSI: arch/m68k/config.in
CONFIG_CHR_DEV_FLASH: arch/cris/kernel/setup.c
CONFIG_SCSI_NCR53C8XX_NVRAM_DETECT: drivers/scsi/README.ncr53c8xx drivers/scsi/sym53c8xx_defs.h
CONFIG_PCMCIA_SERIAL: arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_CPU_ARM10: arch/arm/mm/Makefile
CONFIG_ISDN_WITH_ABC_UDP_CHECK: include/linux/isdn.h
CONFIG_SYSRQ: arch/arm/kernel/process.c
CONFIG_CPU_ARM920: arch/arm/def-configs/integrator
CONFIG_ABSTRACT_CONSOLE: arch/ppc/config.in arch/ppc/configs/apus_defconfig
CONFIG_IA64_SDV: arch/ia64/kernel/fw-emu.c
CONFIG_NLS_ISO8859_10: fs/nls/Makefile Documentation/Configure.help
CONFIG_FB_CONSOLE: arch/ppc/config.in arch/ppc/configs/apus_defconfig
CONFIG_CHEER: Documentation/CodingStyle
CONFIG_ETRAX_I2C_USES: arch/cris/drivers/i2c.c
CONFIG_DEBUG_IO: drivers/s390/s390io.c
CONFIG_PNP_PARPORT: Documentation/video4linux/CQcam.txt
CONFIG_USB_STORAGE_SHUTTLE_SMARTMEDIA: drivers/usb/storage/Makefile
CONFIG_SYNCOOKIES: Documentation/filesystems/proc.txt Documentation/networking/ip-sysctl.txt
CONFIG_COR5: drivers/char/rio/cirrus.h
CONFIG_MVME167: arch/m68k/kernel/head.S
CONFIG_NETWINDER_RX_DMA_PROBLEMS: drivers/net/irda/w83977af_ir.c
CONFIG_MOMENCO_OCELOT: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_ETRAX_ETHERNET_LPSLAVE: arch/cris/kernel/head.S
CONFIG_ACPI_KERNEL_CONFIG_DEBUG: include/asm-ia64/acpikcfg.h
CONFIG_GSP_RESOLVER: drivers/video/amifb.c drivers/video/fbmem.c
CONFIG_ALPHA_NEED_ROUNDING_EMULATION: Documentation/kbuild/config-language.txt
CONFIG_IT8172_TUNING: arch/mips/defconfig-it8172
CONFIG_NET_SECURITY: include/linux/ipsec.h
CONFIG_IPL_RDR_VM: Documentation/Configure.help
CONFIG_AUTODETECT_RAID: arch/ppc/configs/power3_defconfig
CONFIG_M68040_OR_M68060: include/asm-cris/setup.h
CONFIG_ETRAX100LX_V2: arch/cris/config.in arch/cris/defconfig
CONFIG_MTD_SBC_MEDIAGX: arch/cris/defconfig
CONFIG_SGI_xxxxx: include/asm-ia64/sn/arch.h
CONFIG_SCSI_SIM: arch/ia64/config.in
CONFIG_NET_FUNKINESS: Documentation/SubmittingPatches
CONFIG_KERNEL_DEBUG: drivers/s390/s390io.c
CONFIG_MIPS_ATLAS: arch/mips/Makefile arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/mips/mips-boards/generic/gdb_hook.c arch/mips/mips-boards/generic/mipsIRQ.S arch/mips/mips-boards/generic/printf.c arch/mips/mips-boards/generic/reset.c arch/mips/mips-boards/generic/time.c
CONFIG_WHIPPET_SERIAL: arch/m68k/config.in
CONFIG_SCSI_NCR53C8XX_FORCE_SYNC_NEGO: drivers/scsi/README.ncr53c8xx drivers/scsi/sym53c8xx_defs.h
CONFIG_SOUND_UDA1341: arch/arm/def-configs/assabet arch/arm/def-configs/neponset
CONFIG_ETRAX_XYZ: arch/cris/drivers/serial.c
CONFIG_ARCH_ETOILE: arch/arm/kernel/arch.c
CONFIG_INET_RARP: arch/arm/def-configs/empeg
CONFIG_INET_PCTCP: Documentation/Configure.help
CONFIG_ISDN_DRV_EICON_STANDALONE: Documentation/Configure.help
CONFIG_ON_KEY: arch/alpha/kernel/smc37c93x.c
CONFIG_ATARI_MIDI: arch/m68k/config.in Documentation/Configure.help
CONFIG_TXBAUD: drivers/char/rio/cirrus.h
CONFIG_FB_AMIGA_ECS_ONLY: drivers/video/amifb.c
CONFIG_SA1100_PENNY: drivers/video/sa1100fb.c
CONFIG_SERIAL_L7200: arch/arm/def-configs/lusl7200 Documentation/Configure.help
CONFIG_ISDN_WITH_ABC_CALLB: include/linux/isdn.h
CONFIG_BLK_DEV_ST: arch/sparc/config.in arch/m68k/config.in arch/sparc64/config.in
CONFIG_MULTIFACE_III_TTY: arch/ppc/config.in arch/ppc/configs/apus_defconfig arch/m68k/config.in arch/m68k/defconfig Documentation/Configure.help
CONFIG_ETHERTAP_MC: drivers/net/ethertap.c
CONFIG_DRM_AGP: drivers/char/Config.in
CONFIG_VAC_RTC: arch/mips/baget/Makefile
CONFIG_MIPS_GT96100ETH: drivers/net/gt96100eth.c
CONFIG_ETRAX100_XYZ: arch/cris/drivers/serial.c
CONFIG_NE2K_ZORRO: drivers/net/Config.in arch/ppc/configs/apus_defconfig
CONFIG_WINCEPT: arch/ppc/config.in arch/ppc/configs/bseip_defconfig arch/ppc/configs/mbx_defconfig arch/ppc/configs/rpxcllf_defconfig arch/ppc/configs/rpxlite_defconfig arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_MAD16_DMA2: Documentation/sound/README.OSS
CONFIG_FB_MATROX_32MB: drivers/video/matrox/matroxfb_DAC1064.c drivers/video/matrox/matroxfb_base.c drivers/video/matrox/matroxfb_base.h
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No kingdom can be secured otherwise than by arming the people.  The possession
of arms is the distinction between a freeman and a slave. 
        -- "Political Disquisitions", a British republican tract of 1774-1775
