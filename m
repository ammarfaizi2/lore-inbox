Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSDCP4g>; Wed, 3 Apr 2002 10:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312141AbSDCP4U>; Wed, 3 Apr 2002 10:56:20 -0500
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:46187 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S312136AbSDCPzp>; Wed, 3 Apr 2002 10:55:45 -0500
Date: Wed, 3 Apr 2002 16:55:08 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OOPSes with ipchains on 2.4.18
Message-ID: <20020403155508.GA17751@e-jorgensen.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
GPG-Key-FingerPrint: 11AE 72C2 853F 077A 7A0B  72DA 8BE3 D5BF 0669 5C98
Private-Web-Page: www.karl.jorgensen.com
Company-Web-Page: www.sequel-image.com
From: "Karl E. Jorgensen" <karl@jorgensen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[ This is my first ever kernel problem report. Please let me know if I'm
  reporting it to the wrong place or using the wrong format. ]

Full Description:
~~~~~~~~~~~~~~~~
I'm suffering from intermittent kernel oopses on my main machine. As far
as I can dechipher, the kernel oopses happen in the ipchains.o module.

The kernel oopses identifiy themselves as "tainted", which I don't quite
understand: The only modules *ever* loaded are modules produces from the
standard kernel sources as downloaded from ftp.kernel.org. No patches
have been applied. I have even taken the precaution of clearing out
/lib/modules and re-compiling the modules from the kernel (make modules
&& make modules_install). As far as I can see during boot-up, the kernel
warns about being tainted as soon as ipchains.o is loaded.


/proc/version:
~~~~~~~~~~~~~~
    Linux version 2.4.18 (root@hawking) (gcc version 2.95.4 (Debian prerelease)) #4 SMP Mon Mar 25 23:19:15 GMT 2002

Keywords:
~~~~~~~~~
    ipchains
    2.4.18
    netfilter
    
Output from oops:
~~~~~~~~~~~~~~~~~
    See kernel-panic[123].txt attached. I only have the last 24 lines of
    each, as they scroll off the screen. Let me know if I need to get
    the preceding lines - I presume "vga=<something>" in /etc/lilo.conf
    should do the trick.

    I ran ksymoops on it (with same modules loaded in the same order),
    and it consistently points to the ipchains module and diald. The
    stack traces are identical too, although there are slight variations in
    the register contents.

    The ksymoops output and kernel .config (named config-2.4.18) is attached.



Somewhat reproduceable:
~~~~~~~~~~~~~~~~~~~~~~~
    Unfortunately, I cannot reproduce the problem "on demand". But since
    it seems diald/ipchains related, I have attached the output of
    "ipchains -L -n -v" (packet counts from a later boot of course), so
    you can see the firewalling rules in effect.

    I have not tried modifying with the firewalling rules (yet);
    they have served me quite well under kernel 2.2.

Environment:
~~~~~~~~~~~~
    (not sure this matters to much for your diagnostics of this
    specific problem, but who knows?)

    Debian GNU/Linux - woody

    Motherboard: Abit VP6
    Single 800MHz Pentium Coppermine (in socket *2*, not 1. The previous
        occupant of socket 1 died - cause of death was presumably 
        overheating: Some of the thermal paste stuff was missing. Worked
        13 months though...)
    512 Mb memory

    NOTE: I am not 110% sure that my hardware is OK. It is not always
    willing to boot after a power on/off cycle, and doesn't always get 
    as far as lilo before hanging - that has happened twice in the last
    month.

    However, as the oopses consistently point to ipchains/diald, and it
    is rock-stable under kernel 2.2.20 (once it manages to start), I
    don't think this is a hardware related problem.
    

Software:
~~~~~~~~~
    Debian GNU/Linux - woody.

    scripts/ver_linux output:

    Linux hawking 2.4.18 #4 SMP Mon Mar 25 23:19:15 GMT 2002 i686 unknown
 
    Gnu C                  2.95.4
    Gnu make               3.79.1
    util-linux             2.11n
    mount                  2.11n
    modutils               2.4.13
    e2fsprogs              1.26
    reiserfsprogs          3.x.1a
    PPP                    2.4.1
    Linux C Library        2.2.5
    Dynamic linker (ldd)   2.2.5
    Procps                 2.0.7
    Net-tools              1.60
    Console-tools          0.2.3
    Sh-utils               2.0.11
    Modules Loaded         lp tap0 dummy0 isofs inflate_fs loop ipchains
                           parport_pc imm parport

    Debian package versions:
    diald          0.99.4-5       dial on demand daemon for PPP and SLIP.
    ppp            2.4.1.uus-1    Point-to-Point Protocol (PPP) daemon.



