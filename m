Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUFUPLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUFUPLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUFUPLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:11:24 -0400
Received: from main.gmane.org ([80.91.224.249]:34462 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264246AbUFUPLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:11:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Subject: kernel oops with v2.6.7 and tracepath6
Date: Mon, 21 Jun 2004 16:08:59 +0100
Message-ID: <m3zn6xdk38.fsf@pixie.isrnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gtisr.ist.utl.pt
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:UTkF4eptScCfMIyjpIa+IXzuvQg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I just got a kernel oops (two actually) after runmning
tracepath6 (from suse's iputils-ss021109-147.rpm) in a suse9.1-i386
machine:

ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Machine check exception polling timer started.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xa800. Vers LK1.1.19
Bank 2: 940040000000017a
kernel BUG at net/core/skbuff.c:104!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c027e52b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286   (2.6.7)
eax: 0000002d   ebx: cb70a620   ecx: 00000000   edx: c036e458
esi: c58a70f8   edi: c30d6002   ebp: c58a70d4   esp: c0a51bf4
ds: 007b   es: 007b   ss: 0068
Stack: c0356100 c02e36cf 000005f4 0000000e cfe3f000 c02e36db cb70a620 0000000e
       c02e36cf c0104bd5 c0a51c24 00200246 00000000 cfe2fe38 00000000 c0a51ccc
       c58a7194 c02e4679 c0a51ccc cb70a620 0000007b ffffffff c01fa25e 11000060
Call Trace:
 [<c02e36cf>] ip6_output2+0x2af/0x2e0
 [<c02e36db>] ip6_output2+0x2bb/0x2e0
 [<c02e36cf>] ip6_output2+0x2af/0x2e0
 [<c0104bd5>] error_code+0x2d/0x38
 [<c02e4679>] ip6_fragment+0x359/0x8b0
 [<c01fa25e>] csum_partial_copy_generic+0x3a/0xfc
 [<c02e3734>] ip6_output+0x34/0x50
 [<c02e3420>] ip6_output2+0x0/0x2e0
 [<c02e5799>] ip6_push_pending_frames+0x289/0x440
 [<c02f71ac>] udp_v6_push_pending_frames+0x11c/0x180
 [<c02f78d1>] udpv6_sendmsg+0x6c1/0x8a0
 [<c027a814>] sock_recvmsg+0xb4/0x110
 [<c02c276a>] inet_sendmsg+0x4a/0x60
 [<c027a70e>] sock_sendmsg+0x9e/0xf0
 [<c022afd5>] pty_write+0x145/0x190
 [<c01fad54>] copy_from_user+0x54/0x80
 [<c027c616>] sys_recvmsg+0x1f6/0x230
 [<c027a47c>] sockfd_lookup+0x1c/0x90
 [<c027be1b>] sys_sendto+0xfb/0x130
 [<c0116a00>] default_wake_function+0x0/0x20
 [<c0116a00>] default_wake_function+0x0/0x20
 [<c027be87>] sys_send+0x37/0x40
 [<c027c7da>] sys_socketcall+0x18a/0x260
 [<c0104159>] sysenter_past_esp+0x52/0x71
Code: 0f 0b 68 00 2c 36 35 c0 83 c4 14 c3 89 f6 8d bc 27 00 00 00
 
 
>>EIP; c027e52b <skb_under_panic+3b/50>   <=====
 
>>ebx; cb70a620 <pg0+b2d1620/3fbc5000>
>>edx; c036e458 <log_wait+0/8>
>>esi; c58a70f8 <pg0+546e0f8/3fbc5000>
>>edi; c30d6002 <pg0+2c9d002/3fbc5000>
>>ebp; c58a70d4 <pg0+546e0d4/3fbc5000>
>>esp; c0a51bf4 <pg0+618bf4/3fbc5000>
 
Trace; c02e36cf <ip6_output2+2af/2e0>
Trace; c02e36db <ip6_output2+2bb/2e0>
Trace; c02e36cf <ip6_output2+2af/2e0>
Trace; c0104bd5 <error_code+2d/38>
Trace; c02e4679 <ip6_fragment+359/8b0>
Trace; c01fa25e <csum_partial_copy_generic+3a/fc>
Trace; c02e3734 <ip6_output+34/50>
Trace; c02e3420 <ip6_output2+0/2e0>
Trace; c02e5799 <ip6_push_pending_frames+289/440>
Trace; c02f71ac <udp_v6_push_pending_frames+11c/180>
Trace; c02f78d1 <udpv6_sendmsg+6c1/8a0>
Trace; c027a814 <sock_recvmsg+b4/110>
Trace; c02c276a <inet_sendmsg+4a/60>
Trace; c027a70e <sock_sendmsg+9e/f0>
Trace; c022afd5 <pty_write+145/190>
Trace; c01fad54 <copy_from_user+54/80>
Trace; c027c616 <sys_recvmsg+1f6/230>
Trace; c027a47c <sockfd_lookup+1c/90>
Trace; c027be1b <sys_sendto+fb/130>
Trace; c0116a00 <default_wake_function+0/20>
Trace; c0116a00 <default_wake_function+0/20>
Trace; c027be87 <sys_send+37/40>
Trace; c027c7da <sys_socketcall+18a/260>
Trace; c0104159 <sysenter_past_esp+52/71>
 
Code;  c027e52b <skb_under_panic+3b/50>
00000000 <_EIP>:
Code;  c027e52b <skb_under_panic+3b/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c027e52d <skb_under_panic+3d/50>
   2:   68 00 2c 36 35            push   $0x35362c00
Code;  c027e532 <skb_under_panic+42/50>
   7:   c0 83 c4 14 c3 89 f6      rolb   $0xf6,0x89c314c4(%ebx)
Code;  c027e539 <skb_under_panic+49/50>
   e:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
 
kernel BUG at net/core/skbuff.c:104!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c027e52b>]    Not tainted
EFLAGS: 00210286   (2.6.7)
eax: 0000002d   ebx: cb70a1a0   ecx: 00000000   edx: c036e458
esi: c58a70f8   edi: c25d5802   ebp: c58a70d4   esp: c0a51bf4
ds: 007b   es: 007b   ss: 0068
Stack: c0356100 c02e36cf 000005f4 0000000e cfe3f000 c02e36db cb70a1a0 0000000e
       c02e36cf c0104bd5 c0a51c24 00200246 00000000 cfe2fc38 00000000 c0a51ccc
       c24fe714 c02e4679 c0a51ccc cb70a1a0 0000007b ffffffff c01fa25e 11000060
Call Trace:
 [<c02e36cf>] ip6_output2+0x2af/0x2e0
 [<c02e36db>] ip6_output2+0x2bb/0x2e0
 [<c02e36cf>] ip6_output2+0x2af/0x2e0
 [<c0104bd5>] error_code+0x2d/0x38
 [<c02e4679>] ip6_fragment+0x359/0x8b0
 [<c01fa25e>] csum_partial_copy_generic+0x3a/0xfc
 [<c02e3734>] ip6_output+0x34/0x50
 [<c02e3420>] ip6_output2+0x0/0x2e0
 [<c02e5799>] ip6_push_pending_frames+0x289/0x440
 [<c02f71ac>] udp_v6_push_pending_frames+0x11c/0x180
 [<c02f78d1>] udpv6_sendmsg+0x6c1/0x8a0
 [<c027a814>] sock_recvmsg+0xb4/0x110
 [<c02c276a>] inet_sendmsg+0x4a/0x60
 [<c027a70e>] sock_sendmsg+0x9e/0xf0
 [<c022afd5>] pty_write+0x145/0x190
 [<c01fad54>] copy_from_user+0x54/0x80
 [<c027c616>] sys_recvmsg+0x1f6/0x230
 [<c027a47c>] sockfd_lookup+0x1c/0x90
 [<c027be1b>] sys_sendto+0xfb/0x130
 [<c031de52>] schedule+0x1a2/0x4c0
 [<c027be87>] sys_send+0x37/0x40
 [<c027c7da>] sys_socketcall+0x18a/0x260
 [<c0104159>] sysenter_past_esp+0x52/0x71
Code: 0f 0b 68 00 2c 36 35 c0 83 c4 14 c3 89 f6 8d bc 27 00 00 00
 
 
>>EIP; c027e52b <skb_under_panic+3b/50>   <=====
 
>>ebx; cb70a1a0 <pg0+b2d11a0/3fbc5000>
>>edx; c036e458 <log_wait+0/8>
>>esi; c58a70f8 <pg0+546e0f8/3fbc5000>
>>edi; c25d5802 <pg0+219c802/3fbc5000>
>>ebp; c58a70d4 <pg0+546e0d4/3fbc5000>
>>esp; c0a51bf4 <pg0+618bf4/3fbc5000>
 
Trace; c02e36cf <ip6_output2+2af/2e0>
Trace; c02e36db <ip6_output2+2bb/2e0>
Trace; c02e36cf <ip6_output2+2af/2e0>
Trace; c0104bd5 <error_code+2d/38>
Trace; c02e4679 <ip6_fragment+359/8b0>
Trace; c01fa25e <csum_partial_copy_generic+3a/fc>
Trace; c02e3734 <ip6_output+34/50>
Trace; c02e3420 <ip6_output2+0/2e0>
Trace; c02e5799 <ip6_push_pending_frames+289/440>
Trace; c02f71ac <udp_v6_push_pending_frames+11c/180>
Trace; c02f78d1 <udpv6_sendmsg+6c1/8a0>
Trace; c027a814 <sock_recvmsg+b4/110>
Trace; c02c276a <inet_sendmsg+4a/60>
Trace; c027a70e <sock_sendmsg+9e/f0>
Trace; c022afd5 <pty_write+145/190>
Trace; c01fad54 <copy_from_user+54/80>
Trace; c027c616 <sys_recvmsg+1f6/230>
Trace; c027a47c <sockfd_lookup+1c/90>
Trace; c027be1b <sys_sendto+fb/130>
Trace; c031de52 <schedule+1a2/4c0>
Trace; c027be87 <sys_send+37/40>
Trace; c027c7da <sys_socketcall+18a/260>
Trace; c0104159 <sysenter_past_esp+52/71>
 
Code;  c027e52b <skb_under_panic+3b/50>
00000000 <_EIP>:
Code;  c027e52b <skb_under_panic+3b/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c027e52d <skb_under_panic+3d/50>
   2:   68 00 2c 36 35            push   $0x35362c00
Code;  c027e532 <skb_under_panic+42/50>
   7:   c0 83 c4 14 c3 89 f6      rolb   $0xf6,0x89c314c4(%ebx)
Code;  c027e539 <skb_under_panic+49/50>
   e:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi


-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585

