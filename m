Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278556AbRJSRO4>; Fri, 19 Oct 2001 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278558AbRJSROl>; Fri, 19 Oct 2001 13:14:41 -0400
Received: from mail.myrio.com ([63.109.146.2]:38642 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S278556AbRJSRNy>;
	Fri, 19 Oct 2001 13:13:54 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CA79@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Peter Moscatt'" <pmoscatt@yahoo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Can't see IDE CDR-W after compile ?
Date: Fri, 19 Oct 2001 10:14:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you need scsi for CDR.  Frankly, this is one part of the kernel
configuration process that is a mess and hurts normal users pretty badly.
It's embarrassing.  (Distributors like Mandrake can hide the mess from
people until they compile their own kernels.)

See, there are two drivers for IDE CD drives.  One is the normal IDE CDROM
driver built into the IDE driver.  This works for mounting ISO-9660 images
and reading files, but is bad for everything else.  It is the default.  It
has the advantages of not requiring SCSI support, saving some memory, and
being easier to set up.

The other driver is the IDE-SCSI emulation layer.  This works better for
some things, including ripping music CD's.  And, as you have discovered, it
is a requirement for CDR's.  For example, using the IDE-SCSI driver I can
rip audio with my Toshiba DVD drive at 10x speed, but with the "normal IDE"
driver it could not even go at 1x speed.

In my configuration, I access both my CDR and DVD drives with the SCSI
emulation layer.

In the kernel config, I disable normal IDE CD support, turn ON SCSI support,
IDE-SCSI emulation, and turn ON Generic SCSI support and SCSI CD-ROM
support.  You can also use modules for these drivers if you are really short
on memory.

On the kernel command line, you need the "hdc=ide-scsi" parameter.  (Replace
hdc with whatever your CD device actually is.)  This will be set in your
/etc/lilo.conf if you are using LILO as the bootloader, otherwise it will be
in /boot/grub/menu.lst if you are using GRUB as the boot loader. 

Check to see how Mandrake originally set it up and copy that. If you
disabled normal IDE CD support, or just want to use the SCSI driver for both
drives, copy it for both CD drives - something like "hdc=ide-scsi
hdd=ide-scsi".

Then (sigh) you might need to mess around with stuff in your /dev directory,
so the /dev/cdrom is a symbolic link to the right real device. I have mine
set up with symbolic links /dev/cdrom for the DVD and /dev/cdr for the CDR,
with corresponding /mnt/cdrom and /mnt/cdr mountpoints.  You may need to
edit your /etc/fstab as well.

Good luck!  

Torrey


> -----Original Message-----
> From: Peter Moscatt [mailto:pmoscatt@yahoo.com]
> Sent: Friday, October 19, 2001 6:36 AM
> To: Linux Kernel Mailing List
> Subject: Can't see IDE CDR-W after compile ?
> 
> 
> I have recently compiled 2.4.10 onto my Mandrake 8.0
> installation.
> 
> Since then I now can't access my CD burner, but am
> able to mount my normal IDE CDRom.
> 
> As a matter of interest, I disabled the SCSII support
> - do I need to reinstate this option ?
> 
> Pete
> 
>  