Processor Information:
~~~~~~~~~~~~~~~~~~~~~~
    Single pentium 800 Coppermine:
    /proc/cpuinfo:
        processor       : 0
        vendor_id       : GenuineIntel
        cpu family      : 6
        model           : 8
        model name      : Pentium III (Coppermine)
        stepping        : 6
        cpu MHz         : 798.714
        cache size      : 256 KB
        fdiv_bug        : no
        hlt_bug         : no
        f00f_bug        : no
        coma_bug        : no
        fpu             : yes
        fpu_exception   : yes
        cpuid level     : 2
        wp              : yes
        flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
        mca cmov pat pse36 mmx fxsr sse
        bogomips        : 1592.52

Module Information:
~~~~~~~~~~~~~~~~~~~
    /proc/modules report:
        lp                      5536   0 (autoclean)
        tap0                    2560   0 (autoclean)
        dummy0                   960   1 (autoclean)
        isofs                  24448   3 (autoclean)
        inflate_fs             17760   0 (autoclean) [isofs]
        loop                    8304   9 (autoclean)
        ipchains               43848  31
        parport_pc             15688   2 (autoclean)
        imm                     8800   0 (unused)
        parport                12768   2 [lp parport_pc imm]

Loaded driver & hardware info:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Not sure it's relevant for this problem, but here goes:
    Contents of /proc/ioports & /proc/meminfo attached.
    (these bit is from the 2.2.20 kernel)
    

PCI Information:
~~~~~~~~~~~~~~~~
    Not sure it's relevant for this problem, but here goes:
    Output of "lspci -vvv" attached.
    (this bit is from the 2.2.20 kernel)

SCSI Information:
~~~~~~~~~~~~~~~~~
    Not sure it's relevant for this problem, but here goes:
    Contents of /proc/scsi/scsi is attached
    (this bit is from the 2.2.20 kernel)

Other Information:
~~~~~~~~~~~~~~~~~~
    I'm not comfortable with the fact that the ipchains module "taints"
the kernel upon load. I'm aware that ipchains is deprecated in favour of
iptables, and that's the way I'm going. But to get there I only want to
change one thing at a time. Undoubtedly you know the drill already.

Currently, I'm using kernel 2.2.20, and the machine is overdue for a
kernel update. So I decided to go straight for 2.4.18.

Perhaps I would be better off upgrading to 2.4.x (x < 18), switching
over to iptables, and then going to 2.4.18? If so, which version of the
kernel would you suggest? My main criteria is that it should support
both ipchains and iptables, so I can perform a smooth transition.

Regards
-- 
Karl E. Jørgensen
karl@jorgensen.com
www.karl.jorgensen.com
I'm currently out trying to find myself. If I should get back before I
return, please keep me here.

--LpQ9ahxlCli8rRTG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kernel-panic1.txt.gz"
Content-Transfer-Encoding: base64

H4sICJw5pjwAA2tlcm5lbC1wYW5pYzEudHh0AIVTTWvcMBA9W79iemtLGvRVWzKbhbCkJaTQ
haSnkIMszaYmxmvsLbT/viPb8i7Jlgof5s3Me3rSWHfYt9iAvNSXwjD2sQsIV8Dnxb7vu6Ec
Idtsf5RAi7Ob2+0UccHLxxVykwur/PoJHlzdHjCUsGU3X75df70fuYJLkzN0v8tFOMOKUEA0
Fq3J0C9IugxDRJUrjPec4VBPPGEjLxAKPOTKFVGlO9UculklBM/CaFwYAJyjbJgDtu33HocB
Qu2aAO+7miwroS9gODj/0rlnvAokQ6If2H1M0XmT2TkwJm2sFgfHnuj1tEccrzQb70tyDTGo
KgrmkhwzQuXFcvqYoYik0w1MLIUk9NoIB88VuSZa7FRVHjPyM9fWn/GYpNnGNQ089M5jCfM4
yR6NcwLR4gKiuwRG9rGNPK2fWPwxHldp27etsWKU+AfgRtpXnBPFpfW4X6qIQv1nr3OK2gmD
53hCONS7JGK0dwvQSluV2rRErU8UhVbSuFTlORYVVdlmH+huTQWaBmnAWNAapAZBcAdVDroA
bsEo2NE085g0Glyc+vQxWPH13fRWO9fWvoTrGvECXuqmqdtniO+u7391B/jp2tBg/47dtm+z
8Ana/QGGP60nFmN/AXVJRbf/AwAA

--LpQ9ahxlCli8rRTG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kernel-panic2.txt.gz"
Content-Transfer-Encoding: base64

