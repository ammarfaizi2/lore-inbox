Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUKIRNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUKIRNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbUKIRNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:13:10 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:20936 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261589AbUKIRNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:13:00 -0500
Message-ID: <4190FFE9.8000203@drdos.com>
Date: Tue, 09 Nov 2004 10:35:37 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: 2.6.9 RCU breakage in dev_queue_xmit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
receive, 12 CLK interacket gap time, 1500 bytes payload
at 65000 packets per second per gigabit interface, and retransmitting 
received packets at 130 MB/S out of a third gigabit interface
with skb, RCU locks in dev_queue_xmit breaks and enters the following state:

Nov  8 15:38:08 ds kernel: Badness in local_bh_enable at 
kernel/softirq.c:141
Nov  8 15:38:08 ds kernel:  [<40107d1e>] dump_stack+0x1e/0x30
Nov  8 15:38:08 ds kernel:  [<401218b0>] local_bh_enable+0x70/0x80
Nov  8 15:38:08 ds kernel:  [<402c5bbb>] dev_queue_xmit+0x11b/0x250
Nov  8 15:38:08 ds kernel:  [<f8981cb7>] xmit_skb+0x17/0x20 [dsfs]
Nov  8 15:38:08 ds kernel:  [<f8981f8e>] xmit_packet+0x2e/0x80 [dsfs]
Nov  8 15:38:08 ds kernel:  [<f89820eb>] regen_data+0x10b/0x290 [dsfs]
Nov  8 15:38:08 ds kernel:  [<401052c5>] kernel_thread_helper+0x5/0x10
Nov  8 15:38:08 ds kernel: Badness in local_bh_enable at 
kernel/softirq.c:141
Nov  8 15:38:08 ds kernel:  [<40107d1e>] dump_stack+0x1e/0x30
Nov  8 15:38:08 ds kernel:  [<401218b0>] local_bh_enable+0x70/0x80
Nov  8 15:38:08 ds kernel:  [<402c5bbb>] dev_queue_xmit+0x11b/0x250
Nov  8 15:38:08 ds kernel:  [<f8981cb7>] xmit_skb+0x17/0x20 [dsfs]
Nov  8 15:38:08 ds kernel:  [<f8981f8e>] xmit_packet+0x2e/0x80 [dsfs]
Nov  8 15:38:08 ds kernel:  [<f89820eb>] regen_data+0x10b/0x290 [dsfs]
Nov  8 15:38:08 ds kernel:  [<401052c5>] kernel_thread_helper+0x5/0x10


And before any of you guys whine about "give me a test case" I just 
did.   Device driver is e1000 in the 2.6.9 kernel
tree.   System is a Xeon based system at 3 Ghz single processor with 4 
GB of ram and a 3GB/1GB kernel/user
split address space.

Jeff

