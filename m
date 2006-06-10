Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWFJM3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWFJM3W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 08:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWFJM3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 08:29:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:41358 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751505AbWFJM3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 08:29:21 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc6-rt3
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060610082406.GA31985@elte.hu>
References: <20060610082406.GA31985@elte.hu>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 14:32:23 +0200
Message-Id: <1149942743.8340.14.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 10:24 +0200, Ingo Molnar wrote:
> I think all of the regressions reported against rt1 are fixed, please 
> re-report if any of them is still unfixed.

I still see two oddites.

top - 14:17:04 up 5 min,  8 users,  load average: 0.37, 1.39, 0.78
Tasks: 148 total,   1 running, 147 sleeping,   0 stopped,   0 zombie
Cpu(s):  6.4% us,  3.0% sy,  0.0% ni, 90.6% id,  0.0% wa,  0.0% hi,
0.0% si

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 1281 root     -44  -5     0    0    0 S  2.0  0.0   0:00.57 IRQ 20
 6710 root      15   0  147m  15m 2196 S  2.0  1.6   0:11.85 X
 8144 root      15   0 29612  14m  10m S  2.0  1.5   0:05.09 kdesktop
 8087 root      15   0 27124  12m 8436 S  1.0  1.2   0:06.74 kxkb
 8135 root      15   0 24132 9124 6712 S  1.0  0.9   0:02.52 kaccess
 8139 root      15   0 27472  12m 8996 S  1.0  1.3   0:05.61 kwin
 8146 root      15   0 31028  14m  10m S  1.0  1.5   0:07.94 kicker
 8149 root      15   0 25380  10m 7948 S  1.0  1.0   0:02.30 klipper
 8154 root      15   0 29648  12m 8432 S  1.0  1.2   0:03.09 suseplugger
 8156 root      15   0 30912  14m  10m S  1.0  1.5   0:05.84 konsole
 8158 root      15   0 28072  13m 9844 S  1.0  1.4   0:07.30 kmix
 8159 root      15   0 30764  14m  10m S  1.0  1.5   0:05.99 konsole
 8165 root      15   0 30768  14m  10m S  1.0  1.5   0:06.26 konsole
 8170 root      15   0 35368  16m  12m S  1.0  1.7   0:04.47 konqueror
 8172 root      15   0 44876  10m 8100 S  1.0  1.1   0:03.16 knotify
 8297 root      16   0  2136 1076  788 R  1.0  0.1   0:02.51 top
    1 root      16   0   688  260  224 S  0.0  0.0   0:03.14 init

KDE twiddling it's thumbs takes 10% CPU, but didn't in rt29.

Fully repeatable oops when glibc's make check hits rt/tst-cpuclock1.
This isn't a regression though, it's in rt29 too.

kernel BUG at :36841! <-- that's fully repeatable too
invalid opcode: 0000 [#1]
PREEMPT SMP 
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 saa7134 prism54 ohci1394 ieee1394 ir_kbd_i2c bt878 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom sd_mod nls_iso8859_1 nls_cp437 nls_utf8
CPU:    1
EIP:    0060:[<b103cbaa>]    Not tainted VLI
EFLAGS: 00010202   (2.6.17-rc6-rt3-smp #169) 
EIP is at posix_cpu_timer_set+0x505/0x52e
eax: 00000282   ebx: c9380f6c   ecx: ef8b0b90   edx: dff80e10
esi: 3b9aca00   edi: c9380ee4   ebp: c9380eac   esp: c9380e54
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ld-linux.so.2 (pid: 18428, threadinfo=c9380000 task=dff80e10 stack_left=3616 worst_left=-1)
Stack: b13f98ed 00000202 c9380edc c9380ee4 c9380e78 b10151dc 00000000 05f5e100 
       00000000 05f5e100 00000000 ef8b0b90 fffffffd 00000000 c9380ee4 c9380ea4 
       b10151dc 00000000 00000000 c9380f6c 00000000 c9380ee4 c9380f88 b103ce18 
Call Trace:
 [<b10044db>] show_stack_log_lvl+0xaa/0xd5 (32)
 [<b10046c8>] show_registers+0x1c2/0x28e (68)
 [<b10048d0>] die+0x13c/0x31d (60)
 [<b1004b3b>] do_trap+0x8a/0xdb (32)
 [<b1005589>] do_invalid_op+0xae/0xb8 (192)
 [<b1003f97>] error_code+0x4f/0x54 (148)
 [<b103ce18>] posix_cpu_nsleep+0xfd/0x23b (220)
 [<b103969f>] sys_clock_nanosleep+0xe7/0xee (44)
 [<b10033e4>] syscall_call+0x7/0xb (-4020)
Code: 68 00 00 00 00 c7 45 d8 fd ff ff ff e9 db fd ff ff c7 41 6c ff ff ff ff c7 45 d8 01 00 00 00 c7 45 e4 01 00 00 00 e9 e8 fb ff ff <0f> 0b e9 8f fb ff ff b8 80 7a 5a b1 e8 ff cc 3b 00 e9 81 fd ff 
EIP: [<b103cbaa>] posix_cpu_timer_set+0x505/0x52e SS:ESP 0068:c9380e54

<peek>
(gdb) list *posix_cpu_timer_set+0x505
0xb103cbaa is in posix_cpu_timer_set (posix-cpu-timers.c:724).
719             }
720
721             /*
722              * Disarm any old timer after extracting its expiry time.
723              */
724             BUG_ON(!irqs_disabled());
725
726             ret = 0;
727             spin_lock(&p->sighand->siglock);
728             old_expires = timer->it.cpu.expires;
(gdb) list *posix_cpu_nsleep+0xfd
0xb103ce18 is in posix_cpu_nsleep (posix-cpu-timers.c:1597).
1592                    static struct itimerspec zero_it;
1593                    struct itimerspec it = { .it_value = *rqtp,
1594                                             .it_interval = {} };
1595
1596                    spin_lock_irq(&timer.it_lock);
1597                    error = posix_cpu_timer_set(&timer, flags, &it, NULL);
1598                    if (error) {
1599                            spin_unlock_irq(&timer.it_lock);
1600                            return error;
1601                    }
(gdb)
<nope, definitely not Kansas>

