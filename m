Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSFYHpx>; Tue, 25 Jun 2002 03:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSFYHpw>; Tue, 25 Jun 2002 03:45:52 -0400
Received: from quechua.inka.de ([212.227.14.2]:32516 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S314787AbSFYHpu>;
	Tue, 25 Jun 2002 03:45:50 -0400
Mailbox-Line: From aj@dungeon.inka.de  Tue Jun 25 09:45:48 2002
Subject: 2.4.19-pre10 divide by 0 in irport
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org, dag@brattli.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Jun 2002 09:45:42 +0200
Message-Id: <1024991142.652.9.camel@simulacron>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
CPU:    0
EIP:    0010:[<c020631a>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 0001c200   ebx: 00000000     ecx: 000002f8       edx: 00000000
esi: cfefe800   edi: 00000286     ebp: 0001c200       esp: c02f1e80
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02f1000)
Stack: 00000280 00000000 cff38e60 00000287 00000282 c0206c71 cfefe800 00000000
       cfefe800 cfefe800 cfefea00 00000000 c032f5c0 02820018 cfefea00 00000000
       00000000 00000008 c0206640 cff38e60 00000000 cfefe800 c02bc1d4 cfefea00
Call Trace: [<c0206c71>] [<c0206640>] [<c0214648>] [<c021469b>] [c011e72f>]
  [<c011b89e>] [<c011b7d6>] [<c011b5fa>] [<c01099c2>] [<c010b878>] [<c0180018>]
  [<c018bd13>] [<c018bc2c>] [<c0106ba0>] [<c0106c29>] [<c0105000>] [<c0105027>]
Code: f7 f3 89 c3 bd 01 00 00 00 b8 c1 00 00 00 81 be a0 00 00 00


>>EIP; c020631a <irport_change_speed+2e/8c>   <=====

>>eax; 0001c200 Before first symbol
>>esi; cfefe800 <END_OF_CODE+fb9ced8/????>
>>ebp; 0001c200 Before first symbol
>>esp; c02f1e80 <init_task_union+1e80/2000>

Trace; c0206c71 <ircc_change_speed+131/190>
Trace; c0206640 <irport_timeout+30/78>
Trace; c0214648 <dev_watchdog+0/9c>
Trace; c021469b <dev_watchdog+53/9c>
Trace; c011b89e <bh_action+1a/40>
Trace; c011b7d6 <tasklet_hi_action+4a/70>
Trace; c011b5fa <do_softirq+5a/a4>
Trace; c01099c2 <do_IRQ+96/a8>
Trace; c010b878 <call_do_IRQ+5/d>
Trace; c0180018 <acpi_ex_copy_string_to_string+9c/a4>
Trace; c018bd13 <pr_power_idle+e7/22c>
Trace; c018bc2c <pr_power_idle+0/22c>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106c29 <cpu_idle+41/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  c020631a <irport_change_speed+2e/8c>
00000000 <_EIP>:
Code;  c020631a <irport_change_speed+2e/8c>   <=====
   0:   f7 f3                     div    %ebx   <=====
Code;  c020631c <irport_change_speed+30/8c>
   2:   89 c3                     mov    %eax,%ebx
Code;  c020631e <irport_change_speed+32/8c>
   4:   bd 01 00 00 00            mov    $0x1,%ebp
Code;  c0206323 <irport_change_speed+37/8c>
   9:   b8 c1 00 00 00            mov    $0xc1,%eax
Code;  c0206328 <irport_change_speed+3c/8c>
   e:   81 be a0 00 00 00 00      cmpl   $0x0,0xa0(%esi)
Code;  c020632f <irport_change_speed+43/8c>
  15:   00 00 00 

 <0>Kernel panic: Aiee, killing in interrupt handler!

2 warnings issued.  Results may not be reliable.

software is debian woody, hardware is a dell latitude c600 notebook
(p3 850, ..., smc-ircc irda thing, maestro3 sound).
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_RADIO=y
CONFIG_WAVELAN=m
CONFIG_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_WAVELAN=y
CONFIG_IRDA=y
CONFIG_IRCOMM=y
CONFIG_IRTTY_SIR=y
CONFIG_IRPORT_SIR=y
CONFIG_SMC_IRCC_FIR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_R128=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_MAESTRO3=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_AUDIO=m
CONFIG_USB_PRINTER=m

anything else i can do?

best regards, andreas



