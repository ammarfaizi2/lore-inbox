Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRLLKhC>; Wed, 12 Dec 2001 05:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRLLKgo>; Wed, 12 Dec 2001 05:36:44 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63245 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276424AbRLLKg3>;
	Wed, 12 Dec 2001 05:36:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.9.7 is available 
In-Reply-To: Your message of "Wed, 12 Dec 2001 02:35:56 CDT."
             <20011212023556.A8819@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Dec 2001 21:36:13 +1100
Message-ID: <16992.1008153373@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001 02:35:56 -0500, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Release 1.9.7: Wed Dec 12 02:34:34 EST 2001

Dangling symlink kernel-tree/scripts/tree.py breaks the CML2 install,
rm kernel-tree/scripts/tree.py first.

There are still discrepancies between the output produced by different
forms of make *config.  I am also seeing spurious deduction messages
which may be related or may be a separate problem.

# cd cml2-1.9.7/
# rm kernel-tree/scripts/tree.py
# ./install-cml2 /build/kaos/2.4.16-cml2/
Examining your build environment...
Good. You have Python 2.x installed as 'python2.1' already.
Python looks sane...
Good, your python has curses support linked in.
Good, your python has Tk support linked in.
Compiling file list...
Operating on /build/kaos/2.4.16-cml2...
Installing new files...
Merging in CML2 help texts from Configure.help...
Modifying configuration productions...
You are ready to go, cd to /build/kaos/2.4.16-cml2.
# cd /build/kaos/2.4.16-cml2/
# rm -f .config* config.out* rules.out
# yes '' | make oldconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
/build/kaos/2.4.16-cml2/include
python2 -O scripts/cmlcompile.py rules.cml
Compiling rules, please wait......(15.61 sec) Done.
Using defconfig
python2 -O scripts/cmlconfigure.py -t -DX86 -B 2.4.16 -I config.out  rules.out
Side effects:
ISA=y (deduced from X86)

... oldconfig output skipped

Saving config.out......(0.80 sec) Done.
python2 -O scripts/configtrans.py -h include/linux/autoconf.h -s .config config.out
# cp config.out oldconfig.out
# make menuconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
/build/kaos/2.4.16-cml2/include
python2 -O scripts/cmlconfigure.py -c  -DX86 -B 2.4.16 -i config.out  rules.out
Side effects:
ISA=y (deduced from X86)
Side effects from config.out:
Tristate symbols won't default to M.
SCSI=y (deduced from USB_STORAGE)
BLK_DEV_IDE=y (deduced from BLK_DEV_IDEDISK)
BLK_DEV_IDE=y (deduced from BLK_DEV_IDECD)
PCMCIA=y (deduced from NET_PCMCIA)
NET_ETHERNET=y (deduced from NET_PCMCIA)
UNIX98_PTYS=y (deduced from DEVPTS_FS)

=====

Why are those deduction messages appearing in menuconfig?  I just did
make oldconfig, the config should be stable.  I did not change anything
in menuconfig, just saved it.

=====

# cp config.out menuconfig.out
# diff -u oldconfig.out menuconfig.out
--- oldconfig.out	Wed Dec 12 21:13:26 2001
+++ menuconfig.out	Wed Dec 12 21:13:46 2001
@@ -79,6 +79,7 @@
 CONFIG_MWINCHIP3D=n
 CONFIG_MCYRIXIII=n

+CONFIG_MICROCODE=n
 CONFIG_TOSHIBA=n
 CONFIG_I8K=n
 CONFIG_X86_MSR=n
@@ -92,6 +93,8 @@
 CONFIG_HIGHMEM64G=n

 CONFIG_MTRR=y
+CONFIG_X86_UP_APIC=n
+CONFIG_X86_UP_IOAPIC=n
 CONFIG_MULTIQUAD=n


@@ -144,6 +147,7 @@
 # SCSI disk support
 #
 CONFIG_BLK_DEV_SD=y
+CONFIG_SD_EXTRA_DEVS=40
 CONFIG_CHR_DEV_ST=n
 CONFIG_ST_EXTRA_DEVS=2
 CONFIG_BLK_DEV_SR=n