H4sICGk5pjwAA2tlcm5lbC1wYW5pYzIudHh0AIVTTWvcMBA9W79iemtLGvS19thsFsKSlpBA
F5KcQg6yNE5NjNfYW2j/fSXb8i5JSoQP8+bjzdOMdUN9Sw3Ic30ukLGvnSO4AD4f9nPfDcUI
2Xb3UIA/nF1d7yaLC148roljKnJlN09wb+r2QK6AHbv6fnv5426sFVxiysj8KRbihEqPXGUz
RzkmZBckTUIuIKxktSLOaKinOpGHOleHTKdFWgWW7pRz6GYW5yxzo3CBADRbyTAbbNfvLQ0D
uNo0Dj53tZeslDqD4WDsS2ee6WLk8axf2F3w+QtHtbOBGDurRQLYmBPEnuaI40yTcWCSawhG
WXpjDsnRI1SaLdcPHpOhp44jmKqUn0zyWojvzxXm3PKxv+Jq5T1yxXVujznLPSI125qmgfve
WCpg3qeX5/c5gSBxAUFdBGP1Mc1r2jyx8Gc8rmPbt6khgkr8B3CU+auaE8Yl9dgvRkSmPuj1
HqM2Aum9OiEM6SqSoLZmAVrpXMU0LUnrE0ahlUQTozylrPRRtt07P1ssQftFImAOWoPUIDys
oExBZ8BzQAWV32YanKjBhK1PH4M139xMj7UzbW0LuKyJzuClbpq6fYbw8Pr+d3eAX6Z1DfWf
2HX71gvfoN0fYPjbWl/F2D8QLmjkAAQAAA==

--LpQ9ahxlCli8rRTG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kernel-panic3.txt.gz"
Content-Transfer-Encoding: base64

H4sICKpApjwAA2tlcm5lbC1wYW5pYzMudHh0AIVTTWvcMBA9r37F9NaWNOgrtmQ2C2FJS0ig
C0lPIQdZGqcmxmvsLbT/viPb8i5JSoUP8+bjzdOMdYt9iw3Ic30uDGOfu4BwCXw+7Pu+G4oR
su3uRwF0OLu+2U0WF7x4XCM3mbDKb57gwdXtAUMBO3b99e7q2/1YK7g0GUP3u1iIV1gSCpXP
A1qzQr8g6VYYCHmbXQgnOcOhnuqEjXWBkFeqzHQVWbpTzqGbWULwLIzChQHA2VoNs8F2/d7j
MECoXRPgY1eTZCXVGQwH518694yXIw+xfmL30UcXTmpnw5jUWS0SwKecKPY0RxxnuhoHJrmG
aJQlGXNIjh6hsny5fvS43BB1GsFUpZCIXguh/lwZyz0f+2cco0decG39MWe5R6JmW9c08NA7
jwXM+yR5tM8JRIkLiOoSGKuPaaRp88Tin/G4Tm3fpsaIUeIfgBtpX9WcMC6px34pInL1n17v
MWonDL5XJ4RDXSUSo71bgFbaqpSmJWp9wii0ksalKM8wLynKtvtAszUlaFqkAWNBa5AaBMEK
ygx0DtyCUVDRNrPoNBpc3Pr0MVjzze30WDvX1r6AqxrxDF7qpqnbZ4gPr+9/dQf46drQYP+B
3bRvvfAF2v0Bhj+tpyrG/gKugST9AAQAAA==

--LpQ9ahxlCli8rRTG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kernel-ksymoops.txt.gz"
Content-Transfer-Encoding: base64

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
Bg51+D87Z5ExfZsAAA==

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.4.18"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
# CONFIG_ACPI_CMBATT is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
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
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=24
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=m
CONFIG_SLIP=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_ACPI is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
CONFIG_INPUT_EMU10K1=m
# CONFIG_INPUT_SERIO is not set

#
# Joysticks
#
CONFIG_INPUT_ANALOG=m
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_CPIA is not set
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
CONFIG_SOUND_BT878=m
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=y
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=y
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
CONFIG_USB_STORAGE_FREECOM=y
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_STORAGE_HP8200e=y
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_WACOM=m

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
CONFIG_USB_USBNET=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipchains-output.txt"

Chain input (policy REJECT: 6 packets, 420 bytes):
 pkts bytes target     prot opt    tosa tosx  ifname     mark       outsize  source                destination           ports
98726   77M ACCEPT     all  ------ 0xFF 0x00  lo+                            0.0.0.0/0            0.0.0.0/0             n/a
  829  205K ACCEPT     all  ------ 0xFF 0x00  dummy+                         0.0.0.0/0            0.0.0.0/0             n/a
  562 36406 ACCEPT     icmp ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             * ->   *
    0     0 ACCEPT     udp  ----l- 0xFF 0x00  eth+                           0.0.0.0/0            0.0.0.0/0             67 ->   68
    0     0 ACCEPT     udp  ----l- 0xFF 0x00  vmnet+                         0.0.0.0/0            0.0.0.0/0             67 ->   68
    0     0 ACCEPT     udp  ----l- 0xFF 0x00  lo+                            0.0.0.0/0            0.0.0.0/0             67 ->   68
