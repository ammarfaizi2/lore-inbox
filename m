Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRALP4D>; Fri, 12 Jan 2001 10:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131965AbRALPzy>; Fri, 12 Jan 2001 10:55:54 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:23433 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S131512AbRALPzo>;
	Fri, 12 Jan 2001 10:55:44 -0500
Date: Fri, 12 Jan 2001 16:55:49 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Stephen Torri <s.torri@lancaster.ac.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux booting from HD on Promise Ultra ATA 100
In-Reply-To: <Pine.LNX.4.21.0101121523040.4379-100000@egb070000014.lancs.ac.uk>
Message-ID: <Pine.LNX.4.21.0101121653220.6280-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Stephen Torri wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I'm having difficulty booting from the Promise controller. Here is the
> story:
> 
> I originally had my system setup with all drives working off the
> mainsboard IDE controller (Intel 82371AB PIIX4). The setup was
> 
> /dev/hda - ST310232A, FwRev=3.09  (Seagate)
> /dev/hdb - 927308, FwRev=RA530JNO (Maxtor) * Linux installed here
> /dev/hdc - CD-532E-B (Teach CDROM)
> /dev/hdd - CD-RW4224A (Smart & Friendly CDRW).
> 
> Well I got an Promise Ultra ATA 100 controller card. Went over to
> linux-ide.org and get the patches for kernel-2.2.16. Took a pristine
> kernel-2.2.16 and patched it and then compiled it on a RedHat 6.2
> system. I then made a bootdisk with this new kernel.
> 
> So then I installed the drives in this order:
> 
> (Mainsboard controller)
> primary master - ST310232A (Seagate)
> primary slave - none
> secondary master - CDROM
> secondary slave - CDRW
> 
> (Promise controller)
> primary slave - IBM-DLTA-307045 (IBM)
> primary slave - 927308 (Maxtor) * Linux install here
> secondary master - none
> secondary slave - none
> 
> The system boots if I use the bootdisk and tell it "linux
> root=/dev/hdf3".  I edited the lilo.conf and the fstab for the new
> setup. I can log in and do my business with my the linux partition but
> when I tried to use lilo to setup the MBR on the first disk (mainsboard) I
> got this:
> 
> warning: BIOS Drive 0x82 may not be accessible.
> 
> Is there some settings that I need to give to the lilo to boot?

My setup looks like this, I boot from hde
I configured my BIOS to boot from SCSI (I have no scsi-adapter but the
promise card reports itself as one at boottime)

boot = /dev/hde3
delay = 50
message = /boot/message
vga = extended
read-only
lba32
disk=/dev/hde
  bios=0x80

image=/boot/kernel/vmlinuz-2.4.1-pre2
  label = Linux
  root = /dev/hde5

image=/boot/kernel/vmlinuz-2.4.0-test10
  label = test10
  root = /dev/hde5




This works perfectly fine here

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
