Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270175AbTGPHjy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 03:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270179AbTGPHjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 03:39:54 -0400
Received: from bay2-f49.bay2.hotmail.com ([65.54.247.49]:12558 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270175AbTGPHjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 03:39:51 -0400
X-Originating-IP: [212.143.73.102]
X-Originating-Email: [yuval_yeret@hotmail.com]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: yuval@exanet.com
Subject: 2.4.18-24 SMP Machine stuck in zombie state after kernel Oops
Date: Wed, 16 Jul 2003 10:54:42 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F498AWiZAtGYkN000109c5@hotmail.com>
X-OriginalArrivalTime: 16 Jul 2003 07:54:42.0956 (UTC) FILETIME=[844C6CC0:01C34B6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tried to find information about a kernel OOPS I've seen a lot of times 
already on 4 different machines - but nothing seems to be said about this in 
the list archives or anywhere else for that matter.

We are running 2.4.18-24 on SMP machines with 2CPUs and hyperthreading 
(SuperMicro Xeon servers) and doing heavy IO to disk and networking. (Qlogic 
HBAs and Intel e1000 NICs are used)

At some point the machine oopses (no scenario except heavy nfs-server like 
load):


The oops doesn't appear in logs or on the console, but I've been able to use 
the diagnostic keys to get the following information:

right ALT+Scroll lock

CPU 0 : swapper

[<c0106f32>] (0xc0323fc4))  default_idle
[<c0105000>] (0xc0323fd4)) empty_zero_page

CPU 1 : swapper

(<c0106f32>)  (0xc 6597fb0)     - default_idle
(<c011d29b>) (0xc 6597fd0)    - out_of_line_bug
(<c011d449>) (8xc 659ffc)        - printk

CPU 3 : swapper

[<c0106f32>] (0xc8257fb0))  default_idle
[<c011d449>][0xc8257fd0)) printk


CTRL +Scroll lock

XINETD
[<c0108dc0>]sys_sigaltstack
[<c01151b1>]flush_tlb_page
[<c0115140>]flush_tlb_page
[<c014086e>]shmem_file_setup
[<c0131109>]do_generic_file_read
[<c013121e>]generic_file_read
[<c01310b0>]do_generic_file_read
[<c0142aa6>]sys_read
[<c0108ccf>]sys_sigaltstack

CROND

[<c01198f1>]wait_for_completion
[<c011c47a>]do_fork
[<c0107718>]dump_thread
[<c0108ccf>]sys_sigaltstack



After the oops networking stack continues to function, some running daemons 
continue to work (I'm seeing network traffic from the machine which 
indicates that clearly), but login into the node is not possible via 
console, ssh, rsh, and the majority of the application processes are dead.

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
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

