Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129755AbQLLVPS>; Tue, 12 Dec 2000 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129801AbQLLVPM>; Tue, 12 Dec 2000 16:15:12 -0500
Received: from [195.44.156.246] ([195.44.156.246]:1540 "EHLO Consulate.UFP.CX")
	by vger.kernel.org with ESMTP id <S129755AbQLLVOy>;
	Tue, 12 Dec 2000 16:14:54 -0500
Posted-Date: Tue, 12 Dec 2000 16:05:38 GMT
Date: Tue, 12 Dec 2000 16:05:38 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.18: Configuration documentation
Message-ID: <Pine.LNX.4.21.0012121447450.14926-300000@MemAlpha.CX>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463746820-994016188-976637138=:21047"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463746820-994016188-976637138=:21047
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan.

I've just done a comparison of the configuration variables listed in
the config.in files against those listed in the Configure.help file.
I have enclosed the bash script I wrote to perform this analysis, and
would like to submit it for inclusion with the kernel as the file...

	./scripts/listvars

The results indicate three types of problems with these variables:

 1. 452 variables occur in the config.in files, but are never defined
    in Configure.help at all. I can think of the following reasons for
    this occurring:

     a. This will include variables from `choice` lines that do not
	need to be defined as they will never be asked for. Remember
	that only the first variable in any `choice` list is asked
	for by the help systems.

     b. This will include variables that should be documented, but
	are not. This needs to be corrected.

 2. 50 variables occur in Configure.help but are never referenced in any
    of the config.in files. I can think of two reasons for this:

     a. The option is now obsolete, in which case the accompanying help
        text should also be deleted.

     b. The option is spelt differently (a typo) in the config.in files
        to how it is spelt in the Configure.help file, in which case
        the spelling needs to be standardised. The following may be
	cases where this has happenned:

	    config.in version		Configure.help version
	    ~~~~~~~~~~~~~~~~~		~~~~~~~~~~~~~~~~~~~~~~
	    CONFIG_ADVANCED		CONFIG_ADVANCED_CPU
	    CONFIG_OLD_BELKIN_DONGLE	CONFIG_OLD_BELKING_DONGLE
	    CONFIG_SOUND_VMIDI		CONFIG_SOUND_MIDI
	    ~~~~~~~~~~~~~~~~~		~~~~~~~~~~~~~~~~~~~~~~

	There could easily be others, and equally well, the above may
	not be equivalent pairs.

 3. There are four variables that are documented twice each in the
    Config.help file, two of which never occur in the config.in files.
    These are as follows:

	Config  Help  Variable
	~~~~~~  ~~~~  ~~~~~~~~
	   1      2   CONFIG_ADFS_FS
	 <**>     2   CONFIG_ATOMWIDE_SERIAL
	 <**>     2   CONFIG_DUALSP_SERIAL
	   1      2   CONFIG_RADIO_CADET
	~~~~~~  ~~~~  ~~~~~~~~

    I have presumed that the duplicate descriptions need to be merged,
    and have attached a patch to do so.

The results produced from this analysis are shown below, with the items
marked with '<**>' being the ones that appear to be missing in each
case. They are sorted into ASCII order, and are grouped by the first 9
characters of the variable name.

