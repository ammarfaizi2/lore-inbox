Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUDDPwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUDDPwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:52:33 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:43729 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262448AbUDDPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:52:25 -0400
From: Matthias Juchem <lists@konfido.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25: kernel BUG at inode.c:334
Date: Sun, 4 Apr 2004 17:52:08 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_58CcAWD57S5Tzta";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404041752.25721.lists@konfido.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_58CcAWD57S5Tzta
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

Hi there.

I am using 2.4.25 and get the following bug approximately once a week:

Apr  3 08:34:52 xxxxxx kernel: kernel BUG at inode.c:334!
Apr  3 08:34:52 xxxxxx kernel: invalid operand: 0000
Apr  3 08:34:52 xxxxxx kernel: CPU:    0
Apr  3 08:34:52 xxxxxx kernel: EIP:    0010:[try_to_sync_unused_inodes+154/464]    Not tainted
Apr  3 08:34:52 xxxxxx kernel: EIP:    0010:[<c01ca6aa>]    Not tainted
Apr  3 08:34:52 xxxxxx kernel: EFLAGS: 00010202
Apr  3 08:34:52 xxxxxx kernel: eax: db58f064   ebx: 00000009   ecx: db58f064   edx: db58f000
Apr  3 08:34:52 xxxxxx kernel: esi: e50f9680   edi: 00000061   ebp: db58f05c   esp: f7e7bf38
Apr  3 08:34:52 xxxxxx kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 08:34:52 xxxxxx kernel: Process keventd (pid: 2, stackpage=f7e7b000)
Apr  3 08:34:52 xxxxxx kernel: Stack: db58f000 d6566000 d6566000 de4c2180 d6567de0 c0195c56 f7e7bf84 00000000
Apr  3 08:34:52 xxxxxx kernel:        f7e7a000 f7e7bf74 f7e7bf74 f7e7a568 f7e7a000 c019c8d9 00000000 c0153598
Apr  3 08:34:52 xxxxxx kernel:        c0153598 00000000 00000000 c01a4b91 c0102c20 0000000a f7e7a560 f7e7a570
Apr  3 08:34:52 xxxxxx kernel: Call Trace:    [schedule+774/816] [__run_task_queue+73/96] [context_thread+289/432] [context_thread+0/432] [arch_kernel_thread+38/48]
Apr  3 08:34:52 xxxxxx kernel: Call Trace:    [<c0195c56>] [<c019c8d9>] [<c01a4b91>] [<c01a4a70>] [<c01871e6>]
Apr  3 08:34:52 xxxxxx kernel:   [context_thread+0/432]
Apr  3 08:34:52 xxxxxx kernel:   [<c01a4a70>]
Apr  3 08:34:52 xxxxxx kernel:
Apr  3 08:34:52 xxxxxx kernel: Code: 0f 0b 4e 01 c6 7c 2a c0 89 d8 83 c8 08 83 e0 f8 89 86 08 01

>>EIP; c01ca6aa <try_to_sync_unused_inodes+9a/1d0>   <=====
Trace; c0195c56 <schedule+306/330>
Trace; c019c8d9 <__run_task_queue+49/60>
Trace; c01a4b91 <context_thread+121/1b0>
Trace; c01a4a70 <context_thread+0/1b0>
Trace; c01871e6 <arch_kernel_thread+26/30>
Trace; c01a4a70 <context_thread+0/1b0>
Code;  c01ca6aa <try_to_sync_unused_inodes+9a/1d0>
00000000 <_EIP>:
Code;  c01ca6aa <try_to_sync_unused_inodes+9a/1d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01ca6ac <try_to_sync_unused_inodes+9c/1d0>
   2:   4e                        dec    %esi
Code;  c01ca6ad <try_to_sync_unused_inodes+9d/1d0>
   3:   01 c6                     add    %eax,%esi
Code;  c01ca6af <try_to_sync_unused_inodes+9f/1d0>
   5:   7c 2a                     jl     31 <_EIP+0x31> c01ca6db <try_to_sync_unused_inodes+cb/1d0>
Code;  c01ca6b1 <try_to_sync_unused_inodes+a1/1d0>
   7:   c0 89 d8 83 c8 08 83      rorb   $0x83,0x8c883d8(%ecx)
Code;  c01ca6b8 <try_to_sync_unused_inodes+a8/1d0>
   e:   e0 f8                     loopne 8 <_EIP+0x8> c01ca6b2 <try_to_sync_unused_inodes+a2/1d0>
Code;  c01ca6ba <try_to_sync_unused_inodes+aa/1d0>
  10:   89 86 08 01 00 00         mov    %eax,0x108(%esi)

The filesystems used are:

/dev/hda1 on / type ext3 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda4 on /home type ext2 (rw,usrquota)
none on /dev/shm type tmpfs (rw)
/dev/hda2 on /var type ext3 (rw)


The server does not hang, but of course it has some serious problems.
I do not know how the bug is triggered.
The server is used for some network services which usually do not cause a heavy load.

If you need further information, please ask.

Please CC me on any replies as I'm not subscribed to LKML.

TIA,
 Matthias


--Boundary-02=_58CcAWD57S5Tzta
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAcC85FJbl3HvkyPURAoOyAJ9MZaEdMOW9aUTLkiEGbWyq/lUSjgCfaDhO
HkmaTqBCGZ70zzNSQTffySM=
=puDe
-----END PGP SIGNATURE-----

--Boundary-02=_58CcAWD57S5Tzta--

