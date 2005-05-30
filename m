Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVE3Lxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVE3Lxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVE3Lxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:53:39 -0400
Received: from village.ehouse.ru ([193.111.92.18]:50445 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261494AbVE3LvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:51:21 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org, admin@list.net.ru
Subject: 2.6.12-rc3: Oops, BUG at "mm/rmap.c":481 (?)
Date: Mon, 30 May 2005 15:51:18 +0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505301551.18311.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day

	Last tuesday i've got an oops on dual opteron host
[ 2xopteron 246, 4G ram, LSI 320-2x, 
2.6.12-rc3, Gentoo 2005.0 
mostly heavy loaded but not that time ]

Symptoms: system hangs, no activity, no disk io 
	i couldn't determine exactly whether sysrq works (this is a remote
	system and screen->minicom->serial console rather specific bundle )
	
This is production server, so i could run memtest only last night but
it could finds nothing. 

[ I have tried to adapt debug rmap patch from Hugh Dickins he sent 
in reply to similar report.
( http://marc.theaimsgroup.com/?l=linux-kernel&m=111101533309675&w=2 )
to 2.6.12-rc5 but looks like missed something ( perhaps amd64 specific )
and just got another oops after boot. ]

So, this is an oops on 2.6.12-rc3

lights.vh.com.ru login: process `dig' is using obsolete setsockopt 
SO_BSDCOMPAT
swap_free: Bad swap file entry e000007fffffc03e
swap_free: Bad swap file entry f800007fffffc03e
swap_free: Bad swap file entry 4000000000000000
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/rmap.c":481
invalid operand: 0000 [1] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8016bd16>] <ffffffff8016bd16>{page_remove_rmap+38}
RSP: 0018:ffff81003e115db0  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff81004092d460 RCX: ffff81000000d000
RDX: ffff810002fc3580 RSI: 0000000000000000 RDI: ffff8100011a69c8
RBP: 000000000048c000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8015ab80 R12: 0000000000000020
R13: ffff8100011a69c8 R14: ffff810002c0e240 R15: 0000000000490000
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaabcac8 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: ffffffff80163e0d ffffffff804a5160 000000000048ffff 000000000048ffff 
       000000000048ffff ffff810071b6b010 0000000000490000 ffff810028b72000 
       0000000000490000 ffff81004022f000 
Call Trace:<ffffffff80163e0d>{unmap_vmas+1341} 
<ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 0f 0b b6 a1 34 80 ff ff ff ff e1 01 48 c7 c6 ff ff ff ff bf 
RIP <ffffffff8016bd16>{page_remove_rmap+38} RSP <ffff81003e115db0>
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [2] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e115b68  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8024cf00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000490000
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000720 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       000000000000000b ffffffff801349aa ffffffff8038f8e4 ffffffff8034341a 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e115b68>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [3] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e1158f8  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8024cf00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e115ab8
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} <ffffffff8024cfe1>{vgacon_cursor+225}
       <ffffffff8010f3d5>{die+69} <ffffffff8010f821>{do_invalid_op+145}
       <ffffffff8016bd16>{page_remove_rmap+38} <ffffffff80132f5d>{printk+141}
       <ffffffff8010e519>{error_exit+0} 
<ffffffff8015ab80>{__set_page_dirty_nobuffers+0}
       <ffffffff8016bd16>{page_remove_rmap+38} 
<ffffffff80163e0d>{unmap_vmas+1341}
       <ffffffff801698d3>{exit_mmap+163} <ffffffff8012fdd1>{mmput+49}
       <ffffffff80134fcf>{do_exit+351} <ffffffff80135bbc>{do_group_exit+252}
       <ffffffff8010db06>{system_call+126} 

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e1158f8>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [4] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e115688  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000004330 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e115848
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e115688>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [5] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e115418  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000001db0 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e1155d8
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e115418>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [6] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e1151a8  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000002710 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e115368
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e1151a8>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [7] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e114f38  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000012368 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e1150f8
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e114f38>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 8f1cc067 PUD f2ecb067 PMD 0 
Oops: 0000 [8] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e114cc8  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8024cf00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e114e88
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 00000000f20e8000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e114cc8>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 0 
Oops: 0000 [9] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e114a58  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: ffffffff8038f748
RDX: ffffffff8038f700 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000002d50 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e114c18
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 0000000000101000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} <ffffffff8024cfe1>{vgacon_cursor+225}
       <ffffffff8010f3d5>{die+69} <ffffffff8010f821>{do_invalid_op+145}
       <ffffffff8016bd16>{page_remove_rmap+38} <ffffffff80132f5d>{printk+141}
       <ffffffff8010e519>{error_exit+0} 
<ffffffff8015ab80>{__set_page_dirty_nobuffers+0}
       <ffffffff8016bd16>{page_remove_rmap+38} 
<ffffffff80163e0d>{unmap_vmas+1341}
       <ffffffff801698d3>{exit_mmap+163} <ffffffff8012fdd1>{mmput+49}
       <ffffffff80134fcf>{do_exit+351} <ffffffff80135bbc>{do_group_exit+252}
       <ffffffff8010db06>{system_call+126} 

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e114a58>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 0 
Oops: 0000 [10] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>] <ffffffff8012ff26>{mm_release+86}
RSP: 0018:ffff81003e1147e8  EFLAGS: 00010202
RAX: ffff8100f6561a80 RBX: ffff81006ff3f6f0 RCX: 0000000000000000
RDX: 00000000ffffff00 RSI: 0000000000000000 RDI: 00002aaaab4d4d10
RBP: 0000000000000000 R08: 000000000000000d R09: 0000000000000000
R10: 00000000ffffffff R11: ffffffff8024cf00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003e1149a8
FS:  0000000043f3f960(0000) GS:ffffffff80478500(0000) knlGS:00000000556b98c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 0000000000101000 CR4: 00000000000006e0
Process sh (pid: 17875, threadinfo ffff81003e114000, task ffff81006ff3f6f0)
Stack: 0000000000000000 0000000000000000 ffff81006ff3f6f0 ffff81006ff3f6f0 
       0000000000000009 ffffffff801349aa ffffffff8038f8e4 0000000000000001 
       ffff81006ff3fd20 ffff81006ff3f6f0 
Call Trace:<ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} 
<ffffffff80132bb9>{release_console_sem+393}
       <ffffffff8010e519>{error_exit+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8027c435>{do_unblank_screen+21} 
<ffffffff8011e7e2>{do_page_fault+1906}
       <ffffffff80148a59>{autoremove_wake_function+9} 
<ffffffff8012db63>{__wake_up+67}
       <ffffffff80132ea0>{vprintk+656} <ffffffff8010e519>{error_exit+0}
       <ffffffff8024cf00>{vgacon_cursor+0} <ffffffff8012ff26>{mm_release+86}
       <ffffffff8012feff>{mm_release+47} <ffffffff801349aa>{exit_mm+42}
       <ffffffff80134fcf>{do_exit+351} 
<ffffffff8027c435>{do_unblank_screen+21}
       <ffffffff8011e7e2>{do_page_fault+1906} 
<ffffffff80148a59>{autoremove_wake_function+9}
       <ffffffff8012db63>{__wake_up+67} <ffffffff80132ea0>{vprintk+656}
       <ffffffff8010e519>{error_exit+0} <ffffffff8024cf00>{vgacon_cursor+0}
       <ffffffff8012ff26>{mm_release+86} <ffffffff8012feff>{mm_release+47}
       <ffffffff801349aa>{exit_mm+42} <ffffffff80134fcf>{do_exit+351}
       <ffffffff8024cfe1>{vgacon_cursor+225} <ffffffff8010f3d5>{die+69}
       <ffffffff8010f821>{do_invalid_op+145} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80132f5d>{printk+141} <ffffffff8010e519>{error_exit+0}
       <ffffffff8015ab80>{__set_page_dirty_nobuffers+0} 
<ffffffff8016bd16>{page_remove_rmap+38}
       <ffffffff80163e0d>{unmap_vmas+1341} <ffffffff801698d3>{exit_mmap+163}
       <ffffffff8012fdd1>{mmput+49} <ffffffff80134fcf>{do_exit+351}
       <ffffffff80135bbc>{do_group_exit+252} 
<ffffffff8010db06>{system_call+126}
       

Code: 41 8b 45 40 ff c8 7e 45 48 c7 83 f0 01 00 00 00 00 00 00 48 
RIP <ffffffff8012ff26>{mm_release+86} RSP <ffff81003e1147e8>
CR2: 0000000000000040
 <6>note: sh[17875] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff8012ff26>{mm_release+86}
PGD 0 
Oops: 0000 [11] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter
Pid: 17875, comm: sh Not tainted 2.6.12-rc3
RIP: 0010:[<ffffffff8012ff26>]
-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