@@ -389,6 +393,7 @@
 # IDE block devices
 #
 CONFIG_BLK_DEV_IDE=y
+CONFIG_BLK_DEV_HD_ONLY=n

 #
 # IDE options -- see Documentation/ide.txt for help/info

=====

Why is the output after menuconfig WITH NO CHANGES different from
the oldconfig that went into menuconfig?
 
=====

# make menuconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
/build/kaos/2.4.16-cml2/include
python2 -O scripts/cmlconfigure.py -c  -DX86 -B 2.4.16 -i config.out  rules.out
Side effects:
ISA=y (deduced from X86)
Side effects from config.out:
Tristate symbols won't default to M.
SCSI=y (deduced from USB_STORAGE)
BLK_DEV_IDE=y (deduced from BLK_DEV_IDEDISK)
BLK_DEV_IDE=y (deduced from BLK_DEV_IDECD)
PCMCIA=y (deduced from NET_PCMCIA)
NET_ETHERNET=y (deduced from NET_PCMCIA)
UNIX98_PTYS=y (deduced from DEVPTS_FS)

=====

Why are those deductions appearing again?  I checked the input config,
all those options were already set to y.

=====

# make oldconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
/build/kaos/2.4.16-cml2/include
python2 -O scripts/cmlconfigure.py -t -DX86 -B 2.4.16 -I config.out  rules.out
Side effects:
ISA=y (deduced from X86)
Side effects from config.out:
Tristate symbols won't default to M.
SCSI=y (deduced from USB_STORAGE)
BLK_DEV_IDE=y (deduced from BLK_DEV_IDEDISK)
BLK_DEV_IDE=y (deduced from BLK_DEV_IDECD)
PCMCIA=y (deduced from NET_PCMCIA)
NET_ETHERNET=y (deduced from NET_PCMCIA)
UNIX98_PTYS=y (deduced from DEVPTS_FS)

... oldconfig output skipped

Saving config.out......(0.72 sec) Done.
python2 -O scripts/configtrans.py -h include/linux/autoconf.h -s .config config.out
# diff -u config.out menuconfig.out
--- config.out	Wed Dec 12 21:14:35 2001
+++ menuconfig.out	Wed Dec 12 21:13:46 2001
@@ -79,6 +79,7 @@
 CONFIG_MWINCHIP3D=n
 CONFIG_MCYRIXIII=n

+CONFIG_MICROCODE=n
 CONFIG_TOSHIBA=n
 CONFIG_I8K=n
 CONFIG_X86_MSR=n
@@ -92,6 +93,8 @@
 CONFIG_HIGHMEM64G=n

 CONFIG_MTRR=y
+CONFIG_X86_UP_APIC=n
+CONFIG_X86_UP_IOAPIC=n
 CONFIG_MULTIQUAD=n


@@ -144,8 +147,11 @@
 # SCSI disk support
 #
 CONFIG_BLK_DEV_SD=y
+CONFIG_SD_EXTRA_DEVS=40
 CONFIG_CHR_DEV_ST=n
+CONFIG_ST_EXTRA_DEVS=2
 CONFIG_BLK_DEV_SR=n
+CONFIG_SR_EXTRA_DEVS=2
 CONFIG_CHR_DEV_SG=n
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
@@ -178,6 +184,7 @@
 CONFIG_SCSI_DTC3280=n
 CONFIG_SCSI_EATA=n
 CONFIG_SCSI_FUTURE_DOMAIN=n
+CONFIG_SCSI_FD_MCS=n
 CONFIG_SCSI_GDTH=n
 CONFIG_SCSI_GENERIC_NCR5380=n
 CONFIG_SCSI_INITIO=n
@@ -187,6 +194,7 @@
 CONFIG_SCSI_NCR53C406A=n
 CONFIG_SCSI_SYM53C416=n
 CONFIG_SCSI_SIM710=n
+CONFIG_SCSI_NCR_D700=n
 CONFIG_SCSI_NCR53C7xx=n
 CONFIG_SCSI_SYM53C8XX=y
 CONFIG_SCSI_SYM53C8XX_2=n
