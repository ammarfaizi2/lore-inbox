Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271957AbRIIMjg>; Sun, 9 Sep 2001 08:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271956AbRIIMj1>; Sun, 9 Sep 2001 08:39:27 -0400
Received: from krs-dhcp336.studby.uio.no ([129.240.107.113]:52900 "EHLO
	ilm.nlc.no") by vger.kernel.org with ESMTP id <S271953AbRIIMjN>;
	Sun, 9 Sep 2001 08:39:13 -0400
Date: Sun, 9 Sep 2001 14:39:32 +0200
To: linux-kernel@vger.kernel.org
Subject: Oops when reading /proc/dri/0/vm with r128 on Inspiron 4000
Message-ID: <20010909143932.A500@ilm.nlc.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: =?iso-8859-1?Q?Dagfinn_Ilmari_Manns=E5ker?= <ilmari@ilm.nlc.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

DRI won't work on my Dell Inspiron 4000 with an ATI Rage Mobility M3 graphi=
cs
chip. I've tried both 2.4.9 and -ac6, both the stock DRM and from CVS today.
The kernel seems to find the card just fine, according to dmesg, but
/dev/dri/0/ is not created (I'm running devfs).

The dmesg output for the card is:

[drm] AGP 0.99 on Intel 440BX @ 0xf0000000 64MB
[drm] Initialized r128 2.1.6 20010405 on minor 0

X on the other hand, says:

(II) R128(0): Direct rendering disabled

When cat'ing /proc/dri/0/vm I get a NULL pointer dereference oops, after wh=
ich all
reading from any file (except name) in /proc/dri/0/ hangs in uninterruptible
sleep until I reboot. On 2.4.9-ac6 with drm from cvs (no agpgart loaded), t=
he
decoded oops is as follows (I ran ksymoops immediately after the oops, so t=
he
warnings can be ignored):


ksymoops 2.4.2 on i686 2.4.9-ac6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-ac6/ (default)
     -m /boot/System.map-2.4.9-ac6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol zeroes  , ipsec says d09144c0, /=
lib/modules/2.4.9-ac6/kernel/net/ipsec/ipsec.o says d09143c0.  Ignoring /li=
b/modules/2.4.9-ac6/kernel/net/ipsec/ipsec.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
d09ae907
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d09ae907>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 00000000   ebx: 00000032   ecx: c035c000   edx: c7502000
esi: c03a1f98   edi: c035c000   ebp: c035c000   esp: c03a1ee4
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 2416, stackpage=3Dc03a1000)
Stack: c7502000 c03a1f98 c035c000 c7502020 c0c966e0 c03a1f34 00000000 c7502=
000
       d09b8214 d09b8217 d09b821b d09b821f c0c96660 00000000 cd901000 d09ae=
a5b
       c035c000 c03a1f98 00000000 00000400 c03a1f94 c7502000 00000282 c021d=
e84
Call Trace: [<d09b8214>] [<d09b8217>] [<d09b821b>] [<d09b821f>] [<d09aea5b>]
   [<c014571a>] [<c012e1c6>] [<c0106aeb>]
Code: 8b 38 8b 07 0f 18 00 8b 44 24 1c 8b 90 4c 01 00 00 39 d7 0f

>>EIP; d09ae906 <[r128]r128__vm_info+9a/1b4>   <=3D=3D=3D=3D=3D
Trace; d09b8214 <[r128].rodata.start+2274/46be>
Trace; d09b8216 <[r128].rodata.start+2276/46be>
Trace; d09b821a <[r128].rodata.start+227a/46be>
Trace; d09b821e <[r128].rodata.start+227e/46be>
Trace; d09aea5a <[r128]r128_vm_info+3a/54>
Trace; c014571a <proc_file_read+f2/194>
Trace; c012e1c6 <sys_read+96/cc>
Trace; c0106aea <system_call+32/38>
Code;  d09ae906 <[r128]r128__vm_info+9a/1b4>
00000000 <_EIP>:
Code;  d09ae906 <[r128]r128__vm_info+9a/1b4>   <=3D=3D=3D=3D=3D
   0:   8b 38                     mov    (%eax),%edi   <=3D=3D=3D=3D=3D
Code;  d09ae908 <[r128]r128__vm_info+9c/1b4>
   2:   8b 07                     mov    (%edi),%eax
Code;  d09ae90a <[r128]r128__vm_info+9e/1b4>
   4:   0f 18 00                  prefetchnta (%eax)
Code;  d09ae90c <[r128]r128__vm_info+a0/1b4>
   7:   8b 44 24 1c               mov    0x1c(%esp,1),%eax
Code;  d09ae910 <[r128]r128__vm_info+a4/1b4>
   b:   8b 90 4c 01 00 00         mov    0x14c(%eax),%edx
Code;  d09ae916 <[r128]r128__vm_info+aa/1b4>
  11:   39 d7                     cmp    %edx,%edi
Code;  d09ae918 <[r128]r128__vm_info+ac/1b4>
  13:   0f 00 00                  sldt   (%eax)


2 warnings issued.  Results may not be reliable.


lspci -vvv says this about the card:

01:00.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x
(rev 02) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=3D64M]
	Region 1: I/O ports at ec00 [size=3D256]
	Region 2: Memory at fdffc000 (32-bit, non-prefetchable) [size=3D16K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA+ AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

My kernel config and relvant parts of XF86Config-4 are attached.

--=20
Dagfinn I. Manns=E5ker
GPG Public Key ID: 0x51ECFAC6
Fingerprint:  48BB A64D CE9B 9A06 65DF  395C D42E CDC4 51EC FAC6


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-config

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IPSEC=m
CONFIG_IPSEC_IPIP=y
CONFIG_IPSEC_AH=y
CONFIG_IPSEC_AUTH_HMAC_MD5=y
CONFIG_IPSEC_AUTH_HMAC_SHA1=y
CONFIG_IPSEC_ESP=y
CONFIG_IPSEC_ENC_3DES=y
CONFIG_IPSEC_IPCOMP=y
CONFIG_IPSEC_DEBUG=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS=y
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_R128=m
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_EXT2_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=m
CONFIG_USB=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_HID=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=XF86Config-4

Section "Module"
	Load	"ddc"
	Load	"GLcore"
	Load	"dbe"
	Load	"dri"
	Load	"extmod"
	Load	"glx"
	Load	"pex5"
	Load	"record"
	Load	"xie"
	Load	"bitmap"
	Load	"freetype"
	Load	"speedo"
	Load	"type1"
	Load	"vbe"
	Load	"int10"
EndSection

Section "Device"
	Identifier	"ATI M3 Mobility"
	#Driver		"r128"
	Driver		"ati"
	BusID           "PCI:1:0:0"
EndSection

Section "Monitor"
	Identifier	"14.1in TFT"
	HorizSync	31.5-90
	VertRefresh	60
	Modeline "1400x1050" 108.000  1400 1448 1462 1688  1050 1050 1053 1066
	Gamma		0.7
EndSection

Section "Screen"
	Identifier	"Default Screen"
	Device		"ATI M3 Mobility"
	Monitor		"14.1in TFT"
	DefaultDepth	16
	SubSection "Display"
		Depth		16
		Modes		"1400x1050" "1280x960" "1152x864" "1024x768" "800x600" "640x480"
	EndSubSection
EndSection

Section "DRI"
	Mode	0660
	Group	"video"
EndSection

--EeQfGwPcQSOJBaQU--

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7m2ME1C7NxFHs+sYRAm4rAJ0UMTQR1plocnbGoCTzmZa5ZhPWKACdFBpK
mDrvaIxI4yZ7bKAD81biX20=
=fgnT
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
