Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUBCPGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUBCPGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:06:20 -0500
Received: from village.ehouse.ru ([193.111.92.18]:17939 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264457AbUBCPGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:06:16 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Call Trace: page allocation failure - is it normal behaviour?
Date: Tue, 3 Feb 2004 18:06:15 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402031806.15439.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed some call trace when testing box under heavy load.
To create a load following jobs have been running simultaneously.

 ab2 -c 200 -n 10000000 http://192.168.114.239/
 fsx-linux -l 900000000 fsx-data3
 dbench 100

adt root # w
 19:24:32 up 14:58,  6 users,  load average: 90.92, 83.97, 84.28

Some times after dmesg has shown  multiple call traces of two types:

swapper: page allocation failure. order:2, mode:0x20
Call Trace:
 [<c014059c>] __alloc_pages+0x30c/0x350
 [<c0140605>] __get_free_pages+0x25/0x40
 [<c01435a7>] cache_grow+0xc7/0x310
 [<c01438fe>] cache_alloc_refill+0x10e/0x2c0
 [<c0143e01>] __kmalloc+0x71/0x80
 [<c0266697>] alloc_skb+0x47/0xe0
 [<c0294e7e>] tcp_fragment+0x5e/0x340
 [<c02975b8>] tcp_write_wakeup+0xe8/0x280
 [<c0298870>] tcp_write_timer+0x0/0x130
 [<c029776d>] tcp_send_probe0+0x1d/0x110
 [<c0298933>] tcp_write_timer+0xc3/0x130
 [<c01298f7>] run_timer_softirq+0xe7/0x1d0
 [<c0124e2a>] do_softirq+0xca/0xd0
 [<c01162e7>] smp_apic_timer_interrupt+0xd7/0x150
 [<c0106d90>] default_idle+0x0/0x40
 [<c0109dea>] apic_timer_interrupt+0x1a/0x20
 [<c0106d90>] default_idle+0x0/0x40
 [<c0106dbd>] default_idle+0x2d/0x40
 [<c0106e47>] cpu_idle+0x37/0x40
 [<c012111d>] printk+0x17d/0x1d0

ab2: page allocation failure. order:2, mode:0x20
Call Trace:
 [<c014059c>] __alloc_pages+0x30c/0x350
 [<c0140605>] __get_free_pages+0x25/0x40
 [<c01435a7>] cache_grow+0xc7/0x310
 [<c01438fe>] cache_alloc_refill+0x10e/0x2c0
 [<c0143e01>] __kmalloc+0x71/0x80
 [<c0266697>] alloc_skb+0x47/0xe0
 [<c0294e7e>] tcp_fragment+0x5e/0x340
 [<c0294680>] tcp_transmit_skb+0x3e0/0x600
 [<c02975b8>] tcp_write_wakeup+0xe8/0x280
 [<c0298870>] tcp_write_timer+0x0/0x130
 [<c029776d>] tcp_send_probe0+0x1d/0x110
 [<c0287d45>] __tcp_mem_reclaim+0x25/0x60
 [<c0298933>] tcp_write_timer+0xc3/0x130
 [<c01298f7>] run_timer_softirq+0xe7/0x1d0
 [<c0124e2a>] do_softirq+0xca/0xd0
 [<c01162e7>] smp_apic_timer_interrupt+0xd7/0x150
 [<c0109dea>] apic_timer_interrupt+0x1a/0x20
 [<c0289fc5>] tcp_sendmsg+0x955/0x12b0
 [<c02acc2d>] inet_sendmsg+0x4d/0x60
 [<c0262a5d>] sock_aio_write+0xbd/0xe0
 [<c015b02b>] do_sync_write+0x8b/0xc0
 [<c0140613>] __get_free_pages+0x33/0x40
 [<c0287dd4>] tcp_poll+0x34/0x190
 [<c0262ff9>] sock_poll+0x29/0x40
 [<c015b15e>] vfs_write+0xfe/0x130
 [<c015b242>] sys_write+0x42/0x70
 [<c01093fb>] syscall_call+0x7/0xb

bwt I've noticed no visible harm to system and question ruther is
whether this behaviour is normal under such circumstances?

dmesg(full):            http://sysadminday.org.ru/call_trace/dmesg
.config:                http://sysadminday.org.ru/call_trace/config    
/proc/meminfo:          http://sysadminday.org.ru/call_trace/meminfo
/proc/cpuinfo:          http://sysadminday.org.ru/call_trace/cpuinfo
lspsi:                  http://sysadminday.org.ru/call_trace/lspci
lspci -vvn:             http://sysadminday.org.ru/call_trace/lspci_-vvn                     

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc

