Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVGQUnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVGQUnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGQUnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:43:33 -0400
Received: from imo-m28.mx.aol.com ([64.12.137.9]:21757 "EHLO
	imo-m28.mx.aol.com") by vger.kernel.org with ESMTP id S261388AbVGQUnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:43:07 -0400
From: AndyLiebman@aol.com
Message-ID: <7e.6d9bff30.300c1cd5@aol.com>
Date: Sun, 17 Jul 2005 16:43:01 EDT
Subject: 2.6.10 Kernel Goes Crazy After Resetting MTU
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 5200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are some rather extensive logs showing the Linux 2.6.10 kernel  
(kernel.org source) going into a tail spin after my "administration program"  tried 
to reset the mtu on all four of my Ethernet Ports. I believe only eth1 was  
changed -- from 9000 to 1500. But the admin program will reset all ports (even  
if the settings don't change). 
 
In about 1/2 a second, we generated this tremendous list of errors. Then  
everything went back to normal (except that all of my users on all subnets had  
their Windows workstations freak out when it occurred)
 
Any ideas? 
 

Jul 14 12:35:02 localhost sudo: theboss : TTY=unknown ;  PWD=/home/editors ; 
USER=root ; COMMAND=/sbin/ifconfig eth0 mtu 9000
Jul 14  12:35:02 localhost sudo: theboss : TTY=unknown ; PWD=/home/editors ;  
USER=root ; COMMAND=/sbin/ifconfig eth1 mtu 1500
Jul 14 12:35:02 localhost  sudo: theboss : TTY=unknown ; PWD=/home/editors ; 
USER=root ;  COMMAND=/sbin/ifconfig eth2 mtu 9000
Jul 14 12:35:02 localhost  sudo: theboss : TTY=unknown ; PWD=/home/editors ; 
USER=root ;  COMMAND=/sbin/ifconfig eth3 mtu 9000
Jul 14 12:35:02 localhost kernel:  ifconfig: page allocation failure. 
order:3, mode:0x20
Jul 14 12:35:02  localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14  12:35:02 localhost kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [__alloc_pages+835/840]  
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost kernel:   [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14  12:35:02 localhost kernel:  [<c013e9de>]  __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02 localhost  kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14  12:35:02 localhost kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul  14 12:35:02 localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:02 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:02 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943436006/1069028352] 
e1000_up+0x53/0x146 [e1000]
Jul 14  12:35:02 localhost kernel:  [<f88380e6>] e1000_up+0x53/0x146  [e1000]
Jul 14 12:35:02 localhost kernel:  [pg0+943449450/1069028352]  
e1000_change_mtu+0xbe/0x178 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883b56a>] e1000_change_mtu+0xbe/0x178 
[e1000]
Jul 14 12:35:02  localhost kernel:  [dev_set_mtu+94/124] dev_set_mtu+0x5e/0x7c
Jul 14  12:35:02 localhost kernel:  [<c0286c42>] dev_set_mtu+0x5e/0x7c
Jul  14 12:35:02 localhost kernel:  [dev_ioctl+473/756]  dev_ioctl+0x1d9/0x2f4
Jul 14 12:35:02 localhost kernel:   [<c028727a>] dev_ioctl+0x1d9/0x2f4
Jul 14 12:35:02 localhost  kernel:  [inet_ioctl+98/196] inet_ioctl+0x62/0xc4
Jul 14 12:35:02  localhost kernel:  [<c02c84f7>] inet_ioctl+0x62/0xc4
Jul 14  12:35:02 localhost kernel:  [sock_ioctl+401/608]  
sock_ioctl+0x191/0x260
Jul 14 12:35:02 localhost kernel:   [<c027cb3d>] sock_ioctl+0x191/0x260
Jul 14 12:35:02 localhost  kernel:  [sys_ioctl+386/547] sys_ioctl+0x182/0x223
Jul 14 12:35:02  localhost kernel:  [<c016a797>] sys_ioctl+0x182/0x223
Jul 14  12:35:02 localhost kernel:  [sysenter_past_esp+82/117]  
sysenter_past_esp+0x52/0x75
Jul 14 12:35:02 localhost kernel:   [<c01024c5>] sysenter_past_esp+0x52/0x75
Jul 14 12:35:02 localhost  kernel: ifconfig: page allocation failure. 
order:3, mode:0x20
Jul 14 12:35:02  localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14  12:35:02 localhost kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [__alloc_pages+835/840]  
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost kernel:   [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14  12:35:02 localhost kernel:  [<c013e9de>]  __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02 localhost  kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14  12:35:02 localhost kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul  14 12:35:02 localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:02 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:02 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:02 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:02 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:02 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [dev_ioctl+473/756] dev_ioctl+0x1d9/0x2f4
Jul 14 12:35:02  localhost kernel:  [<c028727a>] dev_ioctl+0x1d9/0x2f4
Jul 14  12:35:02 localhost kernel:  [inet_ioctl+98/196] inet_ioctl+0x62/0xc4
Jul  14 12:35:02 localhost kernel:  [<c02c84f7>]  inet_ioctl+0x62/0xc4
Jul 14 12:35:02 localhost kernel:   [sock_ioctl+401/608] 
sock_ioctl+0x191/0x260
Jul 14 12:35:02 localhost  kernel:  [<c027cb3d>] sock_ioctl+0x191/0x260
Jul 14 12:35:02  localhost kernel:  [sys_ioctl+386/547] sys_ioctl+0x182/0x223
Jul 14  12:35:02 localhost kernel:  [<c016a797>] sys_ioctl+0x182/0x223
Jul  14 12:35:02 localhost kernel:  [sysenter_past_esp+82/117]  
sysenter_past_esp+0x52/0x75
Jul 14 12:35:02 localhost kernel:   [<c01024c5>] sysenter_past_esp+0x52/0x75
Jul 14 12:35:02 localhost  kernel: ifconfig: page allocation failure. 
order:3, mode:0x20
Jul 14 12:35:02  localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14  12:35:02 localhost kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [__alloc_pages+835/840]  
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost kernel:   [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14  12:35:02 localhost kernel:  [<c013e9de>]  __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02 localhost  kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14  12:35:02 localhost kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul  14 12:35:02 localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:02 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:02 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:02 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:02 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:02 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [__mod_timer+240/284] 
__mod_timer+0xf0/0x11c
Jul 14 12:35:02  localhost kernel:  [<c0122d16>] __mod_timer+0xf0/0x11c
Jul 14  12:35:02 localhost kernel:  [pg0+943445956/1069028352]  
e1000_watchdog+0x1a2/0x412 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883a7c4>] e1000_watchdog+0x1a2/0x412 
[e1000]
Jul 14 12:35:02  localhost kernel:  [run_timer_softirq+196/389]  
run_timer_softirq+0xc4/0x185
Jul 14 12:35:02 localhost kernel:   [<c0123584>] run_timer_softirq+0xc4/0x185
Jul 14 12:35:02 localhost  kernel:  [__do_softirq+101/211] 
__do_softirq+0x65/0xd3
Jul 14 12:35:02  localhost kernel:  [<c011f631>] __do_softirq+0x65/0xd3
Jul 14  12:35:02 localhost kernel:  [do_softirq+49/51] do_softirq+0x31/0x33
Jul  14 12:35:02 localhost kernel:  [<c011f6d0>]  do_softirq+0x31/0x33
Jul 14 12:35:02 localhost kernel:   [apic_timer_interrupt+28/36] 
apic_timer_interrupt+0x1c/0x24
Jul 14 12:35:02  localhost kernel:  [<c0102f18>] 
apic_timer_interrupt+0x1c/0x24
Jul  14 12:35:02 localhost kernel:  [pg0+943451260/1069028352]  
e1000_update_stats+0x658/0x6b9 [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883bc7c>] 
e1000_update_stats+0x658/0x6b9 [e1000]
Jul  14 12:35:02 localhost kernel:  [pg0+943449248/1069028352]  
e1000_get_stats+0x15/0x21 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883b4a0>] e1000_get_stats+0x15/0x21 
[e1000]
Jul 14 12:35:02  localhost kernel:  [rtnetlink_fill_ifinfo+1235/1510]  
rtnetlink_fill_ifinfo+0x4d3/0x5e6
Jul 14 12:35:02 localhost kernel:   [<c028d6e8>] 
rtnetlink_fill_ifinfo+0x4d3/0x5e6
Jul 14 12:35:02  localhost kernel:  [rtmsg_ifinfo+92/203] 
rtmsg_ifinfo+0x5c/0xcb
Jul 14  12:35:02 localhost kernel:  [<c028dc32>]  rtmsg_ifinfo+0x5c/0xcb
Jul 14 12:35:02 localhost kernel:   [rtnetlink_event+48/93] 
rtnetlink_event+0x30/0x5d
Jul 14 12:35:02 localhost  kernel:  [<c028e08e>] rtnetlink_event+0x30/0x5d
Jul 14 12:35:02  localhost kernel:  [notifier_call_chain+39/63]  
notifier_call_chain+0x27/0x3f
Jul 14 12:35:02 localhost kernel:   [<c012727e>] notifier_call_chain+0x27/0x3f
Jul 14 12:35:02 localhost  kernel:  [dev_set_mtu+122/124] 
dev_set_mtu+0x7a/0x7c
Jul 14 12:35:02  localhost kernel:  [<c0286c5e>] dev_set_mtu+0x7a/0x7c
Jul 14  12:35:02 localhost kernel:  [dev_ioctl+473/756]  dev_ioctl+0x1d9/0x2f4
Jul 14 12:35:02 localhost kernel:   [<c028727a>] dev_ioctl+0x1d9/0x2f4
Jul 14 12:35:02 localhost  kernel:  [inet_ioctl+98/196] inet_ioctl+0x62/0xc4
Jul 14 12:35:02  localhost kernel:  [<c02c84f7>] inet_ioctl+0x62/0xc4
Jul 14  12:35:02 localhost kernel:  [sock_ioctl+401/608]  
sock_ioctl+0x191/0x260
Jul 14 12:35:02 localhost kernel:   [<c027cb3d>] sock_ioctl+0x191/0x260
Jul 14 12:35:02 localhost  kernel:  [sys_ioctl+386/547] sys_ioctl+0x182/0x223
Jul 14 12:35:02  localhost kernel:  [<c016a797>] sys_ioctl+0x182/0x223
Jul 14  12:35:02 localhost kernel:  [sysenter_past_esp+82/117]  
sysenter_past_esp+0x52/0x75
Jul 14 12:35:02 localhost kernel:   [<c01024c5>] sysenter_past_esp+0x52/0x75
Jul 14 12:35:02 localhost  kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14 12:35:02  localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14  12:35:02 localhost kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [__alloc_pages+835/840]  
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost kernel:   [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14  12:35:02 localhost kernel:  [<c013e9de>]  __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02 localhost  kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14  12:35:02 localhost kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul  14 12:35:02 localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:02 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:02 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:02 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:02 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:02 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:02  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:02 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:02  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:02  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:02 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:02 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:02 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:02 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:02 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:02 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:02 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:02 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:02  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:02 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:02  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:02  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:02 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:02 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:02 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:02 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:02 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:02 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:02 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:02 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:02  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:02 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:02  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:02  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:02 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:02 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:02 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:02 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:02 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:02 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:02 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:02 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:02  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:02 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:02  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:02  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:02 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:02 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:02 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:02 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:02 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:02 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:02 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:02 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [ip_rcv+1134/1275] ip_rcv+0x46e/0x4fb
Jul 14 12:35:02 localhost  kernel:  [<c029f51d>] ip_rcv+0x46e/0x4fb
Jul 14 12:35:02 localhost  kernel:  [netif_receive_skb+550/562] 
netif_receive_skb+0x226/0x232
Jul  14 12:35:02 localhost kernel:  [<c0286282>]  
netif_receive_skb+0x226/0x232
Jul 14 12:35:02 localhost kernel:   [process_backlog+129/276] 
process_backlog+0x81/0x114
Jul 14 12:35:02  localhost kernel:  [<c028630f>] process_backlog+0x81/0x114
Jul 14  12:35:02 localhost kernel:  [net_rx_action+195/270]  
net_rx_action+0xc3/0x10e
Jul 14 12:35:02 localhost kernel:   [__do_softirq+101/211] 
__do_softirq+0x65/0xd3
Jul 14 12:35:02 localhost  kernel:  [<c011f631>] __do_softirq+0x65/0xd3
Jul 14 12:35:02  localhost kernel:  [do_softirq+49/51] do_softirq+0x31/0x33
Jul 14  12:35:02 localhost kernel:  [<c011f6d0>] do_softirq+0x31/0x33
Jul  14 12:35:02 localhost kernel:  [do_IRQ+33/40] do_IRQ+0x21/0x28
Jul 14  12:35:02 localhost kernel:  [<c010483d>] do_IRQ+0x21/0x28
Jul 14  12:35:02 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:02  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:02 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:02  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:02  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:02 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:02 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:02 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:02  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:02  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:02 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:02 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:02 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:02 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:02 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:02 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:02  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [ip_rcv+1134/1275] ip_rcv+0x46e/0x4fb
Jul 14 12:35:02 localhost  kernel:  [<c029f51d>] ip_rcv+0x46e/0x4fb
Jul 14 12:35:02 localhost  kernel:  [netif_receive_skb+550/562] 
netif_receive_skb+0x226/0x232
Jul  14 12:35:02 localhost kernel:  [<c0286282>]  
netif_receive_skb+0x226/0x232
Jul 14 12:35:02 localhost kernel:   [process_backlog+129/276] 
process_backlog+0x81/0x114
Jul 14 12:35:02  localhost kernel:  [<c028630f>] process_backlog+0x81/0x114
Jul 14  12:35:02 localhost kernel:  [net_rx_action+195/270]  
net_rx_action+0xc3/0x10e
Jul 14 12:35:02 localhost kernel:   [<c0286465>] net_rx_action+0xc3/0x10e
Jul 14 12:35:02 localhost  kernel:  [__do_softirq+101/211] 
__do_softirq+0x65/0xd3
Jul 14 12:35:02  localhost kernel:  [<c011f631>] __do_softirq+0x65/0xd3
Jul 14  12:35:02 localhost kernel:  [do_softirq+49/51] do_softirq+0x31/0x33
Jul  14 12:35:02 localhost kernel:  [<c011f6d0>]  do_softirq+0x31/0x33
Jul 14 12:35:02 localhost kernel:  [do_IRQ+33/40]  do_IRQ+0x21/0x28
Jul 14 12:35:02 localhost kernel:  [<c010483d>]  do_IRQ+0x21/0x28
Jul 14 12:35:02 localhost kernel:   [common_interrupt+26/32] 
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02  localhost kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02  localhost kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02  localhost kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul  14 12:35:02 localhost kernel:  [<c03da950>]  start_kernel+0x176/0x1b0
Jul 14 12:35:02 localhost kernel:  [L6+0/2]  0xc0100211
Jul 14 12:35:02 localhost kernel:  [<c0100211>]  0xc0100211
Jul 14 12:35:02 localhost kernel: swapper: page allocation  failure. order:3, 
mode:0x20
Jul 14 12:35:02 localhost kernel:   [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14 12:35:02 localhost  kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul 14 12:35:02  localhost kernel:  [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul  14 12:35:02 localhost kernel:  [<c013e9b4>]  __alloc_pages+0x343/0x348
Jul 14 12:35:02 localhost kernel:   [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14 12:35:02 localhost  kernel:  [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:02  localhost kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14  12:35:02 localhost kernel:  [<c0141e9e>]  kmem_getpages+0x20/0xce
Jul 14 12:35:02 localhost kernel:   [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14 12:35:02 localhost  kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:02  localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:02 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:02  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:02 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:02 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:02 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:02 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:02 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:02 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:02 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:02 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:02  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:02 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:02 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [ip_rcv+1134/1275] ip_rcv+0x46e/0x4fb
Jul 14 12:35:02 localhost  kernel:  [<c029f51d>] ip_rcv+0x46e/0x4fb
Jul 14 12:35:02 localhost  kernel:  [netif_receive_skb+550/562] 
netif_receive_skb+0x226/0x232
Jul  14 12:35:02 localhost kernel:  [<c0286282>]  
netif_receive_skb+0x226/0x232
Jul 14 12:35:02 localhost kernel:   [process_backlog+129/276] 
process_backlog+0x81/0x114
Jul 14 12:35:02  localhost kernel:  [<c028630f>] process_backlog+0x81/0x114
Jul 14  12:35:02 localhost kernel:  [net_rx_action+195/270]  
net_rx_action+0xc3/0x10e
Jul 14 12:35:02 localhost kernel:   [<c0286465>] net_rx_action+0xc3/0x10e
Jul 14 12:35:02 localhost  kernel:  [__do_softirq+101/211] 
__do_softirq+0x65/0xd3
Jul 14 12:35:02  localhost kernel:  [<c011f631>] __do_softirq+0x65/0xd3
Jul 14  12:35:02 localhost kernel:  [do_softirq+49/51] do_softirq+0x31/0x33
Jul  14 12:35:02 localhost kernel:  [<c011f6d0>]  do_softirq+0x31/0x33
Jul 14 12:35:02 localhost kernel:  [do_IRQ+33/40]  do_IRQ+0x21/0x28
Jul 14 12:35:02 localhost kernel:  [<c010483d>]  do_IRQ+0x21/0x28
Jul 14 12:35:02 localhost kernel:   [common_interrupt+26/32] 
common_interrupt+0x1a/0x20
Jul 14 12:35:02 localhost  kernel:  [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:02  localhost kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:02  localhost kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:02  localhost kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul  14 12:35:02 localhost kernel:  [<c03da950>]  start_kernel+0x176/0x1b0
Jul 14 12:35:02 localhost kernel:  [L6+0/2]  0xc0100211
Jul 14 12:35:02 localhost kernel:  [<c0100211>]  0xc0100211
Jul 14 12:35:03 localhost ifplugd(eth2)[2469]: Link beat  lost.
Jul 14 12:35:05 localhost kernel: e1000: eth2: e1000_watchdog: NIC Link  is 
Up 1000 Mbps Full Duplex
Jul 14 12:35:06 localhost ifplugd(eth2)[2469]:  Link beat detected.
Jul 14 12:35:07 localhost kernel: printk: 5154 messages  suppressed.
Jul 14 12:35:07 localhost kernel: swapper: page allocation  failure. order:3, 
mode:0x20
Jul 14 12:35:07 localhost kernel:   [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14 12:35:07 localhost  kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul 14 12:35:07  localhost kernel:  [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul  14 12:35:07 localhost kernel:  [<c013e9b4>]  __alloc_pages+0x343/0x348
Jul 14 12:35:07 localhost kernel:   [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14 12:35:07 localhost  kernel:  [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:07  localhost kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14  12:35:07 localhost kernel:  [<c0141e9e>]  kmem_getpages+0x20/0xce
Jul 14 12:35:07 localhost kernel:   [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14 12:35:07 localhost  kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:07  localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:07 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:07 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:07  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:07 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:07 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:07 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:07 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:07 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:07 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:07 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:07 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:07 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:07 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:07 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:07  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:07 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:07 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:07 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:07 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:07 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:07 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:07 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:07  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:07 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:07  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:12  localhost kernel: printk: 47229 messages suppressed.
Jul 14 12:35:12  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:12 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:12 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:12 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:12 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:12  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:12 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:12 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:12  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:12 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:12 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:12 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:12 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:12 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:12 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:12  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:12 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:12 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:12 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:12 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:12 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:12 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:12 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:12 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:12 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:12 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:12 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:12  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:12  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:12  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:12 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:12 localhost  kernel:  [kfree_skbmem+18/41] 
kfree_skbmem+0x12/0x29
Jul 14 12:35:12  localhost kernel:  [<c02800fc>] kfree_skbmem+0x12/0x29
Jul 14  12:35:12 localhost kernel:  [__kfree_skb+173/318]  
__kfree_skb+0xad/0x13e
Jul 14 12:35:12 localhost kernel:   [<c02801c0>] __kfree_skb+0xad/0x13e
Jul 14 12:35:12 localhost  kernel:  [tcp_clean_rtx_queue+303/1075]  
tcp_clean_rtx_queue+0x12f/0x433
Jul 14 12:35:12 localhost kernel:   [<c02ae57f>] 
tcp_clean_rtx_queue+0x12f/0x433
Jul 14 12:35:12 localhost  kernel:  [tcp_ack+186/1445] tcp_ack+0xba/0x5a5
Jul 14 12:35:12 localhost  kernel:  [<c02aee81>] tcp_ack+0xba/0x5a5
Jul 14 12:35:12 localhost  kernel:  [tcp_rcv_established+1454/2306]  
tcp_rcv_established+0x5ae/0x902
Jul 14 12:35:12 localhost kernel:   [<c02b1caf>] 
tcp_rcv_established+0x5ae/0x902
Jul 14 12:35:12 localhost  kernel:  [tcp_v4_do_rcv+305/310] 
tcp_v4_do_rcv+0x131/0x136
Jul 14  12:35:12 localhost kernel:  [<c02ba6ce>]  tcp_v4_do_rcv+0x131/0x136
Jul 14 12:35:12 localhost kernel:   [tcp_v4_rcv+2190/2457] 
tcp_v4_rcv+0x88e/0x999
Jul 14 12:35:12 localhost  kernel:  [<c02baf61>] tcp_v4_rcv+0x88e/0x999
Jul 14 12:35:12  localhost kernel:  [ip_local_deliver+149/654]  
ip_local_deliver+0x95/0x28e
Jul 14 12:35:12 localhost kernel:   [<c029eeb6>] ip_local_deliver+0x95/0x28e
Jul 14 12:35:12 localhost  kernel:  [ip_rcv+1134/1275] ip_rcv+0x46e/0x4fb
Jul 14 12:35:12 localhost  kernel:  [<c029f51d>] ip_rcv+0x46e/0x4fb
Jul 14 12:35:12 localhost  kernel:  [netif_receive_skb+550/562] 
netif_receive_skb+0x226/0x232
Jul  14 12:35:12 localhost kernel:  [<c0286282>]  
netif_receive_skb+0x226/0x232
Jul 14 12:35:12 localhost kernel:   [process_backlog+129/276] 
process_backlog+0x81/0x114
Jul 14 12:35:12  localhost kernel:  [<c028630f>] process_backlog+0x81/0x114
Jul 14  12:35:12 localhost kernel:  [net_rx_action+195/270]  
net_rx_action+0xc3/0x10e
Jul 14 12:35:12 localhost kernel:   [<c0286465>] net_rx_action+0xc3/0x10e
Jul 14 12:35:12 localhost  kernel:  [__do_softirq+101/211] 
__do_softirq+0x65/0xd3
Jul 14 12:35:12  localhost kernel:  [<c011f631>] __do_softirq+0x65/0xd3
Jul 14  12:35:12 localhost kernel:  [do_softirq+49/51] do_softirq+0x31/0x33
Jul  14 12:35:12 localhost kernel:  [<c011f6d0>]  do_softirq+0x31/0x33
Jul 14 12:35:12 localhost kernel:  [do_IRQ+33/40]  do_IRQ+0x21/0x28
Jul 14 12:35:12 localhost kernel:  [<c010483d>]  do_IRQ+0x21/0x28
Jul 14 12:35:12 localhost kernel:   [common_interrupt+26/32] 
common_interrupt+0x1a/0x20
Jul 14 12:35:12 localhost  kernel:  [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:12  localhost kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:12  localhost kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:12  localhost kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul  14 12:35:12 localhost kernel:  [<c03da950>]  start_kernel+0x176/0x1b0
Jul 14 12:35:12 localhost kernel:  [L6+0/2]  0xc0100211
Jul 14 12:35:12 localhost kernel:  [<c0100211>]  0xc0100211
Jul 14 12:35:17 localhost kernel: printk: 7894 messages  suppressed.
Jul 14 12:35:17 localhost kernel: swapper: page allocation  failure. order:3, 
mode:0x20
Jul 14 12:35:17 localhost kernel:   [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14 12:35:17 localhost  kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul 14 12:35:17  localhost kernel:  [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul  14 12:35:17 localhost kernel:  [<c013e9b4>]  __alloc_pages+0x343/0x348
Jul 14 12:35:17 localhost kernel:   [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14 12:35:17 localhost  kernel:  [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:17  localhost kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14  12:35:17 localhost kernel:  [<c0141e9e>]  kmem_getpages+0x20/0xce
Jul 14 12:35:17 localhost kernel:   [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14 12:35:17 localhost  kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:17  localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:17 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:17 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:17  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:17 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:17 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:17 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:17 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:17 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:17 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:17 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:17 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:17 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:17 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:17 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:17  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:17 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:17 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:17 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:17 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:17 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:17 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:17 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:17  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:17 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:17  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:22  localhost kernel: printk: 66036 messages suppressed.
Jul 14 12:35:22  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:22 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:22 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:22 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:22 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:22  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:22 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:22 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:22  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:22 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:22 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:22 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:22 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:22 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:22 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:22  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:22 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:22 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:22 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:22 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:22 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:22 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:22 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:22 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:22 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:22 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:22 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:22  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:22  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:22  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:22 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:22 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:22 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:22 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:22  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:22 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:22  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:24  localhost smbd[30070]: [2005/07/14 12:35:24, 0]  
param/loadparm.c:lp_do_parameter(3162)
Jul 14 12:35:24 localhost  smbd[30070]:   Global parameter unix extensions 
found in service  section!
Jul 14 12:35:24 localhost smbd[30070]: [2005/07/14 12:35:24, 0]  
printing/print_cups.c:cups_cache_reload(85)
Jul 14 12:35:24 localhost  smbd[30070]:   Unable to connect to CUPS server 
localhost - Connection  refused
Jul 14 12:35:24 localhost smbd[30070]: [2005/07/14 12:35:24, 0]  
printing/print_cups.c:cups_cache_reload(85)
Jul 14 12:35:24 localhost  smbd[30070]:   Unable to connect to CUPS server 
localhost - Connection  refused
Jul 14 12:35:27 localhost kernel: printk: 124992 messages  suppressed.
Jul 14 12:35:27 localhost kernel: swapper: page allocation  failure. order:3, 
mode:0x20
Jul 14 12:35:27 localhost kernel:   [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 14 12:35:27 localhost  kernel:  [<c0103378>] dump_stack+0x1e/0x20
Jul 14 12:35:27  localhost kernel:  [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul  14 12:35:27 localhost kernel:  [<c013e9b4>]  __alloc_pages+0x343/0x348
Jul 14 12:35:27 localhost kernel:   [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14 12:35:27 localhost  kernel:  [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:27  localhost kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14  12:35:27 localhost kernel:  [<c0141e9e>]  kmem_getpages+0x20/0xce
Jul 14 12:35:27 localhost kernel:   [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14 12:35:27 localhost  kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:27  localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:27 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:27 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:27  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:27 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:27 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:27 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:27 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:27 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:27 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:27 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:27 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:27 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:27 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:27 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:27  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:27 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:27 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:27 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:27 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:27 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:27 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:27 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:27  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:27 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:27  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:32  localhost kernel: printk: 90240 messages suppressed.
Jul 14 12:35:32  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:32 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:32 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:32 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:32 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:32  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:32 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:32 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:32  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:32 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:32 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:32 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:32 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:32 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:32 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:32  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:32 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:32 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:32 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:32 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:32 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:32 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:32 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:32 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:32 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:32 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:32 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:32  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:32  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:32  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:32 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:32 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:32 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:32 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:32  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:32 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:32  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:37  localhost kernel: printk: 49540 messages suppressed.
Jul 14 12:35:37  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:37 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:37 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:37 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:37 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:37  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:37 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:37 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:37  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:37 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:37 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:37 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:37 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:37 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:37 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:37  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:37 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:37 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:37 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:37 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:37 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:37 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:37 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:37 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:37 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:37 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:37 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:37  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:37  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:37  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:37 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:37 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:37 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:37 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:37  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:37 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:37  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:42  localhost kernel: printk: 76924 messages suppressed.
Jul 14 12:35:42  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:42 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:42 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:42 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:42 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:42  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:42 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:42 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:42  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:42 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:42 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:42 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:42 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:42 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:42 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:42  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:42 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:42 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:42 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:42 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:42 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:42 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:42 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:42 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:42 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:42 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:42 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:42  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:42  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:42  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:42 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:42 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:42 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:42 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:42  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:42 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:42  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:47  localhost kernel: printk: 66392 messages suppressed.
Jul 14 12:35:47  localhost kernel: swapper: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:47 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:47 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:47 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:47 localhost  kernel:  [<c013e9b4>] __alloc_pages+0x343/0x348
Jul 14 12:35:47  localhost kernel:  [__get_free_pages+37/61]  
__get_free_pages+0x25/0x3d
Jul 14 12:35:47 localhost kernel:   [<c013e9de>] __get_free_pages+0x25/0x3d
Jul 14 12:35:47 localhost  kernel:  [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:47  localhost kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14  12:35:47 localhost kernel:  [cache_grow+176/351]  
cache_grow+0xb0/0x15f
Jul 14 12:35:47 localhost kernel:   [<c0142b9a>] cache_grow+0xb0/0x15f
Jul 14 12:35:47 localhost  kernel:  [cache_alloc_refill+343/547] 
cache_alloc_refill+0x157/0x223
Jul  14 12:35:47 localhost kernel:  [<c0142da0>]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:47 localhost kernel:   [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:47 localhost  kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14 12:35:47  localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul 14  12:35:47 localhost kernel:  [<c027ff24>] alloc_skb+0x4e/0xf0
Jul  14 12:35:47 localhost kernel:  [pg0+943455655/1069028352]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:47 localhost  kernel:  [<f883cda7>] 
e1000_alloc_rx_buffers+0x67/0x35f  [e1000]
Jul 14 12:35:47 localhost kernel:  [pg0+943453626/1069028352]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:47 localhost  kernel:  [<f883c5ba>] 
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul  14 12:35:47 localhost kernel:  [pg0+943451472/1069028352]  
e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:47 localhost kernel:   [<f883bd50>] e1000_intr+0x73/0xf4 [e1000]
Jul 14 12:35:47 localhost  kernel:  [handle_IRQ_event+62/115] 
handle_IRQ_event+0x3e/0x73
Jul 14  12:35:47 localhost kernel:  [<c0138bc1>]  handle_IRQ_event+0x3e/0x73
Jul 14 12:35:47 localhost kernel:   [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:47 localhost  kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14 12:35:47  localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14 12:35:47  localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14 12:35:47  localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:47 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:47 localhost  kernel:  [cpu_idle+49/63] cpu_idle+0x31/0x3f
Jul 14 12:35:47 localhost  kernel:  [<c0100747>] cpu_idle+0x31/0x3f
Jul 14 12:35:47 localhost  kernel:  [start_kernel+374/432] 
start_kernel+0x176/0x1b0
Jul 14 12:35:47  localhost kernel:  [<c03da950>] start_kernel+0x176/0x1b0
Jul 14  12:35:47 localhost kernel:  [L6+0/2] 0xc0100211
Jul 14 12:35:47  localhost kernel:  [<c0100211>] 0xc0100211
Jul 14 12:35:52  localhost kernel: printk: 46620 messages suppressed.
Jul 14 12:35:52  localhost kernel: smbd: page allocation failure. order:3, 
mode:0x20
Jul 14  12:35:52 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  14 12:35:52 localhost kernel:  [<c0103378>]  dump_stack+0x1e/0x20
Jul 14 12:35:52 localhost kernel:   [__alloc_pages+835/840] 
__alloc_pages+0x343/0x348
Jul 14 12:35:52 localhost  kernel:  [__get_free_pages+37/61] 
__get_free_pages+0x25/0x3d
Jul 14  12:35:52 localhost kernel:  [<c013e9de>]  __get_free_pages+0x25/0x3d
Jul 14 12:35:52 localhost kernel:   [kmem_getpages+32/206] 
kmem_getpages+0x20/0xce
Jul 14 12:35:52 localhost  kernel:  [<c0141e9e>] kmem_getpages+0x20/0xce
Jul 14 12:35:52  localhost kernel:  [cache_grow+176/351] cache_grow+0xb0/0x15f
Jul 14  12:35:52 localhost kernel:  [<c0142b9a>] cache_grow+0xb0/0x15f
Jul  14 12:35:52 localhost kernel:  [cache_alloc_refill+343/547]  
cache_alloc_refill+0x157/0x223
Jul 14 12:35:52 localhost kernel:   [<c0142da0>] 
cache_alloc_refill+0x157/0x223
Jul 14 12:35:52 localhost  kernel:  [__kmalloc+125/127] __kmalloc+0x7d/0x7f
Jul 14 12:35:52  localhost kernel:  [<c014311e>] __kmalloc+0x7d/0x7f
Jul 14  12:35:52 localhost kernel:  [alloc_skb+78/240] alloc_skb+0x4e/0xf0
Jul  14 12:35:52 localhost kernel:  [<c027ff24>]  alloc_skb+0x4e/0xf0
Jul 14 12:35:52 localhost kernel:   [pg0+943455655/1069028352] 
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14  12:35:52 localhost kernel:  [<f883cda7>]  
e1000_alloc_rx_buffers+0x67/0x35f [e1000]
Jul 14 12:35:52 localhost  kernel:  [pg0+943453626/1069028352] 
e1000_clean_rx_irq+0x1e2/0x4e4  [e1000]
Jul 14 12:35:52 localhost kernel:  [<f883c5ba>]  
e1000_clean_rx_irq+0x1e2/0x4e4 [e1000]
Jul 14 12:35:52 localhost  kernel:  [pg0+943451472/1069028352] 
e1000_intr+0x73/0xf4 [e1000]
Jul 14  12:35:52 localhost kernel:  [<f883bd50>] e1000_intr+0x73/0xf4  [e1000]
Jul 14 12:35:52 localhost kernel:  [handle_IRQ_event+62/115]  
handle_IRQ_event+0x3e/0x73
Jul 14 12:35:52 localhost kernel:   [<c0138bc1>] handle_IRQ_event+0x3e/0x73
Jul 14 12:35:52 localhost  kernel:  [__do_IRQ+208/318] __do_IRQ+0xd0/0x13e
Jul 14 12:35:52  localhost kernel:  [<c0138cc6>] __do_IRQ+0xd0/0x13e
Jul 14  12:35:52 localhost kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
Jul 14  12:35:52 localhost kernel:  [<c0104838>] do_IRQ+0x1c/0x28
Jul 14  12:35:52 localhost kernel:  [common_interrupt+26/32]  
common_interrupt+0x1a/0x20
Jul 14 12:35:52 localhost kernel:   [<c0102e8a>] common_interrupt+0x1a/0x20
Jul 14 12:35:52 localhost  kernel:  [__alloc_pages+170/840] 
__alloc_pages+0xaa/0x348
Jul 14  12:35:52 localhost kernel:  [<c013e71b>]  __alloc_pages+0xaa/0x348
Jul 14 12:35:52 localhost kernel:   [generic_file_buffered_write+252/1595]  
generic_file_buffered_write+0xfc/0x63b
Jul 14 12:35:52 localhost  kernel:  [<c013be36>] 
generic_file_buffered_write+0xfc/0x63b
Jul  14 12:35:52 localhost kernel:  [pg0+948484628/1069028352]  
xfs_write+0x72e/0xb00 [xfs]
Jul 14 12:35:52 localhost kernel:   [<f8d08a14>] xfs_write+0x72e/0xb00 [xfs]
Jul 14 12:35:52 localhost  kernel:  [pg0+948466535/1069028352] 
linvfs_write+0x8f/0xa0 [xfs]
Jul 14  12:35:52 localhost kernel:  [<f8d04367>] linvfs_write+0x8f/0xa0  [xfs]
Jul 14 12:35:52 localhost kernel:  [do_sync_write+171/241]  
do_sync_write+0xab/0xf1
Jul 14 12:35:52 localhost kernel:   [<c0158763>] do_sync_write+0xab/0xf1
Jul 14 12:35:52 localhost  kernel:  [vfs_write+162/270] vfs_write+0xa2/0x10e
Jul 14 12:35:52  localhost kernel:  [<c015884b>] vfs_write+0xa2/0x10e
Jul 14  12:35:52 localhost kernel:  [sys_pwrite64+109/122]  
sys_pwrite64+0x6d/0x7a
Jul 14 12:35:52 localhost kernel:   [<c0158a88>] sys_pwrite64+0x6d/0x7a
Jul 14 12:35:52 localhost  kernel:  [sysenter_past_esp+82/117] 
sysenter_past_esp+0x52/0x75
Jul 14  12:35:52 localhost kernel:  [<c01024c5>]  sysenter_past_esp+0x52/0x75
Jul 14 12:44:38 localhost smbd[30071]:  [2005/07/14 12:44:38, 0] 
param/loadparm.c:lp_do_parameter(3162)
Jul 14  12:44:38 localhost smbd[30071]:   Global parameter unix extensions  
found in service section!

