Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbSJKIaw>; Fri, 11 Oct 2002 04:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSJKIaw>; Fri, 11 Oct 2002 04:30:52 -0400
Received: from satan.intac.net ([199.173.52.34]:60687 "EHLO source.intac.net")
	by vger.kernel.org with ESMTP id <S262369AbSJKIau>;
	Fri, 11 Oct 2002 04:30:50 -0400
Date: Fri, 11 Oct 2002 04:34:03 -0400 (EDT)
From: kernellist@source.intac.net
To: linux-kernel@vger.kernel.org
Subject: Weird kernel behavior on  2.4.18-5.2smp (kernel kills process and
 cant bind to port)
Message-ID: <Pine.LNX.4.21.0210110418290.31903-100000@source.intac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a process that listens on port 81. The past few days the process
has been killed by the kernel, but the port never frees up. fuser shows
nothing listening:

[root@xxxx root]# /sbin/fuser -n tcp 81
[root@xxxx root]# echo $?
1

Output from netstat -ln:

tcp        0      0 *:81                    *:*                     LISTEN  


When my process gets killed by the kernel, I get an oops, and nothing is
listening nor running on that port. Oops message is below. The process is
Apache modperl server that listens on port 81. 

Does anyone know what the oops mean? Or how can I get the kernel to see
that the port is free/available after the kernel kills the root modperl
process so I can restart my server? If it helps,
the only difference on this box from hundreds of others in production is
that this one also runs a local mysql install (on standard mysql port
3306). Right now the only way for me to get the modperl server back up and
running is a reboot. Anyway for me to at least make the kernel see that
nothing is listening so I can restart my modperl server without needing to
reboot?

2.4.18-5.2smp #1 SMP Thu Jul 11 11:51:49 EDT 2002 i686 unknown


Out of Memory: Killed process 24511 (httpd).
Unable to handle kernel paging request at virtual address f8973000
 printing eip:
c0107387
*pde = 01e4d067
*pte = 00000000
Oops: 0000
nfs lockd sunrpc 3c59x e100 usb-uhci usbcore ext3 jbd aic7xxx DAC960
sd_mod sc
CPU:    1
EIP:    0010:[<c0107387>]    Not tainted
EFLAGS: 00010286

EIP is at copy_segments [kernel] 0x57 (2.4.18-5.2smp)
eax: f8962000   ebx: f8962000   ecx: 00004000   edx: f8972000
esi: f8973000   edi: f8962000   ebp: d97db500   esp: cb735f18
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 19151, stackpage=cb735000)
Stack: 00000000 00000000 ec0452c0 ec0452c0 c011ab1d e529e000 d97db500
cb734000 
       00001d29 f5ff9a2c cb734000 ec0452c0 d97db500 00000300 00000001
ee9fa5a0 
       ee9fa400 00000001 f764ea64 f675ea84 e529e000 c011b41a 00000011
e529e000 
Call Trace: [<c011ab1d>] copy_mm [kernel] 0x30d 
[<c011b41a>] do_fork [kernel] 0x4ca 
[<c0107685>] sys_fork [kernel] 0x15 
[<c0108c6b>] system_call [kernel] 0x33 


Code: f3 a5 89 9d 80 00 00 00 b9 ff ff ff ff 89 8d 84 00 00 00 5b 
 <3>Trying to vfree() nonexistent vm area (f8973000)



