Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQLaP1z>; Sun, 31 Dec 2000 10:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbQLaP1p>; Sun, 31 Dec 2000 10:27:45 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:52715 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129588AbQLaP1c>; Sun, 31 Dec 2000 10:27:32 -0500
Date: Sun, 31 Dec 2000 06:50:44 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: test13-pre6 -- OOPS at boot time in kmem_cache_create
 (usb-ohcirelated)
To: Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <078d01c0733a$66594e00$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <3A4EDA52.10800@megapathdsl.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This BUG() probably means you need to enable DEBUG in mm/slab.c
before you try have OHCI use slab poisoning.

Enable both, or neither, and all should be fine.

- Dave


----- Original Message ----- 
From: Miles Lane <miles@megapathdsl.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>; David Brownell <david-b@pacbell.net>
Sent: Saturday, December 30, 2000 11:03 PM
Subject: test13-pre6 -- OOPS at boot time in kmem_cache_create (usb-ohcirelated)


> This OOPS occured at boot time when I did not have my Belkin
> BusPort Mobile USB host-controller inserted.  /etc/usb/rc.usb
> tried loading usb-ohci.  After the boot process completed
> (after the OOPS occured), I was unable to unload the module
> and lsmod showed that usb-ohci was still initializing.
> Presumably, it got wedged when the OOPS occured?
> 
> ksymoops 2.3.5 on i686 2.4.0-test13-pre6.  Options used
> 
> Kernel command line: BOOT_IMAGE=Serial-Debug ro root=305 pci=biosirq 
> console=ttyS0,38400 console=tty0 setup_delay=10
> kernel BUG at slab.c:660!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01284bc>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010292
> eax: 0000001a   ebx: 00002800   ecx: 00000001   edx: 00000001
> esi: 00002800   edi: c5824929   ebp: c58251bc   esp: c4af1eb4
> ds: 0018   es: 0018   ss: 0018
> Process modprobe (pid: 84, stackpage=c4af1000)
> Stack: c01ee425 c01ee4a5 00000294 00002800 c58247d0 00000001 c58251bc 
> 000041f0
>         c021c900 000038d8 000038db 00000286 00000203 00000000 c58251b4 
> c5821079
>         c5824921 00000020 00000000 00002800 00000000 00000000 c5821000 
> c58247d6
> Call Trace: [<c01ee425>] [<c01ee4a5>] [<c58247d0>] [<c58251bc>] 
> [<c58251b4>] [<c5821079>] [<c5824921>]
>         [<c5821000>] [<c58247d6>] [<c5821000>] [<c0116b78>] [<c5813000>] 
> [<c5813000>] [<c58251a8>] [<c5813000>]
>         [<c5821060>] [<c0108d57>]
> Code: 0f 0b 83 c4 0c 6a 07 68 80 c6 21 c0 e8 03 07 00 00 89 c5 83
> 
>  >>EIP; c01284bc <kmem_cache_create+94/3b8>   <=====
> Trace; c01ee425 <tvecs+195d/abb8>
> Trace; c01ee4a5 <tvecs+19dd/abb8>
> Trace; c58247d0 <[usb-ohci]init_module+0/0>
> Trace; c58251bc <[usb-ohci].bss.end+15/39>
> Trace; c58251b4 <[usb-ohci].bss.end+d/39>
> Trace; c5821079 <[usb-ohci]ohci_mem_init+19/78>
> Trace; c5824921 <[usb-ohci].rodata.start+101/76c>
> Trace; c5821000 <[usbcore]__kstrtab_usb_devfs_handle+1864/18c4>
> Trace; c58247d6 <[usb-ohci]ohci_hcd_init+6/3c>
> Trace; c5821000 <[usbcore]__kstrtab_usb_devfs_handle+1864/18c4>
> Trace; c0116b78 <sys_init_module+58c/630>
> Trace; c5813000 <_end+557b9b0/557ba10>
> Trace; c5813000 <_end+557b9b0/557ba10>
> Trace; c58251a8 <[usb-ohci].bss.end+1/39>
> Trace; c5813000 <_end+557b9b0/557ba10>
> Trace; c5821060 <[usb-ohci]ohci_mem_init+0/78>
> Trace; c0108d57 <system_call+33/38>
> Code;  c01284bc <kmem_cache_create+94/3b8>
> 00000000 <_EIP>:
> Code;  c01284bc <kmem_cache_create+94/3b8>   <=====
>     0:   0f 0b                     ud2a      <=====
> Code;  c01284be <kmem_cache_create+96/3b8>
>     2:   83 c4 0c                  add    $0xc,%esp
> Code;  c01284c1 <kmem_cache_create+99/3b8>
>     5:   6a 07                     push   $0x7
> Code;  c01284c3 <kmem_cache_create+9b/3b8>
>     7:   68 80 c6 21 c0            push   $0xc021c680
> Code;  c01284c8 <kmem_cache_create+a0/3b8>
>     c:   e8 03 07 00 00            call   714 <_EIP+0x714> c0128bd0 
> <kmem_cache_alloc+0/58>
> Code;  c01284cd <kmem_cache_create+a5/3b8>
>    11:   89 c5                     mov    %eax,%ebp
> Code;  c01284cf <kmem_cache_create+a7/3b8>
>    13:   83 00 00                  addl   $0x0,(%eax)
> 
> 
> 1 warning issued.  Results may not be reliable.
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
