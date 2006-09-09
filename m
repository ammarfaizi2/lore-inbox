Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWIIKPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWIIKPj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 06:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWIIKPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 06:15:39 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:13586 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751122AbWIIKPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 06:15:36 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Oops after 30 days of uptime
Date: Sat, 9 Sep 2006 12:15:25 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
References: <200609011852.39572.linux@rainbow-software.org> <20060909052036.GD541@1wt.eu>
In-Reply-To: <20060909052036.GD541@1wt.eu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+QpAF7abZehF/Te"
Message-Id: <200609091215.26617.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+QpAF7abZehF/Te
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 09 September 2006 07:20, you wrote:
> On Fri, Sep 01, 2006 at 06:52:39PM +0200, Ondrej Zary wrote:
> > Hello,
> > my home router crashed after about a month. It does this sometimes but
> > this time I was able to capture the oops. Here is the result of running
> > ksymoops on it (took a photo of the screen and then manually converted to
> > plain-text). Does it look like a bug or something other?
>
> I have another problem with your oops. It looks like you used a /proc/ksyms
> from another running kernel. The symbol decoding does not match the code.
> For instance, in the disassembled code, you'll see that two functions are
> indicated for the same sequence of instructions (init_or_cleanup then
> ip_conntrack_protocol_register). And the difference does not look like a
> small offset, since neither of those functions seem to produce comparable
> code here.

Sorry, it's the first time I tried to use ksymoops (was reporting only 2.6 
oopses before) and I probably screwed up. The problem is that there is 
no /proc/ksyms (maybe because CONFIG_MODULES is disabled?):

root@router:~# ls -l /proc/k*
-r-------- 1 root root 33558528 2006-09-09 11:58 /proc/kcore
-r-------- 1 root root        0 2006-09-07 14:32 /proc/kmsg

I also didn't have the System.map file but found it in the tree on my desktop 
machine (where that kernel was compiled) - haven't touched that directory 
since the kernel compile so it should be correct one.

> You should backup the /proc/ksyms from your currently running kernel, and
> reuse it to decode the next oops when it occurs. BTW, could you provide
> the full config file and tell us what version of GCC you're using ? Maybe
> we can try to find the same code sequence in a module and identify it
> without waiting for further oops.

I've used GCC 2.95.3. Attached is dmesg and config file.

>
> > ksymoops 2.4.11 on i486 2.4.31.  Options used
> >      -V (default)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.31/ (default)
> >      -m System.map (specified)
> >
> > Error (regular_file): read_ksyms stat /proc/ksyms failed
> > No modules in ksyms, skipping objects
> > No ksyms, skipping lsmod
> > Unable to handle kernel paging request at virtual address c2000000
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01eeb9e>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010a96
> > eax: db1cec0a   ebx: 7af4a90b   ecx: fff113e8   edx: 00000008
> > esi: c1ffffe8   edi: c17835a4   ebp: c0b4b8b4   esp: c0227cd0
> > ds: 0018   es: 0018   ss: 0018
> > Process swapper (pid: 0, stackpage=c0227000)
> > Stack: fd00a8c0 c17835a4 c01e6587 c0227ce8 00000008 0000a0c5 0000dff0
> > 0000200f c01e8757 0000dff0 0000200f 00005f3a 00000000 00000028 c1783590
> > c0b4b8b4 c01e7162 c1783590 00000028 c0b4b8b4 00000000 00000006 c0b4b810
> > 00000000 Call Trace:    [<c01e6587>] [<c01e8757>] [<c01e7162>]
> > [<c01e72ea>] [<c017fda8>] [<c01baca0>] [<c01e5ed4>] [<c01baca0>]
> > [<c01e5fba>] [<c01baca0>] [<c01afe00>] [<c01baca0>] [<c01baca0>]
> > [<c01b00d0>] [<c01baca0>] [<c01b8270>] [<c01b9652>] [<c01baca0>]
> > [<c01b8270>] [<c01b82ba>] [<c01b0110>] [<c01b05dc>] [<c01b8214>]
> > [<c01b8270>] [<c01b7220>] [<c01b739b>] [<c01b7220>] [<c01b0110>]
> > [<c01b70a6>] [<c01b7220>] [<c01a87bb>] [<c01a885d>] [<c01a8970>]
> > [<c011427a>] [<c01081cd>] [<c0105250>] [<c010a3b8>] [<c0105250>]
> > [<c0105273>] [<c01052d8>] [<c0105000>] [<c0105027>]
> > Code: 8b 5e 18 11 d8 8b 5e 1c 11 d8 8d 76 20 49 75 d3 83 d0 00 89
> >
> > >>EIP; c01eeb9e <init_or_cleanup+15e/160>   <=====
> > >>
> > >>esp; c0227cd0 <bdf_prm+30/40>
> >
> > Trace; c01e6587 <icmp_timestamp+47/f0>
> > Trace; c01e8757 <inet_sock_release+57/80>
> > Trace; c01e7162 <inet_rtm_newaddr+42/190>
> > Trace; c01e72ea <devinet_ioctl+3a/680>
> > Trace; c017fda8 <ei_start_xmit+248/260>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01e5ed4 <icmp_send+84/350>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01e5fba <icmp_send+16a/350>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01afe00 <nf_iterate+0/80>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01b00d0 <nf_hook_slow+80/150>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01b8270 <htb_timer+30/50>
> > Trace; c01b9652 <htb_dump_class+22/260>
> > Trace; c01baca0 <sfq_dequeue+e0/1c0>
> > Trace; c01b8270 <htb_timer+30/50>
> > Trace; c01b82ba <htb_rate_timer+2a/120>
> > Trace; c01b0110 <nf_hook_slow+c0/150>
> > Trace; c01b05dc <eth_header+2c/120>
> > Trace; c01b8214 <htb_requeue+114/140>
> > Trace; c01b8270 <htb_timer+30/50>
> > Trace; c01b7220 <htb_classify+f0/110>
> > Trace; c01b739b <htb_debug_dump+15b/300>
> > Trace; c01b7220 <htb_classify+f0/110>
> > Trace; c01b0110 <nf_hook_slow+c0/150>
> > Trace; c01b70a6 <L2T+26/30>
> > Trace; c01b7220 <htb_classify+f0/110>
> > Trace; c01a87bb <netif_receive_skb+db/140>
> > Trace; c01a885d <process_backlog+3d/110>
> > Trace; c01a8970 <net_rx_action+40/110>
> > Trace; c011427a <do_softirq+5a/b0>
> > Trace; c01081cd <do_IRQ+9d/b0>
> > Trace; c0105250 <default_idle+0/30>
> > Trace; c010a3b8 <call_do_IRQ+5/d>
> > Trace; c0105250 <default_idle+0/30>
> > Trace; c0105273 <default_idle+23/30>
> > Trace; c01052d8 <cpu_idle+38/50>
> > Trace; c0105000 <_stext+0/0>
> > Trace; c0105027 <rest_init+27/30>
> >
> > Code;  c01eeb9e <init_or_cleanup+15e/160>
> > 00000000 <_EIP>:
> > Code;  c01eeb9e <init_or_cleanup+15e/160>   <=====
> >    0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
> > Code;  c01eeba1 <ip_conntrack_protocol_register+1/70>
> >    3:   11 d8                     adc    %ebx,%eax
> > Code;  c01eeba3 <ip_conntrack_protocol_register+3/70>
> >    5:   8b 5e 1c                  mov    0x1c(%esi),%ebx
> > Code;  c01eeba6 <ip_conntrack_protocol_register+6/70>
> >    8:   11 d8                     adc    %ebx,%eax
> > Code;  c01eeba8 <ip_conntrack_protocol_register+8/70>
> >    a:   8d 76 20                  lea    0x20(%esi),%esi
> > Code;  c01eebab <ip_conntrack_protocol_register+b/70>
> >    d:   49                        dec    %ecx
> > Code;  c01eebac <ip_conntrack_protocol_register+c/70>
> >    e:   75 d3                     jne    ffffffe3 <_EIP+0xffffffe3>
> > Code;  c01eebae <ip_conntrack_protocol_register+e/70>
> >   10:   83 d0 00                  adc    $0x0,%eax
> > Code;  c01eebb1 <ip_conntrack_protocol_register+11/70>
> >   13:   89 00                     mov    %eax,(%eax)
> >
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> >
> > 1 error issued.  Results may not be reliable.
> >
> >
> > --
> > Ondrej Zary
>
> Regards,
> Willy

