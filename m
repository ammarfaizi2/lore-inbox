Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSJ0TGT>; Sun, 27 Oct 2002 14:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJ0TGT>; Sun, 27 Oct 2002 14:06:19 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:14536 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S262481AbSJ0TGR>;
	Sun, 27 Oct 2002 14:06:17 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/serial/core.c:1067 with 2.5.44
References: <87elabdf1q.fsf@sycorax.lbl.gov>
	<20021027163307.A9553@flint.arm.linux.org.uk>
	<87adkzde90.fsf@sycorax.lbl.gov>
	<20021027171253.B9553@flint.arm.linux.org.uk>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: 27 Oct 2002 11:12:29 -0800
In-Reply-To: <20021027171253.B9553@flint.arm.linux.org.uk> (message from Russell King on Sun, 27 Oct 2002 17:12:53 +0000)
Message-ID: <873cqrelwi.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> Firstly, you need klogd running with -x so the numbers within [< and >]
> are preserved.  It is a shame that these distributions still run klogd
> without -x.
> 
> BTW, an even better option would be to enable CONFIG_KALLSYMS.

i've recompiled the kernel with CONFIG_KALLSYMS and started klogd with
-x and this is what i get now:

ksymoops 2.4.6 on i686 2.5.44.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44/ (default)
     -m /boot/System.map-2.5.44 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 27 10:36:45 trinculo kernel: kernel BUG at drivers/serial/core.c:1067!
Oct 27 10:36:45 trinculo kernel: invalid operand: 0000
Oct 27 10:36:45 trinculo kernel: 3c574_cs irtty irda autofs4 microcode ppp_async uhci-hcd ohci-hcd usbcore nls_cp437 vfat snd-pcm-oss snd-mixer-oss snd-ymfpci snd-pcm snd-mpu401-uart snd-rawmidi snd-ac97-codec snd-opl3-lib snd-timer snd-hwdep snd-seq-device snd soundcore
Oct 27 10:36:45 trinculo kernel: CPU:    0
Oct 27 10:36:45 trinculo kernel: EIP:    0060:[<c01a7d71>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 27 10:36:45 trinculo kernel: EFLAGS: 00010286
Oct 27 10:36:45 trinculo kernel: eax: cfd21900   ebx: cabe8000   ecx: 000008bd   edx: c13b1d1c
Oct 27 10:36:45 trinculo kernel: esi: c13b1d40   edi: 000008bd   ebp: cb6cec2c   esp: cabe9e58
Oct 27 10:36:45 trinculo kernel: ds: 0068   es: 0068   ss: 0068
Oct 27 10:36:45 trinculo kernel: Stack: cbd98e00 c13b1d40 cabe9ea8 00000000 cabe8000 d11cf5f8 cb1a3000 cabe9e84
Oct 27 10:36:45 trinculo kernel:        cb1a3000 cbd98e00 caba3000 00000005 00000000 000008bd 00000000 7f1c030b
Oct 27 10:36:45 trinculo kernel:        01000415 1a131100 170f1200 2f000016 d11d0321 cbd98e00 00000000 caba3000
Oct 27 10:36:45 trinculo kernel: Call Trace:
Oct 27 10:36:45 trinculo kernel:  [<d11cf5f8>] irtty_stop_receiver+0x64/0x70 [irtty]
Oct 27 10:36:45 trinculo kernel:  [<d11d0321>] irtty_net_open+0x79/0xcc [irtty]
Oct 27 10:36:45 trinculo kernel:  [<c019e64b>] vsnprintf+0x3db/0x41c
Oct 27 10:36:45 trinculo kernel:  [<c0214f7c>] dev_open+0x4c/0xa4
Oct 27 10:36:45 trinculo kernel:  [<c02161e5>] dev_change_flags+0x51/0x104
Oct 27 10:36:45 trinculo kernel:  [<c021630d>] dev_ifsioc+0x75/0x364
Oct 27 10:36:45 trinculo kernel:  [<c021690b>] dev_ioctl+0x30f/0x428
Oct 27 10:36:45 trinculo kernel:  [<d11baf49>] irda_ioctl+0x1cd/0x1d4 [irda]
Oct 27 10:36:45 trinculo kernel:  [<c020eeff>] sock_ioctl+0xcb/0xf0
Oct 27 10:36:45 trinculo kernel:  [<c014d879>] sys_ioctl+0x27d/0x2d4
Oct 27 10:36:45 trinculo kernel:  [<c0106fbb>] syscall_call+0x7/0xb
Oct 27 10:36:45 trinculo kernel: Code: 0f 0b 2b 04 7e 5c 27 c0 8d b4 26 00 00 00 00 8b 4c 24 1c 3b


>>EIP; c01a7d71 <uart_set_termios+29/164>   <=====

>>eax; cfd21900 <_end+f92f74c/10d12eac>
>>ebx; cabe8000 <_end+a7f5e4c/10d12eac>
>>edx; c13b1d1c <_end+fbfb68/10d12eac>
>>esi; c13b1d40 <_end+fbfb8c/10d12eac>
>>ebp; cb6cec2c <_end+b2dca78/10d12eac>
>>esp; cabe9e58 <_end+a7f7ca4/10d12eac>

Trace; d11cf5f8 <[irtty]irtty_stop_receiver+64/70>
Trace; d11d0321 <[irtty]irtty_net_open+79/cc>
Trace; c019e64b <vsnprintf+3db/41c>
Trace; c0214f7c <dev_open+4c/a4>
Trace; c02161e5 <dev_change_flags+51/104>
Trace; c021630d <dev_ifsioc+75/364>
Trace; c021690b <dev_ioctl+30f/428>
Trace; d11baf49 <[irda]irda_ioctl+1cd/1d4>
Trace; c020eeff <sock_ioctl+cb/f0>
Trace; c014d879 <sys_ioctl+27d/2d4>
Trace; c0106fbb <syscall_call+7/b>

Code;  c01a7d71 <uart_set_termios+29/164>
00000000 <_EIP>:
Code;  c01a7d71 <uart_set_termios+29/164>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01a7d73 <uart_set_termios+2b/164>
   2:   2b 04 7e                  sub    (%esi,%edi,2),%eax
Code;  c01a7d76 <uart_set_termios+2e/164>
   5:   5c                        pop    %esp
Code;  c01a7d77 <uart_set_termios+2f/164>
   6:   27                        daa    
Code;  c01a7d78 <uart_set_termios+30/164>
   7:   c0 8d b4 26 00 00 00      rorb   $0x0,0x26b4(%ebp)
Code;  c01a7d7f <uart_set_termios+37/164>
   e:   00 8b 4c 24 1c 3b         add    %cl,0x3b1c244c(%ebx)


1 warning issued.  Results may not be reliable.

i hope this helps.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
