Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRJPJZB>; Tue, 16 Oct 2001 05:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJPJYw>; Tue, 16 Oct 2001 05:24:52 -0400
Received: from [195.66.192.167] ([195.66.192.167]:38416 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S275571AbRJPJYo>; Tue, 16 Oct 2001 05:24:44 -0400
Date: Tue, 16 Oct 2001 12:24:11 +0200
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <5913527831.20011016122411@port.imtp.ilyichevsk.odessa.ua>
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Creating files on Samba got weird
In-Reply-To: <Pine.LNX.4.30.0109212125590.1815-200000@cola.teststation.com>
In-Reply-To: <Pine.LNX.4.30.0109212125590.1815-200000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC'ing to lkml in hope on advise why I've got ksymoops error)

Hello Urban,

My Samba server behaves strangely.
Very frequently (but not always) when I try to create/copy
files from win box to linux samba server it says that file/dir
already exists or that connection terminated. It is indeed exists,
in case of a file it is of zero length. Subsequent copy with
overwrite succeeds.

It seems that smbd dies after it has created dir/file but before
reporting this fact to the client. New smbd gets spawned by inetd
then.

It might be related to newer kernel.
I am willing to track it further.

Samba: 2.2.1a
Kernel: 2.4.10

Also I've got two oopses so far. One of them decoded below
(my first ksymoops, I don't know is it done right on not)

--------------------------------------------
ksymoops 2.4.3 on i686 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information....
<snip>

Unable to handle kernel paging request at virtual address 4008e6ed
*pde = 01100067
Oops: 0003
CPU:    0
EIP:    0010:[<c010655b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 4008e76d   ecx: 4008e6cd   edx: 0000e865
esi: 00000000   edi: 00000128   ebp: 4008e6c9   esp: c1c5bf74
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 213, stackpage=c1c5b000)
Stack: 5650faf0 c1c5a000 c029afd0 00000128 c01068d0 4008e6cd 4008e76d c1c5bf94
       c02a23b2 55c3c85e ec83e589 4000bcd9 40015f67 4000bcd9 40015f67 c1c5a000
       00000000 00000000 bfffea74 c0107603 00000000 bfffe6a3 00000001 00000000
Call Trace: [<c01068d0>] [<c0107603>]
Code: 89 51 20 31 c0 66 8b 53 0c 81 e2 ff ff 00 00 09 c6 89 51 1c
Error (Oops_bfd_perror): set_section_contents Section has no contents

>>EIP; c010655a <restore_sigcontext+3a/140>   <=====
Trace; c01068d0 <sys_rt_sigreturn+110/180>
Trace; c0107602 <system_call+32/40>

1 warning and 1 error issued.  Results may not be reliable.
--
Best regards, vda
mailto:vda@port.imtp.ilyichevsk.odessa.ua


