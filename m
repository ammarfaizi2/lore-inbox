Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315223AbSEIXQp>; Thu, 9 May 2002 19:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315225AbSEIXQo>; Thu, 9 May 2002 19:16:44 -0400
Received: from chiark.greenend.org.uk ([212.22.195.2]:50706 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S315223AbSEIXQo>; Thu, 9 May 2002 19:16:44 -0400
Date: Fri, 10 May 2002 00:16:43 +0100 (BST)
From: "Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20 sparc oops in VC handling?
Message-ID: <Pine.LNX.4.21.0205100014050.9069-100000@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this oops on my sparc machine (prior and post to which it was
saying:
eth0: Carrier Lost, trying AUI
eth0: Carrier Lost, trying TPE
eth0: Carrier Lost, trying AUI
eth0: Carrier Lost, trying TPE
eth0: Carrier Lost, trying AUI
eth0: Carrier Lost, trying TPE
eth0: Carrier Lost, trying AUI
...), after which I couldn't change VC or log in with ssh, telnet or su
(creating new ptys with screen worked though).

Oops data:

Unable to handle kernel NULL pointer dereference<1>tsk->mm->context = 00000032
tsk->mm->pgd = f1e59000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
syslogd(171): Oops
PSR: 41800fc4 PC: fe30d77c NPC: fe30d780 Y: 1fe00000
g0: f009f238 g1: 41900fe5 g2: 21a8b469 g3: f01abd30 g4: f00d1e48 g5: 74727969 g6: f242e000 g7: 00000000
o0: f3000000 o1: 00000010 o2: 00000004 o3: 00000010 o4: 00140000 o5: f0284800 sp: f242fb18 o7: f0034278
l0: 00000004 l1: f019ff5c l2: f019f000 l3: 00000020 l4: 00000000 l5: 74727969 l6: 03002c48 l7: 00000362
i0: 419000e5 i1: f01abd30 i2: f2ffffff i3: ff9ffa8f i4: f0152ce8 i5: 00000018 fp: f242fb80 i7: f010bdac
Caller[f010bdac]
Caller[f00d20a4]
Caller[f00d2818]
Caller[f00d8a04]
Caller[f00db10c]
Caller[f00d5b80]
Caller[f00463ac]
Caller[f0046550]
Caller[f001123c]
Caller[500caaa4]
Instruction DUMP: 80a40015  0280000d  80a72000 <d0040000> 80a22000  02800004  a0042004  7c74eb6f  01000000 

>>PC: fe30d77c <prom_root_node+e15e238/e196190>
>>O7: f0034278 <get_fast_time+a80/bf0>
>>I7: f010bdac <cdrom_get_next_writable+843c/8bfc>
Trace: f010bdac <cdrom_get_next_writable+843c/8bfc>
Trace: f00d20a4 <vc_resize+33a0/3ebc>
Trace: f00d2818 <vc_resize+3b14/3ebc>
Trace: f00d8a04 <tty_unregister_driver+82c/3240>
Trace: f00db10c <tty_unregister_driver+2f34/3240>
Trace: f00d5b80 <tty_hung_up_p+58c/17b8>
Trace: f00463ac <sys_close+840/f00>
Trace: f0046550 <sys_close+9e4/f00>
Trace: f001123c <get_options+1234/14f4>
Trace: 500caaa4 Before first symbol
Code:  fe30d770 <prom_root_node+e15e22c/e196190> 0000000000000000 <_PC>:
Code:  fe30d770 <prom_root_node+e15e22c/e196190>    0:	80 a4 00 15 	cmp  %l0, %l5
Code:  fe30d774 <prom_root_node+e15e230/e196190>    4:	02 80 00 0d 	be   fe30d7a8 <prom_root_node+e15e264/e196190>
Code:  fe30d778 <prom_root_node+e15e234/e196190>    8:	80 a7 20 00 	cmp  %i4, 0
Code:  fe30d77c <prom_root_node+e15e238/e196190>    c:	d0 04 00 00 	ld  [ %l0 ], %o0 <===
Code:  fe30d780 <prom_root_node+e15e23c/e196190>   10:	80 a2 20 00 	cmp  %o0, 0
Code:  fe30d784 <prom_root_node+e15e240/e196190>   14:	02 80 00 04 	be   fe30d794 <prom_root_node+e15e250/e196190>
Code:  fe30d788 <prom_root_node+e15e244/e196190>   18:	a0 04 20 04 	add  %l0, 4, %l0
Code:  fe30d78c <prom_root_node+e15e248/e196190>   1c:	7c 74 eb 6f 	call   f0048548 <__brelse+0/44>
Code:  fe30d790 <prom_root_node+e15e24c/e196190>   20:	01 00 00 00 	nop 


-- 
Jonathan Amery.      Even in the darkness
   #####                There's a light to light your way
  #######__o         Though the world you knew is gone
  #######'/             A world you thought would always stay - Mark Dennis

