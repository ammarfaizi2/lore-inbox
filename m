Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbTEBVOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbTEBVOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:14:34 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:38790 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S263127AbTEBVOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:14:31 -0400
Date: Fri, 2 May 2003 23:26:53 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: ollie@sis.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: oops 2.4.21-rc1, sis900  [was: OOPS, 2.4.20 ...]
Message-ID: <20030502212653.GB9755@finwe.eu.org>
Mail-Followup-To: ollie@sis.com.tw, linux-kernel@vger.kernel.org
References: <20030428205042.GA11571@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428205042.GA11571@finwe.eu.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In addition to previous report, here is an oops from 2.4.21-rc1 (this
time without preemption enabled). To reproduce it I only have to try to 
deconfigure interface (ifdown eth0, where eth0 is SIS 900); once I got it
while just pinging another host... 

As a quick workaround I put there another NIC...

<OOPS>
ksymoops 2.4.8 on i686 2.4.21-rc1+p.  Options used
     -V (default)
     -k ./ksyms (specified)
     -l ./modules (specified)
     -o /lib/modules/2.4.21-rc1-i2/ (specified)
     -m ./System.map-2.4.21-rc1-i2 (specified)

Unable to handle kernel paging request at virtual address 00003615
c0116a3b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0116a3b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c32b332c   ebx: 00003615   ecx: 00000001   edx: 00000001
esi: c32b332c   edi: 00000001   ebp: c2b37e9c   esp: c2b37e80
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 897, stackpage=c2b37000)
Stack: 00000001 00000001 00000001 00000282 c3e39380 c556c560 00001002 00000000 
       c01f5295 c10f55d0 c4d00800 c5546bc0 c3e39380 c01f4828 c3e39380 c4a639c0 
       c01f5982 c4a639c0 00000000 00000030 00000009 c601d369 c4a639c0 c556c400 
Call Trace:    [<c01f5295>] [<c01f4828>] [<c01f5982>] [<c601d369>] [<c01f96f5>]
  [<c01fa879>] [<c01f91df>] [<c022b340>] [<c01f2500>] [<c01f2526>] [<c0146380>]
  [<c010734f>]
Code: 8b 13 0f 0d 02 39 c3 74 16 8b 4b fc 8b 01 85 c7 75 19 8b 02 


>>EIP; c0116a3b <__wake_up+1b/70>   <=====

>>eax; c32b332c <_end+2fb1994/5d196e8>
>>esi; c32b332c <_end+2fb1994/5d196e8>
>>ebp; c2b37e9c <_end+2836504/5d196e8>
>>esp; c2b37e80 <_end+28364e8/5d196e8>

Trace; c01f5295 <sock_def_write_space+75/80>
Trace; c01f4828 <sock_wfree+48/50>
Trace; c01f5982 <__kfree_skb+42/150>
Trace; c601d369 <[sis900]sis900_close+99/c0>
Trace; c01f96f5 <dev_close+c5/d0>
Trace; c01fa879 <dev_change_flags+129/140>
Trace; c01f91df <dev_get+f/20>
Trace; c022b340 <devinet_ioctl+290/610>
Trace; c01f2500 <sock_ioctl+0/30>
Trace; c01f2526 <sock_ioctl+26/30>
Trace; c0146380 <sys_ioctl+b0/1b0>
Trace; c010734f <system_call+33/38>

Code;  c0116a3b <__wake_up+1b/70>
00000000 <_EIP>:
Code;  c0116a3b <__wake_up+1b/70>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c0116a3d <__wake_up+1d/70>
   2:   0f 0d 02                  prefetch (%edx)
Code;  c0116a40 <__wake_up+20/70>
   5:   39 c3                     cmp    %eax,%ebx
Code;  c0116a42 <__wake_up+22/70>
   7:   74 16                     je     1f <_EIP+0x1f>
Code;  c0116a44 <__wake_up+24/70>
   9:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c0116a47 <__wake_up+27/70>
   c:   8b 01                     mov    (%ecx),%eax
Code;  c0116a49 <__wake_up+29/70>
   e:   85 c7                     test   %eax,%edi
Code;  c0116a4b <__wake_up+2b/70>
  10:   75 19                     jne    2b <_EIP+0x2b>
Code;  c0116a4d <__wake_up+2d/70>
  12:   8b 02                     mov    (%edx),%eax

</OOPS>

PS. There is one strange thing - I've got identical motherboard (same model,
    same BIOS) running now the very same kernel (network configuration is different
    though: eth0 has no ipx address) and everything seems to be ok there.


Additional information:

config: 
------
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.21-rc1/oops2/config

lspci:
-----
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.21-rc1/oops2/lspci
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.21-rc1/oops2/lspci_v
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.21-rc1/oops2/lspci_vv

dmesg:
-----
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.21-rc1/oops2/dmesg

cpuinfo:
-------
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.21-rc1/oops2/cpuinfo

gcc: 3.2.3
modutils: 2.4.21
ifconfig: 1.42 (2001-04-13)
binutils: 2.13.90.0.18


Any suggestions are welcome. 


-- 
Jacek Kawa  **Nobody expects the Spanish Inquisition! Our chief weapon
            is suprise... surprise and fear... fear and surprise...**
