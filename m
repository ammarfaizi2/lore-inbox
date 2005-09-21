Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVIUBVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVIUBVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVIUBVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:21:35 -0400
Received: from ms-smtp-01-lbl.southeast.rr.com ([24.25.9.100]:44937 "EHLO
	ms-smtp-01-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932100AbVIUBVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:21:33 -0400
Message-Id: <200509210121.j8L1LKWg000103@ms-smtp-01-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Arthur Othieno'" <a.othieno@bluewin.ch>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Unknown symbol in crc32c in 2.6.13.1
Date: Tue, 20 Sep 2005 21:21:16 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C5BE29.3D5D7A00"
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcW+QWlgeE4AL7a+SDKih+AwQy8DWQACTchw
In-Reply-To: <20050921000341.GA2527@mars>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C5BE29.3D5D7A00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Arthur Othieno [mailto:a.othieno@bluewin.ch]
> Sent: Tuesday, September 20, 2005 8:04 PM
> To: Matt LaPlante
> Cc: 'Linux Kernel Mailing List'
> Subject: Re: Unknown symbol in crc32c in 2.6.13.1
> 
> On Tue, Sep 20, 2005 at 01:07:42AM -0400, Matt LaPlante wrote:
> > Hi All,
> >   I see this error repeatedly.  Running Debian latest stable branch w/
> > custom 2.6.13.1 kernel.  I've got the racoon package installed and I'm
> > running IPSec between two such gateways.  On both ends, when I start
> Racoon
> > for my IPSec link I always get the following error:
> >
> > ###################################################
> > firewall:~# /etc/init.d/racoon restart
> > Stopping IKE (ISAKMP/Oakley) server: racoon.
> > Flushing SAD and SPD...
> > SAD and SPD flushed.
> > Unloading IPSEC/crypto modules...
> > IPSEC/crypto modules unloaded.
> > Loading IPSEC/crypto modules...
> >
> > insmod: error inserting
> > '/lib/modules/2.6.13.1-firewall/kernel/crypto/crc32c.ko': -1 Unknown
> symbol
> > in module
> >
> >
> > IPSEC/crypto modules loaded.
> > Starting IKE (ISAKMP/Oakley) server: racoon.
> > Flushing SAD and SPD...
> > SAD and SPD flushed.
> > Loading SAD and SPD...
> > SAD and SPD loaded.
> > Configuring racoon...done.
> > ###################################################
> >
> > It doesn't seem to be fatal, but I figured I'd report it since it seems
> to
> > be continuous.  Syslog gives only the following:
> >
> > Sep 20 00:58:53 localhost kernel: crc32c: Unknown symbol crc32c_le
> 
> Hmmm.
> 
> > I hope this problem isn't considered too trivial to report...sorry if
> I'm
> > wasting your time with it.
> 
> Could you please post a copy of your .config and /etc/init.d/racoon.
> Thanks.
> 
> 	Arthur

Attaching the requested files.

-
Matt

------=_NextPart_000_0000_01C5BE29.3D5D7A00
Content-Type: application/octet-stream;
	name="racoon"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="racoon"

#! /bin/sh=0A=
#=0A=
# netscript	script to fire up netscript network configuration system=0A=
#=0A=
#		Written by Miquel van Smoorenburg <miquels@cistron.nl>.=0A=
#		Modified for Debian GNU/Linux=0A=
#		by Ian Murdock <imurdock@gnu.ai.mit.edu>.=0A=
#		Modified from /etc/init.d/skeleton=0A=
#		by Matthew Grant <grantma@anathoth.gen.nz>=0A=
#=0A=
=0A=
set -e=0A=
=0A=
PATH=3D/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin=0A=
TOOL=3D/usr/sbin/racoon-tool=0A=
DAEMON=3D/usr/sbin/racoon=0A=
NAME=3Dracoon=0A=
DESC=3D"racoon"=0A=
DEF_CFG=3D"/etc/default/racoon"=0A=
PID_FILE=3D"/var/run/racoon.pid"=0A=
PROC_FILE=3D"/proc/net/pfkey"=0A=
=0A=
test -f $TOOL || exit 0=0A=
test -f $DAEMON || exit 0=0A=
=0A=
CONFIG_MODE=3D"direct"=0A=
RACOON_ARGS=3D""=0A=
=0A=
[ -f "$DEF_CFG" ] && . $DEF_CFG=0A=
=0A=
check_kernel () {=0A=
	local MOD_DIR=3D/lib/modules/`uname -r`=0A=
	local FOUT=0A=
=0A=
	[ -f "$PROC_FILE" ] && return 0=0A=
	[ ! -d "$MOD_DIR" ] && return 1=0A=
	FOUT=3D`find $MOD_DIR -name "*af_key*"`=0A=
	[ -z "$FOUT" ] && return 1=0A=
	return 0=0A=
}=0A=
=0A=
if ! check_kernel ; then=0A=
        echo "racoon - IKE keying daemon will not be started as =
$PROC_FILE is not" 1>&2=0A=
        echo "         available or a suitable 2.6 (or 2.4 with IPSEC =
backport)" 1>&2=0A=
        echo "         kernel with af_key.[k]o module is not installed." =
