Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSCGJVY>; Thu, 7 Mar 2002 04:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293555AbSCGJVP>; Thu, 7 Mar 2002 04:21:15 -0500
Received: from h139n1fls24o900.telia.com ([213.66.143.139]:58078 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S287386AbSCGJVI>;
	Thu, 7 Mar 2002 04:21:08 -0500
Date: Thu, 7 Mar 2002 10:21:50 +0100
From: Voluspa <voluspa@bigfoot.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
Message-Id: <20020307102150.6ea28753.voluspa@bigfoot.com>
In-Reply-To: <Pine.GSO.4.21.0203070329090.24127-100000@weyl.math.psu.edu>
In-Reply-To: <20020307085636.4feb2372.voluspa@bigfoot.com>
	<Pine.GSO.4.21.0203070329090.24127-100000@weyl.math.psu.edu>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002 03:42:32 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:


> > mount() -> -14
> > VFS: Cannot open root device "302" or 03:02
> 
> Bloody hell...  14 is EFAULT.  And that - from sys_mount() called by

Hey, you're talking to pure user land here (but I guess it's meant for the other kernel hackers :-)

> task that has KERNEL_DS as addr_limit.  What options do you pass to kernel
> and what filesystems are compiled in?

No options at all, except what lilo provides:

loke:loke:/proc$ cat cmdline
BOOT_IMAGE=2.4-Linux-test ro root=302 ramdisk=0

(Exchange 2.4-Linux-test with 2.5-Linux-test)

File systems compiled in:

loke:loke:/proc$ cat filesystems 
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   pipefs
nodev   binfmt_misc
        ext2
        minix
        msdos
        vfat
        iso9660
nodev   nfs

Not changed in 2.5 (preempt enabled there shouldn't make a difference)

>  Actually, adding printk("%s\n", p);
> in the same place might give some hints...

I interpret that as printk("mount() -> %d\n", err); can be swapped with printk("%s\n", p); and I'll do that right away. Last compile, then I must rush to work.

Regards,
Mats Johannesson
Sweden
