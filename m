Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270104AbTGUN5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270109AbTGUN5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:57:52 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:24709 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S270104AbTGUN5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:57:35 -0400
Date: Mon, 21 Jul 2003 16:12:26 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: CPU Lockup with 2.4.21 and 2.4.22-pre
Message-Id: <20030721161226.44a95db7.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.6ZAXnWEM,+7Ggh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.6ZAXnWEM,+7Ggh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi all,

We have a Dual-Xeon machine with Hyperthreading which keeps locking up hard,
so that not even Sysrq works anymore. I have captured such a lockup using the
NMI oopser. Below you'll find the lockup fed through ksymoops. Note that
after CPU3 locked up, CPU2 did too. But that lockup couldn't be captured
anymore. Kernel is a monolithic 2.4.22-pre6. Problem also happened on
plain 2.4.21. I can provide more information wrt. hardware, config etc.
on request.

Regards,
-Udo.


ksymoops 2.4.9 on i686 2.4.22-pre6.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre6/ (default)
     -m /boot/System.map-2.4.21 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
NMI Watchdog detected LOCKUP on CPU3, eip c01f8364, registers:
CPU:    3
EIP:    0010:[<c01f8364>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000082
eax: 00000006   ebx: 00000202   ecx: f7ee3400   edx: c01f5d20
esi: f7ee3400   edi: 00000180   ebp: 00000003   esp: f7efff64
ds: 0018   es: 0018   ss: 0018
Process ksoftirqd_CPU3 (pid: 6, stackpage=f7eff000)
Stack: f7ee3428 c02d03e6 c0105cfa f6dae000 f7e4ac80 f7efff88 f7efff88 c011f8da 
       f7ee3400 f7ee34ac f7ee34ac c0393434 00000000 c0122cfd c02ebe1c c011f7f5 
       c011f6a3 00000009 00000001 c0367a00 fffffffe c011f456 c0367a00 00000246 
Call Trace:    [<c0105cfa>] [<c011f8da>] [<c0122cfd>] [<c011f7f5>] [<c011f6a3>]
  [<c011f456>] [<c011f9b5>] [<c0105000>] [<c01058ee>] [<c011f8f0>]
Code: 7e f5 e9 e8 d9 ff ff 80 3d 40 be 2e c0 00 f3 90 7e f5 e9 db 


>>EIP; c01f8364 <pcibios_lookup_irq+194/370>   <=====

>>edx; c01f5d20 <restore_i387+70/1a0>

Trace; c0105cfa <ext2_file_operations+3a/60>
Trace; c011f8da <unix_stream_ops+1a/60>
Trace; c0122cfd <init_tss+7fd/2000>
Trace; c011f7f5 <arpt_sockopts+15/40>
Trace; c011f6a3 <required_len.1+23/60>
Trace; c011f456 <info.0+76/140>
Trace; c011f9b5 <unix_table+15/60>
Trace; c0105000 <proc_mem_inode_operations+20/60>
Trace; c01058ee <nibblemap+e/40>
Trace; c011f8f0 <unix_stream_ops+30/60>

Code;  c01f8364 <pcibios_lookup_irq+194/370>
00000000 <_EIP>:
Code;  c01f8364 <pcibios_lookup_irq+194/370>   <=====
   0:   7e f5                     jle    fffffff7 <_EIP+0xfffffff7>   <=====
Code;  c01f8366 <pcibios_lookup_irq+196/370>
   2:   e9 e8 d9 ff ff            jmp    ffffd9ef <_EIP+0xffffd9ef>
Code;  c01f836b <pcibios_lookup_irq+19b/370>
   7:   80 3d 40 be 2e c0 00      cmpb   $0x0,0xc02ebe40
Code;  c01f8372 <pcibios_lookup_irq+1a2/370>
   e:   f3 90                     repz nop 
Code;  c01f8374 <pcibios_lookup_irq+1a4/370>
  10:   7e f5                     jle    7 <_EIP+0x7>
Code;  c01f8376 <pcibios_lookup_irq+1a6/370>
  12:   e9 db 00 00 00            jmp    f2 <_EIP+0xf2>

 NMI Watchdog detected LOCKUP on CPU2, eip c01062cd, registers:

--=.6ZAXnWEM,+7Ggh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/G/TMnhRzXSM7nSkRAmd/AJ4zrMIk3TFQBEPRpLKV8H3oh9WbgACbBWgd
WaN2pPFFZDOKZruIdcXS4/4=
=GIbv
-----END PGP SIGNATURE-----

--=.6ZAXnWEM,+7Ggh--
