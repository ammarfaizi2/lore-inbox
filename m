Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTJWUvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTJWUvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:51:48 -0400
Received: from mail.convergence.de ([212.84.236.4]:36055 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261786AbTJWUva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:51:30 -0400
Date: Thu, 23 Oct 2003 22:51:21 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Markus Fraczek <marekf@gmx.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops] Linux 2.6.0-test8 - neofb
Message-ID: <20031023205121.GB5854@directfb.org>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
References: <20031021163635.A2174@meson.msf.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031021163635.A2174@meson.msf.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Fraczek:
> Hi,
> 
> I hope I'm posting this in the right place.
> 
> Linux 2.6.0-test8 crashes when I try to switch to another console. I get this 
> message: "nable to handle kernel paging request" 
> (I'm not sure where the `u' is. :) 
> As far as I can tell, it has something to do with the neofb-driver.

Hi,

the stack trace shows that it crashes in neofb_imageblit() which was added by
James Simmons, I've CCed to him and the kernel mailing list.

> System and ksymoops:
> ====================
> Acer Laptop: Extensa 503T
> 
> cat /proc/cpuinfo
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 5
> model		: 8
> model name	: Mobile Pentium MMX
> stepping	: 2
> cpu MHz		: 299.950
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: yes
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr mce cx8 mmx
> bogomips	: 598.01
> 
> 
> Video-card: MagicGraph 128XD
> 
> Oct 21 13:06:02 zaphod kernel: neofb: mapped io at c4800000
> Oct 21 13:06:02 zaphod kernel: Autodetected internal display
> Oct 21 13:06:02 zaphod kernel: Panel is a 800x600 color TFT display
> Oct 21 13:06:02 zaphod kernel: neofb: mapped framebuffer at c4a01000
> Oct 21 13:06:02 zaphod kernel: neofb v0.4.1: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
> Oct 21 13:06:02 zaphod kernel: fb0: MagicGraph 128XD frame buffer device
> 
> 
> ksymoops: 
> 
> ksymoops 2.4.9 on i586 2.4.22.  Options used
>      -v /usr/src/linux26/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.6.0-test8/ (specified)
>      -m /usr/src/linux26/System.map (specified)
> 
> No modules in ksyms, skipping objects
> Oct 21 13:06:02 zaphod kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
> Oct 21 13:07:45 zaphod kernel: Unable to handle kernel paging request<1>Unable to handle kernel paging request at virtual address c4c011c0
> Oct 21 13:07:45 zaphod kernel: c020b14c
> Oct 21 13:07:45 zaphod kernel: *pde = 010dc067
> Oct 21 13:07:45 zaphod kernel: Oops: 0002 [#1]
> Oct 21 13:07:45 zaphod kernel: CPU:    0
> Oct 21 13:07:45 zaphod kernel: EIP:    0060:[<c020b14c>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Oct 21 13:07:45 zaphod kernel: EFLAGS: 00010246
> Oct 21 13:07:45 zaphod kernel: eax: 00000000   ebx: 0000004b   ecx: c030bdc0   edx: c4c011c0
> Oct 21 13:07:45 zaphod kernel: esi: 00000004   edi: 00000130   ebp: c2b89a78   esp: c2b899bc
> Oct 21 13:07:46 zaphod kernel: ds: 007b   es: 007b   ss: 0068
> Oct 21 13:07:46 zaphod kernel: Stack: c10fc000 c10d6616 ffffffff 00000026 00000000 c10d6804 c4c011c0 0f0f0f0f 
> Oct 21 13:07:46 zaphod kernel:        00000010 00000000 00000000 00000000 c10d682a 00000000 00000000 00000000 
> Oct 21 13:07:46 zaphod kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> Oct 21 13:07:46 zaphod kernel: Call Trace:
> Oct 21 13:07:46 zaphod kernel:  [<c0209767>] neofb_imageblit+0x2b/0x30
> Oct 21 13:07:46 zaphod kernel:  [<c0200757>] putcs_aligned+0x143/0x178
> Oct 21 13:07:46 zaphod kernel:  [<c0200a3f>] accel_putcs+0x8b/0xb0
> Oct 21 13:07:46 zaphod kernel:  [<c010aa07>] do_IRQ+0x11b/0x134
> Oct 21 13:07:46 zaphod kernel:  [<c02016fc>] fbcon_putcs+0x6c/0x78
> Oct 21 13:07:46 zaphod kernel:  [<c01c272d>] vt_console_print+0x271/0x2cc
> Oct 21 13:07:46 zaphod kernel:  [<c011ac2a>] __call_console_drivers+0x3a/0x50
> Oct 21 13:07:46 zaphod kernel:  [<c011ac97>] _call_console_drivers+0x57/0x60
> Oct 21 13:07:46 zaphod kernel:  [<c011ad82>] call_console_drivers+0xe2/0xec
> Oct 21 13:07:46 zaphod kernel:  [<c011b007>] release_console_sem+0x5b/0xd4
> Oct 21 13:07:46 zaphod kernel:  [<c011af2f>] printk+0x133/0x164
> Oct 21 13:07:46 zaphod kernel:  [<c01157e2>] do_page_fault+0x2ea/0x4be
> Oct 21 13:07:46 zaphod kernel:  [<c01154f8>] do_page_fault+0x0/0x4be
> Oct 21 13:07:46 zaphod kernel:  [<c020af73>] cfb_imageblit+0xb3/0x5b0
> Oct 21 13:07:46 zaphod kernel:  [<c01092fd>] error_code+0x2d/0x40
> Oct 21 13:07:46 zaphod kernel:  [<c0209ffe>] bitfill32+0x5e/0xec
> Oct 21 13:07:46 zaphod kernel:  [<c0209fa0>] bitfill32+0x0/0xec
> Oct 21 13:07:46 zaphod kernel:  [<c020a55f>] cfb_fillrect+0x17b/0x28c
> Oct 21 13:07:46 zaphod kernel:  [<c0208072>] soft_cursor+0x202/0x220
> Oct 21 13:07:46 zaphod kernel:  [<c0209707>] neofb_fillrect+0x2f/0x34
> Oct 21 13:07:46 zaphod kernel:  [<c0200b31>] accel_clear_margins+0xcd/0xd8
> Oct 21 13:07:46 zaphod kernel:  [<c0202309>] fbcon_scroll+0x44d/0x964
> Oct 21 13:07:46 zaphod kernel:  [<c01be765>] scrup+0x71/0x108
> Oct 21 13:07:46 zaphod kernel:  [<c01bfcaf>] lf+0x33/0x64
> Oct 21 13:07:46 zaphod kernel:  [<c01c1059>] do_con_trol+0x175/0xe48
> Oct 21 13:07:46 zaphod kernel:  [<c01c233c>] do_con_write+0x610/0x6c4
> Oct 21 13:07:46 zaphod kernel:  [<c01c29b1>] con_put_char+0x2d/0x34
> Oct 21 13:07:46 zaphod kernel:  [<c01b57b6>] opost+0x1aa/0x1b8
> Oct 21 13:07:46 zaphod kernel:  [<c01b7bf6>] write_chan+0x12e/0x1f4
> Oct 21 13:07:46 zaphod kernel:  [<c011736c>] default_wake_function+0x0/0x20
> Oct 21 13:07:46 zaphod kernel:  [<c011736c>] default_wake_function+0x0/0x20
> Oct 21 13:07:46 zaphod kernel:  [<c01b295b>] tty_write+0x1e3/0x2a4
> Oct 21 13:07:46 zaphod kernel:  [<c01b7ac8>] write_chan+0x0/0x1f4
> Oct 21 13:07:46 zaphod kernel:  [<c014999e>] vfs_write+0x9e/0xd0
> Oct 21 13:07:46 zaphod kernel:  [<c0149a50>] sys_write+0x30/0x50
> Oct 21 13:07:46 zaphod kernel:  [<c0109097>] syscall_call+0x7/0xb
> Oct 21 13:07:46 zaphod kernel: Code: 89 02 83 c2 04 89 95 5c ff ff ff 85 f6 75 0b be 08 00 00 00 
> 
> 
> >>EIP; c020b14c <cfb_imageblit+28c/5b0>   <=====
> 
> >>ecx; c030bdc0 <cfb_tab8+0/40>
> >>edx; c4c011c0 <_end+4894c30/3fc91a70>
> >>ebp; c2b89a78 <_end+281d4e8/3fc91a70>
> >>esp; c2b899bc <_end+281d42c/3fc91a70>
> 
> Trace; c0209767 <neofb_imageblit+2b/30>
> Trace; c0200757 <putcs_aligned+143/178>
> Trace; c0200a3f <accel_putcs+8b/b0>
> Trace; c010aa07 <do_IRQ+11b/134>
> Trace; c02016fc <fbcon_putcs+6c/78>
> Trace; c01c272d <vt_console_print+271/2cc>
> Trace; c011ac2a <__call_console_drivers+3a/50>
> Trace; c011ac97 <_call_console_drivers+57/60>
> Trace; c011ad82 <call_console_drivers+e2/ec>
> Trace; c011b007 <release_console_sem+5b/d4>
> Trace; c011af2f <printk+133/164>
> Trace; c01157e2 <do_page_fault+2ea/4be>
> Trace; c01154f8 <do_page_fault+0/4be>
> Trace; c020af73 <cfb_imageblit+b3/5b0>
> Trace; c01092fd <error_code+2d/40>
> Trace; c0209ffe <bitfill32+5e/ec>
> Trace; c0209fa0 <bitfill32+0/ec>
> Trace; c020a55f <cfb_fillrect+17b/28c>
> Trace; c0208072 <soft_cursor+202/220>
> Trace; c0209707 <neofb_fillrect+2f/34>
> Trace; c0200b31 <accel_clear_margins+cd/d8>
> Trace; c0202309 <fbcon_scroll+44d/964>
> Trace; c01be765 <scrup+71/108>
> Trace; c01bfcaf <lf+33/64>
> Trace; c01c1059 <do_con_trol+175/e48>
> Trace; c01c233c <do_con_write+610/6c4>
> Trace; c01c29b1 <con_put_char+2d/34>
> Trace; c01b57b6 <opost+1aa/1b8>
> Trace; c01b7bf6 <write_chan+12e/1f4>
> Trace; c011736c <default_wake_function+0/20>
> Trace; c011736c <default_wake_function+0/20>
> Trace; c01b295b <tty_write+1e3/2a4>
> Trace; c01b7ac8 <write_chan+0/1f4>
> Trace; c014999e <vfs_write+9e/d0>
> Trace; c0149a50 <sys_write+30/50>
> Trace; c0109097 <syscall_call+7/b>
> 
> Code;  c020b14c <cfb_imageblit+28c/5b0>
> 00000000 <_EIP>:
> Code;  c020b14c <cfb_imageblit+28c/5b0>   <=====
>    0:   89 02                     mov    %eax,(%edx)   <=====
> Code;  c020b14e <cfb_imageblit+28e/5b0>
>    2:   83 c2 04                  add    $0x4,%edx
> Code;  c020b151 <cfb_imageblit+291/5b0>
>    5:   89 95 5c ff ff ff         mov    %edx,0xffffff5c(%ebp)
> Code;  c020b157 <cfb_imageblit+297/5b0>
>    b:   85 f6                     test   %esi,%esi
> Code;  c020b159 <cfb_imageblit+299/5b0>
>    d:   75 0b                     jne    1a <_EIP+0x1a>
> Code;  c020b15b <cfb_imageblit+29b/5b0>
>    f:   be 08 00 00 00            mov    $0x8,%esi
> 
> Oct 21 13:07:46 zaphod kernel:  <1>Unable to handle kernel paging request at virtual address c4c011c0
> Oct 21 13:07:46 zaphod kernel: c020b14c
> Oct 21 13:07:46 zaphod kernel: *pde = 010dc067
> Oct 21 13:07:46 zaphod kernel: Oops: 0002 [#2]
> Oct 21 13:07:46 zaphod kernel: CPU:    0
> Oct 21 13:07:46 zaphod kernel: EIP:    0060:[<c020b14c>]    Not tainted
> Oct 21 13:07:46 zaphod kernel: EFLAGS: 00010206
> Oct 21 13:07:46 zaphod kernel: eax: 0f000000   ebx: 00000001   ecx: c030bdc0   edx: c4c011c0
> Oct 21 13:07:46 zaphod kernel: esi: 00000004   edi: 00000008   ebp: c3fc9d30   esp: c3fc9c74
> Oct 21 13:07:46 zaphod kernel: ds: 007b   es: 007b   ss: 0068
> Oct 21 13:07:46 zaphod kernel: Stack: c10fc000 c10d6851 ffffffff 00000001 000009c0 c10d685e c4c011c0 0f0f0f0f 
> Oct 21 13:07:46 zaphod kernel:        00000010 00000000 ffffff00 c3fc9d64 c10d685f c10fc000 00000010 c3fc9e40 
> Oct 21 13:07:46 zaphod kernel:        c10fc118 c3fc9d18 c10d61d0 c4bee978 07070707 00000010 ffffffff c3fc9cd0 
> Oct 21 13:07:46 zaphod kernel: Call Trace:
> Oct 21 13:07:46 zaphod kernel:  [<c011ddfe>] do_softirq+0x4e/0xa0
> Oct 21 13:07:46 zaphod kernel:  [<c0209767>] neofb_imageblit+0x2b/0x30
> Oct 21 13:07:46 zaphod kernel:  [<c0200757>] putcs_aligned+0x143/0x178
> Oct 21 13:07:46 zaphod kernel:  [<c0200a3f>] accel_putcs+0x8b/0xb0
> Oct 21 13:07:46 zaphod kernel:  [<c02016fc>] fbcon_putcs+0x6c/0x78
> Oct 21 13:07:46 zaphod kernel:  [<c01c2384>] do_con_write+0x658/0x6c4
> Oct 21 13:07:46 zaphod kernel:  [<c01c29b1>] con_put_char+0x2d/0x34
> Oct 21 13:07:46 zaphod kernel:  [<c01b57b6>] opost+0x1aa/0x1b8
> Oct 21 13:07:46 zaphod kernel:  [<c01b5a1b>] echo_char+0x5f/0x68
> Oct 21 13:07:46 zaphod kernel:  [<c01b623a>] n_tty_receive_buf+0x3aa/0x109c
> Oct 21 13:07:46 zaphod kernel:  [<c0117250>] schedule+0x44c/0x51c
> Oct 21 13:07:46 zaphod kernel:  [<c011742a>] __wake_up_locked+0xe/0x14
> Oct 21 13:07:46 zaphod kernel:  [<c0117250>] schedule+0x44c/0x51c
> Oct 21 13:07:46 zaphod kernel:  [<c01b4a2d>] flush_to_ldisc+0xd9/0xe4
> Oct 21 13:07:46 zaphod kernel:  [<c01b4954>] flush_to_ldisc+0x0/0xe4
> Oct 21 13:07:46 zaphod kernel:  [<c01284ff>] worker_thread+0x1bb/0x288
> Oct 21 13:07:46 zaphod kernel:  [<c0128344>] worker_thread+0x0/0x288
> Oct 21 13:07:46 zaphod kernel:  [<c01b4954>] flush_to_ldisc+0x0/0xe4
> Oct 21 13:07:46 zaphod kernel:  [<c011736c>] default_wake_function+0x0/0x20
> Oct 21 13:07:46 zaphod kernel:  [<c011736c>] default_wake_function+0x0/0x20
> Oct 21 13:07:46 zaphod kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
> Oct 21 13:07:46 zaphod kernel: Code: 89 02 83 c2 04 89 95 5c ff ff ff 85 f6 75 0b be 08 00 00 00 
> 
> 
> >>EIP; c020b14c <cfb_imageblit+28c/5b0>   <=====
> 
> >>ecx; c030bdc0 <cfb_tab8+0/40>
> >>edx; c4c011c0 <_end+4894c30/3fc91a70>
> >>ebp; c3fc9d30 <_end+3c5d7a0/3fc91a70>
> >>esp; c3fc9c74 <_end+3c5d6e4/3fc91a70>
> 
> Trace; c011ddfe <do_softirq+4e/a0>
> Trace; c0209767 <neofb_imageblit+2b/30>
> Trace; c0200757 <putcs_aligned+143/178>
> Trace; c0200a3f <accel_putcs+8b/b0>
> Trace; c02016fc <fbcon_putcs+6c/78>
> Trace; c01c2384 <do_con_write+658/6c4>
> Trace; c01c29b1 <con_put_char+2d/34>
> Trace; c01b57b6 <opost+1aa/1b8>
> Trace; c01b5a1b <echo_char+5f/68>
> Trace; c01b623a <n_tty_receive_buf+3aa/109c>
> Trace; c0117250 <schedule+44c/51c>
> Trace; c011742a <__wake_up_locked+e/14>
> Trace; c0117250 <schedule+44c/51c>
> Trace; c01b4a2d <flush_to_ldisc+d9/e4>
> Trace; c01b4954 <flush_to_ldisc+0/e4>
> Trace; c01284ff <worker_thread+1bb/288>
> Trace; c0128344 <worker_thread+0/288>
> Trace; c01b4954 <flush_to_ldisc+0/e4>
> Trace; c011736c <default_wake_function+0/20>
> Trace; c011736c <default_wake_function+0/20>
> Trace; c0107289 <kernel_thread_helper+5/c>
> 
> Code;  c020b14c <cfb_imageblit+28c/5b0>
> 00000000 <_EIP>:
> Code;  c020b14c <cfb_imageblit+28c/5b0>   <=====
>    0:   89 02                     mov    %eax,(%edx)   <=====
> Code;  c020b14e <cfb_imageblit+28e/5b0>
>    2:   83 c2 04                  add    $0x4,%edx
> Code;  c020b151 <cfb_imageblit+291/5b0>
>    5:   89 95 5c ff ff ff         mov    %edx,0xffffff5c(%ebp)
> Code;  c020b157 <cfb_imageblit+297/5b0>
>    b:   85 f6                     test   %esi,%esi
> Code;  c020b159 <cfb_imageblit+299/5b0>
>    d:   75 0b                     jne    1a <_EIP+0x1a>
> Code;  c020b15b <cfb_imageblit+29b/5b0>
>    f:   be 08 00 00 00            mov    $0x8,%esi
> 
> Oct 21 13:10:40 zaphod kernel: Pid: 0, comm:              swapper
> Oct 21 13:10:40 zaphod kernel: EIP: 0060:[<c010706d>] CPU: 0
> Oct 21 13:10:40 zaphod kernel:  EFLAGS: 00000246    Not tainted
> Oct 21 13:10:40 zaphod kernel: EAX: 00000000 EBX: ffffed2e ECX: 00000000 EDX: 00000000
> Oct 21 13:10:40 zaphod kernel: ESI: 00000010 EDI: c0334000 EBP: c0335fa4 DS: 007b ES: 007b
> Warning (Oops_set_regs): garbage 'DS: 007b ES: 007b' at end of register line ignored
> Oct 21 13:10:40 zaphod kernel: CR0: 8005003b CR2: 400660b0 CR3: 03db6000 CR4: 00000010
> Oct 21 13:10:40 zaphod kernel: Call Trace:
> Oct 21 13:10:40 zaphod kernel:  [<c0113869>] apm_cpu_idle+0x109/0x150
> Oct 21 13:10:40 zaphod kernel:  [<c0105000>] _stext+0x0/0x5c
> Oct 21 13:10:40 zaphod kernel:  [<c01070ec>] cpu_idle+0x28/0x3c
> Oct 21 13:10:40 zaphod kernel:  [<c0105055>] _stext+0x55/0x5c
> Oct 21 13:10:40 zaphod kernel:  [<c033663f>] start_kernel+0x147/0x150
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> 
> >>EIP; c010706d <default_idle+29/34>   <=====
> 
> >>EBX; ffffed2e <__kernel_rt_sigreturn+8ee/19c4>
> >>EDI; c0334000 <init_thread_union+0/2000>
> >>EBP; c0335fa4 <init_thread_union+1fa4/2000>
> 
> Trace; c0113869 <apm_cpu_idle+109/150>
> Trace; c0105000 <_stext+0/0>
> Trace; c01070ec <cpu_idle+28/3c>
> Trace; c0105055 <rest_init+55/5c>
> Trace; c033663f <start_kernel+147/150>
> 
> Oct 21 13:12:11 zaphod kernel: Intel Pentium with F0 0F bug - workaround enabled.
> Oct 21 13:12:11 zaphod kernel: ad1848: OPL3-SA2 WSS mode detected
> Oct 21 13:12:11 zaphod kernel: ad1848: ISAPnP reports 'OPL3-SA2 WSS mode' at i/o 0xe80, irq 5, dma 1, 7
> Oct 21 13:12:11 zaphod kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x240-0x24f 0x378-0x37f 0x388-0x38f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
> Oct 21 13:19:00 zaphod kernel: cs: memory probe 0xa0000000-0xa0ffffff: excluding 0xa0000000-0xa00fffff
> 
> 2 warnings issued.  Results may not be reliable.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
