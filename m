Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVESPdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVESPdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVESPdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:33:45 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:42251
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262492AbVESPdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:33:25 -0400
Date: Thu, 19 May 2005 08:33:24 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4 random oopses
Message-ID: <20050519153324.GA17914@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been attempting to upgrade a 2.6.10 box to 2.6.11 or 2.6.12-rc4,
and keep getting seemingly random oopses.  I've attached 4 of them below
for review.  The first 2 occurred without frame pointers enabled, the
second 2 with.  nmi_watchdog was enabled on all but the last one, as
I read about some potential problems with it recently.

Any ideas?

Phil

Unable to handle kernel NULL pointer dereference at virtual address 00000060
 printing eip: c026b44a
*pde = 00000000
Oops: 0000 [#1]
SMP 
CPU:    1
EIP:    0060:[<c026b44a>]    Not tainted VLI
EFLAGS: 00010206   (2.6.12-rc4) 
EIP is at ip_check_mc+0x2a/0xb0
eax: 026014aa   ebx: c1bb4720   ecx: f7a51e60   edx: 00000000
esi: c033bbe6   edi: 0000b9e6   ebp: f7c29000   esp: c0331d88
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0331000 task=c191b520)
Stack: 00000000 3e6014aa 00000000 0001001d f7044f60 00000000 00000001 3e6014aa 
       7525bece 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 c0331e44 
Call Trace:
 [<c024051a>] ip_route_input_slow+0x3da/0x760
 [<c0242939>] ip_rcv+0x3b9/0x4d0
 [<c0242bb0>] ip_rcv_finish+0x0/0x240
 [<c0111f48>] __wake_up+0x38/0x50
 [<c02304ea>] netif_receive_skb+0x13a/0x1a0
 [<c01f748e>] e1000_clean_rx_irq+0x16e/0x4c0
 [<c01f711f>] e1000_clean_tx_irq+0x1af/0x3b0
 [<c01f6ecc>] e1000_clean+0x3c/0xe0
 [<c02306ef>] net_rx_action+0x7f/0x110
 [<c011a414>] __do_softirq+0xd4/0xf0
 [<c010507f>] do_softirq+0x4f/0x60
 =======================
 [<c0104f6d>] do_IRQ+0x4d/0x70
 [<c0103406>] common_interrupt+0x1a/0x20
 [<c0100990>] default_idle+0x0/0x30
 [<c01009b3>] default_idle+0x23/0x30
 [<c0100a70>] cpu_idle+0x70/0x80
Code: 90 55 31 ed 57 56 89 d6 53 83 ec 08 89 c3 89 4c 24 04 8d 40 10 89 04 24 0f b7 7c 24 1c e8 3f be 01 00 8b 43 14 85 c0 74 14 90 8d <b4> 26 00 00 00 00 39 70 04 74 19 8b 40 1c 85 c0 75 f4 8b 04 24 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

***

Unable to handle kernel NULL pointer dereference at virtual address 00000060
 printing eip:
c0261bc2
*pde = 00000000
Oops: 0000 [#1]
SMP 
CPU:    1
EIP:    0060:[<c0261bc2>]    Not tainted VLI
EFLAGS: 00010206   (2.6.12-rc4) 
EIP is at udp_v4_get_port+0x22/0x220
eax: 026014aa   ebx: c1934400   ecx: f7c25820   edx: 00000000
esi: c0336d8b   edi: 00006c8b   ebp: f7c29000   esp: c0331d88
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0331000 task=c191b520)
Stack: 00000000 402614aa 00000000 00010018 f7765ee0 00000000 00000001 402614aa 
       887414aa 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 c0331e44 
Call Trace:
 [<c024051a>] ip_route_input_slow+0x3da/0x760
 [<c0242939>] ip_rcv+0x3b9/0x4d0
 [<c0242bb0>] ip_rcv_finish+0x0/0x240
 [<c0243edb>] ip_forward+0x14b/0x260
 [<c02304ea>] netif_receive_skb+0x13a/0x1a0
 [<c01f748e>] e1000_clean_rx_irq+0x16e/0x4c0
 [<c0264469>] arp_solicit+0xe9/0x1b0
 [<c01f711f>] e1000_clean_tx_irq+0x1af/0x3b0
 [<c01f6ecc>] e1000_clean+0x3c/0xe0
 [<c02306ef>] net_rx_action+0x7f/0x110
 [<c011a414>] __do_softirq+0xd4/0xf0
 [<c010507f>] do_softirq+0x4f/0x60
 =======================
 [<c0104f6d>] do_IRQ+0x4d/0x70
 [<c0103406>] common_interrupt+0x1a/0x20
 [<c0100990>] default_idle+0x0/0x30
 [<c01009b3>] default_idle+0x23/0x30
 [<c0100a70>] cpu_idle+0x70/0x80
