Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTLDBKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTLDBKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:10:11 -0500
Received: from adsl-68-78-201-244.dsl.klmzmi.ameritech.net ([68.78.201.244]:32520
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S262868AbTLDBI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:08:27 -0500
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pac1 (and others) issue with PDC20265
Date: Wed, 3 Dec 2003 20:08:01 -0500
User-Agent: KMail/1.5.3
References: <200312031610.34288.tabris@tabris.net>
In-Reply-To: <200312031610.34288.tabris@tabris.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xjoz/6PBh8kc8Ld"
Message-Id: <200312032008.08451.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xjoz/6PBh8kc8Ld
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 03 December 2003 4:10 pm, tabris wrote:
> I have an ASUS A7V266-E motherboard, AMD AthlonXP 1800+ CPU.
> several hard drives of various makes.
>
> I've tested a couple different kernels... all (afaik) with preempt.
> I've tried 2.4.22-10mdk, plus 2.4.23-pac1+preempt+lowlatency, and also
> a 2.4.22-ac4+preempt
>
> What I'm getting are deadlocks on what I think are dma issues when
> copying btwn hdf and hdg.
> according to /proc/ide/*/model
> hda is a WDC AC28400R
> hdb is a Maxtor 93652U8
> hde is a WDC WD200BB-32BSA0
> hdf is a Maxtor 4D060H3
> hdg is a Maxtor 4D060H3 (just installed today, likely used)
>

Ok, with some advice, I reorganized to...
hda is a WDC AC28400R - reiserfs
hdb is a Maxtor 93652U8 - reiserfs
=2E
hdf is a Maxtor 4D060H3 - reiserfs
hdg is a Maxtor 4D060H3 (just installed today, likely used) - xfs
=2E
hdh is a WDC WD200BB-32BSA0 - reiserfs

now instead of deadlocks, I got an oops. which is attached, as is the=20
syslog.

=2D --
tabris
who probably has to reboot now.
=2D -
The problem with this country is that there is no death penalty for
incompetence.
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zoj21U5ZaPMbKQcRAqkeAKCD6k95rJJcNXJGp5bzPMCWaFNIdACghRwg
THwZDggMRqQu1YMKUATFnuI=3D
=3D4Wzg
=2D----END PGP SIGNATURE-----

--Boundary-00=_xjoz/6PBh8kc8Ld
Content-Type: text/plain;
  charset="iso-8859-1";
  name="oops-20031203-ksymoops.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oops-20031203-ksymoops.log"

ksymoops 2.4.9 on i686 2.4.23-tab2+jif64.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-tab2+jif64/ (default)
     -m /boot/System.map-2.4.23-tab2+jif64 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Dec  3 19:57:53 tabriel kernel: kernel BUG at prints.c:341!
Dec  3 19:57:53 tabriel kernel: invalid operand: 0000
Dec  3 19:57:53 tabriel kernel: CPU:    0
Dec  3 19:57:53 tabriel kernel: EIP:    0010:[reiserfs_panic+69/128]    Not tainted
Dec  3 19:57:53 tabriel kernel: EIP:    0010:[<c01928a5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  3 19:57:53 tabriel kernel: EFLAGS: 00010286
Dec  3 19:57:53 tabriel kernel: eax: 00000039   ebx: df549c00   ecx: c15a202c   edx: 00000000
Dec  3 19:57:53 tabriel kernel: esi: 00000009   edi: 00000009   ebp: df549c00   esp: c15a3e0c
Dec  3 19:57:53 tabriel kernel: ds: 0018   es: 0018   ss: 0018
Dec  3 19:57:53 tabriel kernel: Process kupdated (pid: 6, stackpage=c15a3000)
Dec  3 19:57:53 tabriel kernel: Stack: c0280611 c032b080 c0329d60 e0a822fc c01a3aaf df549c00 c0291160 e0a82324
Dec  3 19:57:53 tabriel kernel:        c0145eb5 0000000c dee03000 c15a2000 c15a2000 0000000a 00000000 cf515cc0
Dec  3 19:57:53 tabriel kernel:        df549c00 00000008 cef69000 00000000 c01a8620 df549c00 e0a822fc 00000001
Dec  3 19:57:53 tabriel kernel: Call Trace:    [flush_commit_list+1119/1200] [fsync_buffers_list+437/544] [do_journal_end+2064/3072] [get_cnode+122/144] [flush_old_commits+309/464]
Dec  3 19:57:53 tabriel kernel: Call Trace:    [<c01a3aaf>] [<c0145eb5>] [<c01a8620>] [<c01a328a>] [<c01a7555>]
Dec  3 19:57:53 tabriel kernel:   [<c015deb5>] [<c018f230>] [<c0149b79>] [<c0148b64>] [<c0148ebc>] [<c0107562>]
Dec  3 19:57:53 tabriel kernel:   [<c0148de0>] [<c0105000>] [<c010581b>] [<c0148de0>]
Dec  3 19:57:53 tabriel kernel: Code: 0f 0b 55 01 24 06 28 c0 85 db b8 2d 06 28 c0 74 0c 0f b7 43


>>EIP; c01928a5 <reiserfs_panic+45/80>   <=====

>>ebx; df549c00 <_end+1f1fb994/20569df4>
>>ecx; c15a202c <_end+1253dc0/20569df4>
>>ebp; df549c00 <_end+1f1fb994/20569df4>
>>esp; c15a3e0c <_end+1255ba0/20569df4>

Trace; c01a3aaf <flush_commit_list+45f/4b0>
Trace; c0145eb5 <fsync_buffers_list+1b5/220>
Trace; c01a8620 <do_journal_end+810/c00>
Trace; c01a328a <get_cnode+7a/90>
Trace; c01a7555 <flush_old_commits+135/1d0>
Trace; c015deb5 <__sync_one+b5/19a>
Trace; c018f230 <reiserfs_write_super+50/90>
Trace; c0149b79 <sync_supers+159/190>
Trace; c0148b64 <sync_old_buffers+34/d0>
Trace; c0148ebc <kupdate+dc/1c0>
Trace; c0107562 <ret_from_fork+6/20>
Trace; c0148de0 <kupdate+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010581b <arch_kernel_thread+2b/40>
Trace; c0148de0 <kupdate+0/1c0>

Code;  c01928a5 <reiserfs_panic+45/80>
00000000 <_EIP>:
Code;  c01928a5 <reiserfs_panic+45/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01928a7 <reiserfs_panic+47/80>
   2:   55                        push   %ebp
Code;  c01928a8 <reiserfs_panic+48/80>
   3:   01 24 06                  add    %esp,(%esi,%eax,1)
Code;  c01928ab <reiserfs_panic+4b/80>
   6:   28 c0                     sub    %al,%al
Code;  c01928ad <reiserfs_panic+4d/80>
   8:   85 db                     test   %ebx,%ebx
Code;  c01928af <reiserfs_panic+4f/80>
   a:   b8 2d 06 28 c0            mov    $0xc028062d,%eax
Code;  c01928b4 <reiserfs_panic+54/80>
   f:   74 0c                     je     1d <_EIP+0x1d>
Code;  c01928b6 <reiserfs_panic+56/80>
  11:   0f b7 43 00               movzwl 0x0(%ebx),%eax


1 warning issued.  Results may not be reliable.

--Boundary-00=_xjoz/6PBh8kc8Ld
Content-Type: text/plain;
  charset="iso-8859-1";
  name="oops-20031203.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oops-20031203.log"

Dec  3 19:56:50 tabriel kernel: hdh: dma_intr: status=0xd1 { Busy }
Dec  3 19:56:50 tabriel kernel:
Dec  3 19:56:50 tabriel kernel: hdg: DMA disabled
Dec  3 19:56:50 tabriel kernel: hdh: DMA disabled
Dec  3 19:56:50 tabriel kernel: PDC202XX: Secondary channel reset.
Dec  3 19:56:50 tabriel kernel: PDC202XX: Primary channel reset.
Dec  3 19:56:50 tabriel kernel: ide3: reset: master: error (0x00?)
Dec  3 19:57:13 tabriel kernel: hde: dma_timer_expiry: dma status == 0x21
Dec  3 19:57:23 tabriel kernel: hde: error waiting for DMA
Dec  3 19:57:23 tabriel kernel: hde: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }
Dec  3 19:57:23 tabriel kernel:
Dec  3 19:57:23 tabriel kernel: hde: status timeout: status=0xd0 { Busy }
Dec  3 19:57:23 tabriel kernel:
Dec  3 19:57:23 tabriel kernel: PDC202XX: Primary channel reset.
Dec  3 19:57:23 tabriel kernel: PDC202XX: Secondary channel reset.
Dec  3 19:57:23 tabriel kernel: hde: drive not ready for command
Dec  3 19:57:23 tabriel kernel: ide2: reset: master: error (0x00?)
Dec  3 19:57:23 tabriel kernel: blk: queue c0344f58, I/O limit 4095Mb (mask 0xffffffff)
Dec  3 19:57:33 tabriel kernel: hdh: lost interrupt
Dec  3 19:57:43 tabriel kernel: hdh: lost interrupt
Dec  3 19:57:43 tabriel kernel: hde: dma_timer_expiry: dma status == 0x21
Dec  3 19:57:53 tabriel kernel: hdh: lost interrupt
Dec  3 19:57:53 tabriel kernel: hde: error waiting for DMA
Dec  3 19:57:53 tabriel kernel: hde: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }
Dec  3 19:57:53 tabriel kernel:
Dec  3 19:57:53 tabriel kernel: hde: status timeout: status=0xd0 { Busy }
Dec  3 19:57:53 tabriel kernel:
Dec  3 19:57:53 tabriel kernel: PDC202XX: Primary channel reset.
Dec  3 19:57:53 tabriel kernel: PDC202XX: Secondary channel reset.
Dec  3 19:57:53 tabriel kernel: hde: drive not ready for command
Dec  3 19:57:53 tabriel kernel: ide2: reset: master: error (0x00?)
Dec  3 19:57:53 tabriel kernel: end_request: I/O error, dev 21:01 (hde), sector 25120
Dec  3 19:57:53 tabriel kernel: journal-615: buffer write failed
Dec  3 19:57:53 tabriel kernel:  (device ide2(33,1))
Dec  3 19:57:53 tabriel kernel: kernel BUG at prints.c:341!
Dec  3 19:57:53 tabriel kernel: invalid operand: 0000
Dec  3 19:57:53 tabriel kernel: CPU:    0
Dec  3 19:57:53 tabriel kernel: EIP:    0010:[reiserfs_panic+69/128]    Not tainted
Dec  3 19:57:53 tabriel kernel: EIP:    0010:[<c01928a5>]    Not tainted
Dec  3 19:57:53 tabriel kernel: EFLAGS: 00010286
Dec  3 19:57:53 tabriel kernel: eax: 00000039   ebx: df549c00   ecx: c15a202c   edx: 00000000
Dec  3 19:57:53 tabriel kernel: esi: 00000009   edi: 00000009   ebp: df549c00   esp: c15a3e0c
Dec  3 19:57:53 tabriel kernel: ds: 0018   es: 0018   ss: 0018
Dec  3 19:57:53 tabriel kernel: Process kupdated (pid: 6, stackpage=c15a3000)
Dec  3 19:57:53 tabriel kernel: Stack: c0280611 c032b080 c0329d60 e0a822fc c01a3aaf df549c00 c0291160 e0a82324
Dec  3 19:57:53 tabriel kernel:        c0145eb5 0000000c dee03000 c15a2000 c15a2000 0000000a 00000000 cf515cc0
Dec  3 19:57:53 tabriel kernel:        df549c00 00000008 cef69000 00000000 c01a8620 df549c00 e0a822fc 00000001
Dec  3 19:57:53 tabriel kernel: Call Trace:    [flush_commit_list+1119/1200] [fsync_buffers_list+437/544] [do_journal_end+2064/3072] [get_cnode+122/144] [flush_old_commits+309/464]
Dec  3 19:57:53 tabriel kernel: Call Trace:    [<c01a3aaf>] [<c0145eb5>] [<c01a8620>] [<c01a328a>] [<c01a7555>]
Dec  3 19:57:53 tabriel kernel:   [__sync_one+181/410] [reiserfs_write_super+80/144] [sync_supers+345/400] [sync_old_buffers+52/208] [kupdate+220/448] [ret_from_fork+6/32]
Dec  3 19:57:53 tabriel kernel:   [<c015deb5>] [<c018f230>] [<c0149b79>] [<c0148b64>] [<c0148ebc>] [<c0107562>]
Dec  3 19:57:53 tabriel kernel:   [kupdate+0/448] [_stext+0/96] [arch_kernel_thread+43/64] [kupdate+0/448]
Dec  3 19:57:53 tabriel kernel:   [<c0148de0>] [<c0105000>] [<c010581b>] [<c0148de0>]
Dec  3 19:57:53 tabriel kernel:
Dec  3 19:57:53 tabriel kernel: Code: 0f 0b 55 01 24 06 28 c0 85 db b8 2d 06 28 c0 74 0c 0f b7 43
Dec  3 19:57:53 tabriel kernel:  <6>note: kupdated[6] exited with preempt_count 1
Dec  3 19:58:03 tabriel kernel: hdh: lost interrupt
Dec  3 19:58:43 tabriel last message repeated 4 times
Dec  3 19:59:53 tabriel last message repeated 7 times
Dec  3 20:00:53 tabriel last message repeated 6 times
Dec  3 20:01:00 tabriel CROND[3017]: (root) CMD (nice -n 19 run-parts /etc/cron.hourly)
Dec  3 20:01:03 tabriel kernel: hdh: lost interrupt
Dec  3 20:01:43 tabriel last message repeated 4 times
Dec  3 20:02:53 tabriel last message repeated 7 times
Dec  3 20:03:33 tabriel last message repeated 4 times
--Boundary-00=_xjoz/6PBh8kc8Ld--