@@ -197,6 +205,8 @@
 CONFIG_SCSI_NCR53C8XX=n
 CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
 CONFIG_SCSI_NCR53C8XX_SYNC=20
+CONFIG_SCSI_IBMMCA=n
+CONFIG_SCSI_MCA_53C9X=n
 CONFIG_SCSI_PAS16=n
 CONFIG_SCSI_PCI2000=n
 CONFIG_SCSI_PCI2220I=n
@@ -286,6 +296,7 @@
 CONFIG_USB_CDCETHER=n
 CONFIG_USB_USBNET=n
 CONFIG_USB_PEGASUS=n
+CONFIG_USB_USS720=n
 CONFIG_USB_SERIAL=n
 CONFIG_USB_RIO500=n

@@ -323,6 +334,55 @@


 #
+# Memory Technology Device (MTD) support
+#
+CONFIG_MTD_DEBUG=n
+CONFIG_MTD_PARTITIONS=n
+CONFIG_MTD_CHAR=n
+CONFIG_MTD_BLOCK=n
+CONFIG_FTL=n
+CONFIG_MTD_CFI=n
+CONFIG_MTD_JEDECPROBE=n
+CONFIG_MTD_CFI_ADV_OPTIONS=n
+CONFIG_MTD_CFI_INTELEXT=n
+CONFIG_MTD_CFI_AMDSTD=n
+CONFIG_MTD_SHARP=n
+CONFIG_MTD_RAM=n
+CONFIG_MTD_ROM=n
+CONFIG_MTD_JEDEC=n
+CONFIG_MTD_ABSENT=n
+CONFIG_MTD_OBSOLETE_CHIPS=n
+
+#
+# Drivers for chip mappings
+#
+CONFIG_MTD_PHYSMAP=n
+
+CONFIG_MTD_NORA=n
+CONFIG_MTD_PNC2000=n
+CONFIG_MTD_SC520CDP=n
+CONFIG_MTD_NETSC520=n
+CONFIG_MTD_SBC_GXX=n
+CONFIG_MTD_ELAN_104NC=n
+CONFIG_MTD_SA1100=n
+CONFIG_MTD_DC21285=n
+CONFIG_MTD_IQ80310=n
+CONFIG_MTD_CSTM_MIPS_IXX=n
+CONFIG_MTD_L440GX=n
+CONFIG_MTD_OCELOT=n
+CONFIG_MTD_PMC551=n
+CONFIG_MTD_SLRAM=n
+CONFIG_MTD_LART=n
+CONFIG_MTD_MTDRAM=n
+CONFIG_MTD_BLKMTD=n
+CONFIG_MTD_DOC1000=n
+CONFIG_MTD_DOC2000=n
+CONFIG_MTD_DOC2001=n
+CONFIG_MTD_DOCPROBE_ADVANCED=n
+CONFIG_MTD_NAND=n
+
+
+#
 # Block devices
 #
 CONFIG_BLK_DEV_FD=y
@@ -333,6 +393,7 @@
 # IDE block devices
 #
 CONFIG_BLK_DEV_IDE=y
+CONFIG_BLK_DEV_HD_ONLY=n

 #
 # IDE options -- see Documentation/ide.txt for help/info
@@ -391,6 +452,7 @@
 CONFIG_BLK_DEV_Q40IDE=n
 CONFIG_BLK_DEV_MPC8xx_IDE=n

+CONFIG_BLK_DEV_PS2=n
 CONFIG_AMIGA_Z2RAM=n
 CONFIG_ATARI_ACSI=n
 CONFIG_BLK_CPQ_DA=n
@@ -426,11 +488,21 @@
 CONFIG_IP_PNP=n
 CONFIG_NET_IPIP=n
 CONFIG_NET_IPGRE=n
+CONFIG_NET_IPGRE_BROADCAST=n
 CONFIG_IP_MROUTE=n
 CONFIG_ARPD=n
 CONFIG_INET_ECN=n
 CONFIG_SYN_COOKIES=n

