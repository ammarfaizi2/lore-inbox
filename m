Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRLKQIQ>; Tue, 11 Dec 2001 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281707AbRLKQIH>; Tue, 11 Dec 2001 11:08:07 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:22952 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S281691AbRLKQH4> convert rfc822-to-8bit; Tue, 11 Dec 2001 11:07:56 -0500
Message-Id: <sc15cce2.030@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Tue, 11 Dec 2001 09:07:38 -0700
From: "Tyler BIRD" <BIRDTY@uvsc.edu>
To: <joy@empexis.com>, <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <bobp@savemail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Upgrade to 2.4.16 produces "Kernel panic: No init found"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lilo might be configured to load a initial ramdisk
check for a initrd=xxx line in lilo.conf and remove it.

Then make sure all drivers including scsi, etc are compiled in and reboot
pivot_root is a routine that changes the root filesystem that is on the ramdisk
to the newly mounted filesystem from the hardisk

This will definetly fail if the initrd couldn't be loaded din the first place

>>> Joy Almacen <joy@empexis.com> 12/11/01 06:10AM >>>
Bob,

I have a similar problem.  My distro is RH7.1 and running on aCompaq Proliant
6000.
The original install boots fine, but is only running on UP not SMP. I grabbed
the
latest kernel from RH site and the upgraded utilities, SysVinit and all.
I even compiled into the kernel the scsi_mod and sd_mod as well as my
SCSI card driver sym53c8xx but to no avail.  It seems that for this
pivot_root
call wont work if you do not have dev and loop compiled into the kernel.
I will recompile the kernel with both selected to find out if this is true.

So far however, I have tried both:

1. Creating an initrd for my kernel version that has SCSI drivers as modules,

2. Compiling the drivers into the kernel with basically the same results, the
kernel panicking either
it can not mount the root file system( which is still ext2) or no init being
found.

See the docs on initrd fro your kernel  as you amy have to change your
lilo.conf
to pass parameters to the kernel thru "append" depending on whether you have
devfs support enabled or not.

I have been trying to fix this for 3 days now and have , like you had said "
google'd myself silly".

I  will let you know if I get any luck booting.

I would also appreciate it if you can let me know if you have a known fix or
at least the issue that's causing
this.

Thanks,

Joy






vda wrote:

> On Monday 10 December 2001 17:41, Bob Poortinga wrote:
> > Hello kernel gurus,
> >
> > I have searched the list archives and google'd myself silly, but I
> > can't seem to find a solution to my problem.
> >
> > I am trying to update my 2.4.3 kernel (Mandrake 8.0 distro) to 2.4.16.
> > I did a 'make oldconfig' with my old .config file and added ext3 kernel
> > support in addition to ext2.  My root fs is ext2 (as are all my fs).
> > The new kernel boots but panics when it tries to mount the root fs.
> > Here is the error:
> > --------------------------------------------------------------------
> > Mounting /proc filesystem
> > Creating root device
> > Mounting root filesystem
> > pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> > Freeing unused kernel memory: 216k freed
> > Kernel panic: No init found.  Try passing init= option to kernel.
>
> Using initrd I guess?
> Please describe your boot process.
>
> Initrd support broke between 2.4.10 and 2.4.12, it does not like romfs and
> minix initrds anymore. I have a testcase.
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at  http://www.tux.org/lkml/ 




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

