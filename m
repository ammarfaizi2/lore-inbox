Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314497AbSDXAus>; Tue, 23 Apr 2002 20:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSDXAup>; Tue, 23 Apr 2002 20:50:45 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:56009 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S314497AbSDXAuo>; Tue, 23 Apr 2002 20:50:44 -0400
Date: Tue, 23 Apr 2002 20:56:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020423205601.A21267@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds like Jens and Martin have a handle on this
already.  Just in case this helps.  No modules.  

Oops on 2.5.9 at boot time.

Here is the last part of the boot message:

Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
VIA Technologies, Inc. Bus Master IDE: chipset revision 6
VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 51536U3, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdc: Maxtor 52049U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=29777/16/63, UDMA(33)
ide: unexpected interrupt 1 15
hdc: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(33)
ide: unexpected interrupt 0 14
(oops here)


ksymoops output

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01bf5f6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01bf5f6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000004   ebx: d7f61eb4   ecx: 00000001   edx: 00000000
esi: d7f61e30   edi: c02c8b6c   ebp: 00000292   esp: c026bedc
ds: 0018   es: 0018   ss: 0018
Stack: d7f61e30 00000001 c02c8b6c 00000003 00000001 c01c2f1b c02c8b6c 00000001
       00000000 c01c9a52 c02c8b6c 00000001 00000018 d7f61eb4 d7f61e30 c01ca783
       c02c8b6c 00000001 00000000 c02c8b6c d7f622c0 c02c8840 c02c8f0c d7f62380
Call Trace: [<c01c2f1b>] [<c01c9a52>] [<c01ca783>] [<c01c11ba>] [<c01ca6bc>]
   [<c01080fc>] [<c0108262>] [<c0105000>] [<c0106eff>] [<c0105240>] [<c0105000>]
   [<c0105263>] [<c01052d4>] [<c0105019>]
Code: c7 04 02 00 00 00 00 8b 53 0c 8b 87 34 02 00 00 0f b3 10 8b


>>EIP; c01bf5f6 <__ide_end_request+fe/140>   <=====

>>ebx; d7f61eb4 <END_OF_CODE+17c930f8/????>
>>esi; d7f61e30 <END_OF_CODE+17c93074/????>
>>edi; c02c8b6c <ide_hwifs+32c/3a70>
>>esp; c026bedc <init_thread_union+1edc/2000>

Trace; c01c2f1b <ide_end_request+f/14>
Trace; c01c9a52 <cdrom_end_request+42/4c>
Trace; c01ca783 <cdrom_pc_intr+c7/1d0>
Trace; c01c11ba <ide_intr+c6/13c>
Trace; c01ca6bc <cdrom_pc_intr+0/1d0>
Trace; c01080fc <handle_IRQ_event+30/5c>
Trace; c0108262 <do_IRQ+6a/a8>
Trace; c0105000 <_stext+0/0>
Trace; c0106eff <common_interrupt+1f/30>
Trace; c0105240 <default_idle+0/28>
Trace; c0105000 <_stext+0/0>
Trace; c0105263 <default_idle+23/28>
Trace; c01052d4 <cpu_idle+28/38>
Trace; c0105019 <rest_init+19/1c>

Code;  c01bf5f6 <__ide_end_request+fe/140>
00000000 <_EIP>:
Code;  c01bf5f6 <__ide_end_request+fe/140>   <=====
   0:   c7 04 02 00 00 00 00      movl   $0x0,(%edx,%eax,1)   <=====
Code;  c01bf5fd <__ide_end_request+105/140>
   7:   8b 53 0c                  mov    0xc(%ebx),%edx
Code;  c01bf600 <__ide_end_request+108/140>
   a:   8b 87 34 02 00 00         mov    0x234(%edi),%eax
Code;  c01bf606 <__ide_end_request+10e/140>
  10:   0f b3 10                  btr    %edx,(%eax)
Code;  c01bf609 <__ide_end_request+111/140>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

This config has been working with other kernels, including 2.5.8.

grep ^CONFIG .config
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_REISERFS_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

-- 
Randy Hron

