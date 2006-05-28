Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWE1FKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWE1FKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWE1FKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:10:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:51334 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751257AbWE1FKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:10:42 -0400
X-Authenticated: #14349625
Subject: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Date: Sun, 28 May 2006 07:12:03 +0200
Message-Id: <1148793123.7572.22.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I tried to boot 2.6.17-rc4-mm3 twice yesterday, and received the below
both times.  Both times, the oops->panic occurred while X/KDE was
starting.  KDE would not run thereafter, and had to be reinstalled.

Box is P4/HT/ICH5.

	-Mike

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000054
 printing eip:
 b11c28f0
 *pde = 37e93067
 Oops: 0000 [#1]
 PREEMPT SMP
 last sysfs file: /devices/pci0000:00/0000:00:1f.3/class
 Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter saa7134 ip6table_mangle snd_intel8x0 snd_ac97_codec snd_ac97_bus ir_kbd_i2c snd_pcm snd_timer snd ip_conntrack bt878 prism54 soundcore nfnetlink ohci1394 ieee1394 i2c_i801 ip_tables snd_page_alloc ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom nls_iso8859_1 nls_cp437 nls_utf8 sd_mod
 CPU:    0
 EIP:    0060:[<b11c28f0>]    Not tainted VLI
 EFLAGS: 00213046   (2.6.17-rc4-mm3-smp #157)
 EIP is at cfq_dispatch_requests+0xef/0x540
 eax: 00000000   ebx: ef547c30   ecx: fffc593e   edx: 00000000
 esi: ecbb4f98   edi: 00000001   ebp: b153def0   esp: b153deb4
 ds: 007b   es: 007b   ss: 0068
 Process X (pid: 6992, threadinfo=b153d000 task=eb757000)
 Stack: 00203046 ef551f80 e44c1ee4 ee678f00 ef547c00 00000004 00000000 ef547c44
        ef547c44 ef547c34 ef51f81c ef51f7f4 ef51f7e4 b1598400 ef5e5d80 b153df14
	b11b744e 00000001 ef51f7e4 b153df14 b11b92a4 b1598494 b1598400 ef5e5d80
Call Trace:
 <b1003cf3> show_stack_log_lvl+0x9e/0xc3  <b1003f00> show_registers+0x1ac/0x237
 <b10040bd> die+0x132/0x2fb  <b1019df3> do_page_fault+0x4f3/0x577
 <b1003827> error_code+0x4f/0x54  <b11b744e> elv_next_request+0x1b/0x12f
 <b12764a3> ide_do_request+0x1b7/0x841  <b1276e45> ide_intr+0x1dc/0x1e1
 <b104a4a1> handle_IRQ_event+0x35/0x65  <b104a55f> __do_IRQ+0x8e/0xff
 <b100562a> do_IRQ+0x3e/0x57
 =======================
 <b10036ce> common_interrupt+0x1a/0x20
Code: 00 00 75 32 8d 43 34 3b 43 34 74 2a 8b 43 34 8b 70 3c 8b 0d 00 34 4e b1 83 7b 10 01 19 c0 83 e0 fc 8b 84 10 00 01 00 00 8b 56 14 <03> 42 54 39 c8 0f 88 98 01 00 00 8b 73 20 89 f2 8b 4d d4 8b 01
EIP: [<b11c28f0>] cfq_dispatch_requests+0xef/0x540 SS:ESP 0068:b153deb4
Kernel panic - not syncing: Fatal exception in interrupt
BUG: warning at arch/i386/kernel/smp.c:537/smp_call_function()
 <b1003d52> show_trace+0xd/0xf  <b1004440> dump_stack+0x17/0x19
 <b10129d2> smp_call_function+0x124/0x129  <b10129f5> smp_send_stop+0x1e/0x27
 <b1022a2b> panic+0x60/0x1c5  <b1004277> die+0x2ec/0x2fb
 <b1019df3> do_page_fault+0x4f3/0x577  <b1003827> error_code+0x4f/0x54
 <b11b744e> elv_next_request+0x1b/0x12f  <b12764a3> ide_do_request+0x1b7/0x841
 <b1276e45> ide_intr+0x1dc/0x1e1  <b104a4a1> handle_IRQ_event+0x35/0x65
 <b104a55f> __do_IRQ+0x8e/0xff  <b100562a> do_IRQ+0x3e/0x57
 =======================
 <b10036ce> common_interrupt+0x1a/0x20
BUG: warning at kernel/panic.c:138/panic()
 <b1003d52> show_trace+0xd/0xf  <b1004440> dump_stack+0x17/0x19
 <b1022b5d> panic+0x192/0x1c5  <b1004277> die+0x2ec/0x2fb
 <b1019df3> do_page_fault+0x4f3/0x577  <b1003827> error_code+0x4f/0x54
 <b11b744e> elv_next_request+0x1b/0x12f  <b12764a3> ide_do_request+0x1b7/0x841
 <b1276e45> ide_intr+0x1dc/0x1e1  <b104a4a1> handle_IRQ_event+0x35/0x65
 <b104a55f> __do_IRQ+0x8e/0xff  <b100562a> do_IRQ+0x3e/0x57
 =======================
 <b10036ce> common_interrupt+0x1a/0x20

(gdb) list *cfq_dispatch_requests+0xef
0xb11c28f0 is in cfq_dispatch_requests (cfq-iosched.c:969).
964             if (!list_empty(&cfqq->fifo)) {
965                     int fifo = cfq_cfqq_class_sync(cfqq);
966
967                     crq = RQ_DATA(list_entry_fifo(cfqq->fifo.next));
968                     rq = crq->request;
969                     if (time_after(jiffies, rq->start_time + cfqd->cfq_fifo_expire[fifo])) {
970                             cfq_mark_cfqq_fifo_expire(cfqq);
971                             return crq;
972                     }
973             }
(gdb)

0xb11c28f0 <cfq_dispatch_requests+239>: add    0x54(%edx),%eax



