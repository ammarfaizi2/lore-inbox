Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRFOK0i>; Fri, 15 Jun 2001 06:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264320AbRFOK02>; Fri, 15 Jun 2001 06:26:28 -0400
Received: from rasputin.trustix.com ([195.139.104.66]:3597 "HELO
	rasputin.trustix.com") by vger.kernel.org with SMTP
	id <S264329AbRFOK0Q>; Fri, 15 Jun 2001 06:26:16 -0400
Message-ID: <3B29E2AE.3000806@trustix.com>
Date: Fri, 15 Jun 2001 12:25:50 +0200
From: Lars Gaarden <larsg@trustix.com>
Organization: Trustix AS
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac13 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG at slab.c:1244! 2.4.5-ac13
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tend to get these after a few days uptime. This one locked X
hard, ping and ssh over net etc still worked ok.
Pretty standard x86 PC hardware.


kernel BUG at slab.c:1244!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012842f>]
EFLAGS: 00213082
eax: 0000001b   ebx: cfffc768   ecx: c0217700   edx: 0002906e
esi: c8a5b000   edi: c8a5b9aa   ebp: 00012800   esp: ca2e7df8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 11139, stackpage=ca2e7000)
Stack: c01e5225 000004dc ceac71b4 c0273fa0 00000007 00000002 c8a5b000 
00001000
        00000020 00203246 c01a4e86 00000a1c 00000007 c58a97a0 00000000 
000009e0
        c01a4671 000009e0 00000007 ce146ad4 000009e0 c01d34e0 c58a94b4 
ca2e6000
Call Trace: [<c01a4e86>] [<c01a4671>] [<c01d34e0>] [<c01d35df>] [<c01d34e0>]
    [<c01a233d>] [<c01d34e0>] [<c01a265c>] [<c01a26de>] [<c0130c93>] 
[<c0117e65>]
    [<c0130df9>] [<c0106b17>] [<c010002b>]

Code: 0f 0b 83 c4 08 8b 6b 10 f7 c5 00 04 00 00 74 53 b8 a5 c2 0f


ksymoops 0.7c on i686 2.4.5-ac13.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.5-ac13/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012842f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00213082
eax: 0000001b   ebx: cfffc768   ecx: c0217700   edx: 0002906e
esi: c8a5b000   edi: c8a5b9aa   ebp: 00012800   esp: ca2e7df8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 11139, stackpage=ca2e7000)
Stack: c01e5225 000004dc ceac71b4 c0273fa0 00000007 00000002 c8a5b000 
00001000
        00000020 00203246 c01a4e86 00000a1c 00000007 c58a97a0 00000000 
000009e0
        c01a4671 000009e0 00000007 ce146ad4 000009e0 c01d34e0 c58a94b4 
ca2e6000
Call Trace: [<c01a4e86>] [<c01a4671>] [<c01d34e0>] [<c01d35df>] [<c01d34e0>]
    [<c01a233d>] [<c01d34e0>] [<c01a265c>] [<c01a26de>] [<c0130c93>] 
[<c0117e65>]
    [<c0130df9>] [<c0106b17>] [<c010002b>]
Code: 0f 0b 83 c4 08 8b 6b 10 f7 c5 00 04 00 00 74 53 b8 a5 c2 0f

 >>EIP; c012842f <kmalloc+12f/1d8>   <=====
Trace; c01a4e86 <alloc_skb+de/190>
Trace; c01a4671 <sock_alloc_send_skb+71/108>
Trace; c01d34e0 <unix_stream_sendmsg+0/2e0>
Trace; c01d35df <unix_stream_sendmsg+ff/2e0>
Trace; c01d34e0 <unix_stream_sendmsg+0/2e0>
Trace; c01a233d <sock_sendmsg+81/a4>
Trace; c01d34e0 <unix_stream_sendmsg+0/2e0>
Trace; c01a265c <sock_readv_writev+8c/98>
Trace; c01a26de <sock_writev+36/40>
Trace; c0130c93 <do_readv_writev+183/254>
Trace; c0117e65 <sys_gettimeofday+1d/94>
Trace; c0130df9 <sys_writev+41/54>
Trace; c0106b17 <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c012842f <kmalloc+12f/1d8>
00000000 <_EIP>:
Code;  c012842f <kmalloc+12f/1d8>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0128431 <kmalloc+131/1d8>
    2:   83 c4 08                  add    $0x8,%esp
Code;  c0128434 <kmalloc+134/1d8>
    5:   8b 6b 10                  mov    0x10(%ebx),%ebp
Code;  c0128437 <kmalloc+137/1d8>
    8:   f7 c5 00 04 00 00         test   $0x400,%ebp
Code;  c012843d <kmalloc+13d/1d8>
    e:   74 53                     je     63 <_EIP+0x63> c0128492 
<kmalloc+192/1d8>
Code;  c012843f <kmalloc+13f/1d8>
   10:   b8 a5 c2 0f 00            mov    $0xfc2a5,%eax


1 warning issued.  Results may not be reliable.--

-- 
LarsG

