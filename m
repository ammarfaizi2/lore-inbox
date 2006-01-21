Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWAUFmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWAUFmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 00:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAUFmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 00:42:03 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:46249 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932141AbWAUFmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 00:42:01 -0500
Message-ID: <43D1C99E.2000506@t-online.de>
Date: Sat, 21 Jan 2006 06:41:50 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: shemminger@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller 11ab:4362
 (rev 19)
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: VgQ3h0ZUYenCOjdGXKKFNrIfKQbnOdy6KMLaJIPZa+RbeqnQGen8UM@t-dialin.net
X-TOI-MSGID: 0701f308-dca2-4610-a53f-22e74bb4f09f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen!

System description:
    - AOpen i915GMm-HFS, Pentium M 750
    - Realtek 8139 PCI Adapter
    - The software once was a SuSE 9.2
    - kernel: various 2.6.15*, 2.6.16-rc*

The mainboard includes:

0000:02:00.0 Class 0200: 11ab:4362 (rev 19)
        Subsystem: a0a0:0506
        Flags: bus master, fast devsel, latency 0, IRQ 177
        Memory at d0020000 (64-bit, non-prefetchable) [size=1024M]
        I/O ports at a000 [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
        Capabilities: [e0] #10 [0011]

0000:03:00.0 Class 0200: 11ab:4362 (rev 19)
        Subsystem: a0a0:0506
        Flags: bus master, fast devsel, latency 0, IRQ 185
        Memory at d0120000 (64-bit, non-prefetchable) [size=1025M]
        I/O ports at b000 [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
        Capabilities: [e0] #10 [0011]

The sky2 driver is compiled into the kernel as well as the 8139 driver.
I am connected to the internet via adsl and do use the SuSE Firewall.

8139 with or without SuSEFirewall
=====================

Absolutely no problems.

SKY2 with SuSEFirewall
===============

Initiate or terminate a session: fine
host foo, ping bar, etc do not work,
Domain name lookup seems to be broken.

SKY2 without SuSEFirewall
=================

Seems to work.


Have a look at this part of /var/log/messages:
===========================
Jan 20 16:14:56 linux SuSEfirewall2: Firewall rules unloaded.
Jan 20 16:15:53 linux kernel: [ 1182.531241] dsl0: hw csum failure.
Jan 20 16:15:53 linux kernel: [ 1182.531251]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:53 linux kernel: [ 1182.531283]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:53 linux kernel: [ 1182.531302]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:53 linux kernel: [ 1182.531318]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:53 linux kernel: [ 1182.531357]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:53 linux kernel: [ 1182.531390]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:53 linux kernel: [ 1182.531406]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:53 linux kernel: [ 1182.531422]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:53 linux kernel: [ 1182.531436]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:53 linux kernel: [ 1182.531452]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:53 linux kernel: [ 1182.531468]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:53 linux kernel: [ 1182.531484]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:53 linux kernel: [ 1182.531499]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:53 linux kernel: [ 1182.531513]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:53 linux kernel: [ 1182.531526]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:53 linux kernel: [ 1182.531540]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:15:54 linux kernel: [ 1182.531565]  [<c0101147>] 
cpu_idle+0x87/0x90
Jan 20 16:15:54 linux kernel: [ 1182.531578]  [<c0100257>] _stext+0x37/0x40
Jan 20 16:15:54 linux kernel: [ 1182.531591]  [<c055a845>] 
start_kernel+0x195/0x1e0
Jan 20 16:15:54 linux kernel: [ 1182.531606]  [<c0100199>] 0xc0100199
Jan 20 16:15:54 linux kernel: [ 1183.548980] dsl0: hw csum failure.
Jan 20 16:15:54 linux kernel: [ 1183.548989]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:54 linux kernel: [ 1183.549020]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:54 linux kernel: [ 1183.549038]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:54 linux kernel: [ 1183.549054]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:55 linux kernel: [ 1183.549095]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:55 linux kernel: [ 1183.549127]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:55 linux kernel: [ 1183.549144]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:55 linux kernel: [ 1183.549159]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:55 linux kernel: [ 1183.549173]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:55 linux kernel: [ 1183.549190]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:55 linux kernel: [ 1183.549206]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:55 linux kernel: [ 1183.549221]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:55 linux kernel: [ 1183.549236]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:55 linux kernel: [ 1183.549250]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:55 linux kernel: [ 1183.549264]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:56 linux kernel: [ 1183.549278]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:15:56 linux kernel: [  887.950383] dsl0: hw csum failure.
Jan 20 16:15:56 linux kernel: [  887.950389]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:56 linux kernel: [  887.950416]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:56 linux kernel: [  887.950430]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:56 linux kernel: [  887.950442]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:56 linux kernel: [  887.950473]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:56 linux kernel: [  887.950498]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:56 linux kernel: [  887.950511]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:56 linux kernel: [  887.950522]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:57 linux kernel: [  887.950533]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:57 linux kernel: [  887.950545]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:57 linux kernel: [  887.950567]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:57 linux kernel: [  887.950579]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:57 linux kernel: [  887.950590]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:57 linux kernel: [  887.950600]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:57 linux kernel: [  887.950610]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:57 linux kernel: [  887.950621]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:15:57 linux kernel: [  889.050285] dsl0: hw csum failure.
Jan 20 16:15:57 linux kernel: [  889.050291]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:57 linux kernel: [  889.050319]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:57 linux kernel: [  889.050340]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:57 linux kernel: [  889.050352]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:57 linux kernel: [  889.050384]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:57 linux kernel: [  889.050409]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:57 linux kernel: [  889.050422]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:57 linux kernel: [  889.050433]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:57 linux kernel: [  889.050444]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:57 linux kernel: [  889.050456]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:57 linux kernel: [  889.050467]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:58 linux kernel: [  889.050479]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:58 linux kernel: [  889.050490]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:58 linux kernel: [  889.050500]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:58 linux kernel: [  889.050510]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:58 linux kernel: [  889.050520]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:15:58 linux kernel: [  889.050532]  [<c0101147>] 
cpu_idle+0x87/0x90
Jan 20 16:15:58 linux kernel: [  889.050542]  [<c0100257>] _stext+0x37/0x40
Jan 20 16:15:58 linux kernel: [  889.050551]  [<c055a845>] 
start_kernel+0x195/0x1e0
Jan 20 16:15:58 linux kernel: [  889.050562]  [<c0100199>] 0xc0100199
Jan 20 16:15:58 linux kernel: [  712.515665] dsl0: hw csum failure.
Jan 20 16:15:58 linux kernel: [  712.515670]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:58 linux kernel: [  712.515695]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:58 linux kernel: [  712.515706]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:58 linux kernel: [  712.515716]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:58 linux kernel: [  712.515742]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:58 linux kernel: [  712.515763]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:58 linux kernel: [  712.515774]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:58 linux kernel: [  712.515783]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:58 linux kernel: [  712.515792]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:58 linux kernel: [  712.515801]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:58 linux kernel: [  712.515811]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:58 linux kernel: [  712.515820]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:58 linux kernel: [  712.515829]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:58 linux kernel: [  712.515837]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:58 linux kernel: [  712.515845]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:58 linux kernel: [  712.515854]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:15:59 linux kernel: [  713.409544] dsl0: hw csum failure.
Jan 20 16:15:59 linux kernel: [  713.409550]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:59 linux kernel: [  713.409575]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:59 linux kernel: [  713.409587]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:59 linux kernel: [  713.409597]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:59 linux kernel: [  713.409624]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:59 linux kernel: [  713.409644]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:59 linux kernel: [  713.409655]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:59 linux kernel: [  713.409664]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:59 linux kernel: [  713.409673]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:59 linux kernel: [  713.409683]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:59 linux kernel: [  713.409692]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:59 linux kernel: [  713.409701]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:59 linux kernel: [  713.409711]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:59 linux kernel: [  713.409719]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:59 linux kernel: [  713.409727]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:59 linux kernel: [  713.409736]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:15:59 linux kernel: [  595.536855] dsl0: hw csum failure.
Jan 20 16:15:59 linux kernel: [  595.536859]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:15:59 linux kernel: [  595.536876]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:15:59 linux kernel: [  595.536886]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:15:59 linux kernel: [  595.536894]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:15:59 linux kernel: [  595.536918]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:15:59 linux kernel: [  595.536935]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:15:59 linux kernel: [  595.536944]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:15:59 linux kernel: [  595.536952]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:15:59 linux kernel: [  595.536959]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:15:59 linux kernel: [  595.536967]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:15:59 linux kernel: [  595.536975]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:15:59 linux kernel: [  595.536983]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:15:59 linux kernel: [  595.536991]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:15:59 linux kernel: [  595.536998]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:15:59 linux kernel: [  595.537004]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:15:59 linux kernel: [  595.537011]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:16:00 linux kernel: [  511.194225] dsl0: hw csum failure.
Jan 20 16:16:00 linux kernel: [  511.194232]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:16:00 linux kernel: [  511.194254]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:16:00 linux kernel: [  511.194263]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:16:00 linux kernel: [  511.194270]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:16:00 linux kernel: [  511.194291]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:16:00 linux kernel: [  511.194307]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:16:00 linux kernel: [  511.194315]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:16:00 linux kernel: [  511.194321]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:16:00 linux kernel: [  511.194327]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:16:00 linux kernel: [  511.194335]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:16:00 linux kernel: [  511.194341]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:16:00 linux kernel: [  511.194348]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:16:00 linux kernel: [  511.194355]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:16:00 linux kernel: [  511.194361]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:16:00 linux kernel: [  511.194367]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:16:00 linux kernel: [  511.194373]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:16:00 linux kernel: [  511.194379]  [<c0101147>] 
cpu_idle+0x87/0x90
Jan 20 16:16:00 linux kernel: [  511.194385]  [<c0100257>] _stext+0x37/0x40
Jan 20 16:16:00 linux kernel: [  511.194390]  [<c055a845>] 
start_kernel+0x195/0x1e0
Jan 20 16:16:00 linux kernel: [  511.194397]  [<c0100199>] 0xc0100199
Jan 20 16:16:01 linux kernel: [  511.933366] dsl0: hw csum failure.
Jan 20 16:16:01 linux kernel: [  511.933373]  [<c0104007>] 
dump_stack+0x17/0x20
Jan 20 16:16:01 linux kernel: [  511.933395]  [<c03a95c1>] 
netdev_rx_csum_fault+0x31/0x40
Jan 20 16:16:01 linux kernel: [  511.933405]  [<c03a6d4a>] 
__skb_checksum_complete+0x5a/0x60
Jan 20 16:16:01 linux kernel: [  511.933411]  [<f88d892e>] 
icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 20 16:16:01 linux kernel: [  511.933433]  [<f88d5d82>] 
ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 20 16:16:01 linux kernel: [  511.933448]  [<c03bdfa7>] 
nf_iterate+0x57/0x90
Jan 20 16:16:01 linux kernel: [  511.933464]  [<c03be045>] 
nf_hook_slow+0x65/0x120
Jan 20 16:16:01 linux kernel: [  511.933471]  [<c03c48d6>] 
ip_rcv+0x286/0x510
Jan 20 16:16:01 linux kernel: [  511.933477]  [<c03a9e05>] 
netif_receive_skb+0x165/0x1c0
Jan 20 16:16:01 linux kernel: [  511.933484]  [<c03a9ee7>] 
process_backlog+0x87/0x110
Jan 20 16:16:01 linux kernel: [  511.933491]  [<c03aa01f>] 
net_rx_action+0xaf/0x100
Jan 20 16:16:01 linux kernel: [  511.933498]  [<c01242d5>] 
__do_softirq+0x55/0xb0
Jan 20 16:16:01 linux kernel: [  511.933505]  [<c0124363>] 
do_softirq+0x33/0x40
Jan 20 16:16:01 linux kernel: [  511.933511]  [<c0124453>] 
irq_exit+0x43/0x50
Jan 20 16:16:01 linux kernel: [  511.933517]  [<c0105218>] do_IRQ+0x38/0x70
Jan 20 16:16:01 linux kernel: [  511.933523]  [<c0103baa>] 
common_interrupt+0x1a/0x20
Jan 20 16:16:01 linux kernel: [  511.933529]  [<c0101147>] 
cpu_idle+0x87/0x90
Jan 20 16:16:01 linux kernel: [  511.933535]  [<c0100257>] _stext+0x37/0x40
Jan 20 16:16:01 linux kernel: [  511.933540]  [<c055a845>] 
start_kernel+0x195/0x1e0
Jan 20 16:16:01 linux kernel: [  511.933547]  [<c0100199>] 0xc0100199

It seems that the SuSE Firewall locked something ....

I started with kernel 2.6.15-git7, tried 2.6.15.1 and 2.6.16-rc1*.
At the moment I do use a kernel 2.6.15-git7 patched with an updated sky2 
(v.013).
I could not find a single working sky2 configuration.

Any ideas?

cu,
 Knut
