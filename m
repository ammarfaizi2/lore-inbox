Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTAXRob>; Fri, 24 Jan 2003 12:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTAXRoa>; Fri, 24 Jan 2003 12:44:30 -0500
Received: from [212.42.86.71] ([212.42.86.71]:52234 "EHLO center.hqhost.net")
	by vger.kernel.org with ESMTP id <S262492AbTAXRo3>;
	Fri, 24 Jan 2003 12:44:29 -0500
From: Vladimir Klenov <maple@center.hqhost.net>
Date: Fri, 24 Jan 2003 19:53:36 +0200
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at slab.c:1263! (2.4.19)
Message-ID: <20030124175336.GA24760@valinor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after few days of working appeared in dmesg
kernel 2.4.19 with grsecurity patch, ext3, reiserfs, 1G mem, highmem enabled.
machine still alive, it seems working normal.

kernel BUG at slab.c:1263!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b21e>]    Not tainted
EFLAGS: 00010012
eax: c2a5e7ff   ebx: c1c0f700   ecx: 00000001   edx: 00000001
esi: c2a5e000   edi: c2a5e049   ebp: 00012800   esp: d9c3be64
ds: 0018   es: 0018   ss: 0018
Process thttpd (pid: 9414, stackpage=d9c3b000)
Stack: eff8fd54 c031d060 000001f0 c80a32f8 00000800 c2a5e049 00000246
c01ffa91 
       0000069c 000001f0 c80a3220 c80a3220 c80a3220 c0215c1a 00000660
000001f0 
       c80a3220 d9c3bf80 d9c3bf48 ef9b6e4c c64b2f40 caf9db18 c021ff8a
c80a3258 
Call Trace:    [<c01ffa91>] [<c0215c1a>] [<c021ff8a>] [<c022f466>]
[<c01fca95>]
  [<c01fccbe>] [<c0133ee6>] [<c010856f>]

Code: 0f 0b ef 04 60 6c 25 c0 f7 c5 00 04 00 00 74 36 b8 a5 c2 0f

after ksymoops

>>EIP; c012b21e <kmalloc+15a/1e4>   <=====

>>eax; c2a5e7ff <_end+273e3f7/38778c58>
>>ebx; c1c0f700 <_end+18ef2f8/38778c58>
>>esi; c2a5e000 <_end+273dbf8/38778c58>
>>edi; c2a5e049 <_end+273dc41/38778c58>
>>esp; d9c3be64 <_end+1991ba5c/38778c58>

Trace; c01ffa91 <alloc_skb+d1/188>
Trace; c0215c1a <tcp_sendmsg+20a/106c>
Trace; c021ff8a <tcp_write_xmit+20a/2c0>
Trace; c022f466 <inet_sendmsg+3a/40>
Trace; c01fca95 <sock_sendmsg+69/88>
Trace; c01fccbe <sock_write+b2/bc>
Trace; c0133ee6 <sys_write+96/f0>
Trace; c010856f <system_call+33/38>

Code;  c012b21e <kmalloc+15a/1e4>
00000000 <_EIP>:
Code;  c012b21e <kmalloc+15a/1e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012b220 <kmalloc+15c/1e4>
   2:   ef                        out    %eax,(%dx)
Code;  c012b221 <kmalloc+15d/1e4>
   3:   04 60                     add    $0x60,%al
Code;  c012b223 <kmalloc+15f/1e4>
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  c012b224 <kmalloc+160/1e4>
   6:   25 c0 f7 c5 00            and    $0xc5f7c0,%eax
Code;  c012b229 <kmalloc+165/1e4>
   b:   04 00                     add    $0x0,%al
Code;  c012b22b <kmalloc+167/1e4>
   d:   00 74 36 b8               add    %dh,0xffffffb8(%esi,%esi,1)
Code;  c012b22f <kmalloc+16b/1e4>
  11:   a5                        movsl  %ds:(%esi),%es:(%edi)
Code;  c012b230 <kmalloc+16c/1e4>
  12:   c2 0f 00                  ret    $0xf

		SY, Vladimir

