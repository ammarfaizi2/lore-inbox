Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWCQGbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWCQGbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCQGbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:31:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:54717 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932423AbWCQGbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:31:23 -0500
X-Authenticated: #14349625
Subject: oops in ext3_discard_reservation()
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 07:32:57 +0100
Message-Id: <1142577177.7973.6.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I just received the oops below.  This kernel is mostly virgin, but does
contain a small bundle of scheduler modifications.  Salt to taste.

	-Mike

BUG: unable to handle kernel paging request at virtual address 0001001c
 printing eip:
c10ab599
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
Modules linked in: ohci1394 prism54 xt_tcpudp xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 saa7134 snd_intel8x0 snd_ac97_codec ieee1394 snd_ac97_bus bt878 snd_pcm ir_kbd_i2c snd_timer snd soundcore i2c_i801 snd_page_alloc ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip6table_filter ip_conntrack ip_tables ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom sd_mod nls_iso8859_1 nls_cp437 nls_utf8
CPU:    1
EIP:    0060:[<c10ab599>]    Not tainted VLI
EFLAGS: 00210206   (2.6.16-rc6-mm1x-smp #19)
EIP is at ext3_discard_reservation+0x29/0x63
eax: f7e39100   ebx: c1583b50   ecx: 00000000   edx: c10b9ca7
esi: 00010000   edi: 00010018   ebp: dffc2e9c   esp: dffc2e8c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 583, threadinfo=dffc2000 task=dffc6030)
Stack: <0>f7e39100 ffffffff c1583ab0 c1583b50 dffc2eb8 c10b9d0b dffc2eb8 00010000
       c1583b50 c10b9dc1 dffc2ef8 dffc2ecc c10835e5 dffc2ecc c1583b58 c1583b50
       dffc2ee4 c1083669 00000012 00000080 f71817a8 f71817a0 dffc2f0c c1083915
Call Trace:
 <c1004073> show_stack_log_lvl+0xa9/0xe3   <c100424d> show_registers+0x1a0/0x236
 <c1004561> die+0x12f/0x2ae   <c1019aff> do_page_fault+0x353/0x5fa
 <c1003a2b> error_code+0x4f/0x54   <c10b9d0b> ext3_clear_inode+0x64/0xb6
 <c10835e5> clear_inode+0xa3/0x103   <c1083669> dispose_list+0x24/0x103
 <c1083915> shrink_icache_memory+0x1cd/0x220   <c10533c7> shrink_slab+0x160/0x1f9
 <c1054942> balance_pgdat+0x200/0x3be   <c1054bd9> kswapd+0xd9/0x125
 <c1001005> kernel_thread_helper+0x5/0xb
Code: 5d c3 55 89 e5 57 56 53 83 ec 04 89 c3 8b 70 b4 8b 80 a8 00 00 00 8b 80 78 01 00 00 05 00 11 00 00 89 45 f0 85 f6 74 0a 8d 7e 18 <8b> 57 04 85 d2 75 08 83 c4 04 5b 5e 5f 5d c3 e8 2e 41 30 00 8b


