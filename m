Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTH2ITY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTH2ITY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:19:24 -0400
Received: from 148.229-136-217.adsl-fix.skynet.be ([217.136.229.148]:43413
	"EHLO mars2") by vger.kernel.org with ESMTP id S264464AbTH2ITN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:19:13 -0400
From: Frank Dekervel <kervel-uml@drie.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: host kernel crash (null pointer dereference) with skas3 host patch
Date: Fri, 29 Aug 2003 10:19:11 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308201004.21966.kervel-uml@drie.kotnet.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

(i already sent this to uml-devel, but i was advised to send it here too)

i'm trying to make heavy use of UML (coldfusionmx, zope, tomcat, ...) but my 
host kernel already crashed twice (once with 2.4.21 and once with 2.4.22). 
The crash is an oops (null pointer dereference) resulting in dead userland 
(machine still pingable, sysrq-b still works, sysrq-u doesn't work).

The only patch i applied was host-skas3, and i built the kernel with a debian 
woody toolchain.

I was able to write down the output of one oops (the second time, the monitor 
was blanked and i could'nt unblank it anymore but i'm pretty sure it was the 
same crash).

Below is the ksymoopsed output, but it is possible i made a mistake when i 
wrote down the oops output. Reproducing the oops is difficult, the uml's were 
running for several days, and it happent at night when they were almost idle.
The original oops mentions 'Process: linux' but ksymoops didn't output that 
apparently.

Any idea what the bug might be ?

thanks,
greetings,
Frank


unable to handle kernel NULL pointer dereference at virtual address 00000000
 c0149179
*pde = 00000000
Cpu 0
EIP: 0010:[<c014917a>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: d4077190 ecx: d414de28 edx: d40771a0
esi: 00000002   edi: 00000000 ebp: d4077180 esp: d18dff80
ds: 0018 es: 0018 ss: 0018
Stack: c0149048 d18de000 f6ebdf00 00000000 d4077180 c0139ea4 f6ebdf00 00000002
       00000000 00000000 d18de000 00000002 ae043afc ae043a8c 00000002 00000000
       c0108af3 0000002d 00000002 00000000 00000002 ae043afc ae043a8c 00000013
call trace: [<c0149048>] [<c0139ea4>] [<c01089f3>]
Code: 89 10 c6 05 80 6c 37 c0 01 8b 54 24 18 8b 42 08 8b 40 08 8d


>>EIP; c014917a <filldir64+12a/16c>   <=====

>>ebx; d4077190 <END_OF_CODE+13c9f2d4/????>
>>ecx; d414de28 <END_OF_CODE+13d75f6c/????>
>>edx; d40771a0 <END_OF_CODE+13c9f2e4/????>
>>ebp; d4077180 <END_OF_CODE+13c9f2c4/????>
>>esp; d18dff80 <END_OF_CODE+115080c4/????>

Trace; c0149048 <sys_getdents+90/98>
Trace; c0139ea4 <sys_read+5c/100>
Trace; c01089f3 <system_call+33/38>

Code;  c014917a <filldir64+12a/16c>
00000000 <_EIP>:
Code;  c014917a <filldir64+12a/16c>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c014917c <filldir64+12c/16c>
   2:   c6 05 80 6c 37 c0 01      movb   $0x1,0xc0376c80
Code;  c0149183 <filldir64+133/16c>
   9:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c0149187 <filldir64+137/16c>
   d:   8b 42 08                  mov    0x8(%edx),%eax
Code;  c014918a <filldir64+13a/16c>
  10:   8b 40 08                  mov    0x8(%eax),%eax
Code;  c014918d <filldir64+13d/16c>
  13:   8d 00                     lea    (%eax),%eax


