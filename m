Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269306AbTCDOvy>; Tue, 4 Mar 2003 09:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269338AbTCDOvy>; Tue, 4 Mar 2003 09:51:54 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:44068 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S269306AbTCDOvx>; Tue, 4 Mar 2003 09:51:53 -0500
Date: Tue, 4 Mar 2003 15:51:49 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <32979.4.64.238.61.1046569101.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.30.0303041520430.21999-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 1 Mar 2003, Randy.Dunlap wrote:

> This is plain vanilla 2.5.63.

Ditto, no modules enabled, gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-2mdk)

> The NTFS filesystem is mounted and I tried to cd several levels
> deep into it...and voila.

I guess it's not reproducible. I couldn't.

> Mar  1 13:35:44 midway kernel: Unable to handle kernel paging request at
> virtual address 0001029a
> Mar  1 13:35:44 midway kernel: *pde = 00000000
> Mar  1 13:35:44 midway kernel: Oops: 0002
> Mar  1 13:35:44 midway kernel: CPU:    0
> Mar  1 13:35:44 midway kernel: EIP:    0060:[__ntfs_init_inode+169/400]    Not
> tainted
> Mar  1 13:35:44 midway kernel: EIP:    0060:[<c01f40f9>]    Not tainted
> Mar  1 13:35:44 midway kernel: EFLAGS: 00010282
> Mar  1 13:35:44 midway kernel: EIP is at __ntfs_init_inode+0xa9/0x190
> Mar  1 13:35:44 midway kernel: eax: f6c0f080   ebx: 0000416d   ecx: 00010282
> edx: f6c0f0f8
> Mar  1 13:35:44 midway kernel: esi: c040b078   edi: f6c0f0f8   ebp: f6dd1dbc
> esp: f6dd1db4
> Mar  1 13:35:44 midway su(pam_unix)[1839]: session closed for user root
> Mar  1 13:35:44 midway kernel: ds: 007b   es: 007b   ss: 0068

[...]

> Mar  1 13:35:44 midway kernel: Code: 89 51 18 89 51 1c 31 f6 31 c9 89 b0 80 00
> 00 00 31 f6 31 d2

   0:   89 51 18                  mov    %edx,0x18(%ecx)
   3:   89 51 1c                  mov    %edx,0x1c(%ecx)

The only potential match is in this part of __ntfs_init_inode (gcc
3.2.2 generates totally different and overall 50% less code for
__ntfs_init_inode):

        ni->seq_no = 0;
        atomic_set(&ni->count, 1);

However neither the above machine code nor the edx and ecx values are
correct. How reliable is the oopser? What compiler did you use? Could
you disassemble __ntfs_init_inode?

	gdb fs/ntfs/ntfs.o
	gdb> disassemble __ntfs_init_inode

    Szaka


