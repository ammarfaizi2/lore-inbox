Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317330AbSGOF0J>; Mon, 15 Jul 2002 01:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGOF0I>; Mon, 15 Jul 2002 01:26:08 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:37038 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S317330AbSGOFZ5>;
	Mon, 15 Jul 2002 01:25:57 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ed Sweetman <safemode@speakeasy.net>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
References: <1026545050.1203.116.camel@psuedomode>
	<20020713073717.GA9203@wizard.com>
	<1026547292.1224.132.camel@psuedomode>
	<1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 15 Jul 2002 09:28:14 +0200
In-Reply-To: <20020713110619.A28835@ucw.cz>
Message-ID: <m3y9cde9gx.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mentioned this before, but I had major pains with the new input
drivers for keyboards not working with the Comapq Armada M700's, and
gave that up. Now I got a new Compaq N800c, which forced me onto 2.5.x
because of some of the hardware (Intel ICH3 et al).

I also had problems with input compiled in statically, and decided to
go play with modules and a network cables and test and fix
remotely. The end result is that with running RH7.3 and using modules
I get keyboard and mouse to work.

Below is the relevant bit of the .config file and here the mkinitrd
command-line used:

mkinitrd --preload input --preload evdev --preload keybdev --preload \
mousedev --preload serio --preload i8042 --preload atkbd --preload \
psmouse /boot/initrd-2.5.25-dj2-udiv-ide97.img 2.5.25-dj2-udiv-ide97

I used 2.5.25-dj2, and the posted fix on the list for the udiv compile
problem and IDE97.

I might be a bit tired, but there seem to be no proper dependency
between the modules, so that doing a modprobe atkbd doesnt get the
other modules, this the --preloads.

I only have two problems left is that I have a laptop with both a
stick and a glidepad, and the psmouse driver only enables the pad, and
not the stick. The other is that the rpm command segfaults for no
apparent reason under 2.5.x (tried .23, 24., and .25 and -dj varieties
of them). Same also happens with vim, second time it edits a file. 

mvh,
A

PS: Sitting with two laptops on a flight and a cross-over cable tends
to worry the stewardesses on board a lot :)
 
# Input device support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461X is not set
CONFIG_SERIO=m
CONFIG_SERIO_I8042=m
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_PS2SERKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set


Vojtech Pavlik <vojtech@suse.cz> writes:

