Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSLOXeO>; Sun, 15 Dec 2002 18:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLOXeN>; Sun, 15 Dec 2002 18:34:13 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:29392 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263256AbSLOXeM>;
	Sun, 15 Dec 2002 18:34:12 -0500
Date: Mon, 16 Dec 2002 00:38:16 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212152338.AAA24823@harpo.it.uu.se>
To: m.c.p@wolk-project.de
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Dec 2002 02:23:34 +0100, Marc-Christian Petersen wrote:
>> Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
>> now hangs during initialisation. 2.2 kernels (with Andre's
>> IDE patch) and 2.4 up to 2.4.20 do not have this problem.
>> My box has a Seagate STT8000A ATAPI tape drive as hdd;
>> hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).
>http://linux.bkbits.net:8080/linux-2.4/patch@1.828?nav=index.html|ChangeSet@-7d|cset@1.828

Addendum: this patch fixes the init-time hang, and ide-tape does
seem to work fine, but 'rmmod ide-tape' oopses -- 2.4.20-ac2 also
oopses on 'rmmod ide-tape'.

/Mikael

Unable to handle kernel NULL pointer dereference at virtual address 000000c4
d08a8048
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d08a8048>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: c0241ea0   edx: 00000128
esi: 00000014   edi: d08aa9c0   ebp: bfffeb08   esp: ce825f88
ds: 0018   es: 0018   ss: 0018
Process rmmod.old (pid: 614, stackpage=ce825000)
Stack: d08a1000 fffffff0 d08a1000 c0116a53 d08a1000 fffffff0 ce7d5000 bfffeb08 
       c0115ef7 d08a1000 00000000 ce824000 bffffc85 00000001 c0106c17 bffffc85 
       08060ac8 00000100 bffffc85 00000001 bfffeb08 00000081 0000002b 0000002b 
Call Trace:    [<c0116a53>] [<c0115ef7>] [<c0106c17>]
Code: 8b 83 c4 00 00 00 85 c0 74 0e 68 a4 a8 8a d0 50 e8 1f ce 8d 


>>EIP; d08a8048 <END_OF_CODE+8be8/????>   <=====

>>ecx; c0241ea0 <chrdevs+0/7f8>
>>edi; d08aa9c0 <END_OF_CODE+b560/????>
>>ebp; bfffeb08 Before first symbol
>>esp; ce825f88 <_end+e5c4db8/10620e90>

Trace; c0116a53 <free_module+17/98>
Trace; c0115ef7 <sys_delete_module+f3/1b0>
Trace; c0106c17 <system_call+33/38>

Code;  d08a8048 <END_OF_CODE+8be8/????>
00000000 <_EIP>:
Code;  d08a8048 <END_OF_CODE+8be8/????>   <=====
   0:   8b 83 c4 00 00 00         mov    0xc4(%ebx),%eax   <=====
Code;  d08a804e <END_OF_CODE+8bee/????>
   6:   85 c0                     test   %eax,%eax
Code;  d08a8050 <END_OF_CODE+8bf0/????>
   8:   74 0e                     je     18 <_EIP+0x18>
Code;  d08a8052 <END_OF_CODE+8bf2/????>
   a:   68 a4 a8 8a d0            push   $0xd08aa8a4
Code;  d08a8057 <END_OF_CODE+8bf7/????>
   f:   50                        push   %eax
Code;  d08a8058 <END_OF_CODE+8bf8/????>
  10:   e8 1f ce 8d 00            call   8dce34 <_EIP+0x8dce34>
