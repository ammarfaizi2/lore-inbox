Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSBDGfe>; Mon, 4 Feb 2002 01:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288597AbSBDGfZ>; Mon, 4 Feb 2002 01:35:25 -0500
Received: from ppp1370-cwdsl-paris.fr.cw.net ([62.210.117.91]:28684 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S288595AbSBDGfI>; Mon, 4 Feb 2002 01:35:08 -0500
Message-ID: <3C5E2C08.1080105@paulbristow.net>
Date: Mon, 04 Feb 2002 07:36:56 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Oops with ide-floppy in 2.5.2 / 2.5.3
In-Reply-To: <Pine.LNX.4.21.0202040023410.15910-100000@banaan.taco.dhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll take a look at it.

Taco IJsselmuiden wrote:

> Hi,
> 
> the ide-floppy driver (0.98a) produces oops + hang (easy
> reproducable) with 2.5.2 (and onwards). doesn't matter if module or
> in-kernel. Here's the info when 'using' as module:
> 
> 
> taco@brood:~$ cat /proc/version 
> Linux version 2.5.3-K0 (root@brood) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Feb 1 12:36:54 CET 2002
> 
> here's the output from ksymoops:
> 
> ksymoops 2.4.3 on i686 2.5.3-K0.  Options used
>      -v vmlinux (specified)
>      -k /proc/ksyms (specified)
>      -l /proc/modules (specified)
>      -o /lib/modules/2.5.3-K0/ (specified)
>      -m /boot/System.map-2.5.3-K0 (specified)
> 
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01d5f10>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010002
> eax: c3f73d24   ebx: c0338ec0   ecx: c0338ec0   edx: c556701c
> esi: c7fcd300   edi: 00000000   ebp: 00000002   esp: c02d3e80
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c02d3000)
> Stack: 00000202 c0338ec0 c0338ec0 c01e8242 c0338ec0 c556701c c0338ec0
> c556701c
>        c556600c c0338ec0 c0338ec0 c02d3ec4 c7fef380 00000000 00000000
> c02d3ecc
>        c02d3ecc 00000000 00000000 c02d3ecc c02d3ecc c8a92358 c0338ec0
> c556701c
> Call Trace: [<c01e8242>] [<c8a92358>] [<c8a92572>] [<c8a92636>]
> [<c01e807d>]
>    [<c8a92580>] [<c0109a4f>] [<c0109bce>] [<c0106c40>] [<c0106c40>]
> [<c0106c40>]
>    [<c0106c04>] [<c0121f65>] [<c0106cc5>] [<c0105000>] [<c0105019>]
> Code: 0f 0b 8b 42 1c a8 04 75 06 83 e0 01 8b 3c 86 89 7a 08 8b 01
> 
> 
>>>EIP; c01d5f10 <elevator_linus_add_request+20/60>   <=====
>>>
> Trace; c01e8242 <ide_do_drive_cmd+d2/110>
> Trace; c8a92358 <END_OF_CODE+163ea2/????>
> Trace; c8a92572 <END_OF_CODE+1640bc/????>
> Trace; c8a92636 <END_OF_CODE+164180/????>
> Trace; c01e807c <ide_intr+bc/120>
> Trace; c8a92580 <END_OF_CODE+1640ca/????>
> Trace; c0109a4e <handle_IRQ_event+2e/60>
> Trace; c0109bce <do_IRQ+6e/b0>
> Trace; c0106c40 <default_idle+0/30>
> Trace; c0106c40 <default_idle+0/30>
> Trace; c0106c40 <default_idle+0/30>
> Trace; c0106c04 <gunzip+4d4/4f0>
> Trace; c0121f64 <check_pgt_cache+4/20>
> Trace; c0106cc4 <cpu_idle+34/40>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105018 <rest_init+18/20>
> Code;  c01d5f10 <elevator_linus_add_request+20/60>
> 00000000 <_EIP>:
> Code;  c01d5f10 <elevator_linus_add_request+20/60>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c01d5f12 <elevator_linus_add_request+22/60>
>    2:   8b 42 1c                  mov    0x1c(%edx),%eax
> Code;  c01d5f14 <elevator_linus_add_request+24/60>
>    5:   a8 04                     test   $0x4,%al
> Code;  c01d5f16 <elevator_linus_add_request+26/60>
>    7:   75 06                     jne    f <_EIP+0xf> c01d5f1e
> <elevator_linus_add_request+2e/60>
> Code;  c01d5f18 <elevator_linus_add_request+28/60>
>    9:   83 e0 01                  and    $0x1,%eax
> Code;  c01d5f1c <elevator_linus_add_request+2c/60>
>    c:   8b 3c 86                  mov    (%esi,%eax,4),%edi
> Code;  c01d5f1e <elevator_linus_add_request+2e/60>
>    f:   89 7a 08                  mov    %edi,0x8(%edx)
> Code;  c01d5f22 <elevator_linus_add_request+32/60>
>   12:   8b 01                     mov    (%ecx),%eax
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 
> here's the oops itself, if usefull ;))
> (copied by hand...)
> 
> brood:~# insmod ide-floppy
> Using /lib/modules/2.5.3-K0/kernel/drivers/ide/ide-floppy.o
> ide-floppy driver 0.98a
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01d5f10>]    Not tainted
> EFLAGS: 00010002
> eax: c3f73d24   ebx: c0338ec0   ecx: c0338ec0   edx: c556701c
> esi: c7fcd300   edi: 00000000   ebp: 00000002   esp: c02d3e80
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c02d3000)
> Stack: 00000202 c0338ec0 c0338ec0 c01e8242 c0338ec0 c556701c c0338ec0 c556701c
>        c556600c c0338ec0 c0338ec0 c02d3ec4 c7fef380 00000000 00000000 c02d3ecc
>        c02d3ecc 00000000 00000000 c02d3ecc c02d3ecc c8a92358 c0338ec0
> c556701c
> Call Trace: [<c01e8242>] [<c8a92358>] [<c8a92572>] [<c8a92636>] [<c01e807d>]
>    [<c8a92580>] [<c0109a4f>] [<c0109bce>] [<c0106c40>] [<c0106c40>] [<c0106c40>]
>    [<c0106c04>] [<c0121f65>] [<c0106cc5>] [<c0105000>] [<c0105019>]
> 
> Code: 0f 0b 8b 42 1c a8 04 75 06 83 e0 01 8b 3c 86 89 7a 08 8b 01
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> 
> 
> 
> sh ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux brood 2.5.3-K0 #1 Fri Feb 1 12:36:54 CET 2002 i686 unknown
>  
> Gnu C                  2.95.4
> Gnu make               3.79.1
> util-linux             2.11n
> mount                  2.11n
> modutils               2.4.13
> e2fsprogs              1.25
> reiserfsprogs          3.x.0j
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> Modules Loaded         sd_mod usb-storage scsi_mod usb-ohci usbcore
> ip_nat_ftp iptable_nat ne 8390 crc32 3c59x
> 
> 
> 
> cat /proc/cpuinfo 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 1
> model name      : AMD-K7(tm) Processor
> stepping        : 2
> cpu MHz         : 499.043
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat mmx syscall mmxext 3dnowext 3dnow
> bogomips        : 996.14
> 
> 
> cat /proc/modules 
> sd_mod                  9400   0 (unused)
> usb-storage            20476   0 (unused)
> scsi_mod               66808   1 [sd_mod usb-storage]
> usb-ohci               18016   0 (unused)
> usbcore                55020   1 [usb-storage usb-ohci]
> ip_nat_ftp              3104   0 (unused)
> iptable_nat            14644   6 [ip_nat_ftp]
> ne                      6272   1
> 8390                    5872   0 [ne]
> crc32                    888   1 [8390]
> 3c59x                  25032   1
> 
> 
> 
> cat /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0340-035f : eth1
> 0376-0376 : ide1
> 03bc-03be : parport0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> e000-e003 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
> Controller
> e400-e47f : 3Com Corporation 3c900B-Combo [Etherlink XL Combo]
>   e400-e47f : 00:0a.0
> e800-e83f : Ensoniq ES1371 [AudioPCI-97]
>   e800-e83f : es1371
> f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
>   f000-f007 : ide0
>   f008-f00f : ide1
> 
> 
> cat /proc/iomem 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-07ffffff : System RAM
>   00100000-0026d9bb : Kernel code
>   0026d9bc-002d049f : Kernel data
> d8000000-d9ffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
> Controller
> da000000-dbffffff : PCI Bus #01
>   da000000-daffffff : nVidia Corporation Vanta [NV6]
> dc000000-ddffffff : PCI Bus #01
>   dc000000-ddffffff : nVidia Corporation Vanta [NV6]
> df000000-df000fff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
>   df000000-df000fff : usb-ohci
> df001000-df00107f : 3Com Corporation 3c900B-Combo [Etherlink XL Combo]
> df002000-df002fff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
> Controller
> ffff0000-ffffffff : reserved
> 
> 
> 
> if there's any more info you need to figure this one out or patches for me
> to test, just let me know...
> 
> Cheers,
> Taco.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