Config  Help  Variable
~~~~~~  ~~~~  ~~~~~~~~
   1      1   CONFIG_060_WRITETHROUGH

   1    <**>  CONFIG_1GB

   1    <**>  CONFIG_2GB

   1    <**>  CONFIG_3215
   1    <**>  CONFIG_3215_CONSOLE

   1    <**>  CONFIG_3C515

   1      1   CONFIG_60XX_WDT

   3      1   CONFIG_6PACK

   1      1   CONFIG_6xx

   1      1   CONFIG_82C710_MOUSE

   1    <**>  CONFIG_8xx

   2      1   CONFIG_A2065
   1      1   CONFIG_A2091_SCSI

   1      1   CONFIG_A3000_SCSI

   1    <**>  CONFIG_A4000T_SCSI
   1    <**>  CONFIG_A4091_SCSI

   1    <**>  CONFIG_ABSTRACT_CONSOLE

   1      1   CONFIG_AC3200
   1      1   CONFIG_ACENIC
   1      1   CONFIG_ACER_PICA_61
   1      1   CONFIG_ACI_MIXER
   1      1   CONFIG_ACQUIRE_WDT
   1      1   CONFIG_ACSI_MULTI_LUN
   1      1   CONFIG_ACTISYS_DONGLE

   1    <**>  CONFIG_AD1816_BASE
   1    <**>  CONFIG_AD1816_CLOCK
   1    <**>  CONFIG_AD1816_DMA
   1    <**>  CONFIG_AD1816_DMA2
   1    <**>  CONFIG_AD1816_IRQ
   2      1   CONFIG_ADBMOUSE
   2    <**>  CONFIG_ADDIN_FOOTBRIDGE
   1      2   CONFIG_ADFS_FS
   1    <**>  CONFIG_ADVANCED
 <**>     1   CONFIG_ADVANCED_CPU

   1      1   CONFIG_AEDSP16
   4      1   CONFIG_AEDSP16_BASE
   1      1   CONFIG_AEDSP16_MPU401
   1      1   CONFIG_AEDSP16_MPU_IRQ
   1      1   CONFIG_AEDSP16_MSS
   1      1   CONFIG_AEDSP16_MSS_DMA
   1      1   CONFIG_AEDSP16_MSS_IRQ
   1      1   CONFIG_AEDSP16_SBPRO
   1      1   CONFIG_AEDSP16_SB_DMA
   1      1   CONFIG_AEDSP16_SB_IRQ

   1      1   CONFIG_AFFS_FS

   1      1   CONFIG_AGP
   1      1   CONFIG_AGP_ALI
   1      1   CONFIG_AGP_AMD
   1      1   CONFIG_AGP_I810
   1      1   CONFIG_AGP_INTEL
   1      1   CONFIG_AGP_SIS
   1      1   CONFIG_AGP_VIA

   2      1   CONFIG_AIC7XXX_CMDS_PER_DEVICE
   2      1   CONFIG_AIC7XXX_PROC_STATS
   2      1   CONFIG_AIC7XXX_RESET_DELAY
   2      1   CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT

   1      1   CONFIG_ALGOR_P4032
   1      1   CONFIG_ALIGNMENT_TRAP
   1    <**>  CONFIG_ALL_PPC
   1    <**>  CONFIG_ALPHA_ALCOR
   3    <**>  CONFIG_ALPHA_APECS
   2    <**>  CONFIG_ALPHA_AVANTI
   1    <**>  CONFIG_ALPHA_BOOK1
   1    <**>  CONFIG_ALPHA_CABRIOLET
   3    <**>  CONFIG_ALPHA_CIA
   1    <**>  CONFIG_ALPHA_DP264
   1    <**>  CONFIG_ALPHA_EB164
   2    <**>  CONFIG_ALPHA_EB64P
   1    <**>  CONFIG_ALPHA_EB66
   1    <**>  CONFIG_ALPHA_EB66P
   1    <**>  CONFIG_ALPHA_EIGER
   2    <**>  CONFIG_ALPHA_EISA
   6    <**>  CONFIG_ALPHA_EV4
   7    <**>  CONFIG_ALPHA_EV5
   3    <**>  CONFIG_ALPHA_EV6
   1      1   CONFIG_ALPHA_GAMMA
   1      1   CONFIG_ALPHA_GENERIC
   2    <**>  CONFIG_ALPHA_IRONGATE
   1    <**>  CONFIG_ALPHA_JENSEN
   2    <**>  CONFIG_ALPHA_LCA
   1    <**>  CONFIG_ALPHA_LX164
   2    <**>  CONFIG_ALPHA_MCPCIA
   1    <**>  CONFIG_ALPHA_MIATA
   1    <**>  CONFIG_ALPHA_MIKASA
   1    <**>  CONFIG_ALPHA_NAUTILUS
   2    <**>  CONFIG_ALPHA_NONAME
   1    <**>  CONFIG_ALPHA_NORITAKE
   1    <**>  CONFIG_ALPHA_P2K
   1    <**>  CONFIG_ALPHA_PC164
   2    <**>  CONFIG_ALPHA_POLARIS
   1      1   CONFIG_ALPHA_PRIMO
   2    <**>  CONFIG_ALPHA_PYXIS
   1    <**>  CONFIG_ALPHA_RAWHIDE
   1    <**>  CONFIG_ALPHA_RUFFIAN
   1    <**>  CONFIG_ALPHA_RX164
   1    <**>  CONFIG_ALPHA_SABLE
   2      1   CONFIG_ALPHA_SRM
   1      1   CONFIG_ALPHA_SRM_SETUP
   1    <**>  CONFIG_ALPHA_SX164
   2    <**>  CONFIG_ALPHA_T2
   1    <**>  CONFIG_ALPHA_TAKARA
   2    <**>  CONFIG_ALPHA_TSUNAMI
   1    <**>  CONFIG_ALPHA_XL
   1    <**>  CONFIG_ALTIVEC

   2      1   CONFIG_AMIGA
   2      1   CONFIG_AMIGAMOUSE
   2      1   CONFIG_AMIGA_BUILTIN_SERIAL
   1    <**>  CONFIG_AMIGA_FLOPPY
 <**>     1   CONFIG_AMIGA_GSP
   1    <**>  CONFIG_AMIGA_PARTITION
   1      1   CONFIG_AMIGA_PCMCIA
   1      1   CONFIG_AMIGA_Z2RAM

   1      1   CONFIG_AP1000
   1    <**>  CONFIG_APBIF
   1    <**>  CONFIG_APBLOCK
   1    <**>  CONFIG_APFDDI
   1      1   CONFIG_APM
   1      1   CONFIG_APM_ALLOW_INTS
   1      1   CONFIG_APM_CPU_IDLE
   1      1   CONFIG_APM_DISPLAY_BLANK
   1      1   CONFIG_APM_DO_ENABLE
 <**>     1   CONFIG_APM_IGNORE_SUSPEND_BOUNCE
   1      1   CONFIG_APM_IGNORE_USER_SUSPEND
   1      1   CONFIG_APM_REAL_MODE_POWER_OFF
   1      1   CONFIG_APM_RTC_IS_GMT
   1      1   CONFIG_APNE
   1      1   CONFIG_APOLLO
   1      1   CONFIG_APOLLO_ELPLUS
   1      1   CONFIG_APRICOT
   1    <**>  CONFIG_APUS

   1    <**>  CONFIG_ARCH_A5K
   2    <**>  CONFIG_ARCH_ACORN
   1      1   CONFIG_ARCH_ARC
   1    <**>  CONFIG_ARCH_CO285
   1    <**>  CONFIG_ARCH_EBSA110
   1      1   CONFIG_ARCH_EBSA285
   1      1   CONFIG_ARCH_NETWINDER
   1    <**>  CONFIG_ARCH_RPC
   1      1   CONFIG_ARCH_S390
   1      1   CONFIG_ARCNET
   1      1   CONFIG_ARCNET_1051
   1      1   CONFIG_ARCNET_COM20020
   1      1   CONFIG_ARCNET_COM90xx
   1      1   CONFIG_ARCNET_COM90xxIO
   1      1   CONFIG_ARCNET_ETH
   1      1   CONFIG_ARCNET_RIM_I
   2      1   CONFIG_ARIADNE
   2      1   CONFIG_ARIADNE2
   1      1   CONFIG_ARLAN
   1    <**>  CONFIG_ARM
   1      1   CONFIG_ARM_AM79C961A
   1      1   CONFIG_ARM_ETHER1
   1      1   CONFIG_ARM_ETHER3
   1      1   CONFIG_ARM_ETHERH
   1      1   CONFIG_ARPD
   1      1   CONFIG_ARTHUR

   1      1   CONFIG_AT1700
   1      1   CONFIG_ATALK
   1      1   CONFIG_ATARI
   1      1   CONFIG_ATARILANCE
   1      1   CONFIG_ATARIMOUSE
   1      1   CONFIG_ATARI_ACSI
   1      1   CONFIG_ATARI_BIONET
   1      1   CONFIG_ATARI_DSP56K
   1    <**>  CONFIG_ATARI_FLOPPY
   1      1   CONFIG_ATARI_MFPSER
   1      1   CONFIG_ATARI_MIDI
   1      1   CONFIG_ATARI_PAMSNET
   1      1   CONFIG_ATARI_SCC
   1      1   CONFIG_ATARI_SCC_DMA
   1      1   CONFIG_ATARI_SCSI
   1    <**>  CONFIG_ATARI_SCSI_RESET_BOOT
   1      1   CONFIG_ATARI_SCSI_TOSHIBA_DELAY
   1      1   CONFIG_ATARI_SLM
   1      1   CONFIG_ATIXL_BUSMOUSE
 <**>     2   CONFIG_ATOMWIDE_SERIAL
   1      1   CONFIG_ATP

   1      1   CONFIG_AUTOFS_FS

   1      1   CONFIG_AWE32_SYNTH

   3      1   CONFIG_AX25
   3      1   CONFIG_AX25_DAMA_MASTER
   3      1   CONFIG_AX25_DAMA_SLAVE

   1      1   CONFIG_AZTCD

   1    <**>  CONFIG_BAGETBSM
   1    <**>  CONFIG_BAGETLANCE
   1    <**>  CONFIG_BAGET_MIPS
   1      1   CONFIG_BAYCOM_EPP
   1      1   CONFIG_BAYCOM_PAR
   1      1   CONFIG_BAYCOM_SER_FDX
   1      1   CONFIG_BAYCOM_SER_HDX

   6      1   CONFIG_BINFMT_AOUT
   1    <**>  CONFIG_BINFMT_AOUT32
   9      1   CONFIG_BINFMT_ELF
   1    <**>  CONFIG_BINFMT_ELF32
   1      1   CONFIG_BINFMT_EM86
   1      1   CONFIG_BINFMT_IRIX
   6      1   CONFIG_BINFMT_JAVA
   8      1   CONFIG_BINFMT_MISC

   1      1   CONFIG_BLK_CPQ_CISS_DA
   1      1   CONFIG_BLK_CPQ_DA
   1    <**>  CONFIG_BLK_DEV_3W_XXXX_RAID
   1      1   CONFIG_BLK_DEV_4DRIVES
   1      1   CONFIG_BLK_DEV_ALI14XX
   1      1   CONFIG_BLK_DEV_ALI15X3
 <**>     1   CONFIG_BLK_DEV_BUDDHA
   1      1   CONFIG_BLK_DEV_CMD640
   1      1   CONFIG_BLK_DEV_CMD640_ENHANCED
   2      1   CONFIG_BLK_DEV_CMD646
   1      1   CONFIG_BLK_DEV_CS5530
   1      1   CONFIG_BLK_DEV_DAC960
   1      1   CONFIG_BLK_DEV_DTC2278
 <**>     1   CONFIG_BLK_DEV_FALCON_IDE
   3      1   CONFIG_BLK_DEV_FD
   1      1   CONFIG_BLK_DEV_FD1772
 <**>     1   CONFIG_BLK_DEV_GAYLE
   2    <**>  CONFIG_BLK_DEV_HD
   1      1   CONFIG_BLK_DEV_HD_IDE
   1      1   CONFIG_BLK_DEV_HD_ONLY
   1      1   CONFIG_BLK_DEV_HT6560B
   2      1   CONFIG_BLK_DEV_IDE
   2      1   CONFIG_BLK_DEV_IDECD
   2      1   CONFIG_BLK_DEV_IDEDISK
   3      1   CONFIG_BLK_DEV_IDEDMA
   1    <**>  CONFIG_BLK_DEV_IDEDMA_PMAC
 <**>     1   CONFIG_BLK_DEV_IDEDOUBLER
   2      1   CONFIG_BLK_DEV_IDEFLOPPY
   2      1   CONFIG_BLK_DEV_IDEPCI
   2      1   CONFIG_BLK_DEV_IDESCSI
   2      1   CONFIG_BLK_DEV_IDETAPE
   1      1   CONFIG_BLK_DEV_IDE_CARDS
 <**>     1   CONFIG_BLK_DEV_IDE_ICS
   1    <**>  CONFIG_BLK_DEV_IDE_ICSIDE
   1    <**>  CONFIG_BLK_DEV_IDE_PMAC
   1    <**>  CONFIG_BLK_DEV_IDE_RAPIDE
   4      1   CONFIG_BLK_DEV_INITRD
   4      1   CONFIG_BLK_DEV_LOOP
   4      1   CONFIG_BLK_DEV_MD
   1      1   CONFIG_BLK_DEV_MFM
   1      1   CONFIG_BLK_DEV_MFM_AUTODETECT
   4      1   CONFIG_BLK_DEV_NBD
   2      1   CONFIG_BLK_DEV_NS87415
   1      1   CONFIG_BLK_DEV_OFFBOARD
   1      1   CONFIG_BLK_DEV_OPTI621
 <**>     1   CONFIG_BLK_DEV_PART
 <**>     1   CONFIG_BLK_DEV_PCIDE
   1      1   CONFIG_BLK_DEV_PDC4030
   1      1   CONFIG_BLK_DEV_PS2
   1      1   CONFIG_BLK_DEV_QD6580
   4      1   CONFIG_BLK_DEV_RAM
   4      1   CONFIG_BLK_DEV_RAM_SIZE
   1      1   CONFIG_BLK_DEV_RZ1000
   5      1   CONFIG_BLK_DEV_SD
   1      1   CONFIG_BLK_DEV_SL82C105
   5      1   CONFIG_BLK_DEV_SR
   4      1   CONFIG_BLK_DEV_SR_VENDOR
 <**>     1   CONFIG_BLK_DEV_SUNFD
   1      1   CONFIG_BLK_DEV_TRM290
   1      1   CONFIG_BLK_DEV_UMC8672
   1      1   CONFIG_BLK_DEV_VIA82C586
   1      1   CONFIG_BLK_DEV_XD
   1    <**>  CONFIG_BLK_DEV_XPRAM
   1      1   CONFIG_BLZ1230_SCSI
   1      1   CONFIG_BLZ2060_SCSI
   1      1   CONFIG_BLZ603EPLUS_SCSI

   1      1   CONFIG_BMAC

   3    <**>  CONFIG_BONDING
   1    <**>  CONFIG_BOOTX_TEXT

   1      1   CONFIG_BPQETHER

   1      1   CONFIG_BRIDGE
   1    <**>  CONFIG_BRIDGE_NUM_PORTS

   1      1   CONFIG_BSD_DISKLABEL
   9      1   CONFIG_BSD_PROCESS_ACCT

   1      1   CONFIG_BUSMOUSE
   2    <**>  CONFIG_BUS_I2C

   1      1   CONFIG_BVME6000
   1      1   CONFIG_BVME6000_NET
   1      1   CONFIG_BVME6000_SCC
   1      1   CONFIG_BVME6000_SCSI

   1      1   CONFIG_C101

   1      1   CONFIG_CATS

 <**>     1   CONFIG_CDI_INIT
   1      1   CONFIG_CDU31A
   1      1   CONFIG_CDU535
   4      1   CONFIG_CD_NO_IDESCSI

   1    <**>  CONFIG_CHRP
   5      1   CONFIG_CHR_DEV_SG
   5      1   CONFIG_CHR_DEV_ST

   1      1   CONFIG_CM206
   2      1   CONFIG_CMDLINE
   1    <**>  CONFIG_CMDLINE_BOOL

   1      1   CONFIG_CODA_FS
   1    <**>  CONFIG_COMPUTONE
   1      1   CONFIG_COMX
   1      1   CONFIG_COMX_HW_COMX
   1      1   CONFIG_COMX_HW_LOCOMX
   1      1   CONFIG_COMX_HW_MIXCOM
   1      1   CONFIG_COMX_PROTO_FR
   2      1   CONFIG_COMX_PROTO_LAPB
   1      1   CONFIG_COMX_PROTO_PPP
 <**>     1   CONFIG_COPCON
   1      1   CONFIG_COPS
   1      1   CONFIG_COPS_DAYNA
   1      1   CONFIG_COPS_TANGENT
   1      1   CONFIG_COSA

   2    <**>  CONFIG_CPU_26
   2    <**>  CONFIG_CPU_32
   1    <**>  CONFIG_CPU_32v3
   1    <**>  CONFIG_CPU_32v4
 <**>     1   CONFIG_CPU_ARM2
   1    <**>  CONFIG_CPU_ARM6
   1    <**>  CONFIG_CPU_ARM7
   1      1   CONFIG_CPU_IS_SLOW
   2      1   CONFIG_CPU_LITTLE_ENDIAN
   1    <**>  CONFIG_CPU_NEVADA
   1    <**>  CONFIG_CPU_R10000
   1      1   CONFIG_CPU_R3000
   1    <**>  CONFIG_CPU_R4300
   1    <**>  CONFIG_CPU_R4X00
   1    <**>  CONFIG_CPU_R5000
   1    <**>  CONFIG_CPU_R6000
   1    <**>  CONFIG_CPU_R8000
   2    <**>  CONFIG_CPU_SA110

   1      1   CONFIG_CROSSCOMPILE

   1    <**>  CONFIG_CS4232_BASE
   1    <**>  CONFIG_CS4232_DMA
   1    <**>  CONFIG_CS4232_DMA2
   1    <**>  CONFIG_CS4232_IRQ
   1    <**>  CONFIG_CS4232_MPU_BASE
   1    <**>  CONFIG_CS4232_MPU_IRQ
   1      1   CONFIG_CS89x0

   1    <**>  CONFIG_CTC

   1    <**>  CONFIG_CYBERSTORMIII_SCSI
   1      1   CONFIG_CYBERSTORMII_SCSI
   1      1   CONFIG_CYBERSTORM_SCSI
   1      1   CONFIG_CYCLADES
   1      1   CONFIG_CYZ_INTR

   1      1   CONFIG_DASD
   1      1   CONFIG_DASD_CKD
   1      1   CONFIG_DASD_ECKD
 <**>     1   CONFIG_DASD_FAST_IO
   1      1   CONFIG_DASD_FBA
   1      1   CONFIG_DASD_MDSK
   1      1   CONFIG_DAYNAPORT

   1    <**>  CONFIG_DDV

   2      1   CONFIG_DE4X5
   1      1   CONFIG_DE600
   1      1   CONFIG_DE620
   1    <**>  CONFIG_DEBUG_DC21285_PORT
   1      1   CONFIG_DEBUG_ERRORS
   1      1   CONFIG_DEBUG_INFO
   1    <**>  CONFIG_DEBUG_LL
   6    <**>  CONFIG_DEBUG_MALLOC
   1      1   CONFIG_DEBUG_USER
   1    <**>  CONFIG_DECLANCE
   1    <**>  CONFIG_DECNET
   1    <**>  CONFIG_DECSTATION
   1      1   CONFIG_DEC_ELCP
   1      1   CONFIG_DEC_ELCP_OLD
   1      1   CONFIG_DEFXX
   1      1   CONFIG_DEPCA
 <**>     1   CONFIG_DESKSTATION_RPC44
   1      1   CONFIG_DEVPTS_FS
   1      1   CONFIG_DE_AOC

   1      1   CONFIG_DGRS

   1      1   CONFIG_DIGI
   1      1   CONFIG_DIGIEPCA
   1      1   CONFIG_DIO
   1      1   CONFIG_DISPLAY7SEG

   1      1   CONFIG_DLCI
   1      1   CONFIG_DLCI_COUNT
   1      1   CONFIG_DLCI_MAX

   1      1   CONFIG_DM9102
   1      1   CONFIG_DMASCC
   2      1   CONFIG_DMASOUND

   1    <**>  CONFIG_DONGLE

   2      1   CONFIG_DRM
   1    <**>  CONFIG_DRM_FFB
   1      1   CONFIG_DRM_GAMMA
   1      1   CONFIG_DRM_I810
   1      1   CONFIG_DRM_MGA
   1      1   CONFIG_DRM_R128
   1      1   CONFIG_DRM_TDFX

 <**>     1   CONFIG_DS1620

   1      1   CONFIG_DTLK

 <**>     2   CONFIG_DUALSP_SERIAL
   6      1   CONFIG_DUMMY
   2    <**>  CONFIG_DUMMY_CONSOLE

   1    <**>  CONFIG_DZ

   1      1   CONFIG_E2100

 <**>     1   CONFIG_ECOFF_KERNEL
   1      1   CONFIG_ECONET
   1      1   CONFIG_ECONET_AUNUDP
   1      1   CONFIG_ECONET_NATIVE
   1    <**>  CONFIG_EC_FLUSH_TRAP

   1      1   CONFIG_EEXPRESS
   1      1   CONFIG_EEXPRESS_PRO
   2      1   CONFIG_EEXPRESS_PRO100

   1      1   CONFIG_EFS_FS

   1      1   CONFIG_EL1
   1      1   CONFIG_EL16
   1      1   CONFIG_EL2
   1      1   CONFIG_EL3
   1    <**>  CONFIG_ELF_KERNEL
   1      1   CONFIG_ELMC
   1      1   CONFIG_ELMC_II
   1      1   CONFIG_ELPLUS

   1    <**>  CONFIG_ENVCTRL

   1      1   CONFIG_EPIC100

   2      1   CONFIG_EQUALIZER

   1      1   CONFIG_ES3210
   1      1   CONFIG_ESI_DONGLE
   1      1   CONFIG_ESPSERIAL

   1      1   CONFIG_ETH16I
   1      1   CONFIG_ETHERTAP

   1      1   CONFIG_EWRK3

   9      1   CONFIG_EXPERIMENTAL
   1      1   CONFIG_EXT2_FS

   1      1   CONFIG_FASTLANE_SCSI
   1    <**>  CONFIG_FAST_IRQ
   1      1   CONFIG_FAT_FS

  12      1   CONFIG_FB
   1      1   CONFIG_FBCON_ADVANCED
   3      1   CONFIG_FBCON_AFB
   3      1   CONFIG_FBCON_CFB16
   3      1   CONFIG_FBCON_CFB2
   3      1   CONFIG_FBCON_CFB24
   3      1   CONFIG_FBCON_CFB32
   3      1   CONFIG_FBCON_CFB4
   3      1   CONFIG_FBCON_CFB8
   2    <**>  CONFIG_FBCON_FONTS
   1    <**>  CONFIG_FBCON_FONTWIDTH8_ONLY
   3      1   CONFIG_FBCON_ILBM
   3    <**>  CONFIG_FBCON_IPLAN2P16
   3      1   CONFIG_FBCON_IPLAN2P2
   3      1   CONFIG_FBCON_IPLAN2P4
   3      1   CONFIG_FBCON_IPLAN2P8
   3      1   CONFIG_FBCON_MAC
   3      1   CONFIG_FBCON_MFB
   3      1   CONFIG_FBCON_VGA
   2    <**>  CONFIG_FBCON_VGA_PLANES
   1      1   CONFIG_FB_ACORN
   1      1   CONFIG_FB_AMIGA
   1      1   CONFIG_FB_AMIGA_AGA
   1      1   CONFIG_FB_AMIGA_ECS
   1      1   CONFIG_FB_AMIGA_OCS
   1      1   CONFIG_FB_APOLLO
   1      1   CONFIG_FB_ATARI
   2      1   CONFIG_FB_ATY
   1      1   CONFIG_FB_ATY128
   1      1   CONFIG_FB_BWTWO
   1    <**>  CONFIG_FB_CGFOURTEEN
   1      1   CONFIG_FB_CGSIX
   1      1   CONFIG_FB_CGTHREE
   1      1   CONFIG_FB_CLGEN
   1      1   CONFIG_FB_COMPAT_XPMAC
   1    <**>  CONFIG_FB_CONSOLE
   1      1   CONFIG_FB_CONTROL
   1      1   CONFIG_FB_CREATOR
   1      1   CONFIG_FB_CT65550
   1      1   CONFIG_FB_CYBER
   1    <**>  CONFIG_FB_CYBER2000
   1    <**>  CONFIG_FB_DAFB
   1    <**>  CONFIG_FB_FM2
   1    <**>  CONFIG_FB_G364
   1      1   CONFIG_FB_HP300
   1    <**>  CONFIG_FB_IGA
   1    <**>  CONFIG_FB_IMSTT
   1    <**>  CONFIG_FB_LEO
   1      1   CONFIG_FB_MAC
   1      1   CONFIG_FB_MATROX
   1      1   CONFIG_FB_MATROX_G100
   1      1   CONFIG_FB_MATROX_MILLENIUM
   1      1   CONFIG_FB_MATROX_MULTIHEAD
   1      1   CONFIG_FB_MATROX_MYSTIQUE
   1      1   CONFIG_FB_OF
   2    <**>  CONFIG_FB_PCI
   1      1   CONFIG_FB_PLATINUM
   1    <**>  CONFIG_FB_PM2
   1    <**>  CONFIG_FB_PM2_CVPPC
   1    <**>  CONFIG_FB_PM2_FIFO_DISCONNECT
   1    <**>  CONFIG_FB_PM2_PCI
   1    <**>  CONFIG_FB_Q40
   1      1   CONFIG_FB_RETINAZ3
   1      1   CONFIG_FB_S3TRIO
   1      1   CONFIG_FB_SBUS
   1      1   CONFIG_FB_SGIVW
   1      1   CONFIG_FB_TCX
   1      1   CONFIG_FB_TGA
   2      1   CONFIG_FB_VALKYRIE
   1      1   CONFIG_FB_VESA
   1      1   CONFIG_FB_VGA16
   1      1   CONFIG_FB_VIRGE
   1      1   CONFIG_FB_VIRTUAL

   1      1   CONFIG_FC4
   2      1   CONFIG_FC4_SOC
   2    <**>  CONFIG_FC4_SOCAL

   4      1   CONFIG_FDDI

   1      1   CONFIG_FILTER
   1      1   CONFIG_FIREWALL

   1      1   CONFIG_FMV18X

   3    <**>  CONFIG_FONT_6x11
   3    <**>  CONFIG_FONT_8x16
   3    <**>  CONFIG_FONT_8x8
   3    <**>  CONFIG_FONT_ACORN_8x8
   3    <**>  CONFIG_FONT_PEARL_8x8
   2    <**>  CONFIG_FONT_SUN12x22
   2    <**>  CONFIG_FONT_SUN8x16
   1    <**>  CONFIG_FOOTBRIDGE
   1    <**>  CONFIG_FORWARD_KEYBOARD

   1      1   CONFIG_FPU_EMU
   1      1   CONFIG_FPU_EMU_EXTRAPREC
   1      1   CONFIG_FPU_EMU_ONLY

   1      1   CONFIG_FRAME_POINTER

   1      1   CONFIG_FTAPE
   1      1   CONFIG_FT_ALPHA_CLOCK
   1    <**>  CONFIG_FT_ALT_FDC
   1      1   CONFIG_FT_FDC_BASE
   1      1   CONFIG_FT_FDC_DMA
   1      1   CONFIG_FT_FDC_IRQ
   1      1   CONFIG_FT_FDC_MAX_RATE
   1      1   CONFIG_FT_FDC_THR
   1    <**>  CONFIG_FT_FULL_DEBUG
   1    <**>  CONFIG_FT_MACH2
   1      1   CONFIG_FT_NORMAL_DEBUG
   1    <**>  CONFIG_FT_NO_TRACE
   1    <**>  CONFIG_FT_NO_TRACE_AT_ALL
   1      1   CONFIG_FT_NR_BUFFERS
   1    <**>  CONFIG_FT_PROBE_FC10
   1      1   CONFIG_FT_PROC_FS
   1      1   CONFIG_FT_STD_FDC

   1    <**>  CONFIG_GEMINI

   1      1   CONFIG_GIRBIL_DONGLE

   1      1   CONFIG_GMAC

   1      1   CONFIG_GSCD
 <**>     1   CONFIG_GSP_A2410
 <**>     1   CONFIG_GSP_RESOLVER

   1    <**>  CONFIG_GUS16
   1    <**>  CONFIG_GUS16_BASE
   1    <**>  CONFIG_GUS16_DMA
   1    <**>  CONFIG_GUS16_IRQ
   1    <**>  CONFIG_GUSMAX
   1    <**>  CONFIG_GUS_BASE
   1    <**>  CONFIG_GUS_DMA
   1    <**>  CONFIG_GUS_DMA2
   1    <**>  CONFIG_GUS_IRQ

   1      1   CONFIG_GVP11_SCSI
   2      1   CONFIG_GVPIOEXT
   2    <**>  CONFIG_GVPIOEXT_LP
   2    <**>  CONFIG_GVPIOEXT_PLIP
   1    <**>  CONFIG_GVP_TURBO_SCSI

   1      1   CONFIG_H8

   1      1   CONFIG_HADES
   1    <**>  CONFIG_HAMACHI
   3      1   CONFIG_HAMRADIO
   2    <**>  CONFIG_HAPPYMEAL

   1      1   CONFIG_HDLC

   3    <**>  CONFIG_HEARTBEAT

   1      1   CONFIG_HFMODEM
   1      1   CONFIG_HFMODEM_SBC
   1      1   CONFIG_HFMODEM_WSS
   1      1   CONFIG_HFS_FS

   1      1   CONFIG_HIPPI
   1      1   CONFIG_HISAX_16_0
   1      1   CONFIG_HISAX_16_3
   1      1   CONFIG_HISAX_1TR6
   1      1   CONFIG_HISAX_AMD7930
   1      1   CONFIG_HISAX_ASUSCOM
   1      1   CONFIG_HISAX_AVM_A1
   1      1   CONFIG_HISAX_AVM_A1_PCMCIA
   1      1   CONFIG_HISAX_BKM_A4T
   1      1   CONFIG_HISAX_DIEHLDIVA
   1      1   CONFIG_HISAX_ELSA
   1      1   CONFIG_HISAX_EURO
   1      1   CONFIG_HISAX_FRITZPCI
   1      1   CONFIG_HISAX_GAZEL
   1      1   CONFIG_HISAX_HFCS
   1      1   CONFIG_HISAX_HFC_PCI
   1      1   CONFIG_HISAX_HFC_SX
   1      1   CONFIG_HISAX_HSTSAPHIR
   1      1   CONFIG_HISAX_ISURF
   1      1   CONFIG_HISAX_IX1MICROR2
   1      1   CONFIG_HISAX_MIC
   1      1   CONFIG_HISAX_NETJET
   1      1   CONFIG_HISAX_NICCY
   1      1   CONFIG_HISAX_NO_KEYPAD
   1      1   CONFIG_HISAX_NO_LLC
   1      1   CONFIG_HISAX_NO_SENDCOMPLETE
   1      1   CONFIG_HISAX_S0BOX
   1      1   CONFIG_HISAX_SCT_QUADRO
   1      1   CONFIG_HISAX_SEDLBAUER
   1      1   CONFIG_HISAX_SPORTSTER
   1      1   CONFIG_HISAX_TELEINT
   1      1   CONFIG_HISAX_TELESPCI
   1    <**>  CONFIG_HISAX_TESTEMU
   1      1   CONFIG_HISAX_W6692

   1      1   CONFIG_HOSTESS_SV11
   1      1   CONFIG_HOST_FOOTBRIDGE
   1      1   CONFIG_HOTPLUG

   1      1   CONFIG_HP100
   1      1   CONFIG_HP300
   1      1   CONFIG_HPDCA
   1      1   CONFIG_HPFS_FS
   1      1   CONFIG_HPLAN
   1      1   CONFIG_HPLANCE
   1      1   CONFIG_HPLAN_PLUS

   2      1   CONFIG_HUB6

   1    <**>  CONFIG_HWC
   1    <**>  CONFIG_HWC_CONSOLE

   2      1   CONFIG_HYDRA
   1    <**>  CONFIG_HYPERCOM1

   1      1   CONFIG_I2O
   1      1   CONFIG_I2O_BLOCK
   1      1   CONFIG_I2O_PCI
   1      1   CONFIG_I2O_SCSI

   1      1   CONFIG_IBMLS
   1      1   CONFIG_IBMMCA_SCSI_DEV_RESET
   1      1   CONFIG_IBMMCA_SCSI_ORDER_STANDARD
   1      1   CONFIG_IBMOL
   1      1   CONFIG_IBMTR

   2      1   CONFIG_IDEDMA_AUTO
   1      1   CONFIG_IDE_CHIPSETS

   1    <**>  CONFIG_IEEEFPU_EMULATION

   1      1   CONFIG_INET
   1      1   CONFIG_INET_PCTCP
   1      1   CONFIG_INET_RARP
 <**>     1   CONFIG_INET_SNARL
   1    <**>  CONFIG_INPUT_ADBHID
   1      1   CONFIG_INPUT_EVDEV
   1      1   CONFIG_INPUT_JOYDEV
   1      1   CONFIG_INPUT_KEYBDEV
   1      1   CONFIG_INPUT_MOUSEDEV
   1      1   CONFIG_INPUT_MOUSEDEV_SCREEN_X
   1      1   CONFIG_INPUT_MOUSEDEV_SCREEN_Y
   1    <**>  CONFIG_INTEL_RNG

   1      1   CONFIG_IPDDP
   1      1   CONFIG_IPDDP_DECAP
   1      1   CONFIG_IPDDP_ENCAP
   1    <**>  CONFIG_IPHASE5526
   1    <**>  CONFIG_IPL
 <**>     1   CONFIG_IPLABLE
 <**>     1   CONFIG_IPL_RDR
 <**>     1   CONFIG_IPL_RDR_VM
   1      1   CONFIG_IPL_TAPE
   1    <**>  CONFIG_IPL_VM
   2      1   CONFIG_IPV6
   1      1   CONFIG_IPV6_EUI64
   1    <**>  CONFIG_IPV6_FIREWALL
   1      1   CONFIG_IPV6_NETLINK
   1      1   CONFIG_IPV6_NO_PB
   1      1   CONFIG_IPX
   1      1   CONFIG_IPX_INTERN
   1      1   CONFIG_IP_ADVANCED_ROUTER
   1      1   CONFIG_IP_ALIAS
   1      1   CONFIG_IP_FIREWALL
   1      1   CONFIG_IP_FIREWALL_NETLINK
   1      1   CONFIG_IP_MASQUERADE
   1      1   CONFIG_IP_MASQUERADE_ICMP
   1      1   CONFIG_IP_MASQUERADE_IPAUTOFW
   1      1   CONFIG_IP_MASQUERADE_IPPORTFW
   1      1   CONFIG_IP_MASQUERADE_MFW
   1      1   CONFIG_IP_MASQUERADE_MOD
 <**>     1   CONFIG_IP_MASQUERADE_UDP_LOOSE
   1      1   CONFIG_IP_MROUTE
   1      1   CONFIG_IP_MULTICAST
   1      1   CONFIG_IP_MULTIPLE_TABLES
   1      1   CONFIG_IP_PIMSM_V1
   1      1   CONFIG_IP_PIMSM_V2
   1      1   CONFIG_IP_PNP
   1    <**>  CONFIG_IP_PNP_ARP
   1      1   CONFIG_IP_PNP_BOOTP
   1      1   CONFIG_IP_PNP_DHCP
   1      1   CONFIG_IP_PNP_RARP
   1      1   CONFIG_IP_ROUTER
   1      1   CONFIG_IP_ROUTE_FWMARK
   1      1   CONFIG_IP_ROUTE_LARGE_TABLES
   1      1   CONFIG_IP_ROUTE_MULTIPATH
   1      1   CONFIG_IP_ROUTE_NAT
   1      1   CONFIG_IP_ROUTE_TOS
   1      1   CONFIG_IP_ROUTE_VERBOSE
   1      1   CONFIG_IP_TRANSPARENT_PROXY

   1      1   CONFIG_IRCOMM
   1      1   CONFIG_IRDA
   1    <**>  CONFIG_IRDA_BSD
   1    <**>  CONFIG_IRDA_BZIP2
   1      1   CONFIG_IRDA_CACHE_LAST_LSAP
   1      1   CONFIG_IRDA_COMPRESSION
   1      1   CONFIG_IRDA_DEBUG
   1      1   CONFIG_IRDA_DEFLATE
   1      1   CONFIG_IRDA_FAST_RR
   1    <**>  CONFIG_IRDA_OPTIONS
   1    <**>  CONFIG_IRDA_ULTRA
   1      1   CONFIG_IRLAN
   1      1   CONFIG_IRPORT_SIR
   1      1   CONFIG_IRTTY_SIR

   2    <**>  CONFIG_ISA_DMA
   6      1   CONFIG_ISDN
   1      1   CONFIG_ISDN_AUDIO
   1      1   CONFIG_ISDN_DIVERSION
   1      1   CONFIG_ISDN_DRV_ACT2000
   1      1   CONFIG_ISDN_DRV_AVMB1
   1      1   CONFIG_ISDN_DRV_AVMB1_B1ISA
   1      1   CONFIG_ISDN_DRV_AVMB1_B1PCI
   1      1   CONFIG_ISDN_DRV_AVMB1_B1PCIV4
   1      1   CONFIG_ISDN_DRV_AVMB1_B1PCMCIA
   1      1   CONFIG_ISDN_DRV_AVMB1_C4
   1      1   CONFIG_ISDN_DRV_AVMB1_T1ISA
   1      1   CONFIG_ISDN_DRV_AVMB1_T1PCI
   1      1   CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON
   1      1   CONFIG_ISDN_DRV_EICON
   1      1   CONFIG_ISDN_DRV_EICON_ISA
   1      1   CONFIG_ISDN_DRV_HISAX
   1      1   CONFIG_ISDN_DRV_ICN
   1      1   CONFIG_ISDN_DRV_LOOP
   1      1   CONFIG_ISDN_DRV_PCBIT
   1      1   CONFIG_ISDN_DRV_SC
   1      1   CONFIG_ISDN_MPP
   1      1   CONFIG_ISDN_PPP
   1      1   CONFIG_ISDN_PPP_VJ
   1      1   CONFIG_ISDN_TTY_FAX
   1      1   CONFIG_ISDN_X25
   1      1   CONFIG_ISI
   1      1   CONFIG_ISO9660_FS
   1      1   CONFIG_ISP16_CDI
   1      1   CONFIG_ISTALLION

   1    <**>  CONFIG_IUCV

   1    <**>  CONFIG_JAZZ_ESP

   2      1   CONFIG_JOLIET
   1      1   CONFIG_JOYSTICK
   1      1   CONFIG_JOY_AMIGA
   1      1   CONFIG_JOY_ANALOG
   1      1   CONFIG_JOY_ASSASSIN
   1      1   CONFIG_JOY_CONSOLE
   1      1   CONFIG_JOY_CREATIVE
   1      1   CONFIG_JOY_DB9
   1      1   CONFIG_JOY_GRAVIS
   1      1   CONFIG_JOY_LIGHTNING
   1      1   CONFIG_JOY_LOGITECH
   1      1   CONFIG_JOY_MAGELLAN
   1      1   CONFIG_JOY_PCI
   1      1   CONFIG_JOY_SIDEWINDER
   1      1   CONFIG_JOY_SPACEBALL
   1      1   CONFIG_JOY_SPACEORB
   1      1   CONFIG_JOY_THRUSTMASTER
   1      1   CONFIG_JOY_TURBOGRAFX
   1      1   CONFIG_JOY_WARRIOR

   1    <**>  CONFIG_KBDMOUSE

   1    <**>  CONFIG_KERNEL_ELF
   1    <**>  CONFIG_KEYBOARD

   2    <**>  CONFIG_KGDB

   9      1   CONFIG_KMOD

   1      1   CONFIG_LANCE
   1      1   CONFIG_LANMEDIA
   1      1   CONFIG_LAPB
   1      1   CONFIG_LAPBETHER

   1      1   CONFIG_LEDS
   1      1   CONFIG_LEDS_CPU
   1      1   CONFIG_LEDS_TIMER

   1      1   CONFIG_LITELINK_DONGLE

   1      1   CONFIG_LLC

   1      1   CONFIG_LNE390

   3    <**>  CONFIG_LOCKD
   1      1   CONFIG_LOWLEVEL_SOUND

   1      1   CONFIG_LTPC

   1      1   CONFIG_M386

   1    <**>  CONFIG_M486

   1    <**>  CONFIG_M586
   1    <**>  CONFIG_M586TSC

   1      1   CONFIG_M68020
   1      1   CONFIG_M68030
   1      1   CONFIG_M68040
   1      1   CONFIG_M68060
   1    <**>  CONFIG_M686
   1    <**>  CONFIG_M68K_L2_CACHE
   2    <**>  CONFIG_M68K_PRINTER

   1      1   CONFIG_MAC
   1    <**>  CONFIG_MAC8390
   1    <**>  CONFIG_MAC89x0
   1      1   CONFIG_MACE
   1      1   CONFIG_MACE_AAUI_PORT
   1    <**>  CONFIG_MACH_SPECIFIC
   1      1   CONFIG_MACMACE
   1      1   CONFIG_MACSONIC
   1    <**>  CONFIG_MAC_ADBKEYCODES
   1    <**>  CONFIG_MAC_EMUMOUSEBTN
   1      1   CONFIG_MAC_FLOPPY
   1    <**>  CONFIG_MAC_HID
   1      1   CONFIG_MAC_KEYBOARD
   1      1   CONFIG_MAC_PARTITION
   1      1   CONFIG_MAC_SCC
   1      1   CONFIG_MAC_SCSI
   1      1   CONFIG_MAC_SERIAL
   1    <**>  CONFIG_MAD16_BASE
   1    <**>  CONFIG_MAD16_DMA
   1    <**>  CONFIG_MAD16_DMA2
   1    <**>  CONFIG_MAD16_IRQ
   1    <**>  CONFIG_MAD16_MPU_BASE
   1    <**>  CONFIG_MAD16_MPU_IRQ
   1      1   CONFIG_MAD16_OLDCARD
   9      1   CONFIG_MAGIC_SYSRQ
   2      1   CONFIG_MATHEMU
   1      1   CONFIG_MATH_EMULATION
   1    <**>  CONFIG_MAUI_BASE
   1      1   CONFIG_MAUI_BOOT_FILE
   1      1   CONFIG_MAUI_HAVE_BOOT
   1    <**>  CONFIG_MAUI_IRQ

   1    <**>  CONFIG_MBX

   1      1   CONFIG_MCA
   1      1   CONFIG_MCD
   1      1   CONFIG_MCDX
   1      1   CONFIG_MCD_BASE
   1      1   CONFIG_MCD_IRQ

   1      1   CONFIG_MDA_CONSOLE
   1    <**>  CONFIG_MDISK
   1    <**>  CONFIG_MDISK_SYNC
   2      1   CONFIG_MD_BOOT
   4      1   CONFIG_MD_LINEAR
   4      1   CONFIG_MD_MIRRORING
   4      1   CONFIG_MD_RAID5
   4      1   CONFIG_MD_STRIPED

   1      1   CONFIG_MICROCODE
   1      1   CONFIG_MINIX_FS
   1      1   CONFIG_MIPS_FPE_MODULE
   3    <**>  CONFIG_MIPS_JAZZ
   1    <**>  CONFIG_MIPS_JAZZ_SONIC
   1      1   CONFIG_MIPS_MAGNUM_4000
   1    <**>  CONFIG_MIXCOMWD

   3      1   CONFIG_MKISS

   9      1   CONFIG_MODULES
   9      1   CONFIG_MODVERSIONS
   1    <**>  CONFIG_MOTOROLA_HOTSWAP
   2      1   CONFIG_MOUSE
   1    <**>  CONFIG_MOXA_INTELLIO
   1    <**>  CONFIG_MOXA_SMARTIO

   2    <**>  CONFIG_MPU_BASE
   1    <**>  CONFIG_MPU_IRQ

   1      1   CONFIG_MSDOS_FS
 <**>     1   CONFIG_MSDOS_PARTITION
   2    <**>  CONFIG_MSNDCLAS_HAVE_BOOT
   1      1   CONFIG_MSNDCLAS_INIT_FILE
   1    <**>  CONFIG_MSNDCLAS_IO
   1    <**>  CONFIG_MSNDCLAS_IRQ
   1    <**>  CONFIG_MSNDCLAS_MEM
   1      1   CONFIG_MSNDCLAS_PERM_FILE
   1      1   CONFIG_MSNDPIN_CFG
   1      1   CONFIG_MSNDPIN_DIGITAL
   2    <**>  CONFIG_MSNDPIN_HAVE_BOOT
   1    <**>  CONFIG_MSNDPIN_IDE_IO0
   1    <**>  CONFIG_MSNDPIN_IDE_IO1
   1    <**>  CONFIG_MSNDPIN_IDE_IRQ
   1      1   CONFIG_MSNDPIN_INIT_FILE
   1    <**>  CONFIG_MSNDPIN_IO
   1    <**>  CONFIG_MSNDPIN_IRQ
   1    <**>  CONFIG_MSNDPIN_JOYSTICK_IO
   1    <**>  CONFIG_MSNDPIN_MEM
   1    <**>  CONFIG_MSNDPIN_MPU_IO
   1    <**>  CONFIG_MSNDPIN_MPU_IRQ
   1      1   CONFIG_MSNDPIN_NONPNP
   1      1   CONFIG_MSNDPIN_PERM_FILE
   1      1   CONFIG_MSND_FIFOSIZE
   1    <**>  CONFIG_MSS_BASE
   1    <**>  CONFIG_MSS_DMA
   1    <**>  CONFIG_MSS_DMA2
   1    <**>  CONFIG_MSS_IRQ
   1      1   CONFIG_MS_BUSMOUSE

   1      1   CONFIG_MTRR

   1      1   CONFIG_MULTIFACE_III_LP
   2      1   CONFIG_MULTIFACE_III_TTY

   1    <**>  CONFIG_MVME147
   1    <**>  CONFIG_MVME147_NET
   1    <**>  CONFIG_MVME147_SCC
   1    <**>  CONFIG_MVME147_SCSI
   1      1   CONFIG_MVME162_SCC
   1      1   CONFIG_MVME16x
   1      1   CONFIG_MVME16x_NET
   1      1   CONFIG_MVME16x_SCSI

   2    <**>  CONFIG_MYRI_SBUS

   1      1   CONFIG_N2

   1      1   CONFIG_NCPFS_EXTRAS
   1      1   CONFIG_NCPFS_IOCTL_LOCKING
   1      1   CONFIG_NCPFS_MOUNT_SUBDIR
   1      1   CONFIG_NCPFS_NDS_DOMAINS
   1      1   CONFIG_NCPFS_NFS_NS
   1      1   CONFIG_NCPFS_NLS
   1      1   CONFIG_NCPFS_OS2_NS
   1      1   CONFIG_NCPFS_PACKET_SIGNING
   1      1   CONFIG_NCPFS_SMALLDOS
   1      1   CONFIG_NCPFS_STRONG
   1      1   CONFIG_NCP_FS
   1    <**>  CONFIG_NCR885E

   1      1   CONFIG_NE2000
   2      1   CONFIG_NE2K_PCI
   1      1   CONFIG_NE2_MCA
   1      1   CONFIG_NE3210
   9      1   CONFIG_NET
   1    <**>  CONFIG_NETBEUI
   9      1   CONFIG_NETDEVICES
   3      1   CONFIG_NETLINK
   2      1   CONFIG_NETLINK_DEV
   3      1   CONFIG_NETROM
   1      1   CONFIG_NET_CLS
   1    <**>  CONFIG_NET_CLS_FW
   1    <**>  CONFIG_NET_CLS_POLICE
   1    <**>  CONFIG_NET_CLS_ROUTE
   1    <**>  CONFIG_NET_CLS_ROUTE4
   1    <**>  CONFIG_NET_CLS_RSVP
   1    <**>  CONFIG_NET_CLS_RSVP6
   1    <**>  CONFIG_NET_CLS_U32
   1      1   CONFIG_NET_DIVERT
   1      1   CONFIG_NET_EISA
   1      1   CONFIG_NET_ESTIMATOR
   2      1   CONFIG_NET_ETHERNET
   1      1   CONFIG_NET_FASTROUTE
   1    <**>  CONFIG_NET_FC
   1      1   CONFIG_NET_HW_FLOWCONTROL
   1      1   CONFIG_NET_IPGRE
   1      1   CONFIG_NET_IPGRE_BROADCAST
   1      1   CONFIG_NET_IPIP
   1      1   CONFIG_NET_ISA
   1      1   CONFIG_NET_POCKET
   1      1   CONFIG_NET_PROFILE
   1      1   CONFIG_NET_QOS
   1      1   CONFIG_NET_RADIO
   1      1   CONFIG_NET_SB1000
   1      1   CONFIG_NET_SCHED
   1      1   CONFIG_NET_SCH_CBQ
   1      1   CONFIG_NET_SCH_CSZ
   1    <**>  CONFIG_NET_SCH_HFCS
   1    <**>  CONFIG_NET_SCH_HPFQ
   1      1   CONFIG_NET_SCH_PRIO
   1      1   CONFIG_NET_SCH_RED
   1      1   CONFIG_NET_SCH_SFQ
   1      1   CONFIG_NET_SCH_TBF
   1      1   CONFIG_NET_SCH_TEQL
   1      1   CONFIG_NET_VENDOR_3COM
   1      1   CONFIG_NET_VENDOR_RACAL
   1      1   CONFIG_NET_VENDOR_SMC

   1      1   CONFIG_NFSD
   1    <**>  CONFIG_NFSD_TCP
   1      1   CONFIG_NFSD_V3
   1      1   CONFIG_NFS_FS
   1    <**>  CONFIG_NFS_V3

   1      1   CONFIG_NI5010
   1      1   CONFIG_NI52
   1      1   CONFIG_NI65

   2    <**>  CONFIG_NLS
   1      1   CONFIG_NLS_CODEPAGE_437
   1      1   CONFIG_NLS_CODEPAGE_737
   1      1   CONFIG_NLS_CODEPAGE_775
   1      1   CONFIG_NLS_CODEPAGE_850
   1      1   CONFIG_NLS_CODEPAGE_852
   1      1   CONFIG_NLS_CODEPAGE_855
   1      1   CONFIG_NLS_CODEPAGE_857
   1      1   CONFIG_NLS_CODEPAGE_860
   1      1   CONFIG_NLS_CODEPAGE_861
   1      1   CONFIG_NLS_CODEPAGE_862
   1      1   CONFIG_NLS_CODEPAGE_863
   1      1   CONFIG_NLS_CODEPAGE_864
   1      1   CONFIG_NLS_CODEPAGE_865
   1      1   CONFIG_NLS_CODEPAGE_866
   1      1   CONFIG_NLS_CODEPAGE_869
   1      1   CONFIG_NLS_CODEPAGE_874
   1      1   CONFIG_NLS_CODEPAGE_932
   1      1   CONFIG_NLS_CODEPAGE_936
   1      1   CONFIG_NLS_CODEPAGE_949
   1      1   CONFIG_NLS_CODEPAGE_950
   1      1   CONFIG_NLS_DEFAULT
   1      1   CONFIG_NLS_ISO8859_1
 <**>     1   CONFIG_NLS_ISO8859_10
   1      1   CONFIG_NLS_ISO8859_14
   1      1   CONFIG_NLS_ISO8859_15
   1      1   CONFIG_NLS_ISO8859_2
   1      1   CONFIG_NLS_ISO8859_3
   1      1   CONFIG_NLS_ISO8859_4
   1      1   CONFIG_NLS_ISO8859_5
   1      1   CONFIG_NLS_ISO8859_6
   1      1   CONFIG_NLS_ISO8859_7
   1      1   CONFIG_NLS_ISO8859_8
   1      1   CONFIG_NLS_ISO8859_9
   1      1   CONFIG_NLS_KOI8_R

   1    <**>  CONFIG_NO_KEYBOARD
   1      1   CONFIG_NO_PGT_CACHE

   1      1   CONFIG_NSC_FIR

   1      1   CONFIG_NTFS_FS
   1      1   CONFIG_NTFS_RW

   1    <**>  CONFIG_NUBUS

   2      1   CONFIG_NVRAM

 <**>     1   CONFIG_NWBUTTON
 <**>     1   CONFIG_NWBUTTON_REBOOT
   1      1   CONFIG_NWFPE

   1      1   CONFIG_N_HDLC

   1    <**>  CONFIG_OBP_FLASH

   1    <**>  CONFIG_OKTAGON_SCSI

 <**>     1   CONFIG_OLD_BELKING_DONGLE
   1    <**>  CONFIG_OLD_BELKIN_DONGLE
   1      1   CONFIG_OLIVETTI_M700

   1    <**>  CONFIG_OPL3SA1_BASE
   1    <**>  CONFIG_OPL3SA1_DMA
   1    <**>  CONFIG_OPL3SA1_DMA2
   1    <**>  CONFIG_OPL3SA1_IRQ
   1    <**>  CONFIG_OPL3SA1_MPU_BASE
   1    <**>  CONFIG_OPL3SA1_MPU_IRQ
   1    <**>  CONFIG_OPL3SA2_BASE
   1    <**>  CONFIG_OPL3SA2_CHIPSET
   1    <**>  CONFIG_OPL3SA2_CTRL_BASE
   1    <**>  CONFIG_OPL3SA2_DMA
   1    <**>  CONFIG_OPL3SA2_DMA2
   1    <**>  CONFIG_OPL3SA2_IRQ
   1    <**>  CONFIG_OPL3SA2_MPU_BASE
   1    <**>  CONFIG_OPL3SA2_MPU_IRQ
   1      1   CONFIG_OPTCD

   1      1   CONFIG_PACKET
   1    <**>  CONFIG_PAGESIZE_16
   1      1   CONFIG_PARIDE
   1      1   CONFIG_PARIDE_ATEN
   1      1   CONFIG_PARIDE_BPCK
   1      1   CONFIG_PARIDE_COMM
   1      1   CONFIG_PARIDE_DSTR
   1      1   CONFIG_PARIDE_EPAT
   1      1   CONFIG_PARIDE_EPIA
   1      1   CONFIG_PARIDE_FIT2
   1      1   CONFIG_PARIDE_FIT3
   1      1   CONFIG_PARIDE_FRIQ
   1      1   CONFIG_PARIDE_FRPW
   1      1   CONFIG_PARIDE_KBIC
   1      1   CONFIG_PARIDE_KTTI
   1      1   CONFIG_PARIDE_ON20
   1      1   CONFIG_PARIDE_ON26
   3    <**>  CONFIG_PARIDE_PARPORT
   1      1   CONFIG_PARIDE_PCD
   1      1   CONFIG_PARIDE_PD
   1      1   CONFIG_PARIDE_PF
   1      1   CONFIG_PARIDE_PG
   1      1   CONFIG_PARIDE_PT
   9      1   CONFIG_PARPORT
   1    <**>  CONFIG_PARPORT_1284
   1    <**>  CONFIG_PARPORT_AMIGA
   1    <**>  CONFIG_PARPORT_ARC
   1    <**>  CONFIG_PARPORT_ATARI
   1      1   CONFIG_PARPORT_AX
   1    <**>  CONFIG_PARPORT_LOWLEVEL_MODULE
   1    <**>  CONFIG_PARPORT_MFC3
   5      1   CONFIG_PARPORT_OTHER
   5      1   CONFIG_PARPORT_PC
   1    <**>  CONFIG_PAS_DMA
   1    <**>  CONFIG_PAS_IRQ
   1    <**>  CONFIG_PAS_JOYSTICK
   1      1   CONFIG_PATH_MTU_DISCOVERY

   1      1   CONFIG_PC110_PAD
   1      1   CONFIG_PC300
   1      1   CONFIG_PC300_X25
  22      1   CONFIG_PCI
   1    <**>  CONFIG_PCI_BIOS
   1    <**>  CONFIG_PCI_CONSOLE
   1    <**>  CONFIG_PCI_DIRECT
   1    <**>  CONFIG_PCI_GOANY
   1      1   CONFIG_PCI_GOBIOS
   1    <**>  CONFIG_PCI_GODIRECT
   6      1   CONFIG_PCI_OLD_PROC
   4      1   CONFIG_PCI_OPTIMIZE
   4      1   CONFIG_PCI_QUIRKS
   1      1   CONFIG_PCNET32
   1      1   CONFIG_PCWATCHDOG

   1    <**>  CONFIG_PHONE
   1      1   CONFIG_PHONE_IXJ

   2      1   CONFIG_PLIP

   1      1   CONFIG_PMAC
   1    <**>  CONFIG_PMAC_IDEDMA_AUTO
   1    <**>  CONFIG_PMAC_PBOOK

   1      1   CONFIG_PNP
   1      1   CONFIG_PNP_PARPORT

   1    <**>  CONFIG_POWERMAC

   1    <**>  CONFIG_PPC
   1    <**>  CONFIG_PPC_RTC
   5      1   CONFIG_PPP

   1    <**>  CONFIG_PREP
   3      1   CONFIG_PRINTER
   3      1   CONFIG_PRINTER_READBACK
   1    <**>  CONFIG_PROCESS_DEBUG
   1      1   CONFIG_PROC_DEVICETREE
   1      1   CONFIG_PROC_FS
   2    <**>  CONFIG_PROC_HARDWARE
   1    <**>  CONFIG_PROFILE
   1    <**>  CONFIG_PROFILE_SHIFT
   2    <**>  CONFIG_PROM_CONSOLE

   1      1   CONFIG_PSMOUSE
   1    <**>  CONFIG_PSS_BASE
   1      1   CONFIG_PSS_BOOT_FILE
   1      1   CONFIG_PSS_HAVE_BOOT
   1      1   CONFIG_PSS_MIXER
   1    <**>  CONFIG_PSS_MPU_BASE
   1    <**>  CONFIG_PSS_MPU_IRQ
   1    <**>  CONFIG_PSS_MSS_BASE
   1    <**>  CONFIG_PSS_MSS_DMA
   1    <**>  CONFIG_PSS_MSS_IRQ

   1    <**>  CONFIG_Q40

   1      1   CONFIG_QIC02_DYNCONF
   1      1   CONFIG_QIC02_TAPE

   1    <**>  CONFIG_QNX4FS_FS
   1      1   CONFIG_QNX4FS_RW

   1      1   CONFIG_QUOTA

   1      1   CONFIG_RADIO_AZTECH
   1      1   CONFIG_RADIO_AZTECH_PORT
   1      2   CONFIG_RADIO_CADET
 <**>     1   CONFIG_RADIO_CADET_PORT
   1      1   CONFIG_RADIO_GEMTEK
   1      1   CONFIG_RADIO_GEMTEK_PORT
   1      1   CONFIG_RADIO_MAESTRO
   1      1   CONFIG_RADIO_MIROPCM20
   1      1   CONFIG_RADIO_RTRACK
   1      1   CONFIG_RADIO_RTRACK2
   1      1   CONFIG_RADIO_RTRACK2_PORT
   1      1   CONFIG_RADIO_RTRACK_PORT
   1      1   CONFIG_RADIO_SF16FMI
   1      1   CONFIG_RADIO_SF16FMI_PORT
   1      1   CONFIG_RADIO_TRUST
   1      1   CONFIG_RADIO_TRUST_PORT
   1      1   CONFIG_RADIO_TYPHOON
   1      1   CONFIG_RADIO_TYPHOON_MUTEFREQ
   1      1   CONFIG_RADIO_TYPHOON_PORT
   1      1   CONFIG_RADIO_TYPHOON_PROC_FS
   1      1   CONFIG_RADIO_ZOLTRIX
   1      1   CONFIG_RADIO_ZOLTRIX_PORT

   1      1   CONFIG_RCPCI

   2      1   CONFIG_REMOTE_DEBUG

   1      1   CONFIG_RIO
   1      1   CONFIG_RIO_OLDPCI
   1      1   CONFIG_RISCOM8

   1      1   CONFIG_RMW_INSNS

   1      1   CONFIG_ROADRUNNER
   1      1   CONFIG_ROADRUNNER_LARGE_RINGS
   1      1   CONFIG_ROCKETPORT
   1      1   CONFIG_ROMFS_FS
   1      1   CONFIG_ROOT_NFS
   3      1   CONFIG_ROSE

   1    <**>  CONFIG_RPCMOUSE

   1    <**>  CONFIG_RT6_POLICY
   3      1   CONFIG_RTC
   2      1   CONFIG_RTL8139
   1    <**>  CONFIG_RTL8139TOO
   3      1   CONFIG_RTNETLINK

 <**>     1   CONFIG_S390_PARTITION

   1    <**>  CONFIG_SAB82532

   1      1   CONFIG_SBNI
   1      1   CONFIG_SBPCD
   1      1   CONFIG_SBPCD2
   1    <**>  CONFIG_SBPCD3
   1    <**>  CONFIG_SBPCD4
   3    <**>  CONFIG_SBUS
   3    <**>  CONFIG_SBUSCHAR
   1    <**>  CONFIG_SB_BASE
   1    <**>  CONFIG_SB_DMA
   1    <**>  CONFIG_SB_DMA2
   1    <**>  CONFIG_SB_IRQ
   1    <**>  CONFIG_SB_MPU_BASE
   1    <**>  CONFIG_SB_MPU_IRQ

   1      1   CONFIG_SC6600
   1      1   CONFIG_SC6600_CDROM
   1    <**>  CONFIG_SC6600_CDROMBASE
   1      1   CONFIG_SC6600_JOY
   1      1   CONFIG_SCC
   1      1   CONFIG_SCC_DELAY
   1    <**>  CONFIG_SCC_TRXECHO
   9      1   CONFIG_SCSI
   1      1   CONFIG_SCSI_7000FASST
   1      1   CONFIG_SCSI_ACARD
   1      1   CONFIG_SCSI_ACORNSCSI_3
   1      1   CONFIG_SCSI_ACORNSCSI_SYNC
   1      1   CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
   1      1   CONFIG_SCSI_ADVANSYS
   1      1   CONFIG_SCSI_AHA152X
   1      1   CONFIG_SCSI_AHA1542
   1      1   CONFIG_SCSI_AHA1740
   2      1   CONFIG_SCSI_AIC7XXX
   1      1   CONFIG_SCSI_AM53C974
   1    <**>  CONFIG_SCSI_ARXESCSI
   1      1   CONFIG_SCSI_BUSLOGIC
   5      1   CONFIG_SCSI_CONSTANTS
   1      1   CONFIG_SCSI_CPQFCTS
   1      1   CONFIG_SCSI_CUMANA_1
   1      1   CONFIG_SCSI_CUMANA_2
   1      1   CONFIG_SCSI_DC390T
   1      1   CONFIG_SCSI_DC390T_NOGENSUPP
   2      1   CONFIG_SCSI_DEBUG
   1    <**>  CONFIG_SCSI_DECNCR
   1    <**>  CONFIG_SCSI_DECSII
   1      1   CONFIG_SCSI_DTC3280
   1      1   CONFIG_SCSI_EATA
   1      1   CONFIG_SCSI_EATA_DMA
   1      1   CONFIG_SCSI_EATA_LINKED_COMMANDS
   1      1   CONFIG_SCSI_EATA_MAX_TAGS
   1      1   CONFIG_SCSI_EATA_PIO
   1      1   CONFIG_SCSI_EATA_TAGGED_QUEUE
   1      1   CONFIG_SCSI_ECOSCSI
   1      1   CONFIG_SCSI_EESOXSCSI
   3    <**>  CONFIG_SCSI_FCAL
   1      1   CONFIG_SCSI_FD_MCS
   1      1   CONFIG_SCSI_FUTURE_DOMAIN
   1      1   CONFIG_SCSI_GDTH
   1      1   CONFIG_SCSI_GENERIC_NCR5380
   1      1   CONFIG_SCSI_GENERIC_NCR53C400
   1    <**>  CONFIG_SCSI_G_NCR5380_MEM
   1      1   CONFIG_SCSI_G_NCR5380_PORT
   1      1   CONFIG_SCSI_IBMMCA
   1      1   CONFIG_SCSI_IMM
   1      1   CONFIG_SCSI_IN2000
   1      1   CONFIG_SCSI_INIA100
   1      1   CONFIG_SCSI_INITIO
   1      1   CONFIG_SCSI_IPS
   1      1   CONFIG_SCSI_IZIP_EPP16
   1      1   CONFIG_SCSI_IZIP_SLOW_CTR
   2      1   CONFIG_SCSI_LOGGING
   1      1   CONFIG_SCSI_MAC53C94
   1      1   CONFIG_SCSI_MAC_ESP
   1      1   CONFIG_SCSI_MCA_53C9X
   1      1   CONFIG_SCSI_MEGARAID
   1      1   CONFIG_SCSI_MESH
   1      1   CONFIG_SCSI_MESH_SYNC_RATE
   5      1   CONFIG_SCSI_MULTI_LUN
   1      1   CONFIG_SCSI_NCR53C406A
   1      1   CONFIG_SCSI_NCR53C7xx
   1      1   CONFIG_SCSI_NCR53C7xx_DISCONNECT
   1      1   CONFIG_SCSI_NCR53C7xx_FAST
   1      1   CONFIG_SCSI_NCR53C7xx_sync
   1      1   CONFIG_SCSI_NCR53C8XX
   2      1   CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS
   1      1   CONFIG_SCSI_NCR53C8XX_IOMAPPED
   2      1   CONFIG_SCSI_NCR53C8XX_MAX_TAGS
   2      1   CONFIG_SCSI_NCR53C8XX_NO_DISCONNECT
   1      1   CONFIG_SCSI_NCR53C8XX_PQS_PDS
   1      1   CONFIG_SCSI_NCR53C8XX_PROFILE
   2      1   CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT
   2      1   CONFIG_SCSI_NCR53C8XX_SYNC
   1      1   CONFIG_SCSI_OAK1
   1      1   CONFIG_SCSI_OMIT_FLASHPOINT
   1      1   CONFIG_SCSI_PAS16
   1      1   CONFIG_SCSI_PCI2000
   1      1   CONFIG_SCSI_PCI2220I
   2      1   CONFIG_SCSI_PLUTO
   1      1   CONFIG_SCSI_POWERTECSCSI
   1      1   CONFIG_SCSI_PPA
   1      1   CONFIG_SCSI_PSI240I
   2    <**>  CONFIG_SCSI_QLOGICPTI
   1      1   CONFIG_SCSI_QLOGIC_FAS
   1      1   CONFIG_SCSI_QLOGIC_FC
   2      1   CONFIG_SCSI_QLOGIC_ISP
   1      1   CONFIG_SCSI_SEAGATE
   1    <**>  CONFIG_SCSI_SGIWD93
   1      1   CONFIG_SCSI_SIM710
   2      1   CONFIG_SCSI_SUNESP
   1      1   CONFIG_SCSI_SYM53C416
   2      1   CONFIG_SCSI_SYM53C8XX
   1      1   CONFIG_SCSI_T128
   1      1   CONFIG_SCSI_U14_34F
   1      1   CONFIG_SCSI_U14_34F_LINKED_COMMANDS
   1      1   CONFIG_SCSI_U14_34F_MAX_TAGS
   1      1   CONFIG_SCSI_ULTRASTOR

   1      1   CONFIG_SDLA

   1      1   CONFIG_SEALEVEL_4021
   1      1   CONFIG_SEEQ8005
   7      1   CONFIG_SERIAL
   1      1   CONFIG_SERIAL167
 <**>     1   CONFIG_SERIAL_21285
 <**>     1   CONFIG_SERIAL_21285_CONSOLE
  11      1   CONFIG_SERIAL_CONSOLE
   2      1   CONFIG_SERIAL_DETECT_IRQ
   2      1   CONFIG_SERIAL_EXTENDED
   2      1   CONFIG_SERIAL_MANY_PORTS
   2      1   CONFIG_SERIAL_MULTIPORT
   1      1   CONFIG_SERIAL_NONSTANDARD
   2      1   CONFIG_SERIAL_SHARE_IRQ

   1    <**>  CONFIG_SGALAXY_BASE
   1    <**>  CONFIG_SGALAXY_DMA
   1    <**>  CONFIG_SGALAXY_DMA2
   1    <**>  CONFIG_SGALAXY_IRQ
   1    <**>  CONFIG_SGALAXY_SGBASE
   1    <**>  CONFIG_SGI
   1      1   CONFIG_SGISEEQ
 <**>     1   CONFIG_SGI_DISKLABEL
   1    <**>  CONFIG_SGI_DS1286
 <**>     1   CONFIG_SGI_GRAPHICS
   1    <**>  CONFIG_SGI_NEWPORT_CONSOLE
   1    <**>  CONFIG_SGI_NEWPORT_GFX
   1    <**>  CONFIG_SGI_PARTITION
   1    <**>  CONFIG_SGI_PROM_CONSOLE
   1      1   CONFIG_SGI_SERIAL

   1      1   CONFIG_SHAPER

   1    <**>  CONFIG_SINGLE_MEMORY_CHUNK
   1      1   CONFIG_SIS900

   1      1   CONFIG_SJCD

   2      1   CONFIG_SK98LIN
   1      1   CONFIG_SKB_LARGE
   2      1   CONFIG_SKFP
   1      1   CONFIG_SKMC
   1      1   CONFIG_SKTR
   1      1   CONFIG_SK_G16

   5      1   CONFIG_SLIP
   5      1   CONFIG_SLIP_COMPRESSED
   4      1   CONFIG_SLIP_MODE_SLIP6
   5      1   CONFIG_SLIP_SMART

   1      1   CONFIG_SMB_FS
   1      1   CONFIG_SMB_NLS_DEFAULT
   1      1   CONFIG_SMB_NLS_REMOTE
   2      1   CONFIG_SMC9194
   1    <**>  CONFIG_SMC_IRCC_FIR
   1      1   CONFIG_SMD_DISKLABEL
   6      1   CONFIG_SMP

   1    <**>  CONFIG_SNI_RM200_PCI

 <**>     1   CONFIG_SOFTCURSOR
   1    <**>  CONFIG_SOFTOSS_RATE
   1    <**>  CONFIG_SOFTOSS_VOICES
   4      1   CONFIG_SOFT_WATCHDOG
   1      1   CONFIG_SOLARIS_EMUL
   1      1   CONFIG_SOLARIS_X86_PARTITION
   6      1   CONFIG_SOUND
   1      1   CONFIG_SOUNDMODEM
   1      1   CONFIG_SOUNDMODEM_AFSK1200
   1      1   CONFIG_SOUNDMODEM_AFSK2400_7
   1      1   CONFIG_SOUNDMODEM_AFSK2400_8
   1      1   CONFIG_SOUNDMODEM_AFSK2666
   1      1   CONFIG_SOUNDMODEM_FSK9600
   1      1   CONFIG_SOUNDMODEM_HAPN4800
   1      1   CONFIG_SOUNDMODEM_PSK4800
   1      1   CONFIG_SOUNDMODEM_SBC
   1      1   CONFIG_SOUNDMODEM_WSS
   1      1   CONFIG_SOUND_AD1816
 <**>     1   CONFIG_SOUND_AUDIO
   1    <**>  CONFIG_SOUND_CMPCI
   1    <**>  CONFIG_SOUND_CMPCI_FM
   1    <**>  CONFIG_SOUND_CMPCI_MIDI
   1      1   CONFIG_SOUND_CS4232
   1    <**>  CONFIG_SOUND_CS4281
   1      1   CONFIG_SOUND_DMAP
   1      1   CONFIG_SOUND_EMU10K1
   1      1   CONFIG_SOUND_ES1370
   1      1   CONFIG_SOUND_ES1370_JOYPORT_BOOT
   1      1   CONFIG_SOUND_ES1371
   1      1   CONFIG_SOUND_ES1371_GAMEPORT
   1      1   CONFIG_SOUND_ES1371_JOYPORT_BOOT
   1      1   CONFIG_SOUND_ESSSOLO1
   1      1   CONFIG_SOUND_FUSION
   1      1   CONFIG_SOUND_GUS
 <**>     1   CONFIG_SOUND_GUS16
 <**>     1   CONFIG_SOUND_GUSMAX
   1    <**>  CONFIG_SOUND_ICH
   1      1   CONFIG_SOUND_MAD16
   1      1   CONFIG_SOUND_MAESTRO
   1      1   CONFIG_SOUND_MAUI
 <**>     1   CONFIG_SOUND_MIDI
   1      1   CONFIG_SOUND_MPU401
   1      1   CONFIG_SOUND_MSNDCLAS
   1      1   CONFIG_SOUND_MSNDPIN
   1      1   CONFIG_SOUND_MSS
   1      1   CONFIG_SOUND_NM256
   1      1   CONFIG_SOUND_OPL3SA1
   1      1   CONFIG_SOUND_OPL3SA2
   1      1   CONFIG_SOUND_OSS
   1      1   CONFIG_SOUND_PAS
   1      1   CONFIG_SOUND_PSS
   1      1   CONFIG_SOUND_SB
   1      1   CONFIG_SOUND_SGALAXY
   1    <**>  CONFIG_SOUND_SOFTOSS
   1      1   CONFIG_SOUND_SONICVIBES
   1      1   CONFIG_SOUND_SPRO
   1      1   CONFIG_SOUND_SSCAPE
   1      1   CONFIG_SOUND_TRIDENT
   1      1   CONFIG_SOUND_TRIX
   1      1   CONFIG_SOUND_UART6850
   1      1   CONFIG_SOUND_VIA82CXXX
   1    <**>  CONFIG_SOUND_VIDC
   1    <**>  CONFIG_SOUND_VMIDI
   1      1   CONFIG_SOUND_VWSND
   1      1   CONFIG_SOUND_WAVEARTIST
   1      1   CONFIG_SOUND_WAVEFRONT
   1      1   CONFIG_SOUND_YM3812
   1    <**>  CONFIG_SOUND_YMFPCI
   1    <**>  CONFIG_SOUND_YMPCI

   1    <**>  CONFIG_SPARC32
   1    <**>  CONFIG_SPARC32_COMPAT
   1    <**>  CONFIG_SPARC64
   1    <**>  CONFIG_SPARCAUDIO
   1    <**>  CONFIG_SPARCAUDIO_AMD7930
   1    <**>  CONFIG_SPARCAUDIO_CS4231
   1    <**>  CONFIG_SPARCAUDIO_DBRI
   1    <**>  CONFIG_SPARCAUDIO_DUMMY
   1      1   CONFIG_SPECIALIX
   1      1   CONFIG_SPECIALIX_RTSCTS
   1      1   CONFIG_SPX

   1    <**>  CONFIG_SSCAPE_BASE
   1    <**>  CONFIG_SSCAPE_DMA
   1    <**>  CONFIG_SSCAPE_IRQ
   1    <**>  CONFIG_SSCAPE_MSS_BASE
   1    <**>  CONFIG_SSCAPE_MSS_IRQ

   1      1   CONFIG_STALDRV
   1      1   CONFIG_STALLION
   1    <**>  CONFIG_STRAM_PROC
   1      1   CONFIG_STRAM_SWAP
   1      1   CONFIG_STRIP

   1    <**>  CONFIG_SUN3
   1    <**>  CONFIG_SUN3X
   1    <**>  CONFIG_SUN3X_ESP
   1    <**>  CONFIG_SUN3X_ZS
   1      1   CONFIG_SUN4
   2    <**>  CONFIG_SUNBMAC
   3    <**>  CONFIG_SUNLANCE
   2    <**>  CONFIG_SUNOS_EMUL
   2    <**>  CONFIG_SUNQE
   3    <**>  CONFIG_SUNRPC
 <**>     1   CONFIG_SUN_AUDIO
   1    <**>  CONFIG_SUN_AURORA
   2    <**>  CONFIG_SUN_AUXIO
   1    <**>  CONFIG_SUN_BPP
   2    <**>  CONFIG_SUN_CONSOLE
 <**>     1   CONFIG_SUN_INTEL
   2    <**>  CONFIG_SUN_IO
   3    <**>  CONFIG_SUN_KEYBOARD
 <**>     1   CONFIG_SUN_LANCE
   1      1   CONFIG_SUN_MOSTEK_RTC
   3    <**>  CONFIG_SUN_MOUSE
   2    <**>  CONFIG_SUN_OPENPROMFS
   1      1   CONFIG_SUN_OPENPROMIO
   3    <**>  CONFIG_SUN_SERIAL
   1    <**>  CONFIG_SUN_VIDEOPIX
 <**>     1   CONFIG_SUN_ZS

   1      1   CONFIG_SX

   1      1   CONFIG_SYNCLINK
   1      1   CONFIG_SYNCLINK_SYNCPPP
   1      1   CONFIG_SYN_COOKIES
   9      1   CONFIG_SYSCTL
   9      1   CONFIG_SYSVIPC
   1      1   CONFIG_SYSV_FS

   1    <**>  CONFIG_TC
   1      1   CONFIG_TCP_NAGLE_OFF

   1      1   CONFIG_TEKRAM_DONGLE
   1      1   CONFIG_TEXT_SECTIONS

   1      1   CONFIG_TLAN

   1    <**>  CONFIG_TOSHIBA
   1      1   CONFIG_TOSHIBA_FIR
   1    <**>  CONFIG_TOTALMP

   2      1   CONFIG_TR
   1    <**>  CONFIG_TRIX_BASE
   1      1   CONFIG_TRIX_BOOT_FILE
   1    <**>  CONFIG_TRIX_DMA
   1    <**>  CONFIG_TRIX_DMA2
   1      1   CONFIG_TRIX_HAVE_BOOT
   1    <**>  CONFIG_TRIX_IRQ
   1    <**>  CONFIG_TRIX_MPU_BASE
   1    <**>  CONFIG_TRIX_MPU_IRQ
   1    <**>  CONFIG_TRIX_SB_BASE
   1    <**>  CONFIG_TRIX_SB_DMA
   1    <**>  CONFIG_TRIX_SB_IRQ

   1      1   CONFIG_TT_DMA_EMUL

   1    <**>  CONFIG_U6850_BASE
   1    <**>  CONFIG_U6850_IRQ

   1    <**>  CONFIG_UDP_DELAY_CSUM

   1      1   CONFIG_UFS_FS
   1      1   CONFIG_UFS_FS_WRITE

   1      1   CONFIG_ULTRA
   1      1   CONFIG_ULTRA32
   1      1   CONFIG_ULTRAMCA

   1      1   CONFIG_UMSDOS_FS

   1      1   CONFIG_UNIX
   6      1   CONFIG_UNIX98_PTYS
   6      1   CONFIG_UNIX98_PTY_COUNT
   1      1   CONFIG_UNIXWARE_DISKLABEL

   1      1   CONFIG_USB
   1      1   CONFIG_USB_ACM
   1      1   CONFIG_USB_AUDIO
   2      1   CONFIG_USB_BANDWIDTH
   1      1   CONFIG_USB_BLUETOOTH
   1      1   CONFIG_USB_DABUSB
   1      1   CONFIG_USB_DC2XX
   1      1   CONFIG_USB_DEBUG
   1      1   CONFIG_USB_DEVICEFS
   1      1   CONFIG_USB_DSBR
   1      1   CONFIG_USB_HID
   1      1   CONFIG_USB_IBMCAM
   1      1   CONFIG_USB_KAWETH
   1      1   CONFIG_USB_KBD
   1      1   CONFIG_USB_MDC800
   1      1   CONFIG_USB_MICROTEK
   1      1   CONFIG_USB_MOUSE
   1      1   CONFIG_USB_OHCI
   1      1   CONFIG_USB_OV511
   1      1   CONFIG_USB_PEGASUS
   1      1   CONFIG_USB_PLUSB
   1      1   CONFIG_USB_PRINTER
   1      1   CONFIG_USB_RIO500
   1      1   CONFIG_USB_SCANNER
   1      1   CONFIG_USB_SERIAL
   1    <**>  CONFIG_USB_SERIAL_BELKIN
   1      1   CONFIG_USB_SERIAL_DEBUG
   1      1   CONFIG_USB_SERIAL_DIGI_ACCELEPORT
   1      1   CONFIG_USB_SERIAL_FTDI_SIO
   1      1   CONFIG_USB_SERIAL_GENERIC
   1      1   CONFIG_USB_SERIAL_KEYSPAN
   1      1   CONFIG_USB_SERIAL_KEYSPAN_PDA
   1      1   CONFIG_USB_SERIAL_KEYSPAN_USA18X
   1      1   CONFIG_USB_SERIAL_KEYSPAN_USA19
   1      1   CONFIG_USB_SERIAL_KEYSPAN_USA19W
   1      1   CONFIG_USB_SERIAL_KEYSPAN_USA28
   1      1   CONFIG_USB_SERIAL_KEYSPAN_USA28X
   1      1   CONFIG_USB_SERIAL_OMNINET
   1      1   CONFIG_USB_SERIAL_VISOR
   1      1   CONFIG_USB_SERIAL_WHITEHEAT
   1      1   CONFIG_USB_STORAGE
   1      1   CONFIG_USB_STORAGE_DEBUG
   1      1   CONFIG_USB_UHCI
   1      1   CONFIG_USB_UHCI_ALT
 <**>     1   CONFIG_USB_UHCI_ALT_UNLINK_OPTIMIZE
   1      1   CONFIG_USB_USS720
   1      1   CONFIG_USB_WACOM
   1      1   CONFIG_USB_WMFORCE
   1    <**>  CONFIG_USERIAL

   1      1   CONFIG_VENDOR_SANGOMA

   1      1   CONFIG_VFAT_FS

   5      1   CONFIG_VGA_CONSOLE

   1      1   CONFIG_VIA_RHINE
 <**>     1   CONFIG_VIDC_SOUND
   2      1   CONFIG_VIDEO_BT848
   1    <**>  CONFIG_VIDEO_BUZ
   1      1   CONFIG_VIDEO_BWQCAM
   1      1   CONFIG_VIDEO_CPIA
   1      1   CONFIG_VIDEO_CPIA_PP
 <**>     1   CONFIG_VIDEO_CPIA_PP_DMA
   1    <**>  CONFIG_VIDEO_CPIA_USB
   1      1   CONFIG_VIDEO_CQCAM
   2      1   CONFIG_VIDEO_DEV
   1    <**>  CONFIG_VIDEO_G364
   1    <**>  CONFIG_VIDEO_LML33
   1      1   CONFIG_VIDEO_MSP3400
   1      1   CONFIG_VIDEO_PLANB
   1      1   CONFIG_VIDEO_PMS
   1      1   CONFIG_VIDEO_SAA5249
   2      1   CONFIG_VIDEO_SELECT
   1    <**>  CONFIG_VIDEO_VINO
   1    <**>  CONFIG_VIDEO_ZORAN
   1      1   CONFIG_VISWS

   1      1   CONFIG_VME

   2      1   CONFIG_VORTEX

   5      1   CONFIG_VT
   5      1   CONFIG_VT_CONSOLE

   1      1   CONFIG_WANPIPE_CARDS
   1      1   CONFIG_WANPIPE_CHDLC
   1      1   CONFIG_WANPIPE_FR
   1      1   CONFIG_WANPIPE_PPP
   1      1   CONFIG_WANPIPE_X25
   1      1   CONFIG_WANXL
   1      1   CONFIG_WAN_DRIVERS
   1      1   CONFIG_WAN_ROUTER
   1    <**>  CONFIG_WARPENGINE_SCSI
   2      1   CONFIG_WATCHDOG
   2      1   CONFIG_WATCHDOG_NOWAYOUT
   1    <**>  CONFIG_WAVEARTIST_BASE
   1    <**>  CONFIG_WAVEARTIST_DMA
   1    <**>  CONFIG_WAVEARTIST_DMA2
   1    <**>  CONFIG_WAVEARTIST_IRQ
   1    <**>  CONFIG_WAVEFRONT_BASE
   1    <**>  CONFIG_WAVEFRONT_IRQ
   1      1   CONFIG_WAVELAN

   1      1   CONFIG_WD80x3
   1      1   CONFIG_WDT
   1    <**>  CONFIG_WDTPCI
   1      1   CONFIG_WDT_501
   1      1   CONFIG_WDT_501_FAN

   1    <**>  CONFIG_WHIPPET_SERIAL

   1      1   CONFIG_WINBOND_FIR

   1      1   CONFIG_X25
   1      1   CONFIG_X25_ASY

   1    <**>  CONFIG_X86_BSWAP
   1      1   CONFIG_X86_CPUID
   1    <**>  CONFIG_X86_GOOD_APIC
   1    <**>  CONFIG_X86_INVLPG
   1    <**>  CONFIG_X86_IO_APIC
   2    <**>  CONFIG_X86_LOCAL_APIC
   1      1   CONFIG_X86_MSR
   1    <**>  CONFIG_X86_POPAD_OK
   1    <**>  CONFIG_X86_TSC
   1    <**>  CONFIG_X86_VISWS_APIC
   1    <**>  CONFIG_X86_WP_WORKS_OK

   1    <**>  CONFIG_XMON

   1      1   CONFIG_XPEED

   1      1   CONFIG_YAM

   1      1   CONFIG_YELLOWFIN

   1      1   CONFIG_ZFTAPE
   1    <**>  CONFIG_ZFT_COMPRESSOR
   1      1   CONFIG_ZFT_DFLT_BLK_SZ

   1      1   CONFIG_ZNET

   2      1   CONFIG_ZORRO

   1    <**>  CONFIG_ZS
