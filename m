Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTBQSQQ>; Mon, 17 Feb 2003 13:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBQSQQ>; Mon, 17 Feb 2003 13:16:16 -0500
Received: from ktel.gcfn.net ([65.118.13.43]:14739 "EHLO ktel.gcfn.net")
	by vger.kernel.org with ESMTP id <S267273AbTBQSQO>;
	Mon, 17 Feb 2003 13:16:14 -0500
Date: Mon, 17 Feb 2003 13:26:40 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4-ac4 oops
Message-ID: <20030217182640.GA3042@marvin.local.funknet.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, rfunk@funknet.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Face: "@@t%Tp%P[K&^Z1/]q70]C%d'=\$yoa]&jttNbd#nh_uP?0{p.IFN'N+HztsAU!i~b6MS~1 ;DRL#`"zX~!t%Ki8+x&"G|pni0/'wi}78(94"Ud%jH{hzEWc/{F.v\OBMr-!)6x|BBACbObZpW^}w> #P{s4m~_#vGsg$-wHd^u$BV@7|=b44]uvE>7HWz(:5$ygT>^/SsLid||U]}:5"H08!w,Rg;Vr8PE7f N:\hr_*Rh49hXUdLt`;%ChC6kbJUl39=$Y;GF4VJJ2rJ_o{mNfL?Zr$J".
From: Rob Funk <rfunk@funknet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this oops in XFree86 when switching desktops within KDE....


ksymoops 2.4.5 on i586 2.4.21-pre4-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre4-ac4/ (default)
     -m /boot/System.map-2.4.21-pre4-ac4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at memory.c:377!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01215d8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013206
eax: 00000109   ebx: d08c0424   ecx: 425a8000   edx: d08c0000
esi: dfe05ee0   edi: fe008000   ebp: 425a8000   esp: dc42fe84
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 1666, stackpage=dc42f000)
Stack: dd9f9900 dfe05ee0 fe008000 425a8000 d08c0408 d08c0408 409a1000 00000002 
       00000002 00003246 ce2f8180 00000000 405b0000 c0123ce2 dfe05ee0 425a8000 
       fe008000 dfe05ee0 dc42e000 dc42e000 00000006 dd9f9ea0 c0113fd6 dfe05ee0 
Call Trace:    [<c0123ce2>] [<c0113fd6>] [<c01180cd>] [<c011cfe9>] [<c01069b0>]
  [<c0154583>] [<c0131fe4>] [<c0106020>] [<c0106c24>] [<c0106b54>]
Code: 0f 0b 79 01 60 f6 2b c0 89 cd 89 5c 24 28 8b 44 24 30 89 44 


>>EIP; c01215d8 <zap_page_range+34/230>   <=====

>>ebx; d08c0424 <_end+1050f948/204ad524>
>>ecx; 425a8000 Before first symbol
>>edx; d08c0000 <_end+1050f524/204ad524>
>>esi; dfe05ee0 <_end+1fa55404/204ad524>
>>edi; fe008000 <END_OF_CODE+1d742de1/????>
>>ebp; 425a8000 Before first symbol
>>esp; dc42fe84 <_end+1c07f3a8/204ad524>

Trace; c0123ce2 <exit_mmap+c6/138>
Trace; c0113fd6 <mmput+4a/68>
Trace; c01180cd <do_exit+95/234>
Trace; c011cfe9 <sig_exit+91/94>
Trace; c01069b0 <do_signal+1fc/26c>
Trace; c0154583 <ext3_release_file+13/1c>
Trace; c0131fe4 <fput+bc/e0>
Trace; c0106020 <sys_sigreturn+b4/e0>
Trace; c0106c24 <error_code+34/40>
Trace; c0106b54 <signal_return+14/20>

Code;  c01215d8 <zap_page_range+34/230>
00000000 <_EIP>:
Code;  c01215d8 <zap_page_range+34/230>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01215da <zap_page_range+36/230>
   2:   79 01                     jns    5 <_EIP+0x5>
Code;  c01215dc <zap_page_range+38/230>
   4:   60                        pusha  
Code;  c01215dd <zap_page_range+39/230>
   5:   f6 2b                     imulb  (%ebx)
Code;  c01215df <zap_page_range+3b/230>
   7:   c0 89 cd 89 5c 24 28      rorb   $0x28,0x245c89cd(%ecx)
Code;  c01215e6 <zap_page_range+42/230>
   e:   8b 44 24 30               mov    0x30(%esp,1),%eax
Code;  c01215ea <zap_page_range+46/230>
  12:   89 44 00 00               mov    %eax,0x0(%eax,%eax,1)


1 warning issued.  Results may not be reliable.

-- 
==============================|   "A microscope locked in on one point
 Rob Funk <rfunk@funknet.net> |Never sees what kind of room that it's in"
 http://www.funknet.net/rfunk |    -- Chris Mars, "Stuck in Rewind"
