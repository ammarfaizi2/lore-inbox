Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbREPACw>; Tue, 15 May 2001 20:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbREPACn>; Tue, 15 May 2001 20:02:43 -0400
Received: from HIC-SR1.hickam.af.mil ([131.38.214.15]:9608 "EHLO
	hic-sr1.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S261721AbREPACZ>; Tue, 15 May 2001 20:02:25 -0400
Message-ID: <4CDA8A6D03EFD411A1D300D0B7E83E8F697322@FSKNMD07.hickam.af.mil>
From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
To: "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: RE: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 00:01:52 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe thats why there are persistant superblocks on the RAID partitions.
You can switch them around, and it still knows which drive holds which RAID
partition...  That's the only way booting off RAID works, and the only
reason for the "RAID Autodetect" partition type... you can find those
shuffled partitions correctly.  The only time it really looks at the file,
is if you try to rebuild the partition I believe... and some other
circumstance that dosn't come to mind.

	Sam Bingner

-----Original Message-----
From: Alex Bligh - linux-kernel [mailto:linux-kernel@alex.org.uk]
Sent: Tuesday, May 15, 2001 11:30 AM
To: Linus Torvalds; Jonathan Lundell
Cc: Jeff Garzik; James Simmons; Alan Cox; Neil Brown; H. Peter Anvin;
Linux Kernel Mailing List; viro@math.psu.edu; Alex Bligh - linux-kernel
Subject: Re: LANANA: To Pending Device Number Registrants


> The argument that "if you use numbering based on where in the SCSI chain
> the disk is, disks don't pop in and out" is absolute crap. It's not true
> even for SCSI any more (there are devices that will aquire their location
> dynamically), and it has never been true anywhere else. Give it up.

Q: Let us assume you have dynamic numbering disk0..N as you suggest,
   and you have some s/w RAID of SCSI disks. A disk fails, and is (hot)
   removed. Life continues. You reboot the machine. Disks are now numbered
   disk0..(N-1). If the RAID config specifies using disk0..N thusly, it
   is going to be very confused, as stripes will appear in the wrong place.
   Doesn't that mean the file specifying the RAID config is going to have
   to enumerate SCSI IDs (or something configuration invariant) as
   opposed to use the disk0..N numbering anyway? Sure it can interrogate
   each disk0..N to see which has the ID that it actually wanted, but
   doesn't this rather subvert the purpose?

IE, given one could create /dev/disk/?.+, isn't the important
argument that they share common major device numbers etc., not whether
they linearly reorder precisely to 0..N as opposed to have some form
of identifier guaranteed to be static across reboot & config change.
--
Alex Bligh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