~~~~~~  ~~~~  ~~~~~~~~

Best wishes from Riley.

---1463746820-994016188-976637138=:21047
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=listvars
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0012121605380.21047@Consulate.UFP.CX>
Content-Description: bash shell script: scripts/listvars
Content-Disposition: attachment; filename=listvars

IyEvYmluL2Jhc2gNCg0KY2QgL3Vzci9zcmMvbGludXgtMi4yLjE4DQoNCmNh
dCBgZmluZCAtbmFtZSAnW0NjXW9uZmlnLmluJ2AJCQlcDQoJfCB0ciAtcyAn
XHQiICcgJ1xuXG5cbicJCQlcDQoJfCBncmVwIF5DT05GSUdfCQkJCVwNCgl8
IHNvcnQJCQkJCVwNCgl8IHVuaXEgLWMJCQkJXA0KCXwgdHIgLXMgJ1x0JyAn
ICcJCQlcDQoJfCBncmVwIC12ICdeJCcJCT4gY29uZmlnLmxpc3QNCg0KY2F0
IERvY3VtZW50YXRpb24vQ29uZmlndXJlLmhlbHAJCVwNCgl8IGdyZXAgXkNP
TkZJR18JCQkJXA0KCXwgc29ydAkJCQkJXA0KCXwgdW5pcSAtYwkJCQlcDQoJ
fCB0ciAtcyAnXHQnICcgJwkJCVwNCgl8IGdyZXAgLXYgJ14kJwkJPiBkb2No
bHAubGlzdA0KDQpjYXQgY29uZmlnLmxpc3QgZG9jaGxwLmxpc3QJCQlcDQoJ
fCByZXYJCQkJCVwNCgl8IGN1dCAtZCAnICcgLWYgMQkJCVwNCgl8IHJldgkJ
CQkJXA0KCXwgc29ydCAtdQkJCQlcDQoJfCBncmVwIC12ICdeJCcJCT4gdmFy
cy5saXN0DQoNCmZ1bmN0aW9uIGdldE4oKSB7DQogICAgbG9jYWwgTj1gZ3Jl
cCAiICQxXCQiIDwgJDIgfCBjdXQgLWQgJyAnIC1mIDJgDQoNCiAgICBlY2hv
ICRbJE4rMF0NCn0NCg0KZWNobw0KcHJpbnRmICdDb25maWcgIEhlbHAgIFZh
cmlhYmxlXG4nDQpwcmludGYgJ35+fn5+fiAgfn5+fiAgfn5+fn5+fn5cbicN
CmV4cG9ydCBYPWBoZWFkIC0xIHZhcnMubGlzdCB8IGN1dCAtYiA4LTlgDQpj
YXQgdmFycy5saXN0IHwgd2hpbGUgcmVhZCBWQVIgOyBkbw0KICAgIFk9YGVj
aG8gIiRWQVIiIHwgY3V0IC1iIDgtOWANCiAgICBpZiBbICIkWCIgIT0gIiRZ
IiBdOyB0aGVuDQoJZWNobw0KICAgIGZpDQogICAgTj1gZ2V0TiAiJFZBUiIg
Y29uZmlnLmxpc3RgDQogICAgUj1gZ2V0TiAiJFZBUiIgZG9jaGxwLmxpc3Rg
DQogICAgcHJpbnRmICclNHUgICAlNHUgICAlc1xuJyAkTiAkUiAkVkFSCVwN
Cgl8IHNlZCAncy8gIDAgLzwqKj4vZycNCiAgICBYPSRZDQpkb25lDQpwcmlu
dGYgJ35+fn5+fiAgfn5+fiAgfn5+fn5+fn5cblxuJw0KDQo=
---1463746820-994016188-976637138=:21047
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cfghelp.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0012121605381.21047@Consulate.UFP.CX>
Content-Description: 2.2.18 Configure.help patch
Content-Disposition: attachment; filename="cfghelp.diff"

