Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSCWBQt>; Fri, 22 Mar 2002 20:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCWBPc>; Fri, 22 Mar 2002 20:15:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292857AbSCWBPU>;
	Fri, 22 Mar 2002 20:15:20 -0500
Date: Fri, 22 Mar 2002 23:36:13 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: bvermeul@devel.blackstar.nl
cc: linux-kernel@vger.kernel.org, <green@namesys.com>
Subject: Re: oops mounting reiserFS with 2.5.7
In-Reply-To: <Pine.LNX.4.33.0203221427040.23476-100000@devel.blackstar.nl>
Message-ID: <Pine.LNX.4.44.0203222333290.17485-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the patch Oleg sent me (see lkml archive), it works
very well now.
for my needs reiserFS is just optimal, also in production environment.
more, I use reiserFS on sparc64 and alpha CPUs, and I see
it works very well with high load on 64 bit CPUs.

Luigi

On Fri, 22 Mar 2002 bvermeul@devel.blackstar.nl wrote:

> Hi,
>
> I've seen the same on an Athlon 700 MHz with 1.2 GB of memory.
> 2.4.12-ac5 could read it just fine.
>
> I can't test or reproduce, since I've since replaced reiserfs with ext3
> on that box.
>
> Bas Vermeulen
>
> > here is the oops i get mounting reiserFS filesystem with kernel 2.5.7,
> > just after the message:
> >
> > found reiserfs format "3.6" with standard journal
> >
> >
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000010
> > c013415a
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c013415a>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010282
> > eax: 00001000   ebx: 0000000f   ecx: 00000009   edx: 00002012
> > esi: 00000009   edi: 00002012   ebp: 00000000   esp: df97fd94
> > ds: 0018   es: 0018   ss: 0018
> > Stack: 00001000 00002012 00000000 df80b000 df80b000 c0134858 00000000 00002012
> >        00001000 df80b000 e08a7000 e08b83ec c0134a97 00000000 00002012 00001000
> >        df80b000 c017b30c 00000000 00002012 00001000 00000811 00000000 df80b154
> > Call Trace: [<c0134858>] [<c0134a97>] [<c017b30c>] [<c01338b0>] [<c016d439>]
> >    [<c016dd4c>] [<c01858a4>] [<c01393e1>] [<c0137fa0>] [<c016e13f>] [<c016dc20>]
> >    [<c01381a0>] [<c0149679>] [<c0149960>] [<c014979d>] [<c0149d84>] [<c0107047>]
> > Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10
> >
> >
> > >>EIP; c013415a <__get_hash_table+1a/c0>   <=====
> >
> > >>eax; 00001000 Before first symbol
> > >>edx; 00002012 Before first symbol
> > >>edi; 00002012 Before first symbol
> > >>esp; df97fd94 <_end+1f6aa7e8/2052ca54>
> >
> > Trace; c0134858 <__getblk+18/40>
> > Trace; c0134a97 <__bread+17/70>
> > Trace; c017b30c <journal_init+dc/690>
> > Trace; c01338b0 <__wait_on_buffer+80/90>
> > Trace; c016d439 <read_bitmaps+c9/160>
> > Trace; c016dd4c <reiserfs_fill_super+12c/4b0>
> > Trace; c01858a4 <sprintf+14/20>
> > Trace; c01393e1 <bdevname+31/3a>
> > Trace; c0137fa0 <get_sb_bdev+1e0/250>
> > Trace; c016e13f <reiserfs_get_sb+1f/30>
> > Trace; c016dc20 <reiserfs_fill_super+0/4b0>
> > Trace; c01381a0 <do_kern_mount+50/d0>
> > Trace; c0149679 <do_add_mount+69/140>
> > Trace; c0149960 <do_mount+170/190>
> > Trace; c014979d <copy_mount_options+4d/a0>
> > Trace; c0149d84 <sys_mount+a4/110>
> > Trace; c0107047 <syscall_call+7/b>
> >
> > Code;  c013415a <__get_hash_table+1a/c0>
> > 00000000 <_EIP>:
> > Code;  c013415a <__get_hash_table+1a/c0>   <=====
> >    0:   0f b7 45 10               movzwl 0x10(%ebp),%eax   <=====
> > Code;  c013415e <__get_hash_table+1e/c0>
> >    4:   b0 00                     mov    $0x0,%al
> > Code;  c0134160 <__get_hash_table+20/c0>
> >    6:   66 0f b6 55 10            movzbw 0x10(%ebp),%dx
> > Code;  c0134165 <__get_hash_table+25/c0>
> >    b:   01 d0                     add    %edx,%eax
> > Code;  c0134167 <__get_hash_table+27/c0>
> >    d:   0f b7 c0                  movzwl %ax,%eax
> > Code;  c013416a <__get_hash_table+2a/c0>
> >   10:   89 44 24 10               mov    %eax,0x10(%esp,1)
> >
> >
> > The hardware is an AMD Athlon 1300 Mhz 200 MhzFSB,
> > MB Abit KT133A (via chipset), with 512MB RAM,
> > and three scsi disks on an adaptec 2940,
> >
> > kernel is compiled with gcc 2.95.3 and binutils 2.12.90.0.1
> >
> > This oops is coerent with the message i get booting
> > a Pentium III 1Ghz on i810 chipset,
> > at less seeing the EIP (rootfs is reiserFS, and i could not
> > save the oops).
> >
> > I am willing to test any patch.
> >
> > Hope this helps
> >
> > Luigi
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> "God, root, what is difference?"
> 	-- Pitr, User Friendly
>
> "God is more forgiving."
> 	-- Dave Aronson
>

