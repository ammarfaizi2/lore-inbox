Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSGKNwH>; Thu, 11 Jul 2002 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317844AbSGKNwG>; Thu, 11 Jul 2002 09:52:06 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:53033 "EHLO
	devil.stev.org") by vger.kernel.org with ESMTP id <S317842AbSGKNwF>;
	Thu, 11 Jul 2002 09:52:05 -0400
Message-ID: <001501c228e2$2356db90$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <E17ScQK-0000ih-00@the-village.bc.nu>
Subject: Re: ATAPI + cdwriter problem
Date: Thu, 11 Jul 2002 14:52:03 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

just while ATAPI + ide-scsi and cd drive are on topic here
might i also add that this bug has always been very easy for me to trigger
in
the 2.4.x series i have never been able todo it in 2.2.x though.

its very easy as in insert slightly scratched cd and do
dd if=/dev/scd1 of=/dev/null bs=8192k
wait until it gets to damage part of the disk and then the following
arrives.

i belive i have read some posts that this has been seem from other people
with
bad media in dvd drives as well.

ksymoops 2.4.1 on i586 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m BEAST-2.4.19-rc1/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
beast login: Unable to handle kernel NULL pointer dereference at virtual
addres8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e5783>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c7a71000   ecx: c0327104   edx: 00000000
esi: 00000001   edi: c13a4fc0   ebp: cb23df58   esp: cb23df44
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 381, stackpage=cb23d000)
Stack: 00000000 c0327294 c13de260 c0327294 00000202 cb23df78 c01cdd11
c0327294
       c01e5700 c0327104 c121db00 04000001 0000000f cb23df98 c010a0bd
0000000f
       c13de260 cb23dfc4 cb23dfc4 0000000f c02f8ae0 cb23dfbc c010a24d
0000000f
Call Trace: [<c01cdd11>] [<c01e5700>] [<c010a0bd>] [<c010a24d>] [<c010c358>]
Code: 8b 72 18 46 89 72 18 8b 55 f0 8b 82 f0 00 00 00 8b 58 04 53

>>EIP; c01e5783 <idescsi_pc_intr+83/290>   <=====
Trace; c01cdd11 <ide_intr+c1/120>
Trace; c01e5700 <idescsi_pc_intr+0/290>
Trace; c010a0bd <handle_IRQ_event+3d/70>
Trace; c010a24d <do_IRQ+7d/c0>
Trace; c010c358 <call_do_IRQ+5/d>
Code;  c01e5783 <idescsi_pc_intr+83/290>
00000000 <_EIP>:
Code;  c01e5783 <idescsi_pc_intr+83/290>   <=====
   0:   8b 72 18                  mov    0x18(%edx),%esi   <=====
Code;  c01e5786 <idescsi_pc_intr+86/290>
   3:   46                        inc    %esi
Code;  c01e5787 <idescsi_pc_intr+87/290>
   4:   89 72 18                  mov    %esi,0x18(%edx)
Code;  c01e578a <idescsi_pc_intr+8a/290>
   7:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
Code;  c01e578d <idescsi_pc_intr+8d/290>
   a:   8b 82 f0 00 00 00         mov    0xf0(%edx),%eax
Code;  c01e5793 <idescsi_pc_intr+93/290>
  10:   8b 58 04                  mov    0x4(%eax),%ebx
Code;  c01e5796 <idescsi_pc_intr+96/290>
  13:   53                        push   %ebx

<0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.



