Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUBJSNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUBJRyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:54:12 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:37885 "HELO
	mail-srv0.cluster.vnoc.murphx.net") by vger.kernel.org with SMTP
	id S266147AbUBJRvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:51:42 -0500
Message-ID: <40291B48.10801@gadsdon.giointernet.co.uk>
Date: Tue, 10 Feb 2004 17:56:24 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040206
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc2 - Badness in kobject_get at lib/kobject.c:431
References: <fa.j2sgp5j.1cisl0p@ifi.uio.no>
In-Reply-To: <fa.j2sgp5j.1cisl0p@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.6.3-rc2 gives:

................
................
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9] 
MMIO=[df124000-df1247ff]  Max Packet=[2048]
raw1394: /dev/raw1394 device initialized
blk: queue c1b08400, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7df6400, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7decc00, I/O limit 4095Mb (mask 0xffffffff)
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0030e011e00002cb]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e011e00002d3]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0030e002e0000dd3]
ieee1394: Host added: ID:BUS[0-03:1023]  GUID[00601d0001016329]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
  [<c022b630>] kobject_get+0x50/0x60
  [<c026ce98>] get_device+0x18/0x20
  [<c026db9b>] bus_for_each_dev+0x6b/0xd0
  [<f8a0fac0>] nodemgr_probe_ne_cb+0x0/0xa0 [ieee1394]
  [<f8a0fc2b>] nodemgr_node_probe+0x5b/0x140 [ieee1394]
  [<f8a0fac0>] nodemgr_probe_ne_cb+0x0/0xa0 [ieee1394]
  [<f8a100c5>] nodemgr_host_thread+0x195/0x1c0 [ieee1394]
  [<f8a0ff30>] nodemgr_host_thread+0x0/0x1c0 [ieee1394]
  [<c0108c19>] kernel_thread_helper+0x5/0xc

Unable to handle kernel paging request at virtual address b828ec83
  printing eip:
b828ec83
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<b828ec83>]    Not tainted
EFLAGS: 00010282
EIP is at 0xb828ec83
eax: b828ec83   ebx: f8a3ece8   ecx: f754ff9c   edx: 00000000
esi: f8a0f4a0   edi: 00000000   ebp: f8a0e0b0   esp: f754ff40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 577, threadinfo=f754e000 task=f757c6b0)
Stack: c022b6d8 f8a3ece8 f8a3ecc4 f8a3eccc f8a3ec20 f7c74844 c026dbb8 
f8a3ece8
        f754ff9c f8a3ec6c 00000000 f8a0fac0 f754ff9c f749cc38 f754ff9c 
f8a0fc2b
        f8a3ec20 f7c7483c f754ff9c f8a0fac0 00000004 f8a3e660 f7550000 
f749cc38
Call Trace:
  [<c022b6d8>] kobject_cleanup+0x98/0xa0
  [<c026dbb8>] bus_for_each_dev+0x88/0xd0
  [<f8a0fac0>] nodemgr_probe_ne_cb+0x0/0xa0 [ieee1394]
  [<f8a0fc2b>] nodemgr_node_probe+0x5b/0x140 [ieee1394]
  [<f8a0fac0>] nodemgr_probe_ne_cb+0x0/0xa0 [ieee1394]
  [<f8a100c5>] nodemgr_host_thread+0x195/0x1c0 [ieee1394]
  [<f8a0ff30>] nodemgr_host_thread+0x0/0x1c0 [ieee1394]
  [<c0108c19>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
  <6>sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>
ip_tables: (C) 2000-2002 Netfilter core team
Intel(R) PRO/100 Network Driver - version 2.3.36-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.

................
................

2.6.3-rc1 and 2.6.2 were OK.

Similar to the -mm1 -mm2 problem?

Robert Gadsdon.


Linus Torvalds wrote:
> Uhhuh. There was a bit more pending, so here's a -rc2. Now please calm 
> down, I'd like this to have some time to stabilize..
> 
> The rc1->rc2 changes are mostly driver side stuff: PnP update, USB, ACP=
> I,
> IRDA, i2c, hotplug-PCI and netdrivers etc. But there's a NFSv4 update a=
> nd
> soem XFS fixes there too.
> 
> And some ARM and sparc updates.
> 
> 		Linus
> 


