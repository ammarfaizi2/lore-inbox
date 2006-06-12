Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWFLVpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWFLVpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFLVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:45:14 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:54733 "EHLO mail.bluetone.cz")
	by vger.kernel.org with ESMTP id S932392AbWFLVpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:45:12 -0400
Message-ID: <448DE077.1040900@scssoft.com>
Date: Mon, 12 Jun 2006 23:45:27 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.16.20 kernel oops
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun 12 18:53:42 server kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000008
Jun 12 18:53:42 server kernel:  printing eip:
Jun 12 18:53:42 server kernel: c0237744
Jun 12 18:53:42 server kernel: *pde = 00000000
Jun 12 18:53:42 server kernel: Oops: 0002 [#1]
Jun 12 18:53:42 server kernel: Modules linked in: tun
Jun 12 18:53:42 server kernel: CPU:    0
Jun 12 18:53:42 server kernel: EIP:    0060:[<c0237744>]    Not tainted VLI
Jun 12 18:53:42 server kernel: EFLAGS: 00210246   (2.6.16.20 #1)
Jun 12 18:53:42 server kernel: EIP is at udp_recvmsg+0x97/0x1cc
Jun 12 18:53:42 server kernel: eax: 00000008   ebx: df6fcaa0   ecx: 
dd38df64   edx: dfb13794
Jun 12 18:53:42 server kernel: esi: dd38df48   edi: 0000067d   ebp: 
dfb13740   esp: dd38dd98
Jun 12 18:53:42 server kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 18:53:42 server kernel: Process tincd (pid: 1127, 
threadinfo=dd38c000 task=c14d0050)
Jun 12 18:53:42 server kernel: Stack: <0>0000005c dd38dec8 0000005c 
00000000 00000000 00000000 00000040 c02db000
Jun 12 18:53:42 server kernel:        dd38df48 dd38ddf0 c0208bfd 
0000067d 00000040 00000000 dd38ddd4 00000010
Jun 12 18:53:42 server kernel:        c0291080 00000040 dd38df48 
c02071f6 0000067d 00000040 c0207751 0000005c
Jun 12 18:53:42 server kernel: Call Trace:
Jun 12 18:53:42 server kernel:  [<c0208bfd>] sock_common_recvmsg+0x2d/0x43
Jun 12 18:53:42 server kernel:  [<c02071f6>] sock_recvmsg+0xc9/0xe4
Jun 12 18:53:42 server kernel:  [<c0207751>] sock_sendmsg+0xb9/0xd2
Jun 12 18:53:42 server kernel:  [<c011fec4>] 
autoremove_wake_function+0x0/0x2d
Jun 12 18:53:42 server kernel:  [<c012be98>] __alloc_pages+0x4e/0x27e
Jun 12 18:53:42 server kernel:  [<c020c8b9>] datagram_poll+0x22/0xb9
Jun 12 18:53:42 server kernel:  [<c0207d71>] sys_recvfrom+0xb5/0x111
Jun 12 18:53:42 server kernel:  [<c014b41f>] __pollwait+0x0/0x94
Jun 12 18:53:42 server kernel:  [<c014ba97>] core_sys_select+0x217/0x223
Jun 12 18:53:42 server kernel:  [<c02085cc>] sys_socketcall+0x11a/0x181
Jun 12 18:53:42 server kernel:  [<c0102331>] syscall_call+0x7/0xb
Jun 12 18:53:42 server kernel: Code: 20 89 7c 24 04 8a 43 74 83 e0 0c 3c 
08 74 15 f6 46 18 20 74 29 89 d8 e8 39 4e fd ff 85 c0 0f 85 0f 01 00 00 
8b 4e 08 ff 74 24 04 <ba> 08 00 00 0
0 89 d8 e8 20 52 fd ff 89 44 24 14 58 eb 1c 8b 4e

... and probably related oops which I have reported earlier:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114958556818554&w=2

The process which caused the crash is tincd (a virtual private network 
daemon) which uses tun
device to communicate with the peer over udp, tunneling both ipv4 and 
ipv6 traffic. When the
oops happens, the networking layer goes nuts; the machine itself 
continues to operate, yet
I can't send and receive a simple bit. The machine is effectively dead 
from the outside.

I realize these bug reports are probably worthles as there is not much 
of clues to follow...
Does it ring some bells?

Petr