1>&2=0A=
	exit 0=0A=
fi=0A=
=0A=
case  $CONFIG_MODE in=0A=
	racoon-tool)=0A=
# /usr/sbin/racoon-tool command complies with Debian Policy so just do =
this:=0A=
# NB the following makes lintian happy=0A=
	case "$1" in=0A=
		start|stop|reload|force-reload|restart)=0A=
			$TOOL $*=0A=
			;;=0A=
		*)=0A=
			$TOOL $*=0A=
			;;=0A=
	esac=0A=
	;;=0A=
*)=0A=
	case "$1" in=0A=
        	start)=0A=
                	echo -n "Starting IKE (ISAKMP/Oakley) server: racoon"=0A=
	                start-stop-daemon --start --quiet --exec =
/usr/sbin/racoon -- ${RACOON_ARGS}=0A=
        	        echo "."=0A=
                	;;=0A=
         =0A=
	        stop)=0A=
        	        echo -n "Stopping IKE (ISAKMP/Oakley) server: racoon"=0A=
                	start-stop-daemon --stop --retry 25 --quiet --oknodo \=0A=
                        	--pidfile $PID_FILE --name racoon=0A=
	                echo "."=0A=
        	        ;;=0A=
         =0A=
	        reload|force_reload|restart)=0A=
                	$0 stop=0A=
        	        $0 start=0A=
	                ;;=0A=
         =0A=
        	*)=0A=
                	echo "Usage: $0 =
(start|stop|reload|force-reload|restart)" >&2=0A=
	                exit 1=0A=
	esac=0A=
	;;=0A=
esac=0A=
=0A=
exit 0=0A=

------=_NextPart_000_0000_01C5BE29.3D5D7A00
Content-Type: application/octet-stream;
	name=".config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=".config"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.13.1=0A=
