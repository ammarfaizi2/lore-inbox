Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130942AbRBAUjJ>; Thu, 1 Feb 2001 15:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbRBAUi7>; Thu, 1 Feb 2001 15:38:59 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:16350 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S130942AbRBAUiq>;
	Thu, 1 Feb 2001 15:38:46 -0500
Date: Thu, 1 Feb 2001 15:38:40 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
cc: <linux-kernel@vger.kernel.org>, <axp-list@redhat.com>,
        <denis@datafoundation.com>
Subject: 2.4.x/alpha/ALI chipset/IDE problems summary Re: 2.4.1 not fully
 sane on Alpha - file systems
In-Reply-To: <20010201092342.B15101@ellpspace.math.ualberta.ca>
Message-ID: <Pine.SGI.4.31L.02.0102011526200.71788-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The system in question is an API UP1100 based system, running 4 Maxtor
40gb IDE drives off the ALI M15x3 chipset.

This applies to kernel 2.4.0 and 2.4.1.

The drives are identified as follows from hdparm:

Model=Maxtor 54098H8, FwRev=DAC10SC0, SerialNo=K80F1ZFC

Is also has an Adaptec 29160 SCSI card, running a solid state disk and an
AIT tape library.

Upon placing any heavy I/O load on any of the disks (dd if=/dev/*d*
of=/dev/null) the screen flashes a  few times, and then the system locks
hard -- no sysrq, no control-alt-del, no pings, no nothing.

It will also hang and lock hard on fscking corrupted filesystems under
2.4.0 and 2.4.1.

Interestingly enough, I tried 'dd if=/dev/zero of=/tmp/dd.img bs=4096
count=10000' and it also locked hard, after printing messages to the
effect of:

EXT2-fs error: (device info) allocating block in system zone -- block
(block numbers).

stock RH 2.2.16-3 works peachy.

I've tried various options with compiling in and out the ALI chipset, PCI
DMA, drive DMA, and IRQ sharing, but without all four of those enabled,
the system freezes at identifying the IDE device partitions, like so:

  hda: lost interrupt
lost interrupt
lost interrupt

I've heard one other report of similar problems on the linux-kernel
mailing list, and at least one other on the axp-list.

On Thu, 1 Feb 2001, Michal Jaegermann wrote:

> Date: Thu, 1 Feb 2001 09:23:42 -0700
> From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
> To: John Jasen <jjasen@datafoundation.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.1 not fully sane on Alpha - file systems
>
> On Thu, Feb 01, 2001 at 10:46:12AM -0500, John Jasen wrote:
> > On Wed, 31 Jan 2001, Michal Jaegermann wrote:
> >
> > > I just tried to boot 2.4.1 kernel on Alpha UP1100.  This machine
> > > happens to have two SCSI disks on sym53c875 controller and two IDE
> > > drives hooked to a builtin "Acer Laboratories Inc. [ALi] M5229 IDE".
> >
> > ALI M1535D pci-ide bridge, isn't it? That's what the specs on
> > API's webpage seem to indicate.
>
> 'lspci' claims that this is:
>
> "07.0  Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]"
>
> >
> > Try this for fun: dd if=/dev/hda of=/dev/null bs=4096, and see if it
> > cronks out.
>
> Probably.
>
> > In my case, any serious I/O on the IDE drives quickly results in pretty
> > technicolor on the VGA screen, and then a hard lockup.
>
> No, no technicolor or other sounds effects.  The whole thing just
> locks up with a power switch as the only option.
>
> > Furthermore, after power-reset, 2.4.x, x=0 or 1, cannot successfully fsck
> > the drives.  It hangs after about the 2nd-3rd partition, again in a hard
> > lockup.
>
> My box is much healtier than that.  Regardless if I booted into a file
> system on a SCSI drive or on an IDE drive (I happen to have those
> options although I prefer IDE - I have there something which I can loose
> without any real pain :-) I can still fsck drives healthy after the
> crash but I did NOT risk fsck under 2.4.1.  Things looks way too screwy
> for this.
>
> >
> > My WAG is that there are problems in the ALI driver.
>
> Possibly, but I crashed the whole thing without mounting anything from
> IDE drives at all.  There are still there but unused.  I simply managed
> to get something in logs for the case described.  Note that errors
> I quoted are from a device 08:05, i.e. SCSI driver (/dev/sda5 to be
> more precise).  When my compiler went bonkers and started to read
> clearly some random stuff instead of sources then the whole action was
> happening on a SCSI drive.
>
>  Michal
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 
--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
