Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUHXG1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUHXG1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUHXG1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:27:20 -0400
Received: from dauntless.milewski.org ([64.142.38.232]:18632 "EHLO
	dauntless.milewski.org") by vger.kernel.org with ESMTP
	id S266821AbUHXG1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:27:17 -0400
Message-ID: <412AE018.8000207@asperasoft.com>
Date: Mon, 23 Aug 2004 23:28:40 -0700
From: Serban Simu <serban@asperasoft.com>
Organization: Aspera
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: page allocation failure & sk98lin
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I found a few references to similar problems in the list but no 
indications of whether this has been fixed or can be avoided.

I'm using 2.6.8.1 and the patch: sk98lin_v7.04_2.6.8_patch. This happens 
  when receiving data fast on the GigE card (about 600Mbps) and writing 
on disk. It seems to happen after writing 1 GB to disk (1024 MB) but I 
can't correlate that very reliably.

I would appreciate any information pointing me to a fix or explanation.

Thank you!

-Serban

swapper: page allocation failure. order:0, mode:0x20
  [<c013ec91>] __alloc_pages+0x2bf/0x2dd
  [<c013ecc7>] __get_free_pages+0x18/0x24
  [<c0141b8a>] kmem_getpages+0x20/0xc9
  [<c01427b3>] cache_grow+0xae/0x156
  [<c0142a2f>] cache_alloc_refill+0x1d4/0x211
  [<c0142e50>] __kmalloc+0x79/0x8c
  [<c027bd63>] alloc_skb+0x35/0xc9
  [<f8b7cbc4>] AllocAndMapRxBuffer+0x1e/0xc1 [sk98lin]
  [<f8b7af5a>] GiveRxBufferToHw+0x14e/0x3f4 [sk98lin]
  [<f8b7b274>] FillReceiveTableYukon2+0x74/0x7c [sk98lin]
  [<f8b7c467>] HandleStatusLEs+0xd4/0x30e [sk98lin]
  [<f8b7aa5f>] SkY2Poll+0x33/0xed [sk98lin]
  [<c02817cf>] net_rx_action+0x70/0xf2
  [<c0124fa2>] __do_softirq+0x52/0xab
  [<c0125028>] do_softirq+0x2d/0x2f
  [<c0107f9e>] do_IRQ+0xfb/0x112
  [<c01066d8>] common_interrupt+0x18/0x20
  [<c01040da>] mwait_idle+0x25/0x4a
  [<c01040a7>] cpu_idle+0x2e/0x3c
  [<c01216d5>] call_console_drivers+0xce/0xeb
  [<c01bb1b8>] vscnprintf+0x14/0x21
  [<c012191b>] printk+0x152/0x165