# Sat Sep 10 03:13:17 2005=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
CONFIG_GENERIC_IOMAP=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
CONFIG_LOCK_KERNEL=3Dy=0A=
CONFIG_INIT_ENV_ARG_LIMIT=3D32=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D"-Firewall"=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_POSIX_MQUEUE=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT_V3 is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_AUDIT=3Dy=0A=
CONFIG_AUDITSYSCALL=3Dy=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_KOBJECT_UEVENT=3Dy=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_KALLSYMS_EXTRA_PASS=3Dy=0A=
CONFIG_PRINTK=3Dy=0A=
CONFIG_BUG=3Dy=0A=
CONFIG_BASE_FULL=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
CONFIG_CC_ALIGN_LABELS=3D0=0A=
CONFIG_CC_ALIGN_LOOPS=3D0=0A=
CONFIG_CC_ALIGN_JUMPS=3D0=0A=
# CONFIG_TINY_SHMEM is not set=0A=
CONFIG_BASE_SMALL=3D0=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_ELAN is not set=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
CONFIG_MPENTIUMII=3Dy=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUMM is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MEFFICEON is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MGEODEGX1 is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_HPET_TIMER=3Dy=0A=
CONFIG_HPET_EMULATE_RTC=3Dy=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_PREEMPT_NONE is not set=0A=
# CONFIG_PREEMPT_VOLUNTARY is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_PREEMPT_BKL=3Dy=0A=
# CONFIG_X86_UP_APIC is not set=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
# CONFIG_X86_REBOOTFIXUPS is not set=0A=
CONFIG_MICROCODE=3Dm=0A=
CONFIG_X86_MSR=3Dm=0A=
CONFIG_X86_CPUID=3Dm=0A=
=0A=
#=0A=
# Firmware Drivers=0A=
#=0A=
# CONFIG_EDD is not set=0A=
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_SELECT_MEMORY_MODEL=3Dy=0A=
CONFIG_FLATMEM_MANUAL=3Dy=0A=
# CONFIG_DISCONTIGMEM_MANUAL is not set=0A=
# CONFIG_SPARSEMEM_MANUAL is not set=0A=
CONFIG_FLATMEM=3Dy=0A=
CONFIG_FLAT_NODE_MEM_MAP=3Dy=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_EFI is not set=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
CONFIG_REGPARM=3Dy=0A=
CONFIG_SECCOMP=3Dy=0A=
# CONFIG_HZ_100 is not set=0A=
# CONFIG_HZ_250 is not set=0A=
CONFIG_HZ_1000=3Dy=0A=
CONFIG_HZ=3D1000=0A=
CONFIG_PHYSICAL_START=3D0x100000=0A=
# CONFIG_KEXEC is not set=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
# CONFIG_PM_DEBUG is not set=0A=
# CONFIG_SOFTWARE_SUSPEND is not set=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
# CONFIG_ACPI_SLEEP is not set=0A=
# CONFIG_ACPI_AC is not set=0A=
# CONFIG_ACPI_BATTERY is not set=0A=
CONFIG_ACPI_BUTTON=3Dm=0A=
# CONFIG_ACPI_VIDEO is not set=0A=
# CONFIG_ACPI_HOTKEY is not set=0A=
CONFIG_ACPI_FAN=3Dm=0A=
CONFIG_ACPI_PROCESSOR=3Dm=0A=
CONFIG_ACPI_THERMAL=3Dm=0A=
# CONFIG_ACPI_ASUS is not set=0A=
# CONFIG_ACPI_IBM is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
CONFIG_ACPI_BLACKLIST_YEAR=3D2001=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
CONFIG_X86_PM_TIMER=3Dy=0A=
# CONFIG_ACPI_CONTAINER is not set=0A=
=0A=
#=0A=
# APM (Advanced Power Management) BIOS Support=0A=
#=0A=
# CONFIG_APM is not set=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GOMMCONFIG is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_MMCONFIG=3Dy=0A=
# CONFIG_PCIEPORTBUS is not set=0A=
# CONFIG_PCI_LEGACY_PROC is not set=0A=
# CONFIG_PCI_NAMES is not set=0A=
CONFIG_ISA_DMA_API=3Dy=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
=0A=
#=0A=
# PCCARD (PCMCIA/CardBus) support=0A=
#=0A=
# CONFIG_PCCARD is not set=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_AOUT is not set=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Networking=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_XFRM=3Dy=0A=
CONFIG_XFRM_USER=3Dm=0A=
CONFIG_NET_KEY=3Dm=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
CONFIG_ASK_IP_FIB_HASH=3Dy=0A=
# CONFIG_IP_FIB_TRIE is not set=0A=
CONFIG_IP_FIB_HASH=3Dy=0A=
CONFIG_IP_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_ROUTE_FWMARK=3Dy=0A=
CONFIG_IP_ROUTE_MULTIPATH=3Dy=0A=
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set=0A=
CONFIG_IP_ROUTE_VERBOSE=3Dy=0A=
# CONFIG_IP_PNP is not set=0A=
CONFIG_NET_IPIP=3Dm=0A=
CONFIG_NET_IPGRE=3Dm=0A=
CONFIG_NET_IPGRE_BROADCAST=3Dy=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
CONFIG_INET_AH=3Dm=0A=
CONFIG_INET_ESP=3Dm=0A=
CONFIG_INET_IPCOMP=3Dm=0A=
CONFIG_INET_TUNNEL=3Dm=0A=
CONFIG_IP_TCPDIAG=3Dy=0A=
# CONFIG_IP_TCPDIAG_IPV6 is not set=0A=
# CONFIG_TCP_CONG_ADVANCED is not set=0A=
CONFIG_TCP_CONG_BIC=3Dy=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_CT_ACCT=3Dy=0A=
CONFIG_IP_NF_CONNTRACK_MARK=3Dy=0A=
CONFIG_IP_NF_CT_PROTO_SCTP=3Dm=0A=
CONFIG_IP_NF_FTP=3Dy=0A=
CONFIG_IP_NF_IRC=3Dm=0A=
CONFIG_IP_NF_TFTP=3Dm=0A=
CONFIG_IP_NF_AMANDA=3Dm=0A=
CONFIG_IP_NF_QUEUE=3Dm=0A=
CONFIG_IP_NF_IPTABLES=3Dy=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dm=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dm=0A=
CONFIG_IP_NF_MATCH_MAC=3Dm=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm=0A=
CONFIG_IP_NF_MATCH_MARK=3Dm=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm=0A=
CONFIG_IP_NF_MATCH_TOS=3Dm=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dm=0A=
CONFIG_IP_NF_MATCH_ECN=3Dm=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dm=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dm=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dm=0A=
CONFIG_IP_NF_MATCH_TTL=3Dm=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dm=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dm=0A=
CONFIG_IP_NF_MATCH_STATE=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dm=0A=
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm=0A=
CONFIG_IP_NF_MATCH_REALM=3Dm=0A=
CONFIG_IP_NF_MATCH_SCTP=3Dm=0A=
CONFIG_IP_NF_MATCH_COMMENT=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNMARK=3Dm=0A=
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set=0A=
CONFIG_IP_NF_FILTER=3Dy=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dm=0A=
CONFIG_IP_NF_TARGET_LOG=3Dm=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dm=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dm=0A=
CONFIG_IP_NF_NAT=3Dy=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dm=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dm=0A=
CONFIG_IP_NF_TARGET_SAME=3Dm=0A=
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm=0A=
CONFIG_IP_NF_NAT_IRC=3Dm=0A=
CONFIG_IP_NF_NAT_FTP=3Dy=0A=
CONFIG_IP_NF_NAT_TFTP=3Dm=0A=
CONFIG_IP_NF_NAT_AMANDA=3Dm=0A=
CONFIG_IP_NF_MANGLE=3Dy=0A=
CONFIG_IP_NF_TARGET_TOS=3Dm=0A=
CONFIG_IP_NF_TARGET_ECN=3Dm=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dm=0A=
CONFIG_IP_NF_TARGET_MARK=3Dm=0A=
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm=0A=
CONFIG_IP_NF_TARGET_CONNMARK=3Dm=0A=
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set=0A=
CONFIG_IP_NF_RAW=3Dm=0A=
CONFIG_IP_NF_TARGET_NOTRACK=3Dm=0A=
CONFIG_IP_NF_ARPTABLES=3Dm=0A=
CONFIG_IP_NF_ARPFILTER=3Dm=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dm=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
CONFIG_NET_DIVERT=3Dy=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
CONFIG_NET_SCHED=3Dy=0A=
CONFIG_NET_SCH_CLK_JIFFIES=3Dy=0A=
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set=0A=
# CONFIG_NET_SCH_CLK_CPU is not set=0A=
CONFIG_NET_SCH_CBQ=3Dm=0A=
CONFIG_NET_SCH_HTB=3Dm=0A=
CONFIG_NET_SCH_HFSC=3Dm=0A=
CONFIG_NET_SCH_PRIO=3Dm=0A=
CONFIG_NET_SCH_RED=3Dm=0A=
CONFIG_NET_SCH_SFQ=3Dm=0A=
CONFIG_NET_SCH_TEQL=3Dm=0A=
CONFIG_NET_SCH_TBF=3Dm=0A=
CONFIG_NET_SCH_GRED=3Dm=0A=
CONFIG_NET_SCH_DSMARK=3Dm=0A=
CONFIG_NET_SCH_NETEM=3Dm=0A=
CONFIG_NET_SCH_INGRESS=3Dm=0A=
CONFIG_NET_QOS=3Dy=0A=
CONFIG_NET_ESTIMATOR=3Dy=0A=
CONFIG_NET_CLS=3Dy=0A=
CONFIG_NET_CLS_BASIC=3Dm=0A=
CONFIG_NET_CLS_TCINDEX=3Dm=0A=
CONFIG_NET_CLS_ROUTE4=3Dm=0A=
CONFIG_NET_CLS_ROUTE=3Dy=0A=
CONFIG_NET_CLS_FW=3Dm=0A=
CONFIG_NET_CLS_U32=3Dm=0A=
CONFIG_CLS_U32_PERF=3Dy=0A=
CONFIG_NET_CLS_IND=3Dy=0A=
# CONFIG_CLS_U32_MARK is not set=0A=
CONFIG_NET_CLS_RSVP=3Dm=0A=
CONFIG_NET_CLS_RSVP6=3Dm=0A=
# CONFIG_NET_EMATCH is not set=0A=
# CONFIG_NET_CLS_ACT is not set=0A=
CONFIG_NET_CLS_POLICE=3Dy=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
CONFIG_FW_LOADER=3Dy=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_PNP_DEBUG is not set=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
CONFIG_PNPACPI=3Dy=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
# CONFIG_BLK_DEV_COW_COMMON is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D16384=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
# CONFIG_LBD is not set=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
# CONFIG_ATA_OVER_ETH is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_IDE_SATA is not set=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
CONFIG_BLK_DEV_IDECD=3Dm=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
CONFIG_BLK_DEV_IDEFLOPPY=3Dm=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_IDE_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
# CONFIG_BLK_DEV_IDEPNP is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_ATIIXP is not set=0A=
CONFIG_BLK_DEV_CMD64X=3Dm=0A=
CONFIG_BLK_DEV_TRIFLEX=3Dm=0A=
CONFIG_BLK_DEV_CY82C693=3Dy=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
CONFIG_BLK_DEV_HPT34X=3Dy=0A=
# CONFIG_HPT34X_AUTODMA is not set=0A=
CONFIG_BLK_DEV_HPT366=3Dy=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_IT821X is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_ARM is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
# CONFIG_DUMMY is not set=0A=
CONFIG_BONDING=3Dm=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dm=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
CONFIG_NET_TULIP=3Dy=0A=
CONFIG_DE2104X=3Dm=0A=
CONFIG_TULIP=3Dm=0A=
# CONFIG_TULIP_MWI is not set=0A=
CONFIG_TULIP_MMIO=3Dy=0A=
CONFIG_TULIP_NAPI=3Dy=0A=
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy=0A=
CONFIG_DE4X5=3Dm=0A=
CONFIG_WINBOND_840=3Dm=0A=
CONFIG_DM9102=3Dm=0A=
# CONFIG_HP100 is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_FORCEDETH is not set=0A=
# CONFIG_DGRS is not set=0A=
# CONFIG_EEPRO100 is not set=0A=
# CONFIG_E100 is not set=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139CP is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
CONFIG_VIA_RHINE=3Dm=0A=
CONFIG_VIA_RHINE_MMIO=3Dy=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SKGE is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_VIA_VELOCITY is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_BNX2 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
CONFIG_NET_RADIO=3Dy=0A=
=0A=
#=0A=
# Obsolete Wireless cards support (pre-802.11)=0A=
#=0A=
# CONFIG_STRIP is not set=0A=
=0A=
#=0A=
# Wireless 802.11b ISA/PCI cards support=0A=
#=0A=
# CONFIG_HERMES is not set=0A=
# CONFIG_ATMEL is not set=0A=
=0A=
#=0A=
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support=0A=
#=0A=
# CONFIG_PRISM54 is not set=0A=
CONFIG_NET_WIRELESS=3Dy=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PPP=3Dm=0A=
CONFIG_PPP_MULTILINK=3Dy=0A=
CONFIG_PPP_FILTER=3Dy=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
CONFIG_PPP_SYNC_TTY=3Dm=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
CONFIG_PPP_BSDCOMP=3Dm=0A=
CONFIG_PPP_MPPE_MPPC=3Dm=0A=
CONFIG_PPPOE=3Dm=0A=
# CONFIG_SLIP is not set=0A=
CONFIG_SHAPER=3Dm=0A=
CONFIG_NETCONSOLE=3Dm=0A=
CONFIG_NETPOLL=3Dy=0A=
CONFIG_NETPOLL_RX=3Dy=0A=
CONFIG_NETPOLL_TRAP=3Dy=0A=
CONFIG_NET_POLL_CONTROLLER=3Dy=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
CONFIG_INPUT_EVDEV=3Dm=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dm=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_VSXXXAA is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
CONFIG_INPUT_MISC=3Dy=0A=
CONFIG_INPUT_PCSPKR=3Dm=0A=
CONFIG_INPUT_UINPUT=3Dm=0A=
=0A=
#=0A=
# Hardware I/O ports=0A=
#=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
CONFIG_SERIO_LIBPS2=3Dy=0A=
# CONFIG_SERIO_RAW is not set=0A=
# CONFIG_GAMEPORT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_8250_ACPI is not set=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_JSM is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
CONFIG_HW_RANDOM=3Dm=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dy=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dm=0A=
# CONFIG_AGP_ALI is not set=0A=
CONFIG_AGP_ATI=3Dm=0A=
# CONFIG_AGP_AMD is not set=0A=
# CONFIG_AGP_AMD64 is not set=0A=
CONFIG_AGP_INTEL=3Dm=0A=
# CONFIG_AGP_NVIDIA is not set=0A=
# CONFIG_AGP_SIS is not set=0A=
# CONFIG_AGP_SWORKS is not set=0A=
# CONFIG_AGP_VIA is not set=0A=
# CONFIG_AGP_EFFICEON is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
# CONFIG_HPET is not set=0A=
# CONFIG_HANGCHECK_TIMER is not set=0A=
=0A=
#=0A=
# TPM devices=0A=
#=0A=
# CONFIG_TCG_TPM is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
# CONFIG_I2C_SENSOR is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Hardware Monitoring support=0A=
#=0A=
CONFIG_HWMON=3Dm=0A=
# CONFIG_HWMON_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_IBM_ASM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
# CONFIG_MMC is not set=0A=
=0A=
#=0A=
# InfiniBand support=0A=
#=0A=
# CONFIG_INFINIBAND is not set=0A=
=0A=
#=0A=
# SN Devices=0A=
#=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_EXT2_FS is not set=0A=
# CONFIG_EXT3_FS is not set=0A=
# CONFIG_JBD is not set=0A=
CONFIG_REISERFS_FS=3Dy=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
CONFIG_REISERFS_PROC_INFO=3Dy=0A=
# CONFIG_REISERFS_FS_XATTR is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_FS_POSIX_ACL is not set=0A=
=0A=
#=0A=
# XFS support=0A=
#=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_INOTIFY=3Dy=0A=
# CONFIG_QUOTA is not set=0A=
CONFIG_DNOTIFY=3Dy=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dm=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dm=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
CONFIG_ZISOFS_FS=3Dm=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_TMPFS_XATTR=3Dy=0A=
CONFIG_TMPFS_SECURITY=3Dy=0A=
# CONFIG_HUGETLBFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_NFS_FS is not set=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
# CONFIG_BSD_DISKLABEL is not set=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
# CONFIG_LDM_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_EFI_PARTITION is not set=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"utf8"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ASCII=3Dy=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
CONFIG_NLS_UTF8=3Dm=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_PRINTK_TIME is not set=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
CONFIG_DEBUG_BUGVERBOSE=3Dy=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_KEYS is not set=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dm=0A=
CONFIG_CRYPTO_MD4=3Dm=0A=
CONFIG_CRYPTO_MD5=3Dm=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A=
CONFIG_CRYPTO_SHA256=3Dm=0A=
CONFIG_CRYPTO_SHA512=3Dm=0A=
CONFIG_CRYPTO_WP512=3Dm=0A=
# CONFIG_CRYPTO_TGR192 is not set=0A=
CONFIG_CRYPTO_DES=3Dm=0A=
CONFIG_CRYPTO_BLOWFISH=3Dm=0A=
CONFIG_CRYPTO_TWOFISH=3Dm=0A=
CONFIG_CRYPTO_SERPENT=3Dm=0A=
CONFIG_CRYPTO_AES_586=3Dm=0A=
CONFIG_CRYPTO_CAST5=3Dm=0A=
CONFIG_CRYPTO_CAST6=3Dm=0A=
CONFIG_CRYPTO_TEA=3Dm=0A=
CONFIG_CRYPTO_ARC4=3Dm=0A=
CONFIG_CRYPTO_KHAZAD=3Dm=0A=
# CONFIG_CRYPTO_ANUBIS is not set=0A=
CONFIG_CRYPTO_DEFLATE=3Dm=0A=
CONFIG_CRYPTO_MICHAEL_MIC=3Dm=0A=
CONFIG_CRYPTO_CRC32C=3Dm=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
=0A=
#=0A=
# Hardware crypto devices=0A=
#=0A=
# CONFIG_CRYPTO_DEV_PADLOCK is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC_CCITT=3Dm=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_LIBCRC32C=3Dm=0A=
CONFIG_ZLIB_INFLATE=3Dm=0A=
CONFIG_ZLIB_DEFLATE=3Dm=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_GENERIC_IRQ_PROBE=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_PC=3Dy=0A=

------=_NextPart_000_0000_01C5BE29.3D5D7A00--


