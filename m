Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287002AbSAZVd3>; Sat, 26 Jan 2002 16:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbSAZVdV>; Sat, 26 Jan 2002 16:33:21 -0500
Received: from mx04.nexgo.de ([151.189.8.80]:38411 "EHLO mx04.nexgo.de")
	by vger.kernel.org with ESMTP id <S287002AbSAZVdM>;
	Sat, 26 Jan 2002 16:33:12 -0500
Message-ID: <3C532063.3090709@arcor.de>
Date: Sat, 26 Jan 2002 22:32:19 +0100
From: Hartmut Holz <hartmut.holz@arcor.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020116
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uptime again?
In-Reply-To: <Pine.LNX.4.33L.0201261522110.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
 > On Sat, 26 Jan 2002, Hartmut Holz wrote:
 >

 >
 > Interesting. Could you test 2.4 -aa and 2.4 -rmap too if you
 > have the time ? ;)
 >
 > (you can get -rmap and -aa from http://surriel.com/patches and
 > kernel.org, respectively)
 >

rmap12a about 15 minutes. As far as I can remember, I tested 2.4.6, 2.4.14/15/16/17/18pre7, rmap11c

It looks like memory corruption. lavrec stops or makes a segmentation fault (With a oops).
After that every apps starts with a oops till the kernel is dead.

Xawtv works without any problems. I don't think -aa is a solution, but I will try it.


Regards

Hartmut

rmap12a:
---------

