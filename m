Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUEXTJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUEXTJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEXTJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:09:27 -0400
Received: from lvs00-fl-n02.valueweb.net ([216.219.253.98]:52434 "EHLO
	ams002.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S264424AbUEXTJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:09:24 -0400
Message-ID: <40B246C6.4020404@coyotegulch.com>
Date: Mon, 24 May 2004 15:02:30 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040522)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NUMA Questions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a Tyan K8W 2885, with two Opteron 240s and 512MB in each
memory bank. I've compiled kernel 2.6.7-rc1 with the following in my config:

CONFIG_K8_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_NUMA=y

In /var/log/messages, I see:

May 24 14:45:11 Corwin Scanning NUMA topology in Northbridge 24
May 24 14:45:11 Corwin Number of nodes 2 (10010)
May 24 14:45:11 Corwin Node 0 MemBase 0000000000000000 Limit 
000000001fffffff
May 24 14:45:11 Corwin Node 1 MemBase 0000000020000000 Limit 
000000003fff0000
May 24 14:45:11 Corwin Using node hash shift of 24
May 24 14:45:11 Corwin Bootmem setup node 0 
0000000000000000-000000001fffffff
May 24 14:45:11 Corwin Bootmem setup node 1 
0000000020000000-000000003fff0000
May 24 14:45:11 Corwin ACPI: have wakeup address 0x10020005000
May 24 14:45:11 Corwin No mptable found.
May 24 14:45:11 Corwin No mptable found.
May 24 14:45:11 Corwin setting up node 0 0-1ffff
May 24 14:45:11 Corwin On node 0 totalpages: 131071
May 24 14:45:11 Corwin DMA zone: 4096 pages, LIFO batch:1
May 24 14:45:11 Corwin Normal zone: 126975 pages, LIFO batch:16
May 24 14:45:11 Corwin HighMem zone: 0 pages, LIFO batch:1
May 24 14:45:11 Corwin setting up node 1 20000-3fff0
May 24 14:45:11 Corwin On node 1 totalpages: 131056
May 24 14:45:11 Corwin DMA zone: 0 pages, LIFO batch:1
May 24 14:45:11 Corwin Normal zone: 131056 pages, LIFO batch:16
May 24 14:45:11 Corwin HighMem zone: 0 pages, LIFO batch:1

So am I correct in assuming that NUMA is up and running? I note that 
Andi's numastat displays:

		         node1         node0
numa_hit	        304539        472556
numa_miss	             0             0
numa_foreign	             0             0
interleave_hit	             0             0
local_node	        303607        472549
other_node	           932             7

Yet when I run Andi's numactl, it states:

Corwin /usr/src/numactl-0.6.3 # numactl --show
No NUMA support available on this system.

A quick test program, and I see:

numa_available() returns -1
numa_max_node() return 1

Can anyone shed light on this?

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

