Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293527AbSCKWjF>; Mon, 11 Mar 2002 17:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293543AbSCKWi4>; Mon, 11 Mar 2002 17:38:56 -0500
Received: from enchanter.real-time.com ([208.20.202.11]:48648 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S293527AbSCKWip>; Mon, 11 Mar 2002 17:38:45 -0500
Date: Mon, 11 Mar 2002 16:38:42 -0600 (CST)
From: Nate Carlson <natecars@real-time.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel panic with PoPToP
Message-ID: <Pine.LNX.4.33.0203111621570.19991-100000@enchanter.real-time.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Got a client reporting a kernel panic with pptpd.. not sure what could be
causing it. Decoded Oops also included. Anyone have any ideas as to what
could cause it?

Single-processor X86 box; kernel 2.4.17; vanilla except patches for mppe
in ppp module. Apparently, this error is caused when users log in and out
of the VPN in quick succession. It's happened twice today.

Please let me know if you guys need more info. Thanks!

-- 
Nate Carlson <natecars@real-time.com>   | Phone : (952)943-8700
http://www.real-time.com                | Fax   : (952)943-8500

--- start of oops ----
skput:over:d0882723:1432 put:1432 dev:<NULL> invalid operand:0000

cpu:0
EIP:0010[<c01e278b>] Not Tainted
EFLAGS:00010286
eax:0000002d ebx:d0882723 ecx:cfdc8ee0 edx:00000001

esi:c9119280 edi:00000598 ebp:cd5fe400 esp:cfb77e1c ds:0018 es:0018 ss:0018

Process pptpctrl (pid:1039, stackpage=cfb770000)

Stack:c0251da0 d0882723 00000598 00000598 c0251d80 c9119280 d088282b c9119280 00000598 d0882723 c781ab20 c810bf40 cd5fe400 c855d813 d088210a cd5fe400 c781ab20 cd5fe400 c810bf40 ccbf4e6c c855d813 c02b6a20 d0882087 cd5fe400

call trace:[<do882723>][<d088272b>][<d0882723>][<d088210a>][<d0882087>][<d0881f3a>][<d08870e2>][<d0886376>][<c0175dfe>][<c017481e>][<c0170768>][<c0174684>][<c012f4e6>][<c0106d7b>]

Code: 0f 0b 83 c4 14 5b c3 89 f6 53 b8 80 1d 25 c0 8b 54 24 08 8b

<0> Kernel panic:Aiee, killing interrupt handler!

Interrupt handler - not synching

---- ksymoops output ----
$ ksymoops -m /boot/System.map-2.4.17-1_rte_1 < oops.txt
ksymoops 2.3.4 on i686 2.4.17-1_rte_1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-1_rte_1/ (default)
     -m /boot/System.map-2.4.17-1_rte_1 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01d3930, System.map says c014d010.  Ignoring ksyms_base entry
Process pptpctrl (pid:1039, stackpage=cfb770000)
00000598 d0882723 c781ab20 c810bf40 cd5fe400 c855d813 d088210a cd5fe400
c781ab20 cd5fe400 c810bf40 ccbf4e6c c855d813 c02b6a20 d0882087 cd5fe400
Code: 0f 0b 83 c4 14 5b c3 89 f6 53 b8 80 1d 25 c0 8b 54 24 08 8b
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   83 c4 14                  add    $0x14,%esp
Code;  00000005 Before first symbol
   5:   5b                        pop    %ebx
Code;  00000006 Before first symbol
   6:   c3                        ret
Code;  00000007 Before first symbol
   7:   89 f6                     mov    %esi,%esi
Code;  00000009 Before first symbol
   9:   53                        push   %ebx
Code;  0000000a Before first symbol
   a:   b8 80 1d 25 c0            mov    $0xc0251d80,%eax
Code;  0000000f Before first symbol
   f:   8b 54 24 08               mov    0x8(%esp,1),%edx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

<0> Kernel panic:Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


-- 
Bob Tanner <tanner@real-time.com>         | Phone : (952)943-8700
http://www.mn-linux.org, Minnesota, Linux | Fax   : (952)943-8500
Key fingerprint =  6C E9 51 4F D5 3E 4C 66 62 A9 10 E5 35 85 39 D9





