Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTGAJ0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTGAJ0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:26:50 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:44161 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S261773AbTGAJ0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:26:46 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.71 oops 
Date: Tue, 1 Jul 2003 11:44:12 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011144.12868.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello I was under high IO-wait with 2.5.71,
I lanched a "fileschanged" with "fam" on my whole
filesystem but a misconfig sent many lines to syslog, like

"Jul  1 11:36:34 hal9003 xinetd[923]: warning: can't get client address: 
Transport endpoint is not connected
Jul  1 11:36:34 hal9003 xinetd[923]: libwrap refused connection to sgi_fam 
from <no address>
Jul  1 11:36:34 hal9003 xinetd[924]: warning: can't get client address: 
Transport endpoint is not connected
Jul  1 11:36:34 hal9003 xinetd[924]: libwrap refused connection to sgi_fam 
from <no address>
Jul  1 11:36:34 hal9003 xinetd[925]: warning: can't get client address: 
Transport endpoint is not connected
Jul  1 11:36:34 hal9003 xinetd[925]: libwrap refused connection to sgi_fam 
from <no address>
"
And then I had an oops :

Jul  1 11:36:34 hal9003 kernel: Unable to handle kernel paging request at 
virtual address 35b70ae1
Jul  1 11:36:34 hal9003 kernel:  printing eip:
Jul  1 11:36:34 hal9003 kernel: c0135ed9
Jul  1 11:36:34 hal9003 kernel: *pde = 00000000
Jul  1 11:36:34 hal9003 kernel: Oops: 0002 [#1]
Jul  1 11:36:34 hal9003 kernel: CPU:    0
Jul  1 11:36:34 hal9003 kernel: EIP:    0060:[__rmqueue+143/288]    Not 
tainted
Jul  1 11:36:34 hal9003 kernel: EIP:    0060:[<c0135ed9>]    Not tainted
Jul  1 11:36:34 hal9003 kernel: EFLAGS: 00010002
Jul  1 11:36:34 hal9003 kernel: EIP is at __rmqueue+0x8f/0x120
Jul  1 11:36:34 hal9003 kernel: eax: 00000002   ebx: c02e08b8   ecx: 00000001   
edx: c02e08ac
Jul  1 11:36:34 hal9003 kernel: esi: 00000001   edi: c02e08ec   ebp: d4729e60   
esp: d4729e38
Jul  1 11:36:34 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul  1 11:36:34 hal9003 kernel: Process xinetd (pid: 7708, threadinfo=d4728000 
task=d2d0b380)
Jul  1 11:36:34 hal9003 kernel: Stack: 00000000 000000d0 c0156ad3 f6d94e0c 
00000246 00011e0e c12f3230 c02e08ac
Jul  1 11:36:34 hal9003 kernel:        00000000 00000000 d4729e88 c013629b 
c02e08ac 00000001 c02e08ac cf3cc008
Jul  1 11:36:34 hal9003 kernel:        00000246 c02e08ac 000001f8 00000000 
d4729ed0 c013635c c02e08ac 00000001
Jul  1 11:36:34 hal9003 kernel: Call Trace:
Jul  1 11:36:34 hal9003 kernel:  [path_release+22/60] path_release+0x16/0x3c
Jul  1 11:36:34 hal9003 kernel:  [<c0156ad3>] path_release+0x16/0x3c
Jul  1 11:36:34 hal9003 kernel:  [buffered_rmqueue+203/265] 
buffered_rmqueue+0xcb/0x109
Jul  1 11:36:34 hal9003 kernel:  [<c013629b>] buffered_rmqueue+0xcb/0x109
Jul  1 11:36:34 hal9003 kernel:  [__alloc_pages+131/770] 
__alloc_pages+0x83/0x302
Jul  1 11:36:34 hal9003 kernel:  [<c013635c>] __alloc_pages+0x83/0x302
Jul  1 11:36:34 hal9003 kernel:  [__get_free_pages+39/64] 
__get_free_pages+0x27/0x40
Jul  1 11:36:34 hal9003 kernel:  [<c0136602>] __get_free_pages+0x27/0x40
Jul  1 11:36:34 hal9003 kernel:  [dup_task_struct+207/241] 
dup_task_struct+0xcf/0xf1
Jul  1 11:36:34 hal9003 kernel:  [<c011b014>] dup_task_struct+0xcf/0xf1
Jul  1 11:36:34 hal9003 kernel:  [copy_process+111/2611] 
copy_process+0x6f/0xa33
Jul  1 11:36:34 hal9003 kernel:  [<c011b9c2>] copy_process+0x6f/0xa33
Jul  1 11:36:34 hal9003 kernel:  [sys_select+539/1310] sys_select+0x21b/0x51e
Jul  1 11:36:34 hal9003 kernel:  [<c015ba51>] sys_select+0x21b/0x51e
Jul  1 11:36:34 hal9003 kernel:  [do_fork+77/348] do_fork+0x4d/0x15c
Jul  1 11:36:34 hal9003 kernel:  [<c011c3d3>] do_fork+0x4d/0x15c
Jul  1 11:36:34 hal9003 kernel:  [default_wake_function+0/46] 
default_wake_function+0x0/0x2e
Jul  1 11:36:34 hal9003 kernel:  [<c0119d63>] default_wake_function+0x0/0x2e
Jul  1 11:36:34 hal9003 kernel:  [sys_fork+56/60] sys_fork+0x38/0x3c
Jul  1 11:36:34 hal9003 kernel:  [<c01079e5>] sys_fork+0x38/0x3c
Jul  1 11:36:34 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  1 11:36:34 hal9003 kernel:  [<c0108fc7>] syscall_call+0x7/0xb
Jul  1 11:36:34 hal9003 kernel:
Jul  1 11:36:34 hal9003 kernel: Code: 89 bb 29 02 89 75 e0 be 01 00 00 00 8b 
4d f0 8b 45 ec 89 4d

