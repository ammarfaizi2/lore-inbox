Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTJGLdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTJGLdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:33:39 -0400
Received: from docsis106-17.menta.net ([62.57.106.17]:38289 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S262262AbTJGLdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:33:36 -0400
Date: Tue, 7 Oct 2003 13:33:35 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: ksymoops in 2.6.0test6-mm4
Message-ID: <Pine.LNX.4.44.0310071330180.2847-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got this symoops in my log, but the computer still works :)

This is what gets logged:

Oct  7 13:28:27 pau kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000034
Oct  7 13:28:27 pau kernel:  printing eip:
Oct  7 13:28:27 pau kernel: c0190be8
Oct  7 13:28:27 pau kernel: *pde = 00000000
Oct  7 13:28:27 pau kernel: Oops: 0000 [#2]
Oct  7 13:28:27 pau kernel: PREEMPT 
Oct  7 13:28:27 pau kernel: CPU:    0
Oct  7 13:28:27 pau kernel: EIP:    0060:[<c0190be8>]    Not tainted VLI
Oct  7 13:28:27 pau kernel: EFLAGS: 00010212
Oct  7 13:28:27 pau kernel: EIP is at proc_pid_stat+0x268/0x520
Oct  7 13:28:27 pau kernel: eax: 00000000   ebx: 00000000   ecx: 05de0c5f   
edx: c0126daf
Oct  7 13:28:27 pau kernel: esi: 0000000a   edi: e461c4c0   ebp: d962d940   
esp: d0a57e44
Oct  7 13:28:27 pau kernel: ds: 007b   es: 007b   ss: 0068
Oct  7 13:28:27 pau kernel: Process lsof (pid: 29943, threadinfo=d0a56000 
task=da88e0c0)
Oct  7 13:28:27 pau kernel: Stack: d962d940 c02cdf00 c02cdf00 c02cdf00 
d1edc990 c018ea34 d81b6200 d1edc990 
Oct  7 13:28:27 pau kernel:        0000000d c02b34dc d962d940 ffffffea 
fffffff4 d1edcb78 d1edcb10 d81b6200 
Oct  7 13:28:27 pau kernel:        c016affb d1edcb10 d81b6200 c02cdea0 
00000000 d0a57f70 edfe4fc0 d0a57f00 
Oct  7 13:28:27 pau kernel: Call Trace:
Oct  7 13:28:27 pau kernel:  [<c018ea34>] proc_pident_lookup+0x104/0x260
Oct  7 13:28:27 pau kernel:  [<c016affb>] real_lookup+0xcb/0xf0
Oct  7 13:28:27 pau kernel:  [<c01747a2>] dput+0x22/0x270
Oct  7 13:28:27 pau kernel:  [<c016b898>] link_path_walk+0x5f8/0x920
Oct  7 13:28:27 pau kernel:  [<c0144db0>] buffered_rmqueue+0xd0/0x180
Oct  7 13:28:27 pau kernel:  [<c0126daf>] do_exit+0x2ff/0x3d0
Oct  7 13:28:27 pau kernel:  [<c018d934>] proc_info_read+0x74/0x160
Oct  7 13:28:27 pau kernel:  [<c015d3ec>] vfs_read+0xbc/0x130
Oct  7 13:28:27 pau kernel:  [<c015d6c2>] sys_read+0x42/0x70
Oct  7 13:28:27 pau kernel:  [<c028b826>] sysenter_past_esp+0x43/0x65
Oct  7 13:28:27 pau kernel: 
Oct  7 13:28:27 pau kernel: Code: f3 01 c0 29 c2 be 0a 00 00 00 89 c8 f7 
f6 89 da 89 94 24 b4 00 00 00 89 84 24 b0 00 00 00 8b 94 24 d8 00 00 00 8b 
85 ac 05 00 00 <8b> 58 34 8b 70 2c 8b 45 40 89 84 24 ac 00 00 00 8b 85 60 
01 00 

And this is run through ksymoops:


>>EIP; c0190be8 <proc_pid_stat+268/520>   <=====

>>ecx; 05de0c5f <__crc___getblk+5e45/3835f1>
>>edx; c0126daf <do_exit+2ff/3d0>
>>edi; e461c4c0 <__crc_tcp_unhash+50de8e/832eb7>
>>ebp; d962d940 <__crc_tty_hangup+1ad7e/c0d20>
>>esp; d0a57e44 <__crc_dev_set_allmulti+e99c4/10a115>

Code;  c0190bbd <proc_pid_stat+23d/520>
00000000 <_EIP>:
Code;  c0190bbd <proc_pid_stat+23d/520>
   0:   f3 01 c0                  repz add %eax,%eax
Code;  c0190bc0 <proc_pid_stat+240/520>
   3:   29 c2                     sub    %eax,%edx
Code;  c0190bc2 <proc_pid_stat+242/520>
   5:   be 0a 00 00 00            mov    $0xa,%esi
Code;  c0190bc7 <proc_pid_stat+247/520>
   a:   89 c8                     mov    %ecx,%eax
Code;  c0190bc9 <proc_pid_stat+249/520>
   c:   f7 f6                     div    %esi
Code;  c0190bcb <proc_pid_stat+24b/520>
   e:   89 da                     mov    %ebx,%edx
Code;  c0190bcd <proc_pid_stat+24d/520>
  10:   89 94 24 b4 00 00 00      mov    %edx,0xb4(%esp,1)
Code;  c0190bd4 <proc_pid_stat+254/520>
  17:   89 84 24 b0 00 00 00      mov    %eax,0xb0(%esp,1)
Code;  c0190bdb <proc_pid_stat+25b/520>
  1e:   8b 94 24 d8 00 00 00      mov    0xd8(%esp,1),%edx
Code;  c0190be2 <proc_pid_stat+262/520>
  25:   8b 85 ac 05 00 00         mov    0x5ac(%ebp),%eax
Code;  c0190be8 <proc_pid_stat+268/520>   <=====
  2b:   8b 58 34                  mov    0x34(%eax),%ebx   <=====
Code;  c0190beb <proc_pid_stat+26b/520>
  2e:   8b 70 2c                  mov    0x2c(%eax),%esi
Code;  c0190bee <proc_pid_stat+26e/520>
  31:   8b 45 40                  mov    0x40(%ebp),%eax
Code;  c0190bf1 <proc_pid_stat+271/520>
  34:   89 84 24 ac 00 00 00      mov    %eax,0xac(%esp,1)
Code;  c0190bf8 <proc_pid_stat+278/520>
  3b:   8b                        .byte 0x8b
Code;  c0190bf9 <proc_pid_stat+279/520>
  3c:   85 60 01                  test   %esp,0x1(%eax)


-- 

Pau

