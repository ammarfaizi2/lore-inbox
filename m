Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSFRK2e>; Tue, 18 Jun 2002 06:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317379AbSFRK2d>; Tue, 18 Jun 2002 06:28:33 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:58125 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S317378AbSFRK2a>; Tue, 18 Jun 2002 06:28:30 -0400
Date: Tue, 18 Jun 2002 12:31:29 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.22: FB_VESA - early crash in fbcon_cursor()
Message-ID: <Pine.LNX.4.21.0206181001300.1798-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

no luck here getting 2.5.22 to boot on my ob800 with vesafb enabled.
Same with 2.5.21. Last one working was 2.5.16 but I haven't tried 17-20.
Box oopses due to NULL-pointer dereference during inital fbdev setup.

config, dmesg + decoded dump from serial console below.

Regards,
Martin

--------------------------------
Loading linux.2522............
Linux version 2.5.22 (root@srv.diehl.home) (gcc version 2.96 20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #3 Mon Jun 17 23:55:17 CEST 2002
Video mode to be used for restore is 314
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
48MB LOWMEM available.
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux.2522 ro root=301 video=vesa console=ttyS0,9600 console=tty0
Initializing CPU#0
Detected 164.663 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 328.49 BogoMIPS
Memory: 46768k/49152k available (879k kernel code, 1996k reserved, 237k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xeefc2, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VLSI 82C534 [1004/0102] at 00:01.0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Disk quotas vdquot_6.5.1
devfs: v1.17 (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
vesafb: framebuffer at 0xc0000000, mapped to 0xc3800000, size 1088k
vesafb: mode is 800x600x16, linelength=1600, pages=0
vesafb: protected mode interface info at c000:7d70
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0

-----------------------

2.5.16 goes on with:

Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
...

-----------------------

2.5.22 crashes here:

ksymoops 2.3.4 on i586 2.5.16.  Options used
     -v /tmp/vmlinux-2.5.22 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.22/ (specified)
     -m /boot/System.map-2.5.22 (specified)

No modules in ksyms, skipping objects
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
c0192baf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0192baf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c02797a0   ecx: 00000000   edx: 00000000
esi: 00000002   edi: c106d000   ebp: 00000018   esp: c109fd04
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 00000000 00000000 c0264860 00000ad4 00000000 c0177281 c106d000 
       00000002 00000000 00000000 c017a79c 00000000 c0250000 c020b880 c02522d4 
       00000ad4 00000b04 c01126d9 c020b880 c02522d4 00000030 00000b04 00000b04 
Call Trace: [<c0177281>] [<c017a79c>] [<c01126d9>] [<c011283f>] [<c0112a3e>] 
   [<c01129c3>] [<c0192193>] [<c0192193>] [<c010ed34>] [<c012a0f1>] [<c0127897>] 
   [<c010ea20>] [<c0106f14>] [<c0192193>] [<c0106ebf>] [<c0191daa>] [<c01775a0>] 
   [<c017b0ae>] [<c01910c6>] [<c0105000>] [<c0105029>] [<c0105000>] [<c01055b6>] 
   [<c0105020>] 
Code: 8b 40 18 85 c0 74 4a 66 8b 7f 2c 89 ea 66 89 bb e4 00 00 00 
Error (Oops_bfd_perror): set_section_contents Bad value

>>EIP; c0192baf <fbcon_cursor+6f/200>   <=====
Trace; c0177281 <hide_cursor+81/90>
Trace; c017a79c <vt_console_print+8c/310>
Trace; c01126d9 <__call_console_drivers+39/50>
Trace; c011283f <call_console_drivers+df/f0>
Trace; c0112a3e <release_console_sem+2e/80>
Trace; c01129c3 <printk+103/110>
Trace; c0192193 <fbcon_setup+2c3/920>
Trace; c0192193 <fbcon_setup+2c3/920>
Trace; c010ed34 <do_page_fault+314/4ff>
Trace; c012a0f1 <__alloc_pages+41/1b0>
Trace; c0127897 <kmem_cache_grow+c7/2f0>
Trace; c010ea20 <do_page_fault+0/4ff>
Trace; c0106f14 <error_code+34/40>
Trace; c0192193 <fbcon_setup+2c3/920>
Trace; c0106ebf <common_interrupt+1f/30>
Trace; c0191daa <fbcon_init+ba/f0>
Trace; c01775a0 <visual_init+a0/100>
Trace; c017b0ae <take_over_console+9e/170>
Trace; c01910c6 <register_framebuffer+f6/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105029 <init+9/130>
Trace; c0105000 <_stext+0/0>
Trace; c01055b6 <kernel_thread+26/30>
Trace; c0105020 <init+0/130>

 <0>Kernel panic: Attempted to kill init!

1 error issued.  Results may not be reliable.

---------------------------------

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
# CONFIG_M686 is not set
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
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

[...]

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_CFB24 is not set
# CONFIG_FBCON_CFB32 is not set
# CONFIG_FBCON_ACCEL is not set
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

[...]

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y

