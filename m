Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbRBYLgR>; Sun, 25 Feb 2001 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbRBYLgH>; Sun, 25 Feb 2001 06:36:07 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:23052 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S130032AbRBYLgA>; Sun, 25 Feb 2001 06:36:00 -0500
Date: Sun, 25 Feb 2001 08:37:28 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops followed by "kernel BUG"s
Message-ID: <20010225083728.A1064@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I woke today I found I'd gotten the following oops,

    Feb 25 06:27:37 burocracia kernel: Unable to handle kernel paging request at virtual address 00020008
    Feb 25 06:27:37 burocracia kernel: c0139e3d
    Feb 25 06:27:37 burocracia kernel: *pde = 00000000
    Feb 25 06:27:37 burocracia kernel: Oops: 0002
    Feb 25 06:27:37 burocracia kernel: CPU:    1
    Feb 25 06:27:37 burocracia kernel: EIP:    0010:[bdput+5/96]
    Feb 25 06:27:37 burocracia kernel: EFLAGS: 00010206
    Feb 25 06:27:37 burocracia kernel: eax: 00020000   ebx: 00020000   ecx: ca58a648   edx: c15ddfa4
    Feb 25 06:27:37 burocracia kernel: esi: c15ddfa4   edi: c7108a08   ebp: c15ddfac   esp: c15ddf6c
    Feb 25 06:27:37 burocracia kernel: ds: 0018   es: 0018   ss: 0018
    Feb 25 06:27:37 burocracia kernel: Process kswapd (pid: 3, stackpage=c15dd000)
    Feb 25 06:27:37 burocracia kernel: Stack: ca58a640 c0146d82 00020000 ca58a640 c0146dd7 ca58a640 c7111088 c7111080 
    Feb 25 06:27:37 burocracia kernel:        c0147009 c15ddfa4 00010f00 00000004 00000000 00002576 cb8f7b88 cfb17808 
    Feb 25 06:27:37 burocracia kernel:        00000000 c0147039 00000000 c012ccdf 00000006 00000004 00000006 00000004 
    Feb 25 06:27:37 burocracia kernel: Call Trace: [clear_inode+194/220] [dispose_list+59/84] [prune_icache+261/276] [shrink_icache_memory+33/48] [do_try_to_free_pages+103/124] [kswapd+103/244] [kernel_thread+40/56] 
    Feb 25 06:27:37 burocracia kernel: Code: f0 ff 4b 08 0f 94 c0 84 c0 74 4d f0 fe 0d 20 09 26 c0 0f 88 

which decodes into

    Code;  00000000 Before first symbol            00000000 <_EIP>:
    Code;  00000000 Before first symbol               0:   f0 ff 4b 08               lock decl 0x8(%ebx)
    Code;  00000004 Before first symbol               4:   0f 94 c0                  sete   %al
    Code;  00000007 Before first symbol               7:   84 c0                     test   %al,%al
    Code;  00000009 Before first symbol               9:   74 4d                     je     58 <_EIP+0x58> 00000058 Before first symbol
    Code;  0000000b Before first symbol               b:   f0 fe 0d 20 09 26 c0      lock decb 0xc0260920
    Code;  00000012 Before first symbol              12:   0f 88 00 00 00 00         js     18 <_EIP+0x18> 00000018 Before first symbol

and a series (2 or 3, not sure) of "kernel BUG"s, finishing with
"deactivating console" or words to that effect. On reboot I'm
afraid the only bit that survived after the oops was

    Feb 25 06:27:39 burocracia kernel: kernel BUG at exit.c:458!
    Feb 25 06:27:39 burocracia kernel: invalid operand: 0000
    Feb 25 06:27:39 burocracia kernel: CPU:    1
    Feb 25 06:27:39 burocracia kernel: EIP:    0010:[do_exit+668/680]
    Feb 25 06:27:39 burocracia kernel: EFLAGS: 00010286
    Feb 25 06:27:39 burocracia kernel: eax: 0000001a   ebx: c025b460   ecx: 00000046   edx: 01000000
    Feb 25 07:45:11 burocracia kernel: activating NMI Watchdog ... done.
    Feb 25 07:45:11 burocracia kernel: CPU#0 NMI appears to be stuck.
    Feb 25 07:45:11 burocracia kernel: cpu: 0, clocks: 1002185, slice: 334061
    Feb 25 07:45:11 burocracia kernel: cpu: 1, clocks: 1002185, slice: 334061

the box is debian unstable, w/reiserprogs from the reiser site.

Let me know if any other info'll be useful.

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
BOFH excuse #277:

Your Flux Capacitor has gone bad.