> Hi!
> 
> Okay, I wrote all these input drivers. So I'd like to see them working.  ;)
> 
> All you should need for proper function of both keyboard and mouse on a
> all-input-driver based system (like -dj kernels, or linux-input BK tree
> are) is:
> 
> CONFIG_INPUT=y
> CONFIG_INPUT_KEYBDEV=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_I8042_REG_BASE=60
> CONFIG_I8042_KBD_IRQ=1
> CONFIG_I8042_AUX_IRQ=12
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> 
> So I guess your problem is not enabling the i8042 module.
> 
> This code will also hopefully be enabled in 2.5.26 (though it'll be optional
> with the old driver still there).
> 
> On Sat, Jul 13, 2002 at 04:45:56AM -0400, Ed Sweetman wrote:
> > Nope, failure.  I'm not getting any reaction from the kernel at all
> > about the keyboard.  I'm including my config 
> > 
> > 
> > On Sat, 2002-07-13 at 04:01, Ed Sweetman wrote:
> > > 2.5.18 is the last time it worked for me I have basically the same exact
> > > config, the new input system seems to have undergone some changes since
> > > then though and now it's not behaving.  I will try setting the XTKBD
> > > setting and PS2SEDKBD or whatever it is.  
> > > 
> > > 
> > > On Sat, 2002-07-13 at 03:37, A Guy Called Tyketto wrote:
> > > > On Sat, Jul 13, 2002 at 03:24:09AM -0400, Ed Sweetman wrote:
> > > > > Same config as in my last post about the issue linking with this
> > > > > kernel.  I'm having my keyboard just not respond from boot.  I've got
> > > > > Input Device support built in and i had it as module and the keyboard is
> > > > > ps/2.  No idea what's going on here 
> > > > > 
> > > > 
> > > >         Just a "me too" here.. I've had this problem since around 2.5.15-dj 
> > > > and later, and have had input and keyboard support compiled into the kernel. 
> > > > Luckily I was able to get into the box via ssh, and check things. both 
> > > > keyboard and mouse are PS/2. If possible, see if you can do this, and check if 
> > > > IRQ 1 is not listed in /proc/interrupts. That is what is happening with me, 
> > > > while my mouse is working. For me to get my keyboard to work, I have to have 
> > > > the following set:
> > > > 
> > > > CONFIG_INPUT=y
> > > > CONFIG_INPUT_KEYBDEV=y
> > > > CONFIG_INPUT_MOUSEDEV=y
> > > > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > > > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > > > CONFIG_INPUT_EVDEV=y
> > > > CONFIG_INPUT_EVBUG=y
> > > > CONFIG_SERIO=y
> > > > CONFIG_SERIO_SERPORT=m
> > > > CONFIG_INPUT_KEYBOARD=y
> > > > CONFIG_KEYBOARD_ATKBD=y
> > > > CONFIG_KEYBOARD_XTKBD=y
> > > > CONFIG_INPUT_MOUSE=y
> > > > CONFIG_MOUSE_PS2=y
> > > > 
> > > >         This leaves me without using the new Input API, but with a working 
> > > > keyboard. with using the new API, mouse will work, keyboard will not. you can 
> > > > try these, and use the old setup (I assume will be made legacy by the time 2.6 
> > > > comes out), and let me know if they work. The new API seems to be working for 
> > > > some people, but not all.
> > > > 
> > > >                                                         BL.
> > > > -- 
> > > > Brad Littlejohn                         | Email:        tyketto@wizard.com
> > > > Unix Systems Administrator,             |           tyketto@ozemail.com.au
> > > > Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
> > > >   PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF
> > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> > #
> > # Automatically generated make config: don't edit
> > #
> > CONFIG_X86=y
> > # CONFIG_SBUS is not set
> > CONFIG_UID16=y
> > 
> > #
> > # Code maturity level options
> > #
> > CONFIG_EXPERIMENTAL=y
> > 
> > #
> > # General setup
> > #
> > CONFIG_NET=y
> > CONFIG_SYSVIPC=y
> > # CONFIG_BSD_PROCESS_ACCT is not set
> > CONFIG_SYSCTL=y
> > 
> > #
> > # Loadable module support
> > #
> > CONFIG_MODULES=y
> > # CONFIG_MODVERSIONS is not set
> > CONFIG_KMOD=y
> > 
> > #
> > # Processor type and features
> > #
> > # CONFIG_M386 is not set
> > # CONFIG_M486 is not set
> > # CONFIG_M586 is not set
> > # CONFIG_M586TSC is not set
> > # CONFIG_M586MMX is not set
> > # CONFIG_M686 is not set
> > # CONFIG_MPENTIUMIII is not set
> > CONFIG_MPENTIUM4=y
> > # CONFIG_MK6 is not set
> > # CONFIG_MK7 is not set
> > # CONFIG_MELAN is not set
> > # CONFIG_MCRUSOE is not set
> > # CONFIG_MWINCHIPC6 is not set
> > # CONFIG_MWINCHIP2 is not set
> > # CONFIG_MWINCHIP3D is not set
> > # CONFIG_MCYRIXIII is not set
> > CONFIG_X86_WP_WORKS_OK=y
> > CONFIG_X86_INVLPG=y
> > CONFIG_X86_CMPXCHG=y
> > CONFIG_X86_XADD=y
> > CONFIG_X86_BSWAP=y
> > CONFIG_X86_POPAD_OK=y
> > # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> > CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> > CONFIG_X86_L1_CACHE_SHIFT=7
> > CONFIG_X86_TSC=y
> > CONFIG_X86_GOOD_APIC=y
> > CONFIG_X86_USE_PPRO_CHECKSUM=y
> > # CONFIG_SMP is not set
> > CONFIG_PREEMPT=y
> > CONFIG_X86_UP_APIC=y
> > CONFIG_X86_UP_IOAPIC=y
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > CONFIG_X86_MCE=y
> > # CONFIG_X86_MCE_NONFATAL is not set
> > CONFIG_X86_MCE_P4THERMAL=y
> > # CONFIG_CPU_FREQ is not set
> > # CONFIG_TOSHIBA is not set
> > # CONFIG_I8K is not set
> > # CONFIG_MICROCODE is not set
> > CONFIG_X86_MSR=m
> > CONFIG_X86_CPUID=m
> > CONFIG_NOHIGHMEM=y
> > # CONFIG_HIGHMEM4G is not set
> > # CONFIG_HIGHMEM64G is not set
> > # CONFIG_MATH_EMULATION is not set
> > CONFIG_MTRR=y
> > CONFIG_HAVE_DEC_LOCK=y
> > 
> > #
> > # Power management options (ACPI, APM)
> > #
> > 
> > #
> > # ACPI Support
> > #
> > # CONFIG_ACPI is not set
> > # CONFIG_PM is not set
> > # CONFIG_APM is not set
> > # CONFIG_SOFTWARE_SUSPEND is not set
> > 
> > #
> > # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> > #
> > CONFIG_PCI=y
> > # CONFIG_PCI_GOBIOS is not set
> > # CONFIG_PCI_GODIRECT is not set
> > CONFIG_PCI_GOANY=y
> > CONFIG_PCI_BIOS=y
> > CONFIG_PCI_DIRECT=y
> > CONFIG_PCI_NAMES=y
> > # CONFIG_ISA is not set
> > # CONFIG_EISA is not set
> > # CONFIG_MCA is not set
> > CONFIG_HOTPLUG=y
> > 
> > #
> > # PCMCIA/CardBus support
> > #
> > # CONFIG_PCMCIA is not set
> > 
> > #
> > # PCI Hotplug Support
> > #
> > # CONFIG_HOTPLUG_PCI is not set
> > # CONFIG_HOTPLUG_PCI_COMPAQ is not set
> > # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> > # CONFIG_HOTPLUG_PCI_IBM is not set
> > 
> > #
> > # Executable file formats
> > #
> > CONFIG_KCORE_ELF=y
> > # CONFIG_KCORE_AOUT is not set
> > CONFIG_BINFMT_AOUT=m
> > CONFIG_BINFMT_ELF=y
> > CONFIG_BINFMT_MISC=m
> > # CONFIG_IKCONFIG is not set
> > 
> > #
> > # Memory Technology Devices (MTD)
> > #
> > # CONFIG_MTD is not set
> > 
> > #
> > # Parallel port support
> > #
> > # CONFIG_PARPORT is not set
> > 
> > #
> > # Plug and Play configuration
> > #
> > # CONFIG_PNP is not set
> > # CONFIG_ISAPNP is not set
> > # CONFIG_PNPBIOS is not set
> > 
> > #
> > # Block devices
> > #
> > CONFIG_BLK_DEV_FD=y
> > # CONFIG_BLK_DEV_XD is not set
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_CPQ_DA is not set
> > # CONFIG_BLK_CPQ_CISS_DA is not set
> > # CONFIG_CISS_SCSI_TAPE is not set
> > # CONFIG_BLK_DEV_DAC960 is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > CONFIG_BLK_DEV_LOOP=m
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_BLK_DEV_INITRD is not set
> > 
> > #
> > # Multi-device support (RAID and LVM)
> > #
> > # CONFIG_MD is not set
> > # CONFIG_BLK_DEV_MD is not set
> > # CONFIG_MD_LINEAR is not set
> > # CONFIG_MD_RAID0 is not set
> > # CONFIG_MD_RAID1 is not set
> > # CONFIG_MD_RAID5 is not set
> > # CONFIG_MD_MULTIPATH is not set
> > # CONFIG_BLK_DEV_LVM is not set
> > 
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=y
> > CONFIG_PACKET_MMAP=y
> > # CONFIG_NETLINK_DEV is not set
> > # CONFIG_NETFILTER is not set
> > # CONFIG_FILTER is not set
> > CONFIG_UNIX=y
> > CONFIG_INET=y
> > # CONFIG_IP_MULTICAST is not set
> > # CONFIG_IP_ADVANCED_ROUTER is not set
> > # CONFIG_IP_PNP is not set
> > # CONFIG_NET_IPIP is not set
> > # CONFIG_NET_IPGRE is not set
> > # CONFIG_ARPD is not set
> > # CONFIG_INET_ECN is not set
> > # CONFIG_SYN_COOKIES is not set
> > # CONFIG_IPV6 is not set
> > # CONFIG_KHTTPD is not set
> > # CONFIG_ATM is not set
> > # CONFIG_VLAN_8021Q is not set
> > 
> > #
> > #  
> > #
> > # CONFIG_IPX is not set
> > # CONFIG_ATALK is not set
> > 
> > #
> > # Appletalk devices
> > #
> > # CONFIG_DEV_APPLETALK is not set
> > # CONFIG_DECNET is not set
> > # CONFIG_BRIDGE is not set
> > # CONFIG_X25 is not set
> > # CONFIG_LAPB is not set
> > # CONFIG_LLC is not set
> > # CONFIG_NET_DIVERT is not set
> > # CONFIG_ECONET is not set
> > # CONFIG_WAN_ROUTER is not set
> > # CONFIG_NET_FASTROUTE is not set
> > # CONFIG_NET_HW_FLOWCONTROL is not set
> > 
> > #
> > # QoS and/or fair queueing
> > #
> > # CONFIG_NET_SCHED is not set
> > 
> > #
> > # Telephony Support
> > #
> > # CONFIG_PHONE is not set
> > # CONFIG_PHONE_IXJ is not set
> > # CONFIG_PHONE_IXJ_PCMCIA is not set
> > 
> > #
> > # ATA/IDE/MFM/RLL support
> > #
> > CONFIG_IDE=y
> > # CONFIG_IDE_24 is not set
> > CONFIG_IDE_25=y
> > 
> > #
> > # ATA and ATAPI Block devices
> > #
> > CONFIG_BLK_DEV_IDE=y
> > 
> > #
> > # Please see Documentation/ide.txt for help/info on IDE drives
> > #
> > # CONFIG_BLK_DEV_HD_IDE is not set
> > # CONFIG_BLK_DEV_HD is not set
> > CONFIG_BLK_DEV_IDEDISK=y
> > CONFIG_IDEDISK_MULTI_MODE=y
> > CONFIG_IDEDISK_STROKE=y
> > # CONFIG_BLK_DEV_IDECS is not set
> > CONFIG_BLK_DEV_IDECD=m
> > # CONFIG_BLK_DEV_IDETAPE is not set
> > # CONFIG_BLK_DEV_IDEFLOPPY is not set
> > CONFIG_BLK_DEV_IDESCSI=m
> > 
> > #
> > # ATA host chip set support
> > #
> > # CONFIG_BLK_DEV_CMD640 is not set
> > # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> > # CONFIG_BLK_DEV_ISAPNP is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > 
> > #
> > #   PCI host chip set support
> > #
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > CONFIG_IDEPCI_SHARE_IRQ=y
> > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > CONFIG_IDEDMA_PCI_AUTO=y
> > # CONFIG_IDEDMA_ONLYDISK is not set
> > CONFIG_BLK_DEV_IDEDMA=y
> > # CONFIG_BLK_DEV_IDE_TCQ is not set
> > # CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
> > # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_AEC6280_BURST is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_WDC_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_CY82C693 is not set
> > # CONFIG_BLK_DEV_CS5530 is not set
> > # CONFIG_BLK_DEV_HPT34X is not set
> > # CONFIG_HPT34X_AUTODMA is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > CONFIG_BLK_DEV_PIIX=y
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_PDC202XX is not set
> > # CONFIG_PDC202XX_BURST is not set
> > # CONFIG_PDC202XX_FORCE is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > # CONFIG_BLK_DEV_SL82C105 is not set
> > # CONFIG_IDE_CHIPSETS is not set
> > # CONFIG_IDEDMA_IVB is not set
> > CONFIG_ATAPI=y
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_BLK_DEV_ATARAID is not set
> > # CONFIG_BLK_DEV_ATARAID_PDC is not set
> > # CONFIG_BLK_DEV_ATARAID_HPT is not set
> > 
> > #
> > # SCSI support
> > #
> > CONFIG_SCSI=m
> > 
> > #
> > # SCSI support type (disk, tape, CD-ROM)
> > #
> > # CONFIG_BROKEN_SCSI_ERROR_HANDLING is not set
> > CONFIG_BLK_DEV_SD=m
> > CONFIG_SD_EXTRA_DEVS=40
> > # CONFIG_CHR_DEV_ST is not set
> > # CONFIG_CHR_DEV_OSST is not set
> > CONFIG_BLK_DEV_SR=m
> > # CONFIG_BLK_DEV_SR_VENDOR is not set
> > CONFIG_SR_EXTRA_DEVS=2
> > CONFIG_CHR_DEV_SG=m
> > # CONFIG_CHR_DEV_SM is not set
> > 
> > #
> > # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> > #
> > CONFIG_SCSI_MULTI_LUN=y
> > CONFIG_SCSI_REPORT_LUNS=y
> > # CONFIG_SCSI_CONSTANTS is not set
> > # CONFIG_SCSI_LOGGING is not set
> > 
> > #
> > # SCSI low-level drivers
> > #
> > # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> > # CONFIG_SCSI_7000FASST is not set
> > # CONFIG_SCSI_ACARD is not set
> > # CONFIG_SCSI_AIC7XXX is not set
> > # CONFIG_SCSI_AIC7XXX_OLD is not set
> > # CONFIG_SCSI_DPT_I2O is not set
> > # CONFIG_SCSI_ADVANSYS is not set
> > # CONFIG_SCSI_IN2000 is not set
> > # CONFIG_SCSI_AM53C974 is not set
> > # CONFIG_SCSI_MEGARAID is not set
> > # CONFIG_SCSI_BUSLOGIC is not set
> > # CONFIG_SCSI_CPQFCTS is not set
> > # CONFIG_SCSI_DMX3191D is not set
> > # CONFIG_SCSI_DTC3280 is not set
> > # CONFIG_SCSI_EATA is not set
> > # CONFIG_SCSI_EATA_DMA is not set
> > # CONFIG_SCSI_EATA_PIO is not set
> > # CONFIG_SCSI_FUTURE_DOMAIN is not set
> > # CONFIG_SCSI_GDTH is not set
> > # CONFIG_SCSI_GENERIC_NCR5380 is not set
> > # CONFIG_SCSI_IPS is not set
> > # CONFIG_SCSI_INITIO is not set
> > # CONFIG_SCSI_INIA100 is not set
> > # CONFIG_SCSI_NCR53C406A is not set
> > # CONFIG_SCSI_NCR53C7xx is not set
> > # CONFIG_SCSI_SYM53C8XX_2 is not set
> > # CONFIG_SCSI_NCR53C8XX is not set
> > # CONFIG_SCSI_SYM53C8XX is not set
> > # CONFIG_SCSI_PAS16 is not set
> > # CONFIG_SCSI_PCI2000 is not set
> > # CONFIG_SCSI_PCI2220I is not set
> > # CONFIG_SCSI_PSI240I is not set
> > # CONFIG_SCSI_QLOGIC_FAS is not set
> > # CONFIG_SCSI_QLOGIC_ISP is not set
> > # CONFIG_SCSI_QLOGIC_FC is not set
> > # CONFIG_SCSI_QLOGIC_1280 is not set
> > # CONFIG_SCSI_SYM53C416 is not set
> > # CONFIG_SCSI_DC390T is not set
> > # CONFIG_SCSI_T128 is not set
> > # CONFIG_SCSI_U14_34F is not set
> > # CONFIG_SCSI_DEBUG is not set
> > 
> > #
> > # Fusion MPT device support
> > #
> > # CONFIG_FUSION is not set
> > # CONFIG_FUSION_BOOT is not set
> > # CONFIG_FUSION_ISENSE is not set
> > # CONFIG_FUSION_CTL is not set
> > # CONFIG_FUSION_LAN is not set
> > 
> > #
> > # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> > #
> > # CONFIG_IEEE1394 is not set
> > 
> > #
> > # I2O device support
> > #
> > # CONFIG_I2O is not set
> > # CONFIG_I2O_PCI is not set
> > # CONFIG_I2O_BLOCK is not set
> > # CONFIG_I2O_LAN is not set
> > # CONFIG_I2O_SCSI is not set
> > # CONFIG_I2O_PROC is not set
> > 
> > #
> > # Network device support
> > #
> > CONFIG_NETDEVICES=y
> > 
> > #
> > # ARCnet devices
> > #
> > # CONFIG_ARCNET is not set
> > CONFIG_DUMMY=m
> > # CONFIG_BONDING is not set
> > # CONFIG_EQUALIZER is not set
> > # CONFIG_TUN is not set
> > # CONFIG_ETHERTAP is not set
> > 
> > #
> > # Ethernet (10 or 100Mbit)
> > #
> > CONFIG_NET_ETHERNET=y
> > # CONFIG_SUNLANCE is not set
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNBMAC is not set
> > # CONFIG_SUNQE is not set
> > # CONFIG_SUNGEM is not set
> > # CONFIG_NET_VENDOR_3COM is not set
> > # CONFIG_LANCE is not set
> > # CONFIG_NET_VENDOR_SMC is not set
> > # CONFIG_NET_VENDOR_RACAL is not set
> > # CONFIG_HP100 is not set
> > # CONFIG_NET_ISA is not set
> > CONFIG_NET_PCI=y
> > # CONFIG_PCNET32 is not set
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > # CONFIG_APRICOT is not set
> > # CONFIG_CS89x0 is not set
> > # CONFIG_DGRS is not set
> > CONFIG_EEPRO100=m
> > CONFIG_E100=m
> > # CONFIG_LNE390 is not set
> > # CONFIG_FEALNX is not set
> > # CONFIG_NATSEMI is not set
> > # CONFIG_NE2K_PCI is not set
> > # CONFIG_NE3210 is not set
> > # CONFIG_ES3210 is not set
> > # CONFIG_8139CP is not set
> > # CONFIG_8139TOO is not set
> > # CONFIG_8139TOO_PIO is not set
> > # CONFIG_8139TOO_TUNE_TWISTER is not set
> > # CONFIG_8139TOO_8129 is not set
> > # CONFIG_8139_NEW_RX_RESET is not set
> > # CONFIG_SIS900 is not set
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SUNDANCE is not set
> > # CONFIG_TLAN is not set
> > # CONFIG_VIA_RHINE is not set
> > # CONFIG_VIA_RHINE_MMIO is not set
> > # CONFIG_NET_POCKET is not set
> > 
> > #
> > # Ethernet (1000 Mbit)
> > #
> > # CONFIG_ACENIC is not set
> > # CONFIG_DL2K is not set
> > # CONFIG_E1000 is not set
> > # CONFIG_MYRI_SBUS is not set
> > # CONFIG_NS83820 is not set
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > # CONFIG_SK98LIN is not set
> > # CONFIG_TIGON3 is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_PLIP is not set
> > # CONFIG_PPP is not set
> > # CONFIG_SLIP is not set
> > 
> > #
> > # Wireless LAN (non-hamradio)
> > #
> > # CONFIG_NET_RADIO is not set
> > 
> > #
> > # Token Ring devices
> > #
> > # CONFIG_TR is not set
> > # CONFIG_NET_FC is not set
> > # CONFIG_RCPCI is not set
> > # CONFIG_SHAPER is not set
> > 
> > #
> > # Wan interfaces
> > #
> > # CONFIG_WAN is not set
> > 
> > #
> > # Tulip family network device support
> > #
> > # CONFIG_NET_TULIP is not set
> > 
> > #
> > # Amateur Radio support
> > #
> > # CONFIG_HAMRADIO is not set
> > 
> > #
> > # IrDA (infrared) support
> > #
> > # CONFIG_IRDA is not set
> > 
> > #
> > # ISDN subsystem
> > #
> > # CONFIG_ISDN_BOOL is not set
> > 
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> > 
> > #
> > # Userland interfaces
> > #
> > CONFIG_INPUT_KEYBDEV=y
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > # CONFIG_INPUT_JOYDEV is not set
> > # CONFIG_INPUT_TSDEV is not set
> > CONFIG_INPUT_EVDEV=y
> > # CONFIG_INPUT_EVBUG is not set
> > 
> > #
> > # Input I/O drivers
> > #
> > # CONFIG_GAMEPORT is not set
> > CONFIG_SOUND_GAMEPORT=y
> > # CONFIG_GAMEPORT_NS558 is not set
> > # CONFIG_GAMEPORT_L4 is not set
> > # CONFIG_GAMEPORT_EMU10K1 is not set
> > # CONFIG_GAMEPORT_VORTEX is not set
> > # CONFIG_GAMEPORT_FM801 is not set
> > # CONFIG_GAMEPORT_CS461X is not set
> > CONFIG_SERIO=y
> > # CONFIG_SERIO_I8042 is not set
> > CONFIG_I8042_REG_BASE=60
> > CONFIG_I8042_KBD_IRQ=1
> > CONFIG_I8042_AUX_IRQ=12
> > # CONFIG_SERIO_SERPORT is not set
> > # CONFIG_SERIO_CT82C710 is not set
> > # CONFIG_SERIO_PARKBD is not set
> > 
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_KEYBOARD_ATKBD=y
> > # CONFIG_KEYBOARD_SUNKBD is not set
> > # CONFIG_KEYBOARD_PS2SERKBD is not set
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_INPUT_MOUSE is not set
> > # CONFIG_MOUSE_PS2 is not set
> > # CONFIG_MOUSE_SERIAL is not set
> > # CONFIG_MOUSE_INPORT is not set
> > # CONFIG_MOUSE_LOGIBM is not set
> > # CONFIG_MOUSE_PC110PAD is not set
> > # CONFIG_INPUT_JOYSTICK is not set
> > # CONFIG_JOYSTICK_ANALOG is not set
> > # CONFIG_JOYSTICK_A3D is not set
> > # CONFIG_JOYSTICK_ADI is not set
> > # CONFIG_JOYSTICK_COBRA is not set
> > # CONFIG_JOYSTICK_GF2K is not set
> > # CONFIG_JOYSTICK_GRIP is not set
> > # CONFIG_JOYSTICK_GUILLEMOT is not set
> > # CONFIG_JOYSTICK_INTERACT is not set
> > # CONFIG_JOYSTICK_SIDEWINDER is not set
> > # CONFIG_JOYSTICK_TMDC is not set
> > # CONFIG_JOYSTICK_IFORCE_USB is not set
> > # CONFIG_JOYSTICK_IFORCE_232 is not set
> > # CONFIG_JOYSTICK_WARRIOR is not set
> > # CONFIG_JOYSTICK_MAGELLAN is not set
> > # CONFIG_JOYSTICK_SPACEORB is not set
> > # CONFIG_JOYSTICK_SPACEBALL is not set
> > # CONFIG_JOYSTICK_STINGER is not set
> > # CONFIG_JOYSTICK_TWIDDLER is not set
> > # CONFIG_JOYSTICK_DB9 is not set
> > # CONFIG_JOYSTICK_GAMECON is not set
> > # CONFIG_JOYSTICK_TURBOGRAFX is not set
> > # CONFIG_INPUT_TOUCHSCREEN is not set
> > # CONFIG_TOUCHSCREEN_GUNZE is not set
> > 
> > #
> > # Character devices
> > #
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_SERIAL=y
> > # CONFIG_SERIAL_CONSOLE is not set
> > # CONFIG_SERIAL_EXTENDED is not set
> > # CONFIG_SERIAL_NONSTANDARD is not set
> > CONFIG_UNIX98_PTYS=y
> > CONFIG_UNIX98_PTY_COUNT=256
> > 
> > #
> > # I2C support
> > #
> > CONFIG_I2C=m
> > CONFIG_I2C_ALGOBIT=m
> > # CONFIG_I2C_PHILIPSPAR is not set
> > # CONFIG_I2C_ELV is not set
> > # CONFIG_I2C_VELLEMAN is not set
> > # CONFIG_I2C_ALGOPCF is not set
> > CONFIG_I2C_CHARDEV=m
> > CONFIG_I2C_PROC=m
> > # CONFIG_QIC02_TAPE is not set
> > 
> > #
> > # Watchdog Cards
> > #
> > # CONFIG_WATCHDOG is not set
> > # CONFIG_AMD_RNG is not set
> > CONFIG_INTEL_RNG=y
> > # CONFIG_NVRAM is not set
> > CONFIG_RTC=y
> > # CONFIG_DTLK is not set
> > # CONFIG_R3964 is not set
> > # CONFIG_APPLICOM is not set
> > # CONFIG_SONYPI is not set
> > 
> > #
> > # Ftape, the floppy tape device driver
> > #
> > # CONFIG_FTAPE is not set
> > CONFIG_AGP=y
> > CONFIG_AGP_INTEL=y
> > # CONFIG_AGP_I810 is not set
> > # CONFIG_AGP_VIA is not set
> > # CONFIG_AGP_AMD is not set
> > # CONFIG_AGP_SIS is not set
> > # CONFIG_AGP_ALI is not set
> > # CONFIG_AGP_SWORKS is not set
> > CONFIG_DRM=y
> > # CONFIG_DRM_TDFX is not set
> > # CONFIG_DRM_GAMMA is not set
> > # CONFIG_DRM_R128 is not set
> > # CONFIG_DRM_RADEON is not set
> > # CONFIG_DRM_I810 is not set
> > # CONFIG_DRM_I830 is not set
> > # CONFIG_DRM_MGA is not set
> > # CONFIG_DRM_SIS is not set
> > # CONFIG_MWAVE is not set
> > 
> > #
> > # Multimedia devices
> > #
> > # CONFIG_VIDEO_DEV is not set
> > 
> > #
> > # File systems
> > #
> > # CONFIG_QUOTA is not set
> > # CONFIG_QFMT_V1 is not set
> > # CONFIG_QFMT_V2 is not set
> > # CONFIG_AUTOFS_FS is not set
> > CONFIG_AUTOFS4_FS=y
> > # CONFIG_REISERFS_FS is not set
> > # CONFIG_REISERFS_CHECK is not set
> > # CONFIG_REISERFS_PROC_INFO is not set
> > # CONFIG_ADFS_FS is not set
> > # CONFIG_ADFS_FS_RW is not set
> > # CONFIG_AFFS_FS is not set
> > # CONFIG_HFS_FS is not set
> > # CONFIG_BFS_FS is not set
> > CONFIG_EXT3_FS=y
> > CONFIG_JBD=y
> > # CONFIG_JBD_DEBUG is not set
> > CONFIG_FAT_FS=m
> > CONFIG_MSDOS_FS=m
> > # CONFIG_UMSDOS_FS is not set
> > CONFIG_VFAT_FS=m
> > # CONFIG_EFS_FS is not set
> > # CONFIG_JFFS_FS is not set
> > # CONFIG_JFFS2_FS is not set
> > # CONFIG_CRAMFS is not set
> > # CONFIG_TMPFS is not set
> > CONFIG_RAMFS=y
> > CONFIG_ISO9660_FS=m
> > CONFIG_JOLIET=y
> > # CONFIG_ZISOFS is not set
> > # CONFIG_JFS_FS is not set
> > # CONFIG_JFS_DEBUG is not set
> > # CONFIG_JFS_STATISTICS is not set
> > # CONFIG_MINIX_FS is not set
> > # CONFIG_VXFS_FS is not set
> > # CONFIG_NTFS_FS is not set
> > # CONFIG_NTFS_DEBUG is not set
> > # CONFIG_HPFS_FS is not set
> > CONFIG_PROC_FS=y
> > CONFIG_DEVFS_FS=y
> > CONFIG_DEVFS_MOUNT=y
> > # CONFIG_DEVFS_DEBUG is not set
> > # CONFIG_DEVPTS_FS is not set
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_QNX4FS_RW is not set
> > # CONFIG_ROMFS_FS is not set
> > CONFIG_EXT2_FS=m
> > # CONFIG_SYSV_FS is not set
> > # CONFIG_UDF_FS is not set
> > # CONFIG_UDF_RW is not set
> > # CONFIG_UFS_FS is not set
> > # CONFIG_UFS_FS_WRITE is not set
> > 
> > #
> > # Network File Systems
> > #
> > # CONFIG_CODA_FS is not set
> > # CONFIG_INTERMEZZO_FS is not set
> > # CONFIG_NFS_FS is not set
> > # CONFIG_NFS_V3 is not set
> > # CONFIG_ROOT_NFS is not set
> > # CONFIG_NFSD is not set
> > # CONFIG_NFSD_V3 is not set
> > # CONFIG_NFSD_TCP is not set
> > # CONFIG_SUNRPC is not set
> > # CONFIG_LOCKD is not set
> > # CONFIG_EXPORTFS is not set
> > CONFIG_SMB_FS=y
> > # CONFIG_SMB_NLS_DEFAULT is not set
> > # CONFIG_NCP_FS is not set
> > # CONFIG_NCPFS_PACKET_SIGNING is not set
> > # CONFIG_NCPFS_IOCTL_LOCKING is not set
> > # CONFIG_NCPFS_STRONG is not set
> > # CONFIG_NCPFS_NFS_NS is not set
> > # CONFIG_NCPFS_OS2_NS is not set
> > # CONFIG_NCPFS_SMALLDOS is not set
> > # CONFIG_NCPFS_NLS is not set
> > # CONFIG_NCPFS_EXTRAS is not set
> > # CONFIG_ZISOFS_FS is not set
> > 
> > #
> > # Partition Types
> > #
> > # CONFIG_PARTITION_ADVANCED is not set
> > CONFIG_MSDOS_PARTITION=y
> > CONFIG_SMB_NLS=y
> > CONFIG_NLS=y
> > 
> > #
> > # Native Language Support
> > #
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=y
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > # CONFIG_NLS_CODEPAGE_850 is not set
> > # CONFIG_NLS_CODEPAGE_852 is not set
> > # CONFIG_NLS_CODEPAGE_855 is not set
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > # CONFIG_NLS_CODEPAGE_860 is not set
> > # CONFIG_NLS_CODEPAGE_861 is not set
> > # CONFIG_NLS_CODEPAGE_862 is not set
> > # CONFIG_NLS_CODEPAGE_863 is not set
> > # CONFIG_NLS_CODEPAGE_864 is not set
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > # CONFIG_NLS_CODEPAGE_866 is not set
> > # CONFIG_NLS_CODEPAGE_869 is not set
> > # CONFIG_NLS_CODEPAGE_936 is not set
> > # CONFIG_NLS_CODEPAGE_950 is not set
> > # CONFIG_NLS_CODEPAGE_932 is not set
> > # CONFIG_NLS_CODEPAGE_949 is not set
> > # CONFIG_NLS_CODEPAGE_874 is not set
> > # CONFIG_NLS_ISO8859_8 is not set
> > # CONFIG_NLS_CODEPAGE_1250 is not set
> > # CONFIG_NLS_CODEPAGE_1251 is not set
> > CONFIG_NLS_ISO8859_1=y
> > # CONFIG_NLS_ISO8859_2 is not set
> > # CONFIG_NLS_ISO8859_3 is not set
> > # CONFIG_NLS_ISO8859_4 is not set
> > # CONFIG_NLS_ISO8859_5 is not set
> > # CONFIG_NLS_ISO8859_6 is not set
> > # CONFIG_NLS_ISO8859_7 is not set
> > # CONFIG_NLS_ISO8859_9 is not set
> > # CONFIG_NLS_ISO8859_13 is not set
> > # CONFIG_NLS_ISO8859_14 is not set
> > # CONFIG_NLS_ISO8859_15 is not set
> > # CONFIG_NLS_KOI8_R is not set
> > # CONFIG_NLS_KOI8_U is not set
> > # CONFIG_NLS_UTF8 is not set
> > 
> > #
> > # Console drivers
> > #
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_VIDEO_SELECT=y
> > # CONFIG_MDA_CONSOLE is not set
> > 
> > #
> > # Frame-buffer support
> > #
> > # CONFIG_FB is not set
> > 
> > #
> > # Sound
> > #
> > CONFIG_SOUND=m
> > 
> > #
> > # Open Sound System
> > #
> > # CONFIG_SOUND_PRIME is not set
> > 
> > #
> > # Advanced Linux Sound Architecture
> > #
> > CONFIG_SND=m
> > # CONFIG_SND_SEQUENCER is not set
> > CONFIG_SND_OSSEMUL=y
> > CONFIG_SND_MIXER_OSS=m
> > CONFIG_SND_PCM_OSS=m
> > # CONFIG_SND_SEQUENCER_OSS is not set
> > CONFIG_SND_RTCTIMER=m
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > # CONFIG_SND_DEBUG is not set
> > # CONFIG_SND_DEBUG_MEMORY is not set
> > # CONFIG_SND_DEBUG_DETECT is not set
> > 
> > #
> > # Generic devices
> > #
> > # CONFIG_SND_DUMMY is not set
> > # CONFIG_SND_VIRMIDI is not set
> > # CONFIG_SND_MTPAV is not set
> > # CONFIG_SND_SERIAL_U16550 is not set
> > # CONFIG_SND_MPU401 is not set
> > 
> > #
> > # PCI devices
> > #
> > # CONFIG_SND_ALI5451 is not set
> > # CONFIG_SND_CS46XX is not set
> > CONFIG_SND_EMU10K1=m
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_TRIDENT is not set
> > # CONFIG_SND_YMFPCI is not set
> > # CONFIG_SND_ALS4000 is not set
> > # CONFIG_SND_CMIPCI is not set
> > # CONFIG_SND_ENS1370 is not set
> > # CONFIG_SND_ENS1371 is not set
> > # CONFIG_SND_ES1938 is not set
> > # CONFIG_SND_ES1968 is not set
> > # CONFIG_SND_MAESTRO3 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_ICE1712 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_SONICVIBES is not set
> > # CONFIG_SND_VIA686 is not set
> > # CONFIG_SND_VIA8233 is not set
> > 
> > #
> > # USB support
> > #
> > CONFIG_USB=m
> > # CONFIG_USB_DEBUG is not set
> > 
> > #
> > # Miscellaneous USB options
> > #
> > CONFIG_USB_DEVICEFS=y
> > CONFIG_USB_LONG_TIMEOUT=y
> > # CONFIG_USB_BANDWIDTH is not set
> > # CONFIG_USB_DYNAMIC_MINORS is not set
> > 
> > #
> > # USB Host Controller Drivers
> > #
> > # CONFIG_USB_EHCI_HCD is not set
> > # CONFIG_USB_OHCI_HCD is not set
> > CONFIG_USB_UHCI_HCD_ALT=m
> > 
> > #
> > # USB Device Class drivers
> > #
> > # CONFIG_USB_AUDIO is not set
> > # CONFIG_USB_BLUETOOTH_TTY is not set
> > # CONFIG_USB_MIDI is not set
> > # CONFIG_USB_ACM is not set
> > # CONFIG_USB_PRINTER is not set
> > CONFIG_USB_STORAGE=m
> > # CONFIG_USB_STORAGE_DEBUG is not set
> > # CONFIG_USB_STORAGE_DATAFAB is not set
> > # CONFIG_USB_STORAGE_FREECOM is not set
> > # CONFIG_USB_STORAGE_ISD200 is not set
> > # CONFIG_USB_STORAGE_DPCM is not set
> > # CONFIG_USB_STORAGE_HP8200e is not set
> > # CONFIG_USB_STORAGE_SDDR09 is not set
> > # CONFIG_USB_STORAGE_SDDR55 is not set
> > # CONFIG_USB_STORAGE_JUMPSHOT is not set
> > 
> > #
> > # USB Human Interface Devices (HID)
> > #
> > CONFIG_USB_HID=m
> > CONFIG_USB_HIDINPUT=y
> > # CONFIG_USB_HIDDEV is not set
> > # CONFIG_USB_KBD is not set
> > # CONFIG_USB_MOUSE is not set
> > # CONFIG_USB_AIPTEK is not set
> > # CONFIG_USB_WACOM is not set
> > 
> > #
> > # USB Imaging devices
> > #
> > # CONFIG_USB_MDC800 is not set
> > # CONFIG_USB_SCANNER is not set
> > # CONFIG_USB_MICROTEK is not set
> > # CONFIG_USB_HPUSBSCSI is not set
> > 
> > #
> > # USB Multimedia devices
> > #
> > # CONFIG_USB_DABUSB is not set
> > 
> > #
> > #   Video4Linux support is needed for USB Multimedia device support
> > #
> > # CONFIG_USB_VICAM is not set
> > # CONFIG_USB_DSBR is not set
> > # CONFIG_USB_IBMCAM is not set
> > # CONFIG_USB_KONICAWC is not set
> > # CONFIG_USB_OV511 is not set
> > # CONFIG_USB_PWC is not set
> > # CONFIG_USB_SE401 is not set
> > # CONFIG_USB_STV680 is not set
> > 
> > #
> > # USB Network adaptors
> > #
> > # CONFIG_USB_CATC is not set
> > # CONFIG_USB_CDCETHER is not set
> > # CONFIG_USB_KAWETH is not set
> > # CONFIG_USB_PEGASUS is not set
> > # CONFIG_USB_RTL8150 is not set
> > # CONFIG_USB_USBNET is not set
> > 
> > #
> > # USB port drivers
> > #
> > # CONFIG_USB_USS720 is not set
> > 
> > #
> > # USB Serial Converter support
> > #
> > # CONFIG_USB_SERIAL is not set
> > # CONFIG_USB_SERIAL_GENERIC is not set
> > # CONFIG_USB_SERIAL_BELKIN is not set
> > # CONFIG_USB_SERIAL_WHITEHEAT is not set
> > # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> > # CONFIG_USB_SERIAL_EMPEG is not set
> > # CONFIG_USB_SERIAL_FTDI_SIO is not set
> > # CONFIG_USB_SERIAL_VISOR is not set
> > # CONFIG_USB_SERIAL_IPAQ is not set
> > # CONFIG_USB_SERIAL_IR is not set
> > # CONFIG_USB_SERIAL_EDGEPORT is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> > # CONFIG_USB_SERIAL_KEYSPAN is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
> > # CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
> > # CONFIG_USB_SERIAL_KLSI is not set
> > # CONFIG_USB_SERIAL_MCT_U232 is not set
> > # CONFIG_USB_SERIAL_PL2303 is not set
> > # CONFIG_USB_SERIAL_SAFE is not set
> > # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> > # CONFIG_USB_SERIAL_CYBERJACK is not set
> > # CONFIG_USB_SERIAL_XIRCOM is not set
> > # CONFIG_USB_SERIAL_OMNINET is not set
> > 
> > #
> > # USB Miscellaneous drivers
> > #
> > # CONFIG_USB_EMI26 is not set
> > # CONFIG_USB_TIGL is not set
> > # CONFIG_USB_AUERSWALD is not set
> > # CONFIG_USB_RIO500 is not set
> > # CONFIG_USB_BRLVGER is not set
> > 
> > #
> > # Bluetooth support
> > #
> > # CONFIG_BLUEZ is not set
> > 
> > #
> > # Kernel hacking
> > #
> > CONFIG_DEBUG_KERNEL=y
> > # CONFIG_DEBUG_OBSOLETE is not set
> > # CONFIG_DEBUG_SLAB is not set
> > # CONFIG_DEBUG_IOVIRT is not set
> > CONFIG_MAGIC_SYSRQ=y
> > # CONFIG_DEBUG_SPINLOCK is not set
> > # CONFIG_DEBUG_486_STRING is not set
> > # CONFIG_FRAME_POINTER is not set
> > 
> > #
> > # Library routines
> > #
> > CONFIG_CRC32=y
> > # CONFIG_ZLIB_INFLATE is not set
> > # CONFIG_ZLIB_DEFLATE is not set
> 
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
