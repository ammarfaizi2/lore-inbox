Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSGLTSx>; Fri, 12 Jul 2002 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSGLTSw>; Fri, 12 Jul 2002 15:18:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316789AbSGLTSv>; Fri, 12 Jul 2002 15:18:51 -0400
Date: Fri, 12 Jul 2002 15:21:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 'remount' problem
In-Reply-To: <20020712184912.GR8738@clusterfs.com>
Message-ID: <Pine.LNX.3.95.1020712151607.11987A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Andreas Dilger wrote:
[SNIPPED...]

> output).
> 
> On reboot the filesystem is not clean.  Either the kernel is not
> doing what it should to flush the dirty superblock to disk, or the disk
> is lying about having written the superblock to disk.  I would suspect
> the latter on IDE drives, but SCSI drives are usually sane.
> 
> Try adding a sync or two before rebooting, and also checking via
> debugfs after reboot to ensure it is marked dirty when it shouldn't
> be.  You could even add some printk's to ext2_put_super() inside the
> conditional where it marks the filesystem clean and syncs the super
> to ensure that is being called.
> 
> > # umount -a
> > umount: /mnt: device is busy
> 
> What about the above message?

That's because I have a floppy (with typescript) mounted rw on
/mnt and the file is still open (that's how these messages are
recorded).

> 
> The fact that /dev/sda1 is your root fs could cause some strangeness also.
> 
> It would appear to be that ext2_remount() is missing "sb->s_flags |=
> MS_RDONLY" after the comment "set the rdonly flag and then mark the
> partition as valid again".  The other check for valid flags also appears
> to be a bit suspect.
> 

I will look around a bit. This only happens when one remounts an
already-mounted file-system, then dismounts it. Normally everything
is clean. This is not something that would normally happen.  Oh... I
forgot... This is a SMP machine

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.574
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.574
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90


> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/
> 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

