Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbQKNVmG>; Tue, 14 Nov 2000 16:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130704AbQKNVlz>; Tue, 14 Nov 2000 16:41:55 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:64202 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S130420AbQKNVlg>; Tue, 14 Nov 2000 16:41:36 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Ooops with 2.4.0-test11pre4 (vgacon_font)
Message-ID: <3A11AA7E.3439C9DD@fi.muni.cz>
Date: Tue, 14 Nov 2000 21:11:26 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11pre4 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an oops while using console-screen setup
on my Debian Woody SMP machine.


Anyway - could anyone add some comments to those
changes in kernel like removing get_module_symbol,
put_module_symbol.

I've tried to fix Nvidia's driver for this latest
kernel so I've made this change in os-interface.c
--
    //symbol_value = get_module_symbol(NV_MODULE_NAME, symbol_name);
    routine = inter_module_get_request(symbol_name, NV_MODULE_NAME);
    
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
    //put_module_symbol(symbol_value);
    if (routine)
	inter_module_put(symbol_name);
#endif

 done:
     //return (void *) symbol_value;
     return routine;
---

However it doesn't work - how could I fully replace
those old functions with new ones??
Or even better - does anyone maintaine uptodate NVdriver module ?


ksymoops 2.3.4 on i686 2.4.0-test11pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11pre4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c02099a3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: 00000160   ebx: 000003f5   ecx: 000001df   edx: 000003d5
esi: 00000010   edi: 0000001e   ebp: 000003d5   esp: c8d23c6c
ds: 0018   es: 0018   ss: 0018
Process consolechars (pid: 666, stackpage=c8d23000)
Stack: c8d23d74 c8d23d74 c8d23cd8 00000001 c01ba2f7 c8608000 c01ba30d
00000010 
       00002000 c018ea42 c1334000 c8d23d74 bfffec4c bfffec64 c8d23d8c
c8d23d74 
       00000000 000000f1 000000f1 c8888000 ffffffea 00000000 4000c5d0
00000008 
Call Trace: [<c01ba2f7>] [<c01ba30d>] [<c018ea42>] [<c019a9ed>]
[<c0153f6c>] [<c0153664>] [<c021d119>] 
       [<c012adc8>] [<c012ae4a>] [<c01362a4>] [<c012adc8>] [<c012ae4a>]
[<c012afe2>] [<c01362a4>] [<c012adc8>] 
       [<c012ae4a>] [<c012afe2>] [<c01364f8>] [<c0136dfd>] [<c012bafe>]
[<c012bedf>] [<c0186879>] [<c0149757>] 
       [<c010bad3>] 
Code: 80 3d c8 2d 26 c0 00 f3 90 7e f5 e9 30 08 fb ff 80 3d c8 2d 

>>EIP; c02099a3 <stext_lock+4127/8524>   <=====
Trace; c01ba2f7 <vgacon_font_op+4f/b8>
Trace; c01ba30d <vgacon_font_op+65/b8>
Trace; c018ea42 <con_font_op+1de/2e0>
Trace; c019a9ed <vt_ioctl+17fd/1a54>
Trace; c0153f6c <load_elf_binary+908/a48>
Trace; c0153664 <load_elf_binary+0/a48>
Trace; c021d119 <tvecs+6971/b058>
Trace; c012adc8 <do_anonymous_page+30/80>
Trace; c012ae4a <do_no_page+32/b0>
Trace; c01362a4 <__alloc_pages+e0/2d4>
Trace; c012adc8 <do_anonymous_page+30/80>
Trace; c012ae4a <do_no_page+32/b0>
Trace; c012afe2 <handle_mm_fault+11a/198>
Trace; c01362a4 <__alloc_pages+e0/2d4>
Trace; c012adc8 <do_anonymous_page+30/80>
Trace; c012ae4a <do_no_page+32/b0>
Trace; c012afe2 <handle_mm_fault+11a/198>
Trace; c01364f8 <__free_pages+14/18>
Trace; c0136dfd <free_page_and_swap_cache+81/84>
Trace; c012bafe <unmap_fixup+62/14c>
Trace; c012bedf <do_munmap+273/280>
Trace; c0186879 <tty_ioctl+361/398>
Trace; c0149757 <sys_ioctl+1bb/214>
Trace; c010bad3 <system_call+33/38>
Code;  c02099a3 <stext_lock+4127/8524>
00000000 <_EIP>:
Code;  c02099a3 <stext_lock+4127/8524>   <=====
   0:   80 3d c8 2d 26 c0 00      cmpb   $0x0,0xc0262dc8   <=====
Code;  c02099aa <stext_lock+412e/8524>
   7:   f3 90                     repz nop 
Code;  c02099ac <stext_lock+4130/8524>
   9:   7e f5                     jle    0 <_EIP>
Code;  c02099ae <stext_lock+4132/8524>
   b:   e9 30 08 fb ff            jmp    fffb0840 <_EIP+0xfffb0840>
c01ba1e3 <vgacon_adjust_height+7b/140>
Code;  c02099b3 <stext_lock+4137/8524>
  10:   80 3d c8 2d 00 00 00      cmpb   $0x0,0x2dc8


-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
