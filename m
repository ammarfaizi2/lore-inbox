Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310299AbSCLBgF>; Mon, 11 Mar 2002 20:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310303AbSCLBf5>; Mon, 11 Mar 2002 20:35:57 -0500
Received: from splot.org ([216.86.199.146]:21215 "EHLO gee.splot.org")
	by vger.kernel.org with ESMTP id <S310299AbSCLBfm>;
	Mon, 11 Mar 2002 20:35:42 -0500
Date: Mon, 11 Mar 2002 17:29:18 -0800 (PST)
From: Eric Ortega <eto@splot.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18:  kernel paging request oops
Message-ID: <Pine.LNX.4.21.0203111718080.24540-101000@gee.splot.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1457033927-1266065672-1015896558=:24540"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1457033927-1266065672-1015896558=:24540
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello,

We are running the vanilla 2.4.18 kernel on a 1.4 Ghz AMD Athlon on a 
IWill KK266+ with 4 IBM IDE drives and 1 WD.  There are two tulip 100MB cards
and a Promise Ultra/66.  We are running software RAID 5 across the four
IBM drives and have 3 brand new 512MB sticks of memory from crucial.com.

The .config file for the oopsing kernel is attached.

The memory and motherboard are brand new on this system.  I will be 
taking it down and running memtest on it for the next few days (with 1.5GB
it takes a while for the thorough checks).


Please help me figure out how to stabilize this system.

Thanks.


The output from ksymoops:

shrimp:/lnc/eto# ksymoops -v /usr/src/linux/vmlinux -K -L -O -m /usr/src/linux/System.map oops
ksymoops 2.4.3 on i686 2.4.18.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

Mar 11 17:10:21 shrimp kernel: Unable to handle kernel paging request at virtual address 40000014
Mar 11 17:10:21 shrimp kernel: c01266ea
Mar 11 17:10:21 shrimp kernel: *pde = 371f6067
Mar 11 17:10:21 shrimp kernel: Oops: 0003
Mar 11 17:10:21 shrimp kernel: CPU:    0
Mar 11 17:10:21 shrimp kernel: EIP:    0010:[<c01266ea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 11 17:10:21 shrimp kernel: EFLAGS: 00010246
Mar 11 17:10:21 shrimp kernel: eax: 00001f00   ebx: 00000000   ecx: 40000000   edx: 00000000
Mar 11 17:10:21 shrimp kernel: esi: f634d6c0   edi: f634d71c   ebp: 00000078   esp: f71fbdbc
Mar 11 17:10:21 shrimp kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 17:10:21 shrimp kernel: Process rpc.nfsd (pid: 380, stackpage=f71fb000)
Mar 11 17:10:21 shrimp kernel: Stack: c01a7a2d f634d6c0 f7235b40 c01a7a6b f634d6c0 f634d6c0 c01a7bd3 f634d6c0 
Mar 11 17:10:21 shrimp kernel:        f634d6c0 f71fbec8 c01a977c f634d6c0 c01d27f1 f7235b40 f634d6c0 c022d880 
Mar 11 17:10:21 shrimp kernel:        00002260 f71fbf38 f71fbf38 f71fbeb8 00000078 c01d7fdd f7235b40 f71fbf38 
Mar 11 17:10:21 shrimp kernel: Call Trace: [<c01a7a2d>] [<c01a7a6b>] [<c01a7bd3>] [<c01a977c>] [<c01d27f1>] 
Mar 11 17:10:21 shrimp kernel:    [<c01d7fdd>] [<c01a4a4d>] [<c01a5dab>] [<c013825b>] [<c010ff60>] [<c01a4e23>] 
Mar 11 17:10:21 shrimp kernel:    [<c01389fa>] [<c0138ab7>] [<c01266fb>] [<c012671a>] [<c01381ba>] [<c0138de4>] 
Mar 11 17:10:21 shrimp kernel:    [<c01a607d>] [<c0106c43>] 
Mar 11 17:10:21 shrimp kernel: Code: ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8 e5 f8 ff ff c3 8d 74 

>>EIP; c01266ea <__free_pages+a/20>   <=====
Trace; c01a7a2c <skb_release_data+3c/70>
Trace; c01a7a6a <kfree_skbmem+a/60>
Trace; c01a7bd2 <__kfree_skb+112/120>
Trace; c01a977c <skb_free_datagram+1c/20>
Trace; c01d27f0 <udp_recvmsg+190/230>
Trace; c01d7fdc <inet_recvmsg+3c/60>
Trace; c01a4a4c <sock_recvmsg+3c/b0>
Trace; c01a5daa <sys_recvmsg+15a/200>
Trace; c013825a <__pollwait+8a/90>
Trace; c010ff60 <schedule+2c0/2f0>
Trace; c01a4e22 <sock_poll+22/30>
Trace; c01389fa <do_pollfd+5a/90>
Trace; c0138ab6 <do_poll+86/e0>
Trace; c01266fa <__free_pages+1a/20>
Trace; c012671a <free_pages+1a/20>
Trace; c01381ba <poll_freewait+3a/50>
Trace; c0138de4 <sys_poll+2d4/2f0>
Trace; c01a607c <sys_socketcall+1ec/200>
Trace; c0106c42 <system_call+2e/34>
Code;  c01266ea <__free_pages+a/20>
00000000 <_EIP>:
Code;  c01266ea <__free_pages+a/20>   <=====
   0:   ff 49 14                  decl   0x14(%ecx)   <=====
Code;  c01266ec <__free_pages+c/20>
   3:   0f 94 c0                  sete   %al
Code;  c01266f0 <__free_pages+10/20>
   6:   84 c0                     test   %al,%al
Code;  c01266f2 <__free_pages+12/20>
   8:   74 07                     je     11 <_EIP+0x11> c01266fa <__free_pages+1a/20>
Code;  c01266f4 <__free_pages+14/20>
   a:   89 c8                     mov    %ecx,%eax
Code;  c01266f6 <__free_pages+16/20>
   c:   e8 e5 f8 ff ff            call   fffff8f6 <_EIP+0xfffff8f6> c0125fe0 <__free_pages_ok+0/200>
Code;  c01266fa <__free_pages+1a/20>
  11:   c3                        ret    
Code;  c01266fc <__free_pages+1c/20>
  12:   8d 74 00 00               lea    0x0(%eax,%eax,1),%esi


--1457033927-1266065672-1015896558=:24540
Content-Type: APPLICATION/octet-stream; name="config.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0203111729180.24540@gee.splot.org>
Content-Description: 
Content-Disposition: attachment; filename="config.gz"

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
--1457033927-1266065672-1015896558=:24540--
