Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282453AbRL0IZw>; Thu, 27 Dec 2001 03:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284644AbRL0IZn>; Thu, 27 Dec 2001 03:25:43 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:48655 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S282453AbRL0IZW>; Thu, 27 Dec 2001 03:25:22 -0500
Subject: 2.4.18pre1 -- OOPS -- possibly in the cpia driver
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>,
        Johannes Erdfelt <johannes@erdfelt.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.21.18.01 (Preview Release)
Date: 27 Dec 2001 00:26:43 -0800
Message-Id: <1009441604.1901.11.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the text displayed immediately before the OOPS occurred:

	Parallel port driver for Vision CPiA based cameras V0.7.4
	usb.c: registered new driver cpia

ksymoops 2.4.3 on i686 2.4.15-pre6.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18pre1/ (specified)
     -m /boot/System.map-2.4.18pre1 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c0111e3a>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c03e370c ebx: 00000000 ecx: c1417f98 edx: c1417f90
esi: 00000202 edi: c0105000 ebp: 0008e000 esp: c1417f84
ds: 0018 es: 0018 ss: 0018
Stack: c03e3700 c1416000 c0105c7b 00000001 c1416000 c03e370c 00000000 c0356a00
        c036bfd8 c0105de0 c03e3700 c0362320 c0356a0c c02c7433 c0356a00 c02542d4
        c03a3d08 c0377ed4 c0356a00 c036c8b2 00010f00 c036c8fa c0105259 00010f00
Call trace: [<c0105c7b>] [<c0105de0>] [<c02c7433>] [<c02542d4>] [<c0105259>]
        [<c0105000>] [<c0105746>] [<c0105250>]
Code: 89 0b 56 9d 5b 5e c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90

>>EIP; c0111e3a <add_wait_queue_exclusive+1a/30>   <=====
Trace; c0105c7a <__down+3a/a0>
Trace; c0105de0 <__down_failed+8/c>
Trace; c02c7432 <stext_lock+1ea6/389c>
Trace; c02542d4 <usb_register+94/a0>
Trace; c0105258 <init+8/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105746 <kernel_thread+26/30>
Trace; c0105250 <init+0/140>
Code;  c0111e3a <add_wait_queue_exclusive+1a/30>
00000000 <_EIP>:
Code;  c0111e3a <add_wait_queue_exclusive+1a/30>   <=====
   0:   89 0b                     mov    %ecx,(%ebx)   <=====
Code;  c0111e3c <add_wait_queue_exclusive+1c/30>
   2:   56                        push   %esi
Code;  c0111e3c <add_wait_queue_exclusive+1c/30>
   3:   9d                        popf   
Code;  c0111e3e <add_wait_queue_exclusive+1e/30>
   4:   5b                        pop    %ebx
Code;  c0111e3e <add_wait_queue_exclusive+1e/30>
   5:   5e                        pop    %esi
Code;  c0111e40 <add_wait_queue_exclusive+20/30>
   6:   c3                        ret    
Code;  c0111e40 <add_wait_queue_exclusive+20/30>
   7:   eb 0d                     jmp    16 <_EIP+0x16> c0111e50 <remove_wait_queue+0/20>
Code;  c0111e42 <add_wait_queue_exclusive+22/30>
   9:   90                        nop    
Code;  c0111e44 <add_wait_queue_exclusive+24/30>
   a:   90                        nop    
Code;  c0111e44 <add_wait_queue_exclusive+24/30>
   b:   90                        nop    
Code;  c0111e46 <add_wait_queue_exclusive+26/30>
   c:   90                        nop    
Code;  c0111e46 <add_wait_queue_exclusive+26/30>
   d:   90                        nop    
Code;  c0111e48 <add_wait_queue_exclusive+28/30>
   e:   90                        nop    
Code;  c0111e48 <add_wait_queue_exclusive+28/30>
   f:   90                        nop    
Code;  c0111e4a <add_wait_queue_exclusive+2a/30>
  10:   90                        nop    
Code;  c0111e4a <add_wait_queue_exclusive+2a/30>
  11:   90                        nop    
Code;  c0111e4c <add_wait_queue_exclusive+2c/30>
  12:   90                        nop    
Code;  c0111e4c <add_wait_queue_exclusive+2c/30>
  13:   90                        nop    

<0>Kernel panic:  Attempted to kill init!

Possibly relevant information:

I am currently attempting to switch from using the vesafb to rivafb.
I have a nVidia Corporation GeForce 256 DDR (rev 10).
My lilo.conf append= line includes "video=riva".  The console seems to have 
successfully switched to using the rivafb driver before the OOPS occurs. 

Also, here are what may be the pertinent lines of my .config file:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

CONFIG_MK7=y

CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y

CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_ALLOW_INTS=y

CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_AGP=y
CONFIG_AGP_AMD=y

CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_CPIA=y
CONFIG_VIDEO_CPIA_PP=y
CONFIG_VIDEO_CPIA_USB=y

CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=y
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_WACOM=m
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=y
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=y
CONFIG_USB_STV680=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_PEGASUS=y
CONFIG_USB_KAWETH=y
CONFIG_USB_CATC=y
CONFIG_USB_CDCETHER=y
CONFIG_USB_USBNET=y
CONFIG_USB_USS720=y


