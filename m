Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270108AbTGUODI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270109AbTGUODI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:03:08 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:34181 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S270108AbTGUOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:02:59 -0400
Date: Mon, 21 Jul 2003 16:17:57 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
Message-Id: <20030721161757.5dec00fb.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030721161226.44a95db7.us15@os.inf.tu-dresden.de>
References: <20030721161226.44a95db7.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.:,UIZ+R(htlk(1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:,UIZ+R(htlk(1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2003 16:12:26 +0200 Udo A. Steinberg (UAS) wrote:

UAS> We have a Dual-Xeon machine with Hyperthreading which keeps locking up hard,
UAS> so that not even Sysrq works anymore. I have captured such a lockup using the
UAS> NMI oopser. Below you'll find the lockup fed through ksymoops. Note that
UAS> after CPU3 locked up, CPU2 did too. But that lockup couldn't be captured
UAS> anymore. Kernel is a monolithic 2.4.22-pre6. Problem also happened on
UAS> plain 2.4.21. I can provide more information wrt. hardware, config etc.
UAS> on request.

Sorry, I used the wrong System.map. Below is the fixed decode. Looks like
the lockup is caused by the 3rd party Compushack FDDI driver.

Regards,
-Udo.


ksymoops 2.4.9 on i686 2.4.22-pre6.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre6/ (default)
     -m /boot/System.map-2.4.22 (specified)

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


>>EIP; c01f8364 <.text.lock.csfddi+39/55>   <=====

>>edx; c01f5d20 <csfddi_timer_work+0/e0>

Trace; c0105cfa <__switch_to+ca/d0>
Trace; c011f8da <__run_task_queue+6a/80>
Trace; c0122cfd <immediate_bh+1d/20>
Trace; c011f7f5 <bh_action+45/70>
Trace; c011f6a3 <tasklet_hi_action+63/b0>
Trace; c011f456 <do_softirq+d6/e0>
Trace; c011f9b5 <ksoftirqd+c5/f0>
Trace; c0105000 <_stext+0/0>
Trace; c01058ee <arch_kernel_thread+2e/40>
Trace; c011f8f0 <ksoftirqd+0/f0>

Code;  c01f8364 <.text.lock.csfddi+39/55>
00000000 <_EIP>:
Code;  c01f8364 <.text.lock.csfddi+39/55>   <=====
   0:   7e f5                     jle    fffffff7 <_EIP+0xfffffff7>   <=====
Code;  c01f8366 <.text.lock.csfddi+3b/55>
   2:   e9 e8 d9 ff ff            jmp    ffffd9ef <_EIP+0xffffd9ef>
Code;  c01f836b <.text.lock.csfddi+40/55>
   7:   80 3d 40 be 2e c0 00      cmpb   $0x0,0xc02ebe40
Code;  c01f8372 <.text.lock.csfddi+47/55>
   e:   f3 90                     repz nop 
Code;  c01f8374 <.text.lock.csfddi+49/55>
  10:   7e f5                     jle    7 <_EIP+0x7>
Code;  c01f8376 <.text.lock.csfddi+4b/55>
  12:   e9 db 00 00 00            jmp    f2 <_EIP+0xf2>

 NMI Watchdog detected LOCKUP on CPU2, eip c01062cd, registers:

--=.:,UIZ+R(htlk(1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/G/YVnhRzXSM7nSkRAm6zAJ9FsjeJGpVJytNoUF27d3x+jjKd2wCdERh5
boxpHp4wb/CMcS1iu1ep4Bw=
=I+d3
-----END PGP SIGNATURE-----

--=.:,UIZ+R(htlk(1--