10228  744K ACCEPT     udp  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             * ->   53
10203 1911K ACCEPT     udp  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             53 ->   *
57505   12M ACCEPT     tcp  ------ 0xFF 0x00  eth+                           0.0.0.0/0            0.0.0.0/0             * ->   22
  438  281K REDIRECT   tcp  ------ 0xFF 0x00  *                              192.168.0.0/16       !192.168.0.0/16        * ->   25 => 25
34772 5529K REDIRECT   tcp  ------ 0xFF 0x00  *                              192.168.0.0/16       !192.168.0.0/16        * ->   80 => 3128
 2183  163K ACCEPT     all  ------ 0xFF 0x00  tap+                           0.0.0.0/0            0.0.0.0/0             n/a
 4915  374K ACCEPT     udp  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             123 ->   123
56813 5176K ACCEPT     all  ------ 0xFF 0x00  eth+                           0.0.0.0/0            0.0.0.0/0             n/a
    0     0 ACCEPT     all  ------ 0xFF 0x00  vmnet+                         0.0.0.0/0            0.0.0.0/0             n/a
   59 40074 ACCEPT     udp  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             * ->   6970
   60  2932 REJECT     tcp  -y--l- 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             * ->   *
 136K   81M ACCEPT     tcp  !y---- 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             * ->   *
   60  2084 REJECT     all  ----l- 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             n/a
Chain forward (policy REJECT: 0 packets, 0 bytes):
 pkts bytes target     prot opt    tosa tosx  ifname     mark       outsize  source                destination           ports
   10   840 ACCEPT     all  ------ 0xFF 0x00  *                              192.168.0.0/16       192.168.0.0/16        n/a
34518 2097K MASQ       all  ------ 0xFF 0x00  ppp+                           192.168.0.0/16       0.0.0.0/0             n/a
 1267 82030 MASQ       all  ------ 0xFF 0x00  tap+                           192.168.0.0/16       0.0.0.0/0             n/a
    0     0 REJECT     all  ----l- 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             n/a
Chain output (policy REJECT: 6 packets, 420 bytes):
 pkts bytes target     prot opt    tosa tosx  ifname     mark       outsize  source                destination           ports
98726   77M ACCEPT     all  ------ 0xFF 0x00  lo+                            0.0.0.0/0            0.0.0.0/0             n/a
  829  205K ACCEPT     all  ------ 0xFF 0x00  dummy+                         0.0.0.0/0            0.0.0.0/0             n/a
    0     0 ACCEPT     tcp  ------ 0xFF 0x00  eth+                           0.0.0.0/0            0.0.0.0/0             * ->   22
18446 1402K ACCEPT     udp  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             123 ->   123
 211K  146M ACCEPT     all  ------ 0xFF 0x00  eth+                           0.0.0.0/0            0.0.0.0/0             n/a
    0     0 ACCEPT     all  ------ 0xFF 0x00  vmnet+                         0.0.0.0/0            0.0.0.0/0             n/a
    0     0 ACCEPT     udp  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             * ->   6970
 118K 9489K ACCEPT     all  ------ 0xFF 0x00  *                              0.0.0.0/0            0.0.0.0/0             n/a

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioports.txt"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
a000-a007 : ide0
a008-a00f : ide1
ac00-acfe : aic7xxx
b800-b87f : eth0

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="meminfo.txt"

        total:    used:    free:  shared: buffers:  cached:
Mem:  529526784 487866368 41660416 88612864 266588160 102625280
Swap: 509956096        0 509956096
MemTotal:    517116 kB
MemFree:      40684 kB
MemShared:    86536 kB
Buffers:     260340 kB
Cached:      100220 kB
SwapTotal:   498004 kB
SwapFree:    498004 kB

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-output.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: ABIT Computer Corp.: Unknown device a204
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d4000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a000
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at a400
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at a800
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
	Subsystem: Adaptec AHA-2940AU Single
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00
	Region 1: Memory at db000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at db001000 (32-bit, prefetchable)

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at db002000 (32-bit, prefetchable)

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4790 SoundBlaster PCI512
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b000
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at b400
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b800
	Region 1: Memory at db003000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at bc00
	Region 1: I/O ports at c000
	Region 2: I/O ports at c400
	Region 3: I/O ports at c800
	Region 4: I/O ports at cc00
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d4000000 (32-bit, prefetchable)
	Region 1: I/O ports at 9000
	Region 2: Memory at d9000000 (32-bit, non-prefetchable)
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi.txt"

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DXHS18Y          Rev: 03D1
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0c
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST11200N SUN1.05 Rev: 8358
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: SEAGATE  Model: ST32430N         Rev: 0250
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: H.41
  Type:   Direct-Access                    ANSI SCSI revision: 02

--LpQ9ahxlCli8rRTG--
