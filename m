Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUAWGVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUAWGVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:21:10 -0500
Received: from mxsf04.cluster1.charter.net ([209.225.28.204]:11012 "EHLO
	mxsf04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265356AbUAWGVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:21:01 -0500
Date: Fri, 23 Jan 2004 00:19:27 -0600
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-mm1 oops with X
Message-ID: <20040123061927.GA7025@gforce.johnson.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
From: glennpj@charter.net (Glenn Johnson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the oops pasted below.  It only happens when the X server
is restarting.  I do not see it all of the time but frequently enough
that I can call it reproducible.  I started seeing it with 2.6.1-mm4 and
can trigger it fairly regularly with 2.6.2-rc1-mm1.  However, I do not
see it with 2.6.1-mm3 nor with 2.6.2-rc1.  Hopefully, that narrows the
field as to what may be the culprit.

Some relevant hardware and kernel configuration information: 

- 2.4GHz P4c with HyperThreading (I do have CONFIG_SMT set)
- Radeon 9100 graphics card (DRI enabled)

---begin oops---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02a2c56
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
CPU:    0
EIP:    0060:[<c02a2c56>]    Not tainted VLI
EFLAGS: 00010286
EIP is at vt_ioctl+0x1e/0x1f4b
eax: 00000000   ebx: daf10000   ecx: 00000007   edx: 00000007
esi: 00005607   edi: daf10000   ebp: daf48080   esp: dc6d7ea0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 6100, threadinfo=dc6d6000 task=dbe56d00)
Stack: 00000006 df8e6005 00000003 df8e6005 dc6d7f70 dffd8f00 00000000 dfda1480 
       df963b00 c01746e1 dfda1480 c0526e80 00000000 dfbaf780 df963b00 c016b982 
       00021480 00000000 00000000 00000001 df4f9200 c01668e6 c0579800 daf48280 
Call Trace:
 [<c01746e1>] dput+0x22/0x2b1
 [<c016b982>] link_path_walk+0x690/0x9ea
 [<c01668e6>] cdev_put+0x17/0x69
 [<c0166503>] chrdev_open+0x160/0x291
 [<c011dfaa>] recalc_task_prio+0x90/0x1aa
 [<c012082d>] schedule+0x39b/0x6d7
 [<c02a2c38>] vt_ioctl+0x0/0x1f4b
 [<c029d8dd>] tty_ioctl+0x472/0x570
 [<c016fb3a>] sys_ioctl+0x119/0x2a3
 [<c041b3da>] sysenter_past_esp+0x43/0x65

Code: ff e8 5f 77 e6 ff e9 6d ff ff ff 90 90 55 57 56 53 81 ec b8 00 00 00 8b bc 24 cc 00 00 00 8b b4 24 d4 00 00 00 8b 87 78 09 00 00 <8b> 18 8b 04 9d 00 9e 57 c0 89 1c 24 89 44 24 50 e8 4e 6a 00 00 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02a2c56
*pde = 00000000
Oops: 0000 [#2]
PREEMPT SMP 
CPU:    0
EIP:    0060:[<c02a2c56>]    Not tainted VLI
EFLAGS: 00010286
EIP is at vt_ioctl+0x1e/0x1f4b
eax: 00000000   ebx: d1ec7000   ecx: 00000008   edx: 00000008
esi: 00005607   edi: d1ec7000   ebp: daf48180   esp: d0927ea0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 6117, threadinfo=d0926000 task=dbe56080)
Stack: 00000007 df9df005 00000003 df9df005 d0927f70 dffd8f00 00000000 dfda1480 
       df963b00 c01746e1 dfda1480 c0526e80 00000000 dfbaf780 df963b00 c016b982 
       00021480 00000000 00000000 00000001 dee34a00 c01668e6 c0579800 daeab180 
Call Trace:
 [<c01746e1>] dput+0x22/0x2b1
 [<c016b982>] link_path_walk+0x690/0x9ea
 [<c01668e6>] cdev_put+0x17/0x69
 [<c0166503>] chrdev_open+0x160/0x291
 [<c011dfaa>] recalc_task_prio+0x90/0x1aa
 [<c012082d>] schedule+0x39b/0x6d7
 [<c02a2c38>] vt_ioctl+0x0/0x1f4b
 [<c029d8dd>] tty_ioctl+0x472/0x570
 [<c016fb3a>] sys_ioctl+0x119/0x2a3
 [<c041b3da>] sysenter_past_esp+0x43/0x65

Code: ff e8 5f 77 e6 ff e9 6d ff ff ff 90 90 55 57 56 53 81 ec b8 00 00 00 8b bc 24 cc 00 00 00 8b b4 24 d4 00 00 00 8b 87 78 09 00 00 <8b> 18 8b 04 9d 00 9e 57 c0 89 1c 24 89 44 24 50 e8 4e 6a 00 00 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02a2c56
*pde = 00000000
Oops: 0000 [#3]
PREEMPT SMP 
CPU:    0
EIP:    0060:[<c02a2c56>]    Not tainted VLI
EFLAGS: 00010286
EIP is at vt_ioctl+0x1e/0x1f4b
eax: 00000000   ebx: d1ec6000   ecx: 00000009   edx: 00000009
esi: 00005607   edi: d1ec6000   ebp: ce675380   esp: cd0f9ea0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 6134, threadinfo=cd0f8000 task=df4c8d00)
Stack: 00000008 c1738005 00000003 c1738005 cd0f9f70 dffd8f00 00000000 dfda1480 
       df963b00 c01746e1 dfda1480 c0526e80 00000000 dfbaf780 df963b00 c016b982 
       00021480 00000000 00000000 00000001 dee34800 c01668e6 c0579800 cd177e80 
Call Trace:
 [<c01746e1>] dput+0x22/0x2b1
 [<c016b982>] link_path_walk+0x690/0x9ea
 [<c01668e6>] cdev_put+0x17/0x69
 [<c0166503>] chrdev_open+0x160/0x291
 [<c011dfaa>] recalc_task_prio+0x90/0x1aa
 [<c012082d>] schedule+0x39b/0x6d7
 [<c02a2c38>] vt_ioctl+0x0/0x1f4b
 [<c029d8dd>] tty_ioctl+0x472/0x570
 [<c016fb3a>] sys_ioctl+0x119/0x2a3
 [<c041b3da>] sysenter_past_esp+0x43/0x65

Code: ff e8 5f 77 e6 ff e9 6d ff ff ff 90 90 55 57 56 53 81 ec b8 00 00 00 8b bc 24 cc 00 00 00 8b b4 24 d4 00 00 00 8b 87 78 09 00 00 <8b> 18 8b 04 9d 00 9e 57 c0 89 1c 24 89 44 24 50 e8 4e 6a 00 00 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02a2c56
*pde = 00000000
Oops: 0000 [#4]
PREEMPT SMP 
CPU:    1
EIP:    0060:[<c02a2c56>]    Not tainted VLI
EFLAGS: 00010286
EIP is at vt_ioctl+0x1e/0x1f4b
eax: 00000000   ebx: c7f3a000   ecx: 0000000a   edx: 0000000a
esi: 00005607   edi: c7f3a000   ebp: d089a980   esp: cd0f9ea0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 6151, threadinfo=cd0f8000 task=df4c8d00)
Stack: 00000009 df069005 00000003 df069005 cd0f9f70 dffd8f00 00000000 dfda1480 
       df963b00 c01746e1 dfda1480 c0526e80 00000000 dfbaf780 df963b00 c016b982 
       00021480 00000000 00000000 00000001 df4f9000 c01668e6 c0579800 daeab180 
Call Trace:
 [<c01746e1>] dput+0x22/0x2b1
 [<c016b982>] link_path_walk+0x690/0x9ea
 [<c01668e6>] cdev_put+0x17/0x69
 [<c0166503>] chrdev_open+0x160/0x291
 [<c011dfaa>] recalc_task_prio+0x90/0x1aa
 [<c012082d>] schedule+0x39b/0x6d7
 [<c02a2c38>] vt_ioctl+0x0/0x1f4b
 [<c029d8dd>] tty_ioctl+0x472/0x570
 [<c016fb3a>] sys_ioctl+0x119/0x2a3
 [<c041b3da>] sysenter_past_esp+0x43/0x65

Code: ff e8 5f 77 e6 ff e9 6d ff ff ff 90 90 55 57 56 53 81 ec b8 00 00 00 8b bc 24 cc 00 00 00 8b b4 24 d4 00 00 00 8b 87 78 09 00 00 <8b> 18 8b 04 9d 00 9e 57 c0 89 1c 24 89 44 24 50 e8 4e 6a 00 00 
---end oops--- 

Regards,

Glenn
