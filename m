Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUCPBmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUCPBj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:39:58 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:13529 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262933AbUCPB3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:29:10 -0500
Date: Mon, 15 Mar 2004 20:28:23 -0500 (EST)
From: Richard A Nelson <kenpocowboy@bellsouth.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-mm{1,2} Oopsen
Message-ID: <Pine.LNX.4.58.0403152027310.5164@onpx40.onqynaqf.bet>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# 1: Occurred whilst running a 2.4 UML (for VPN connectivity - 2.6/IPSEC
     is b0rked wrt MASQ)
 ------------[ cut here ]------------
 kernel BUG at fs/locks.c:1729!
 invalid operand: 0000 [#1]
 PREEMPT
 CPU:    0
 EIP:    0060:[locks_remove_flock+147/192]    Not tainted VLI
 EFLAGS: 00210246
 EIP is at locks_remove_flock+0x93/0xc0
 eax: dc6f4a84   ebx: c3370f0c   ecx: c3370e74   edx: 00000001
 esi: ca37583c   edi: dff565cc   ebp: c27d9e68   esp: c27d9e60
 ds: 007b   es: 007b   ss: 0068
 Process linux (pid: 6826, threadinfo=c27d9000 task=d289ba00)
 Stack: ca37583c 00000000 c27d9e84 c015ae93 c3370e74 c43ff48c ca37583c 00000000
        c926f90c c27d9e9c c015960f 00000001 00000003 0000001e c926f90c c27d9eb4
        c0123ab1 00000001 c926f90c c90d82b4 d289ba00 c27d9ed8 c0124658 00000008
 Call Trace:
  [__fput+51/304] __fput+0x33/0x130
  [filp_close+79/128] filp_close+0x4f/0x80
  [put_files_struct+113/208] put_files_struct+0x71/0xd0
  [do_exit+312/1056] do_exit+0x138/0x420
  [do_group_exit+51/160] do_group_exit+0x33/0xa0
  [get_signal_to_deliver+584/832] get_signal_to_deliver+0x248/0x340
  [do_signal+97/240] do_signal+0x61/0xf0
  [send_signal+149/320] send_signal+0x95/0x140
  [vfs_read+234/288] vfs_read+0xea/0x120
  [do_notify_resume+57/64] do_notify_resume+0x39/0x40
  [work_notifysig+19/21] work_notifysig+0x13/0x15

 Code: 8b 42 08 a8 08 75 04 5b 5e 5d c3
       5b 5e 5d e9 e5 f2 fa ff 0f 0b 34 00 7b 68 2f c0 eb d8 0f b6 50 28 f6 c2
       02 75 1d f6 c2 20 75 0a <0f> 0b c1 06 3f 3c 30 c0 eb a8 ba 02 00 00 00
       89 d8 e8 b7 eb ff
 ------------[ cut here ]------------

# 2: Occured twice (caught once), apparently during a DHCP client renew
     which caused bind/nscd to be reloaded
 ------------[ cut here ]------------
 kernel BUG at include/linux/list.h:148!
 invalid operand: 0000 [#1]
 PREEMPT
 CPU:    0
 EIP:    0060:[del_timer+155/176]    Not tainted VLI
 EFLAGS: 00010087   (2.6.4-mm1)
 EIP is at del_timer+0x9b/0xb0
 eax: dee18000   ebx: dee18f20   ecx: c04049a0   edx: 00000286
 esi: df614f20   edi: 00000dcb   ebp: dee18f0c   esp: dee18f04
 ds: 007b   es: 007b   ss: 0068
 Process nscd (pid: 3406, threadinfo=dee18000 task=d3888d20)
Mar 15 11:34:44 renegade dhclient: bound to 192.168.1.10 -- renewal in 2755 seconds.
 Stack: 00367510 00367510 dee18f48 c01291cf e180d3c0 c983afd0 dee18f28 c0405350
        df614f20 00367510 4b87ad6e c0129120 d3888d20 c04049a0 c983afc8 00000000
        dee18f64 dee18f74 c016a1fc dee18f64 dee18000 dee18fa0 c983afc8 00000000
 Call Trace:
  [schedule_timeout+111/192] schedule_timeout+0x6f/0xc0
  [process_timeout+0/16] process_timeout+0x0/0x10
  [do_poll+156/192] do_poll+0x9c/0xc0
  [sys_poll+416/704] sys_poll+0x1a0/0x2c0
  [__pollwait+0/192] __pollwait+0x0/0xc0
  [sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65

 Code: 18 00 00 00 00 52 9d ff 48 14 8b
       40 08 a8 08 75 09 b8 01 00 00 00 5b 5e 5d c3 e8 e1 53 ff ff eb f0 0f 0b
       95 00 31 72 2f c0 eb c1 <0f> 0b 94 00 31 72 2f c0 eb b0 8d 74 26 00 8d
       bc 27 00 00 00 00
  <6>note: nscd[3406] exited with preempt_count 1
 ------------[ cut here ]------------

-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya
