Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263460AbTCNTKD>; Fri, 14 Mar 2003 14:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbTCNTKD>; Fri, 14 Mar 2003 14:10:03 -0500
Received: from ktel.gcfn.net ([65.118.13.43]:23689 "EHLO ktel.gcfn.net")
	by vger.kernel.org with ESMTP id <S263460AbTCNTKB>;
	Fri, 14 Mar 2003 14:10:01 -0500
Date: Fri, 14 Mar 2003 14:21:21 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5 oops in mod_timer
Message-ID: <20030314192121.GA6395@marvin.local.funknet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Face: "@@t%Tp%P[K&^Z1/]q70]C%d'=\$yoa]&jttNbd#nh_uP?0{p.IFN'N+HztsAU!i~b6MS~1 ;DRL#`"zX~!t%Ki8+x&"G|pni0/'wi}78(94"Ud%jH{hzEWc/{F.v\OBMr-!)6x|BBACbObZpW^}w> #P{s4m~_#vGsg$-wHd^u$BV@7|=b44]uvE>7HWz(:5$ygT>^/SsLid||U]}:5"H08!w,Rg;Vr8PE7f N:\hr_*Rh49hXUdLt`;%ChC6kbJUl39=$Y;GF4VJJ2rJ_o{mNfL?Zr$J".
From: Rob Funk <rfunk@funknet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre5 has been the most stable 2.4.21-pre yet for me (I haven't
tried the pre5-ac patches though), but after a week of uptime I got
this oops...


ksymoops 2.4.6 on i586 2.4.21-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre5/ (default)
     -m /boot/System.map-2.4.21-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 02000004
c011ba4a
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011ba4a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000000   ebx: d9ec333c   ecx: 00000000   edx: 02000000
esi: 00000216   edi: d9ec3290   ebp: 000005a8   esp: d4af3e6c
ds: 0018   es: 0018   ss: 0018
Process korn (pid: 1148, stackpage=d4af3000)
Stack: d9ec3290 c56a0d40 d9ec3290 c0286cde d9ec333c 0356d7e4 00000000 00000000 
       00000000 d9ec3290 00000001 d9ec31c4 00000000 c027d385 d9ec3160 00000000 
       d9ec3160 d4af3f80 d4af3f4c dfb8a3c0 d4af3f0c d9ec3290 d9ec3198 d9ec3194 
Call Trace:    [<c0286cde>] [<c027d385>] [<c02961f4>] [<c0262444>] [<c0262657>]
  [<c0130175>] [<c0106bd3>]
Code: 89 42 04 89 10 c7 03 00 00 00 00 c7 43 04 00 00 00 00 bf 01 


>>EIP; c011ba4a <mod_timer+1e/ec>   <=====

>>ebx; d9ec333c <_end+19b24078/204bed9c>
>>edi; d9ec3290 <_end+19b23fcc/204bed9c>
>>esp; d4af3e6c <_end+14754ba8/204bed9c>

Trace; c0286cde <tcp_write_xmit+202/2c0>
Trace; c027d385 <tcp_sendmsg+d65/f8c>
Trace; c02961f4 <inet_sendmsg+38/40>
Trace; c0262444 <sock_sendmsg+68/88>
Trace; c0262657 <sock_write+9f/a8>
Trace; c0130175 <sys_write+95/f0>
Trace; c0106bd3 <system_call+33/40>

Code;  c011ba4a <mod_timer+1e/ec>
00000000 <_EIP>:
Code;  c011ba4a <mod_timer+1e/ec>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c011ba4d <mod_timer+21/ec>
   3:   89 10                     mov    %edx,(%eax)
Code;  c011ba4f <mod_timer+23/ec>
   5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c011ba55 <mod_timer+29/ec>
   b:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c011ba5c <mod_timer+30/ec>
  12:   bf 01 00 00 00            mov    $0x1,%edi


1 warning issued.  Results may not be reliable.


-- 
==============================| "A slice of life isn't the whole cake
 Rob Funk <rfunk@funknet.net> | One tooth will never make a full grin"
 http://www.funknet.net/rfunk |    -- Chris Mars, "Stuck in Rewind"
