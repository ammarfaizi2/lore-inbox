Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281404AbRKHDsj>; Wed, 7 Nov 2001 22:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281426AbRKHDs3>; Wed, 7 Nov 2001 22:48:29 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:55698 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281404AbRKHDsO>;
	Wed, 7 Nov 2001 22:48:14 -0500
Message-ID: <3BEA0078.F938623B@pobox.com>
Date: Wed, 07 Nov 2001 19:48:08 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: Robert Love <rml@tech9.net>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: preempt-patch cleared of blame
In-Reply-To: <3BE8B460.A23E1A67@pobox.com> <1005109646.884.0.camel@phantasy> <3BE9A506.82D64AE4@lexus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'd reported a disaster with 2.4.14+preempt,
but I have just reproduced it with 2.4.14
vanilla - (to recap, "dbench 16" hangs the
system hard, it doesn't even respond to
pings, and must be power cycled)

Again, since I am seeing the problem with
2.4.14 vanilla, the preempt patch is NOT at
fault here -

However I am concerned with this latest
twist, as I want linux to be extremely stable,
and this sort of thing is discouraging.

I think there may be a problem with the
compaq smart/2p raid drivers, since
the "do_ida_intr" code keeps showing
up in the oops, and I have not seen a
problem with 2.4.14 on any other system.

I am going to try and reproduce the oops
elsewhere, and hopefuly I will not be able
to - in any event, the oops follows:

Compaq 6500
4XPPRO 200
1.2 GB RAM
compaq "smart" raid controller

-----------------------------------------------------------

ksymoops 2.4.1 on i686 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (default)

case login: Unable to handle kernel NULL pointer dereference at virtual
address
00000000
*pde = 00000000
Oops: 0000
CPU:    3
EIP:    0010:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: f1c29480   ebx: f1ec17e0   ecx: 00000001   edx: f0509540
esi: f7b93fc4   edi: f7bb7000   ebp: 00000001   esp: f569de80
ds: 0018   es: 0018  ss: 0018
Process dbench (pid:1360, stackpage=f569d000)
Stack: c0182b3f f1c29480 00000001 00000012 00004812 00178a3c 00001000
c1abb7c0
       f7bc2ca0 00000003 24000001 0000000b c01089d4 0000000b f7bb7000
f569def8
       f569def8 c0298960 0000000b 00000003 c01089d4 0000000b f569def8
f7bc2ca0
Call Trace:  [<c0182b3f>] [<c01087ce>] [<c01089d4>] [<c0120018>]
[<c0127631>]
[<c0133266>] [<c0132dd0>] [<c0132fce>] [<c0106f66>]
Code: Bad EIP Value.

>>EIP; 00000000 Before first symbol
Trace; c0182b3f <do_ida_intr+20f/280>
Trace; c01087ce <handle_IRQ_event+5e/90>
Trace; c01089d4 <do_IRQ+a4/f0>
Trace; c0120018 <exec_usermodehelper+38/400>
Trace; c0127631 <generic_file_write+4e1/610>
Trace; c0133266 <sys_write+96/d0>
Trace; c0132dd0 <generic_file_llseek+0/b0>
Trace; c0132fce <sys_lseek+be/d0>
Trace; c0106f66 <system_call+2e/38>

 <0> Kernel panic: Aiee, killing interrupt handler!





