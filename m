Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWHWNQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWHWNQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWHWNQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:16:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:19115 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750713AbWHWNQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:16:10 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <1156326208.6265.33.camel@Homer.simpson.net>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
	 <1156326208.6265.33.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:24:43 +0000
Message-Id: <1156346683.6456.4.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 09:43 +0000, Mike Galbraith wrote:

> ...and after my box finishes rebooting, I'll alert the developer of this
> patch set that very bad things happen the instant you do that :)

Good news is that it doesn't always spontaneous reboot.  Sometimes, it
just goes pop.

(gdb) list *schedule+0x18a
0xb13c4aba is in schedule (kernel/sched.c:3586).
3581    #else
3582            next_grp = init_task_grp.rq[cpu];
3583    #endif
3584
3585            /* Pick a task within that group next */
3586            array = next_grp->active;
3587            if (!array->nr_active) {
3588                    /*
3589                     * Switch the active and expired arrays.
3590                     */
(gdb)

BUG: unable to handle kernel paging request at virtual address ffffffe8
 printing eip:
b13c4aba
*pde = 00004067
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: xt_pkttype ipt_LOG xt_limit eeprom snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 tuner snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc saa7134 prism54 bt878 ir_kbd_i2c snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_i801 bttv ohci1394 ieee1394 video_buf ir_common btcx_risc tveeprom soundcore sd_mod
CPU:    0
EIP:    0060:[<b13c4aba>]    Not tainted VLI
EFLAGS: 00210097   (2.6.18-rc4-ctrl #166) 
EIP is at schedule+0x18a/0xb5b
eax: 0000008c   ebx: b1488f40   ecx: b1e65f60   edx: fffff6e8
esi: b1489054   edi: b15ce300   ebp: b158efac   esp: b158ef38
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=b158e000 task=b1488f40 task.ti=b158e000)
Stack: 00000000 00200046 b158ef3c b1488f40 00000000 00000000 b158ef78 b15ce380 
       b15ce300 b158ef64 b1027f51 00000001 b1488f40 00000000 008961d3 00000035 
       0005466d 00000000 b1489054 b1e65f60 b15ce300 b158efac 00000000 b1e6007b 
Call Trace:
 [<b1001a52>] cpu_idle+0x8f/0xc9
 [<b1000622>] rest_init+0x39/0x47
 [<b15957c8>] start_kernel+0x34d/0x405
 [<b1000210>] 0xb1000210
DWARF2 unwinder stuck at 0xb1000210
Leftover inexact backtrace:
 =======================
 =======================
BUG: unable to handle kernel paging request at virtual address 38f28034
 printing eip:
b1004074
*pde = 00000000
Oops: 0000 [#2]
PREEMPT SMP 
Modules linked in: xt_pkttype ipt_LOG xt_limit eeprom snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 tuner snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc saa7134 prism54 bt878 ir_kbd_i2c snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_i801 bttv ohci1394 ieee1394 video_buf ir_common btcx_risc tveeprom soundcore sd_mod
CPU:    0
EIP:    0060:[<b1004074>]    Not tainted VLI
EFLAGS: 00210812   (2.6.18-rc4-ctrl #166) 
EIP is at show_trace_log_lvl+0x92/0x191
eax: 38f28ffd   ebx: 38f289c9   ecx: ffffffff   edx: 00200006
esi: b158ee1c   edi: 38f28000   ebp: b158ee1c   esp: b158edc8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=b158e000 task=b1488f40 task.ti=b158e000)
Stack: b1407cc4 b1407d3c 00020809 b1e65f60 fffff6e8 00099100 b1500800 01675007 
       0000008c 0020007b 0000007b ffffffff b1000210 00000060 00210097 b158f000 
       00000068 b1488f40 b158ef9b 00000018 b1407d3c b158ee44 b1004219 b1407d3c 
Call Trace:
 [<b1004219>] show_stack_log_lvl+0xa6/0xcb
 [<b10043e7>] show_registers+0x1a9/0x22e
 [<b10045a2>] die+0x136/0x2ea
 [<b10191cb>] do_page_fault+0x269/0x529
 [<b1003bb1>] error_code+0x39/0x40
 [<b13c4aba>] schedule+0x18a/0xb5b
 [<b1001a52>] cpu_idle+0x8f/0xc9
 [<b1000622>] rest_init+0x39/0x47
 [<b15957c8>] start_kernel+0x34d/0x405
 [<b1000210>] 0xb1000210
DWARF2 unwinder stuck at 0xb1000210
Leftover inexact backtrace:
 =======================
 =======================
BUG: unable to handle kernel paging request at virtual address 38f28034
 printing eip:
b1004074
*pde = 00000000
Recursive die() failure, output suppressed