+#
+# IP netfilter configuration
+#
+CONFIG_IP_NF_CONNTRACK=n
+CONFIG_IP_NF_QUEUE=n
+CONFIG_IP_NF_IPTABLES=n
+CONFIG_IP_NF_COMPAT_IPCHAINS=n
+
+
 CONFIG_PPP=n
 CONFIG_SLIP=n
 CONFIG_PACKET=y
@@ -464,6 +536,7 @@
 CONFIG_BONDING=n
 CONFIG_TUN=n
 CONFIG_EQUALIZER=n
+CONFIG_ETHERTAP=n
 CONFIG_NET_SB1000=n
 CONFIG_NET_ETHERNET=y

@@ -500,6 +573,9 @@
 CONFIG_AT1700=n
 CONFIG_DEPCA=n
 CONFIG_HP100=n
+CONFIG_SKMC=n
+CONFIG_NE2_MCA=n
+CONFIG_IBMLANA=n
 CONFIG_E2100=n
 CONFIG_EWRK3=n
 CONFIG_EEXPRESS=n
@@ -516,6 +592,7 @@
 CONFIG_AC3200=n
 CONFIG_DE4X5=n
 CONFIG_DGRS=n
+CONFIG_NE3210=n
 CONFIG_ES3210=n
 CONFIG_PCNET32=n
 CONFIG_ADAPTEC_STARFIRE=n
@@ -524,6 +601,7 @@
 CONFIG_DE2104X=n
 CONFIG_TULIP=n
 CONFIG_EEPRO100=y
+CONFIG_LNE390=n
 CONFIG_FEALNX=n
 CONFIG_NATSEMI=n
 CONFIG_NE2K_PCI=n
@@ -573,6 +651,7 @@
 CONFIG_PCMCIA_XIRC2PS=n
 CONFIG_PCMCIA_AXNET=n
 CONFIG_PCMCIA_IBMTR=n
+CONFIG_PCMCIA_XIRTULIP=n
 CONFIG_PCMCIA_XIRCOM=n
 CONFIG_NET_PCMCIA_RADIO=y
 CONFIG_PCMCIA_RAYCS=y
@@ -583,6 +662,23 @@



+#
+# ATM drivers
+#
+CONFIG_ATM_TCP=n
+CONFIG_ATM_LANAI=n
+CONFIG_ATM_ENI=n
+CONFIG_ATM_ZATM=n
+CONFIG_ATM_FIRESTREAM=n
+CONFIG_ATM_NICSTAR=n
+CONFIG_ATM_IDT77252=n
+CONFIG_ATM_AMBASSADOR=n
+CONFIG_ATM_HORIZON=n
+CONFIG_ATM_IA=n
+CONFIG_ATM_FORE200E_MAYBE=n
+CONFIG_PPPOATM=n
+
+

 #
 # Sound, ham radio, and telephony
@@ -609,6 +705,7 @@
 CONFIG_SOUND_TRIDENT=n
 CONFIG_SOUND_MSNDCLAS=n
 CONFIG_SOUND_MSNDPIN=n
+CONFIG_MSND_FIFOSIZE=128
 CONFIG_SOUND_OSS=n
 CONFIG_DMASOUND=n
 CONFIG_SOUND_TVMIXER=n
@@ -636,6 +733,8 @@
 CONFIG_ATOMWIDE_SERIAL=n
 CONFIG_DUALSP_SERIAL=n
 CONFIG_SERIAL_ACPI=n
+CONFIG_SERIAL_EXTENDED=n
+CONFIG_SERIAL_NONSTANDARD=n
 CONFIG_SMC2_UART=n
 CONFIG_USE_SCC_IO=n
 CONFIG_SUN3X_ZS=n
@@ -724,6 +823,7 @@
 # QIC tape support
 #
 CONFIG_QIC02_TAPE=n
+CONFIG_QIC02_DYNCONF=n
 CONFIG_FTAPE=n
 CONFIG_FT_NR_BUFFERS=3
 CONFIG_FT_PROC_FS=n

=====

OUCH!  The output from make menuconfig has significantly more options
than make oldconfig when given exactly the same input.  I thought one
of the selling points for CML2 was different front ends but with
identical back end processing.  I don't like the way that the resulting
config varies when fed to different front ends.