Jan 26 21:34:08 woodpecker kernel: CPU:    1
Jan 26 21:34:08 woodpecker kernel: EIP:    0010:[rmqueue+506/576]    Tainted: P
Jan 26 21:34:08 woodpecker kernel: EIP:    0010:[<c013004a>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 26 21:34:08 woodpecker kernel: EFLAGS: 00210202
Jan 26 21:34:08 woodpecker kernel: eax: 00000088   ebx: c10a68d8   ecx: 00001000   edx: 0000333f
Jan 26 21:34:08 woodpecker kernel: esi: c028c1dc   edi: 0001aff0   ebp: 0001aff0   esp: d8323ed0
Jan 26 21:34:08 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Jan 26 21:34:08 woodpecker kernel: Process lavrec (pid: 13680, stackpage=d8323000)
Jan 26 21:34:08 woodpecker kernel: Stack: 00001000 0000233f 00200282 00000000 c028c1dc 0001aff0 c028c3b8 00000000
Jan 26 21:34:08 woodpecker kernel:        00000100 c01301df 00000001 c028c3b4 000001d2 414e46c6 dbebe364 0000973a
Jan 26 21:34:08 woodpecker kernel:        c14efa4c d8323f54 dbebe364 0000973a 00000000 c0129f4a d8323f54 00001000
Jan 26 21:34:08 woodpecker kernel: Call Trace: [__alloc_pages+95/704] [generic_file_write+1066/1824] [sys_write+150/208] 
[smp_apic_timer_interrupt+239/288] [system_call+51/56]
Jan 26 21:34:08 woodpecker kernel: Call Trace: [<c01301df>] [<c0129f4a>] [<c01365a6>] [<c0111c8f>] [<c0106f3b>]
Jan 26 21:34:08 woodpecker kernel: Code: 0f 0b 8b 43 18 83 e0 20 74 02 0f 0b 89 d8 eb 22 8d b6 00 00

 >>EIP; c013004a <rmqueue+1fa/240>   <=====
Trace; c01301df <__alloc_pages+5f/2c0>
Trace; c0129f4a <generic_file_write+42a/720>
Trace; c01365a6 <sys_write+96/d0>
Trace; c0111c8f <smp_apic_timer_interrupt+ef/120>
Trace; c0106f3b <system_call+33/38>
Code;  c013004a <rmqueue+1fa/240>
00000000 <_EIP>:
Code;  c013004a <rmqueue+1fa/240>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c013004c <rmqueue+1fc/240>
    2:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c013004f <rmqueue+1ff/240>
    5:   83 e0 20                  and    $0x20,%eax
Code;  c0130052 <rmqueue+202/240>
    8:   74 02                     je     c <_EIP+0xc> c0130056 <rmqueue+206/240>
Code;  c0130054 <rmqueue+204/240>
    a:   0f 0b                     ud2a
Code;  c0130056 <rmqueue+206/240>
    c:   89 d8                     mov    %ebx,%eax
Code;  c0130058 <rmqueue+208/240>
    e:   eb 22                     jmp    32 <_EIP+0x32> c013007c <rmqueue+22c/240>
Code;  c013005a <rmqueue+20a/240>
   10:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Jan 26 21:34:08 woodpecker kernel:  invalid operand: 0000
Jan 26 21:34:08 woodpecker kernel: CPU:    0
Jan 26 21:34:08 woodpecker kernel: EIP:    0010:[rmqueue+506/576]    Tainted: P
Jan 26 21:34:08 woodpecker kernel: EIP:    0010:[<c013004a>]    Tainted: P
Jan 26 21:34:08 woodpecker kernel: EFLAGS: 00210202
Jan 26 21:34:08 woodpecker kernel: eax: 00000088   ebx: c10a68a4   ecx: 00001000   edx: 0000333e
Jan 26 21:34:08 woodpecker kernel: esi: c028c1dc   edi: 0001aff0   ebp: 0001aff0   esp: d0ec7b88
Jan 26 21:34:08 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Jan 26 21:34:08 woodpecker kernel: Process lavrec (pid: 13676, stackpage=d0ec7000)
Jan 26 21:34:08 woodpecker kernel: Stack: 00001000 0000233e 00200286 00000000 c028c1dc 0001aff0 c028c3b8 00000000
Jan 26 21:34:08 woodpecker kernel:        00000100 c01301df 00000001 c028c3b4 000001d2 d42c0000 dbef433c 00000003
Jan 26 21:34:08 woodpecker kernel:        d0ec6000 d0ec7c0c dbef433c 00000003 00000000 c0129f4a d0ec7c0c 00001000
Jan 26 21:34:08 woodpecker kernel: Call Trace: [__alloc_pages+95/704] [generic_file_write+1066/1824] [get_user_pages+252/384] 
[dump_write+26/48] [elf_core_dump+2338/2480]
Jan 26 21:34:08 woodpecker kernel: Call Trace: [<c01301df>] [<c0129f4a>] [<c0123edc>] [<c014e6aa>] [<c014f112>]
Jan 26 21:34:08 woodpecker kernel:    [<dd93f04b>] [balance_dirty_state+12/96] [do_coredump+272/336] [dequeue_signal+109/176] 
[do_signal+491/688] [sys_rt_sigsuspend+276/304]
Jan 26 21:34:08 woodpecker kernel:    [<dd93f04b>] [<c01384cc>] [<c013e8d0>] [<c011f17d>] [<c0106d8b>] [<c0106024>]
Jan 26 21:34:08 woodpecker kernel:    [<c0106f3b>]
Jan 26 21:34:08 woodpecker kernel: Code: 0f 0b 8b 43 18 83 e0 20 74 02 0f 0b 89 d8 eb 22 8d b6 00 00

 >>EIP; c013004a <rmqueue+1fa/240>   <=====
Trace; c01301df <__alloc_pages+5f/2c0>
Trace; c0129f4a <generic_file_write+42a/720>
Trace; c0123edc <get_user_pages+fc/180>
Trace; c014e6aa <dump_write+1a/30>
Trace; c014f112 <elf_core_dump+922/9b0>
Trace; dd93f04b <[bttv]bttv_call_i2c_clients+3b/50>
Trace; dd93f04b <[bttv]bttv_call_i2c_clients+3b/50>
Trace; c01384cc <balance_dirty_state+c/60>
Trace; c013e8d0 <do_coredump+110/150>
Trace; c011f17d <dequeue_signal+6d/b0>
Trace; c0106d8b <do_signal+1eb/2b0>
Trace; c0106024 <sys_rt_sigsuspend+114/130>
Trace; c0106f3b <system_call+33/38>
Code;  c013004a <rmqueue+1fa/240>
00000000 <_EIP>:
Code;  c013004a <rmqueue+1fa/240>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c013004c <rmqueue+1fc/240>
    2:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c013004f <rmqueue+1ff/240>
    5:   83 e0 20                  and    $0x20,%eax
Code;  c0130052 <rmqueue+202/240>
    8:   74 02                     je     c <_EIP+0xc> c0130056 <rmqueue+206/240>
Code;  c0130054 <rmqueue+204/240>
    a:   0f 0b                     ud2a
Code;  c0130056 <rmqueue+206/240>
    c:   89 d8                     mov    %ebx,%eax
Code;  c0130058 <rmqueue+208/240>
    e:   eb 22                     jmp    32 <_EIP+0x32> c013007c <rmqueue+22c/240>
Code;  c013005a <rmqueue+20a/240>
   10:   8d b6 00 00 00 00         lea    0x0(%esi),%esi


2.4.18.pre7:
-----------
Jan 26 17:28:40 woodpecker kernel: Unable to handle kernel paging request at virtual address 0232013d
Jan 26 17:28:40 woodpecker kernel: c0114893
Jan 26 17:28:40 woodpecker kernel: *pde = 00000000
Jan 26 17:28:40 woodpecker kernel: Oops: 0000
Jan 26 17:28:40 woodpecker kernel: CPU:    0
Jan 26 17:28:40 woodpecker kernel: EIP:    0010:[__wake_up+51/192]    Not tainted
Jan 26 17:28:40 woodpecker kernel: EIP:    0010:[<c0114893>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 26 17:28:40 woodpecker kernel: EFLAGS: 00210083
Jan 26 17:28:40 woodpecker kernel: eax: d765d984   ebx: c02c60bc   ecx: 0232013d   edx: 00000001
Jan 26 17:28:40 woodpecker kernel: esi: d6001ede   edi: d765d980   ebp: d6001d68   esp: d6001d50
Jan 26 17:28:40 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Jan 26 17:28:40 woodpecker kernel: Process lavrec (pid: 1544, stackpage=d6001000)
Jan 26 17:28:40 woodpecker kernel: Stack: 00000001 00200282 00000001 d765d980 d6001ede d5d44a10 d765d000 c0185daa
Jan 26 17:28:40 woodpecker kernel:        c335da80 db6a5b60 d6001db8 00000007 00000120 00000160 0000000f 00006603
Jan 26 17:28:40 woodpecker kernel:        00000812 00001000 000d7f9d 00200202 00000000 00000812 000d7f9d 00001000
Jan 26 17:28:40 woodpecker kernel: Call Trace: [n_tty_receive_buf+2986/3040] [ext2_alloc_branch+48/576] [timer_bh+599/688] 
[ext2_get_branch+82/192] [ext2_get_block+943/1104]
Jan 26 17:28:40 woodpecker kernel: Call Trace: [<c0185daa>] [<c0158930>] [<c011f707>] [<c0158892>] [<c0158eef>]
Jan 26 17:28:40 woodpecker kernel:    [<c0158c3d>] [<c0108abf>] [<c01881be>] [<c0184d80>] [<c01869a5>] [<c01826ff>]
Jan 26 17:28:40 woodpecker kernel:    [<c0186840>] [<c01361c6>] [<c0108abf>] [<c010700b>]
Jan 26 17:28:40 woodpecker kernel: Code: 8b 01 85 45 f0 74 65 31 d2 9c 5e fa f0 fe 0d a0 38 2e c0 0f

 >>EIP; c0114893 <__wake_up+33/c0>   <=====
Trace; c0185daa <n_tty_receive_buf+baa/be0>
Trace; c0158930 <ext2_alloc_branch+30/240>
Trace; c011f707 <timer_bh+257/2b0>
Trace; c0158892 <ext2_get_branch+52/c0>
Trace; c0158eef <ext2_get_block+3af/450>
Trace; c0158c3d <ext2_get_block+fd/450>
Trace; c0108abf <do_IRQ+df/f0>
Trace; c01881be <pty_write+11e/130>
Trace; c0184d80 <opost_block+180/190>
Trace; c01869a5 <write_chan+165/1f0>
Trace; c01826ff <tty_write+20f/270>
Trace; c0186840 <write_chan+0/1f0>
Trace; c01361c6 <sys_write+96/d0>
Trace; c0108abf <do_IRQ+df/f0>
Trace; c010700b <system_call+33/38>
Code;  c0114893 <__wake_up+33/c0>
00000000 <_EIP>:
Code;  c0114893 <__wake_up+33/c0>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0114895 <__wake_up+35/c0>
    2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c0114898 <__wake_up+38/c0>
    5:   74 65                     je     6c <_EIP+0x6c> c01148ff <__wake_up+9f/c0>
Code;  c011489a <__wake_up+3a/c0>
    7:   31 d2                     xor    %edx,%edx
Code;  c011489c <__wake_up+3c/c0>
    9:   9c                        pushf
Code;  c011489d <__wake_up+3d/c0>
    a:   5e                        pop    %esi
Code;  c011489e <__wake_up+3e/c0>
    b:   fa                        cli
Code;  c011489f <__wake_up+3f/c0>
    c:   f0 fe 0d a0 38 2e c0      lock decb 0xc02e38a0
Code;  c01148a6 <__wake_up+46/c0>
   13:   0f 00 00                  sldt   (%eax)