Code: 04 74 e9 89 c2 eb f3 90 90 55 89 c5 b8 20 c3 2c c0 57 56 53 83 ec 08 0f b7 da e8 ba 57 02 00 66 85 db 0f 85 8c 01 00 00 8b 15 04 <bf> 2c c0 a1 c0 5c 35 c0 89 54 24 04 39 d0 0f 8f 68 01 00 00 8b 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

***

Unable to handle kernel paging request at virtual address 4e495720
 printing eip:
c0289d63
*pde = 00000000
Oops: 0002 [#1]
SMP 
CPU:    0
EIP:    0060:[<c0289d63>]    Not tainted VLI
EFLAGS: 00010206   (2.6.12-rc4) 
EIP is at _read_unlock_bh+0x3/0x10
eax: 4e495720   ebx: c02d14e0   ecx: 0000c8de   edx: 4e493a50
esi: f8861274   edi: f8861214   ebp: c0332d78   esp: c0332d78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0332000 task=c02b6bc0)
Stack: c033d8c4 c0277c73 f8861234 00000000 c0332dbc 00000070 c02d176c f8861504 
       f8861040 f7c29000 c0368da0 00000000 f7a91020 00000000 00000000 00000004 
       c0332ea0 00000000 00000004 f739f538 00000002 c0332df4 c027ade7 f7c29000 
Call Trace:
 [<c01038ba>] show_stack+0x7a/0x90
 [<c0103a3d>] show_registers+0x14d/0x1b0
 [<c0103c3d>] die+0xed/0x170
 [<c010f05a>] do_page_fault+0x30a/0x65a
 [<c0103503>] error_code+0x4f/0x54
 [<c0277c73>] ipt_do_table+0x263/0x340
 =======================
Code: 64 0b e9 ff 8d 74 26 00 55 89 e5 f0 ff 00 52 9d 5d c3 8d b6 00 00 00 00 55 89 e5 f0 ff 00 fb 5d c3 8d b4 26 00 00 00 00 55 89 e5 <f0> ff 00 5d e9 34 0b e9 ff 8d 74 26 00 55 89 e5 f0 81 00 00 00 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

***

Unable to handle kernel NULL pointer dereference at virtual address 000000ec
 printing eip:
c026a59a
*pde = 00000000
Oops: 0000 [#1]
SMP 
CPU:    1
EIP:    0060:[<c026a59a>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4) 
EIP is at inet_select_addr+0xa/0xf0
eax: 00000000   ebx: c1bb4720   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c0333d60   esp: c0333d54
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0333000 task=c191b520)
Stack: c1bb4720 c0333d74 00000000 c0333dd8 c026eb0b 00000000 3e6014aa 00000000 
       0001001d f78d169f 00000000 00000001 3e6014aa 25e65e42 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c01038ba>] show_stack+0x7a/0x90
 [<c0103a3d>] show_registers+0x14d/0x1b0
 [<c0103c3d>] die+0xed/0x170
 [<c010f05a>] do_page_fault+0x30a/0x65a
 [<c0103503>] error_code+0x4f/0x54
 [<c026eb0b>] fib_validate_source+0x1cb/0x1f0
 [<c0242305>] ip_route_input_slow+0x445/0x840
 [<c0244890>] ip_rcv+0x3b0/0x4d0
 [<c0231e3a>] netif_receive_skb+0x13a/0x1a0
 [<c01f87e6>] e1000_clean_rx_irq+0x156/0x480
 [<c01f822f>] e1000_clean+0x3f/0xe0
 [<c0232050>] net_rx_action+0x90/0x130
 [<c011a884>] __do_softirq+0xd4/0xf0
 [<c0104fc2>] do_softirq+0x52/0x70
 =======================
 [<c0104eb0>] do_IRQ+0x50/0x70
 [<c01033aa>] common_interrupt+0x1a/0x20
 [<c0100a82>] cpu_idle+0x72/0x80
 [<00000000>] stext+0x3feffd6c/0xc
 [<c191ffb4>] 0xc191ffb4
Code: 30 5b 5e 5f 5d c3 c7 45 c4 f2 <7> ff ff ff eb ec 89 f6 8b 75 d0 eb ae 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 57 31 ff 56 89 ce 53 <8b> 80 ec 00 00 00 85 c0 74 38 8b 48 0c 85 c9 74 2d f6 41 25 01 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

