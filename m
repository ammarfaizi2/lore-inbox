Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTFDApk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTFDApk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:45:40 -0400
Received: from [202.37.96.11] ([202.37.96.11]:24274 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S262340AbTFDApd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:45:33 -0400
Date: Wed, 04 Jun 2003 12:59:21 +1200
From: James Sewell <james.sewell@tait.co.nz>
Subject: Crash problems
To: linux-kernel@vger.kernel.org
Message-id: <3EDD4469.6080109@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,

I am not 100% percent sure this is a kernel problem - but suspect it is. 
If not guidance in the right direction would be appreciated. I would 
also appreciate a cc on any replies.

Right. At my place of work we are running a dual Xeon machine with 2 gig 
of RAM. It is running Redhat 7.2 with the 2.4.17 kernel with the ACL 
patches applied. The problem is this: every so often the machine hangs 
dead: no services, no terminal input, no pings no nothing.

After a clean reboot we see the following in the messages file:

May 29 12:14:21 medusa rpc.mountd: authenticated mount request from 
172.25.130.14:764 for /taitdata/ecad/home (/taitdata/ecad)
May 29 12:15:36 medusa kernel: invalid operand: 0000
May 29 12:15:36 medusa kernel: CPU:    0
May 29 12:15:36 medusa kernel: EIP:    0010:[__free_pages_ok+80/512]    
Not tainted
May 29 12:15:36 medusa kernel: EIP:    0010:[<c012fd20>]    Not tainted
May 29 12:15:36 medusa kernel: EFLAGS: 00010202
May 29 12:15:36 medusa kernel: eax: 00000040   ebx: 00000000   ecx: 
c1000000   edx: 00000000
May 29 12:15:36 medusa kernel: esi: c17fff00   edi: dfffc000   ebp: 
00000000   esp: f7ee1ef4
May 29 12:15:36 medusa kernel: ds: 0018   es: 0018   ss: 0018
May 29 12:15:36 medusa kernel: Process kswapd (pid: 5, stackpage=f7ee1000)
May 29 12:15:36 medusa kernel: Stack: c1040000 c02749e0 00000202 
ffffffff c200bbd0 00000000 dfffc000 d8289de0
May 29 12:15:36 medusa kernel:        c012d5fd ffffffff c200bbd0 
00000000 c200b060 f57a1340 c012e85c c200bbd0
May 29 12:15:36 medusa kernel:        d8289de0 00000001 c200bbd8 
c200bbe0 c0274a70 f7ee0000 00000000 00000007
May 29 12:15:36 medusa kernel: Call Trace: [kmem_slab_destroy+173/208] 
[kmem_cache_reap+668/784] [shrink_caches+25/144] 
[try_to_free_pages+60/96] [kswapd_balance_pgdat+81/160]
May 29 12:15:36 medusa kernel: Call Trace: [<c012d5fd>] [<c012e85c>] 
[<c012f7c9>] [<c012f87c>] [<c012f921>]
May 29 12:15:36 medusa kernel:    [kswapd_balance+38/64] 
[kswapd+161/192] [kswapd+0/192] [_stext+0/64] [kernel_thread+38/48] 
[kswapd+0/192]
May 29 12:15:36 medusa kernel:    [<c012f996>] [<c012fad1>] [<c012fa30>] 
[<c0105000>] [<c0105826>] [<c012fa30>]
May 29 12:15:36 medusa kernel:
May 29 12:15:36 medusa kernel: Code: 0f 0b 8b 46 18 a9 80 00 00 00 74 02 
0f 0b 83 66 18 eb b8 00
May 29 12:15:37 medusa rpc.mountd: authenticated unmount request from 
172.25.142.10:759 for /taitdata/ecad/home (/taitdata/ecad)
May 29 12:44:38 medusa syslogd 1.4.1: restart.

The restart was caused by us hitting the power button, not by the system 
hang.

Any insights into why this is happening? One of the solutions proposed 
is to throw more RAM at the problem - although I think finding the cause 
of the problem will be much more beneficial.

Cheers for any help,
James Sewell


