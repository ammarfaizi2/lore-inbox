Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVD0OhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVD0OhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVD0OhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:37:04 -0400
Received: from aun.it.uu.se ([130.238.12.36]:27795 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261640AbVD0Ogx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:36:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17007.41839.107679.682497@alkaid.it.uu.se>
Date: Wed, 27 Apr 2005 16:36:31 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gcc-4.0: a couple oopses
In-Reply-To: <1114610970l.5419l.0l@werewolf.able.es>
References: <1114610970l.5419l.0l@werewolf.able.es>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon writes:
 > Hi...
 > 
 > I have just built 2.6.12-rc2-mm3 with gcc4 final. I got this couple oopses on boot.
...
 > Apr 27 15:52:44 werewolf kernel: Unable to handle kernel paging request at virtual address 10a316b4
 > Apr 27 15:52:44 werewolf kernel: b011f5d5
 > Apr 27 15:52:44 werewolf kernel: *pde = 00000000
 > Apr 27 15:52:44 werewolf kernel: Oops: 0002 [#1]
 > Apr 27 15:52:44 werewolf kernel: CPU:    0
 > Apr 27 15:52:44 werewolf kernel: EIP:    0060:[do_proc_dointvec_conv+15/58]    Not tainted VLI
 > Apr 27 15:52:44 werewolf kernel: EIP:    0060:[<b011f5d5>]    Not tainted VLI
 > Using defaults from ksymoops -t elf32-i386 -a i386
 > Apr 27 15:52:44 werewolf kernel: EFLAGS: 00010246   (2.6.11-jam14) 
 > Apr 27 15:52:44 werewolf kernel: eax: 00000000   ebx: 00000001   ecx: 10a316b4   edx: ef4eef1c
 > Apr 27 15:52:44 werewolf kernel: esi: a7f5f001   edi: ef4eef03   ebp: 00000001   esp: ef4eeedc
 > Apr 27 15:52:44 werewolf kernel: ds: 007b   es: 007b   ss: 0068
 > Apr 27 15:52:44 werewolf kernel: Stack: b011f8b2 00000001 00000000 00000001 eed6332c 10a316b4 00000001 00000001 
 > Apr 27 15:52:44 werewolf kernel:        00000000 30000000 0000000a ef4eefbc ef507550 a7f5f000 00000001 ef4eef04 
 > Apr 27 15:52:44 werewolf kernel:        00000000 00000000 a7f5f000 a7f5f000 00000001 efd9e8e0 b011f95c a7f5f000 
 > Apr 27 15:52:44 werewolf kernel: Call Trace:
 > Apr 27 15:52:44 werewolf kernel:  [<b011f8b2>] do_proc_dointvec+0x2b2/0x32c
 > Apr 27 15:52:44 werewolf kernel:  [<b011f95c>] proc_dointvec+0x30/0x35
 > Apr 27 15:52:44 werewolf kernel:  [<b011f5c6>] do_proc_dointvec_conv+0x0/0x3a
 > Apr 27 15:52:44 werewolf kernel:  [<b011f311>] do_rw_proc+0x78/0x84
 > Apr 27 15:52:44 werewolf kernel:  [<b011f354>] proc_writesys+0x0/0x24
 > Apr 27 15:52:44 werewolf kernel:  [<b011f373>] proc_writesys+0x1f/0x24
 > Apr 27 15:52:44 werewolf kernel:  [<b0152032>] vfs_write+0x89/0x12a
 > Apr 27 15:52:44 werewolf kernel:  [<b015217e>] sys_write+0x41/0x6a
 > Apr 27 15:52:44 werewolf kernel:  [<b0102993>] sysenter_past_esp+0x54/0x75
 > Apr 27 15:52:44 werewolf kernel: Code: c1 89 d8 ba ff ff 00 00 f0 0f c1 10 0f 85 9a 12 00 00 89 c8 83 c4 0c 5b 5e 5f 5d c3 83 7c 24 04 00 74 0d 8b 00 85 c0 75 18 8b 02 <89> 01 31 c0 c3 8b 09 85 c9 78 13 c7 00 00 00 00 00 89 0a 31 c0 

Old news :-) See:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111425013208085&w=2
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21173

To fix the bug, apply this patch to gcc-4.0.0 final:
http://gcc.gnu.org/cgi-bin/cvsweb.cgi/gcc/gcc/tree-ssa-pre.c.diff?cvsroot=gcc&only_with_tag=gcc-4_0-branch&r1=2.65.4.2&r2=2.65.4.3

/Mikael
