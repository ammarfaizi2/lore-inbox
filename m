Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129206AbRBBOds>; Fri, 2 Feb 2001 09:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBBOdm>; Fri, 2 Feb 2001 09:33:42 -0500
Received: from bretweir.total.net ([154.11.89.176]:29343 "HELO
	smtp.interlog.com") by vger.kernel.org with SMTP id <S129206AbRBBOd1>;
	Fri, 2 Feb 2001 09:33:27 -0500
Message-ID: <3A7AC41D.D2761669@interlog.com>
Date: Fri, 02 Feb 2001 09:28:45 -0500
From: Douglas Gilbert <dgilbert@interlog.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2 SCSI controllers causing boot problems...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Pacey wrote:
> On Fri, 02 Feb 2001 10:09:21 Drew Bertola wrote:
> > 
> > I know I've seen this in the past, but the answer slips my mind and I
> > can't find anything in the archives.
> > 
> > I've just set up a box w/ an aic7xxx card.  The boot drive hangs off
> > that card.  During installation, the boot drive is sda.  Lilo contains
> > "root=/dev/sda8".  
> > 
> > I compiled a new kernel with the 3ware raid driver.  When I rebooted,
> > the 3ware card driver must have been loaded first; /dev/sda8 was no
> > longer the root device.
> > 
> > How do I control the device designations during boot?
> >
>
> Drew,
>
> If you check the archive's I've had a similar problem.
>
> Possible answers:
>
> Compile the to-be-loaded-2nd driver as a module and keep the first builtin
> Use devfs (it lets you pass a 'scsi=driver1:driver2:...' to the kernel,
> controlling load order)
>
> There are devfs 2.2 patches and 2.4.1 includes devfs natively; I chose
> 2.4.1 and it worked.

Just some fine tuning on that answer. The relevant kernel 
boot time option in the 2.4 series is "scsihosts" and it 
is available whether or not devfs is selected. [Richard
Gooch did introduce this option together with devfs. It
is now part of the scsi mid level code.]

If you apply Richard's devfs patch to the lk 2.2 series
you will also get the "scsihosts" kernel boot time option
(but I suspect it doesn't work as it needed to some
tweaking in 2.4).

As for scsi device naming issues, you could look at:
http://linuxdoc.org/HOWTO/SCSI-2.4-HOWTO
for more information.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
