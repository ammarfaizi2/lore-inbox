Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271365AbTG2Jri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271351AbTG2Jri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:47:38 -0400
Received: from bay2-f6.bay2.hotmail.com ([65.54.247.6]:51726 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S271383AbTG2Jr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:47:29 -0400
X-Originating-IP: [212.143.73.102]
X-Originating-Email: [yuval_yeret@hotmail.com]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: yuval@exanet.com
Subject: RE: 2.4.18-24 SMP Machine stuck in zombie state after kernel Oops
Date: Tue, 29 Jul 2003 12:47:28 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F6wupAHj8XYj4M0000c87d@hotmail.com>
X-OriginalArrivalTime: 29 Jul 2003 09:47:28.0570 (UTC) FILETIME=[6C49F1A0:01C355B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Tried to find information about a kernel OOPS I've seen a lot of times 
>already on 4 different machines - >but nothing seems to be said about this 
>in the list archives or anywhere else for that matter.

>We are running 2.4.18-24 on SMP machines with 2CPUs and hyperthreading 
>(SuperMicro Xeon >servers) and doing heavy IO to disk and networking. 
>(Qlogic HBAs and Intel e1000 NICs are used)
Actually this time it happened on machines with Emulex HBAs.

>At some point the machine oopses (no scenario except heavy nfs-server like 
>load):
.....snipped...
>After the oops networking stack continues to function, some running daemons 
>continue to work (I'm >seeing network traffic from the machine which 
>indicates that clearly), but login into the node is not >possible via 
>console, ssh, rsh, and the majority of the application processes are dead.

Since then I tried to reproduce the problem with devfs disabled, and after 
some time found a pattern that reproduces this scenario quite consistently.

This time I've been able to see the output of the magic keys in the log:



===============================
Magic keys show:
Jul 29 11:00:17 node1 kernel: Pid: 0, comm:              swapper
Jul 29 11:00:17 node1 kernel: EIP: 0010:[default_idle+41/64] CPU: 2
Jul 29 11:00:17 node1 kernel: EIP: 0010:[<c0106e89>] CPU: 2
Jul 29 11:00:17 node1 kernel: EIP is at  (2.4.18-24exa)
Jul 29 11:00:17 node1 kernel:  EFLAGS: 00000246    Not tainted
Jul 29 11:00:17 node1 kernel: EAX: 00000000 EBX: c0106e60 ECX: 00000032 EDX: 
c4af6000
Jul 29 11:00:17 node1 kernel: ESI: c4af6000 EDI: c4af6000 EBP: c0106e60 DS: 
0018 ES: 0018
Jul 29 11:00:17 node1 kernel: CR0: 8005003b CR2: 4012faa0 CR3: 33b6a340 CR4: 
000006f0
Jul 29 11:00:17 node1 kernel: Call Trace: [cpu_idle+50/80]  (0xc4af7fb0))
Jul 29 11:00:17 node1 kernel: Call Trace: [<c0106f02>]  (0xc4af7fb0))
Jul 29 11:00:17 node1 kernel: [printk+297/320]  (0xc4af7fd0))
Jul 29 11:00:17 node1 kernel: [<c011d409>]  (0xc4af7fd0))

Jul 29 11:00:20 node1 kernel: Pid: 0, comm:              swapper
Jul 29 11:00:20 node1 kernel: EIP: 0010:[default_idle+41/64] CPU: 0
Jul 29 11:00:20 node1 kernel: EIP: 0010:[<c0106e89>] CPU: 0
Jul 29 11:00:20 node1 kernel: EIP is at  (2.4.18-24exa)
Jul 29 11:00:20 node1 kernel:  EFLAGS: 00000246    Not tainted
Jul 29 11:00:20 node1 kernel: EAX: 00000000 EBX: c0106e60 ECX: 00000032 EDX: 
c031c000
Jul 29 11:00:20 node1 kernel: ESI: c031c000 EDI: c031c000 EBP: c0106e60 DS: 
0018 ES: 0018
Jul 29 11:00:20 node1 kernel: CR0: 8005003b CR2: 40048794 CR3: 36963c80 CR4: 
000006f0
Jul 29 11:00:20 node1 kernel: Call Trace: [cpu_idle+50/80]  (0xc031dfc4))
Jul 29 11:00:20 node1 kernel: [<c0106f02>]  (0xc031dfc4))
Jul 29 11:00:20 node1 kernel: [_stext+0/80]  (0xc031dfd0))
Jul 29 11:00:20 node1 kernel: [<c0105000>]  (0xc031dfd0))
Jul 29 11:00:20 node1 kernel:

Any information / pointers will be appreciated.



If any information is missing or anything I should do to help analyze next 
time it happens tell me as well.


Thanks,

--
Yuval Yeret
Exanet
yuval@exanet.com
http://www.exanet.com
Tel.  972-9-9717782
Fax. 972-9-9717778

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail

