Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVGaPE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVGaPE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVGaPE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:04:28 -0400
Received: from smtp.ifrance.com ([82.196.5.121]:30607 "EHLO smtp.ifrance.com")
	by vger.kernel.org with ESMTP id S261702AbVGaPE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:04:27 -0400
Message-ID: <42ECE7E9.1040406@winch-hebergement.net>
Date: Sun, 31 Jul 2005 17:02:01 +0200
From: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: gp@winch-hebergement.net
Subject: 2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to upgrade kernel from 2.6.12.3 to 2.6.13-rc4 on a 
rather loaded http server, but i'm currently having a kernel panic a few 
minutes only after booting. The bug was reproductible (the crash 
happened after every reboot, with the same backtrace).

Here is the error log:
------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:918!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c027dd56>]    Not tainted VLI
EFLAGS: 00010293   (2.6.13-rc4-endy)
EIP is at tcp_tso_should_defer+0xd6/0xf0
eax: 00000007   ebx: f1258080   ecx: 00000007   edx: f297f800
esi: 00000008   edi: 00000004   ebp: c031fd80   esp: c031fd70
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c031e000 task=c02dbb80)
Stack: f5f547b8 f1258080 00000008 f297f800 c031fdb8 c027de4b f297f800 
f297f800
        f1258080 00000009 f297f800 d039250c 00000000 00000002 00000002 
f297f800
        f297f800 00000100 c031fddc c027e192 f297f800 00000218 00000001 
f5fd4034
Call Trace:
  [<c0102e5f>] show_stack+0x7f/0xa0
  [<c0103002>] show_registers+0x152/0x1c0
  [<c01031f8>] die+0xc8/0x140
  [<c0103325>] do_trap+0xb5/0xc0
  [<c010366c>] do_invalid_op+0xbc/0xd0
  [<c0102aa3>] error_code+0x4f/0x54
  [<c027de4b>] tcp_write_xmit+0xdb/0x3f0
  [<c027e192>] __tcp_push_pending_frames+0x32/0xd0
  [<c027c04e>] tcp_rcv_state_process+0x2be/0x9c0
  [<c0283ee9>] tcp_v4_do_rcv+0x99/0x120
  [<c02844e2>] tcp_v4_rcv+0x572/0x750
  [<c026a62b>] ip_local_deliver+0xcb/0x1d0
  [<c026aa52>] ip_rcv+0x322/0x4a0
  [<c0256a97>] netif_receive_skb+0x137/0x1a0
  [<c0256b8f>] process_backlog+0x8f/0x110
  [<c0256c82>] net_rx_action+0x72/0x100
  [<c01172dc>] __do_softirq+0x8c/0xa0
  [<c011731a>] do_softirq+0x2a/0x30
  [<c01173d5>] irq_exit+0x35/0x40
  [<c01044fc>] do_IRQ+0x3c/0x70
  [<c0102a46>] common_interrupt+0x1a/0x20
  [<c0100997>] cpu_idle+0x57/0x60
  [<c010024b>] _stext+0x2b/0x30
  [<c0320847>] start_kernel+0x147/0x170
  [<c0100199>] 0xc0100199
Code: 89 f8 0f af c2 3b 45 f0 0f 47 45 f0 31 d2 89 45 f0 f7 f3 31 d2 39 
c1 73 ce ba 01 00 00 00 eb c7 6b c2 03 31 d2 39 c1 77 be eb ee <0f> 0b 
96 03 ae 54 2d c0 e9 76 ff ff ff 8b ba 78 02 00 00 eb eb
  <0>Kernel panic - not syncing: Fatal exception in interrupt

Some infos about my system:

My network card is an e1000.

root # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 3
cpu MHz         : 2995.045
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dtsacpi mmx fxsr sse sse2 ss ht tm pbe pni 
monitor ds_cpl cid
bogomips        : 5914.62

http00 root # uname -a
Linux http00 2.6.13-rc4 #1 Thu May 19 14:19:19 CEST 2005 i686 Intel(R) 
Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

You can find dmesg, lspci and config at the following address:
http://82.196.5.50/20050731/config.txt
http://82.196.5.50/20050731/dmesg.txt
http://82.196.5.50/20050731/lspci.txt
http://82.196.5.50/20050731/sysctl.txt

Best regards,

Guillaume Pelat