-- 
Ondrej Zary

--Boundary-00=_+QpAF7abZehF/Te
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_X86_F00F_WORKS_OK is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
CONFIG_MATH_EMULATION=y
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
# CONFIG_PCI_NAMES is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=y
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_TARGET_REDIRECT=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
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
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_CSZ is not set
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_MEDLEY is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

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
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
# CONFIG_EEXPRESS_PRO is not set
CONFIG_HPLAN_PLUS=y
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
CONFIG_NE2000=y
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

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
CONFIG_INPUT=y
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_EXT2_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

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
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

--Boundary-00=_+QpAF7abZehF/Te
Content-Type: text/plain;
  charset="iso-8859-1";
  name="router-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="router-dmesg.txt"

Linux version 2.4.31 (root@pentium) (gcc version 2.95.3 20010315 (release)) #2 Sun Aug 14 13:22:02 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
32MB LOWMEM available.
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
DMI not present.
Kernel command line: auto BOOT_IMAGE=Linux2431 ro root=302 reboot=b ether=10,0x300,0,0,eth0 ether=9,0x340,0,0,eth1
Initializing CPU#0
Console: colour VGA+ 80x25
Calibrating delay loop... 22.16 BogoMIPS
Memory: 30536k/32768k available (969k kernel code, 1848k reserved, 201k data, 76k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU:     After generic, caps: 00000000 00000000 00000000 00000000
CPU:             Common caps: 00000000 00000000 00000000 00000000
CPU: UMC U5S stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Fixing base address flags for device 00:12.1
PCI: Ignoring BAR0-3 of IDE controller 00:12.1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Keyboard timed out[1]
keyboard: Timeout - AT keyboard not present?(ed)
Keyboard timed out[1]
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Non-volatile memory driver v1.2
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 c0 df 20 a2 08
eth0: NE2000 found at 0x300, using IRQ 10.
hp-plus.c:v1.10 9/24/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth1: HP-PC-LAN+ at 0x340, 08 00 09 81 79 3b ID 0080, IRQ 9, programmed-I/O mode.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
UM8886BF: IDE controller at PCI slot 00:12.1
UM8886BF: chipset revision 16
UM8886BF: not 100% native mode: will probe irqs later
hda: WDC AC14300R, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 8421840 sectors (4312 MB) w/512KiB Cache, CHS=524/255/63
Partition check:
 hda: hda1 hda2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
ip_conntrack version 2.1 (256 buckets, 2048 max) - 284 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 76k freed
Adding Swap: 125172k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
--Boundary-00=_+QpAF7abZehF/Te--
