Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269971AbRIEBGy>; Tue, 4 Sep 2001 21:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270025AbRIEBGp>; Tue, 4 Sep 2001 21:06:45 -0400
Received: from krs-dhcp336.studby.uio.no ([129.240.107.113]:56555 "EHLO
	ilm.nlc.no") by vger.kernel.org with ESMTP id <S269971AbRIEBGc>;
	Tue, 4 Sep 2001 21:06:32 -0400
Date: Wed, 5 Sep 2001 03:06:49 +0200
To: linux-kernel@vger.kernel.org
Subject: Oops when reading /proc/dri/0/vm with r128 on Inspiron 4000
Message-ID: <20010905030649.A25418@ilm.nlc.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: =?iso-8859-1?Q?Dagfinn_Ilmari_Manns=E5ker?= <ilmari@ilm.nlc.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Let me first ask you to please copy me on replies, as I am not subscribed to
the list (but I do browse it via the fa.linux.kernel nntp gateway).

DRI won't work on my Dell Inspiron 4000 with an ATI Rage Mobility M3 graphi=
cs
chip. I've tried both 2.4.9 and -ac6. The kernel seems to find the card just
fine, according to dmesg, but /dev/dri/0/ is not created (I'm running devfs=
).

The dmesg output for the card is:

[drm] AGP 0.99 on Intel 440BX @ 0xf0000000 64MB
[drm] Initialized r128 2.1.6 20010405 on minor 0

X on the other hand, says:

(II) R128(0): Direct rendering disabled

When cat'ing /proc/dri/0/vm I get  the following oops, after which all
reading from any file (except name) in /proc/dri/0/ hangs in uninterruptible
sleep until I reboot:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
d09d75a4
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d09d75a4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 00000000   ebx: 00000032   ecx: ce44e000   edx: c5dce800
esi: cf00df98   edi: ce44e000   ebp: ce44e000   esp: cf00df0c
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 2942, stackpage=3Dcf00d000)
Stack: c5dce800 cf00df98 ce44e000 c5dce820 00000000 c5dce800 d09e0d34 d09e0=
d37
       d09e0d3b d09e0d3f d09d76f5 ce44e000 cf00df98 00000000 00000400 cf00d=
f94
       c5dce800 c1d1a6e0 00000400 ce44e000 00000400 c014571a ce44e000 cf00d=
f98
Call Trace: [<d09e0d34>] [<d09e0d37>] [<d09e0d3b>] [<d09e0d3f>] [<d09d76f5>]
   [<c014571a>] [<c012e1c6>] [<c0106aeb>]
Code: 8b 38 8b 07 0f 18 00 8b 44 24 14 8b 90 4c 01 00 00 39 d7 0f

>>EIP; d09d75a4 <[r128]r128__vm_info+98/1b4>   <=3D=3D=3D=3D=3D
Trace; d09e0d34 <[r128].rodata.start+2374/481e>
Trace; d09e0d36 <[r128].rodata.start+2376/481e>
Trace; d09e0d3a <[r128].rodata.start+237a/481e>
Trace; d09e0d3e <[r128].rodata.start+237e/481e>
Trace; d09d76f4 <[r128]r128_vm_info+34/48>
Trace; c014571a <proc_file_read+f2/194>
Trace; c012e1c6 <sys_read+96/cc>
Trace; c0106aea <system_call+32/38>
Code;  d09d75a4 <[r128]r128__vm_info+98/1b4>
00000000 <_EIP>:
Code;  d09d75a4 <[r128]r128__vm_info+98/1b4>   <=3D=3D=3D=3D=3D
   0:   8b 38                     mov    (%eax),%edi   <=3D=3D=3D=3D=3D
Code;  d09d75a6 <[r128]r128__vm_info+9a/1b4>
   2:   8b 07                     mov    (%edi),%eax
Code;  d09d75a8 <[r128]r128__vm_info+9c/1b4>
   4:   0f 18 00                  prefetchnta (%eax)
Code;  d09d75aa <[r128]r128__vm_info+9e/1b4>
   7:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  d09d75ae <[r128]r128__vm_info+a2/1b4>
   b:   8b 90 4c 01 00 00         mov    0x14c(%eax),%edx
Code;  d09d75b4 <[r128]r128__vm_info+a8/1b4>
  11:   39 d7                     cmp    %edx,%edi
Code;  d09d75b6 <[r128]r128__vm_info+aa/1b4>
  13:   0f 00 00                  sldt   (%eax)


lspci -vvv output:

01:00.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x =
(rev 02) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
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
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

My kernel config is attached.
--=20
Dagfinn I. Manns=E5ker
GPG Public Key ID: 0x51ECFAC6
Fingerprint:  48BB A64D CE9B 9A06 65DF  395C D42E CDC4 51EC FAC6


--W/nzBZO5zC0uMSeA
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

--W/nzBZO5zC0uMSeA--

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lXqp1C7NxFHs+sYRAqzkAJ4n9AoJuooRBKu3845ADgyceupFfACcCjIt
n6iZhGIeDHX8q7QTgf3+mb0=
=IR01
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