LS0tIGxpbnV4LTIuMi4xOC5vbGQvRG9jdW1lbnRhdGlvbi9Db25maWd1cmUu
aGVscAlUdWUgRGVjIDEyIDEyOjU5OjQ1IDIwMDANCisrKyBsaW51eC0yLjIu
MTgvRG9jdW1lbnRhdGlvbi9Db25maWd1cmUuaGVscAlUdWUgRGVjIDEyIDE1
OjQ4OjUwIDIwMDANCkBAIC03NDc1LDEzICs3NDc1LDYgQEANCiAgIGZ0cDov
L21ldGFsYWIudW5jLmVkdS9wdWIvTGludXgvZG9jcy9IT1dUTy9taW5pLiBQ
cm9iYWJseSB0aGUgcXVvdGENCiAgIHN1cHBvcnQgaXMgb25seSB1c2VmdWwg
Zm9yIG11bHRpIHVzZXIgc3lzdGVtcy4gSWYgdW5zdXJlLCBzYXkgTi4NCiAN
Ci1BY29ybidzIEFERlMgZmlsZXN5c3RlbSBzdXBwb3J0IChyZWFkIG9ubHkp
IChFWFBFUklNRU5UQUwpDQotQ09ORklHX0FERlNfRlMNCi0gIFRoZSBBZHZh
bmNlZCBEaXNrIEZpbGUgU3lzdGVtIGlzIHRoZSBmaWxlc3lzdGVtIHVzZWQg
b24gZmxvcHB5IGFuZA0KLSAgaGFyZCBkaXNrcyBieSBBY29ybiBTeXN0ZW1z
LiAgQ3VycmVudGx5IGluIGRldmVsb3BtZW50LCBhcyBhIHJlYWQtDQotICBv
bmx5IGRyaXZlciBmb3IgaGFyZCBkaXNrcy4gIFRoZXNlIHNob3VsZCBiZSB0
aGUgZmlyc3QgcGFydGl0aW9uDQotICAoZWcuIC9kZXYvW3NoXWQ/MSkgb24g
ZWFjaCBvZiB5b3VyIGRyaXZlcy4gIElmIHVuc3VyZSwgc2F5IE4uDQotDQog
U3VwcG9ydCBmb3IgVVNCDQogQ09ORklHX1VTQg0KICAgVW5pdmVyc2FsIFNl
cmlhbCBCdXMgKFVTQikgaXMgYSBzcGVjaWZpY2F0aW9uIGZvciBhIHNlcmlh
bCBidXMNCkBAIC0xMDY5OCwxNyArMTA2OTEsNiBAQA0KICAgdG8gaXQuIEZv
ciBtb3JlIGluZm9ybWF0aW9uIG9uIGhvdyB0byB1c2UgdGhlIGRyaXZlciBw
bGVhc2UgcmVhZA0KICAgRG9jdW1lbnRhdGlvbi9qb3lzdGljay50eHQNCiAN
Ci1BdG9td2lkZSBTZXJpYWwgU3VwcG9ydA0KLUNPTkZJR19BVE9NV0lERV9T
RVJJQUwNCi0gIElmIHlvdSBoYXZlIGFuIEF0b213aWRlIFNlcmlhbCBjYXJk
IGZvciBhbiBBY29ybiBzeXN0ZW0sIHNheSBZIHRvDQotICB0aGlzIG9wdGlv
bi4gVGhlIGRyaXZlciBjYW4gaGFuZGxlIDEsIDIsIG9yIDMgcG9ydCBjYXJk
cy4NCi0gIElmIHVuc3VyZSwgc2F5IE4NCi0NCi1UaGUgU2VyaWFsIFBvcnQg
RHVhbCBTZXJpYWwgUG9ydA0KLUNPTkZJR19EVUFMU1BfU0VSSUFMDQotICBJ
ZiB5b3UgaGF2ZSB0aGUgU2VyaWFsIFBvcnQncyBkdWFsIHNlcmlhbCBjYXJk
IGZvciBhbiBBY29ybiBzeXN0ZW0sDQotICBzYXkgWSB0byB0aGlzIG9wdGlv
bi4gSWYgdW5zdXJlLCBzYXkgTg0KLQ0KIE5ldFdpbmRlciBCdXR0b24NCiBD
T05GSUdfTldCVVRUT04NCiAgIElmIHlvdSBlbmFibGUgdGhpcyBkcml2ZXIg
YW5kIGNyZWF0ZSBhIGNoYXJhY3RlciBkZXZpY2Ugbm9kZQ0KQEAgLTEyNzYz
LDIyICsxMjc0NSw2IEBADQogWk9MVFJJWCBJL08gcG9ydCAoMHgyMGMgb3Ig
MHgzMGMpDQogQ09ORklHX1JBRElPX1pPTFRSSVhfUE9SVA0KICAgRW50ZXIg
dGhlIEkvTyBwb3J0IG9mIHlvdXIgWm9sdHJpeCByYWRpbyBjYXJkLg0KLQ0K
LUFEUyBDYWRldCBBTS9GTSBUdW5lcg0KLUNPTkZJR19SQURJT19DQURFVA0K
LSAgU2F5IFkgaGVyZSBpZiB0aGlzIGlzIHlvdXIgQU0vRk0gcmFkaW8gY2Fy
ZC4NCi0NCi0gIEluIG9yZGVyIHRvIGNvbnRyb2wgeW91ciByYWRpbyBjYXJk
LCB5b3Ugd2lsbCBuZWVkIHRvIHVzZSBwcm9ncmFtcw0KLSAgdGhhdCBhcmUg
Y29tcGF0aWJsZSB3aXRoIHRoZSBWaWRlbyBmb3IgTGludXggQVBJLiBJbmZv
cm1hdGlvbiBvbiANCi0gIHRoaXMgQVBJIGFuZCBwb2ludGVycyB0byAidjRs
IiBwcm9ncmFtcyBtYXkgYmUgZm91bmQgb24gdGhlIFdXVyBhdA0KLSAgaHR0
cDovL3JvYWRydW5uZXIuc3dhbnNlYS51ay5saW51eC5vcmcvdjRsLnNodG1s
OyB0byBicm93c2UgdGhlIFdXVywNCi0gIHlvdSBuZWVkIHRvIGhhdmUgYWNj
ZXNzIHRvIGEgbWFjaGluZSBvbiB0aGUgSW50ZXJuZXQgdGhhdCBoYXMgYSAN
Ci0gIHByb2dyYW0gbGlrZSBseW54IG9yIG5ldHNjYXBlLg0KLQ0KLSAgSWYg
eW91IHdhbnQgdG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSAo
ID0gY29kZSB3aGljaCBjYW4gYmUNCi0gIGluc2VydGVkIGluIGFuZCByZW1v
dmVkIGZyb20gdGhlIHJ1bm5pbmcga2VybmVsIHdoZW5ldmVyIHlvdSB3YW50
KSwNCi0gIHNheSBNIGhlcmUgYW5kIHJlYWQgRG9jdW1lbnRhdGlvbi9tb2R1
bGVzLnR4dC4gVGhlIG1vZHVsZSB3aWxsIGJlDQotICBjYWxsZWQgcmFkaW8t
Y2FkZXQubw0KIA0KIE1pcm8gUENNMjAgUmFkaW8NCiBDT05GSUdfUkFESU9f
TUlST1BDTTIwDQo=
---1463746820-994016188-976637138=:21047--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
