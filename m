Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRAMOI2>; Sat, 13 Jan 2001 09:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRAMOIS>; Sat, 13 Jan 2001 09:08:18 -0500
Received: from styx.suse.cz ([195.70.145.226]:53237 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130162AbRAMOFm>;
	Sat, 13 Jan 2001 09:05:42 -0500
Date: Sat, 13 Jan 2001 14:42:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: davej@suse.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010113144236.B1155@suse.cz>
In-Reply-To: <E14HDqv-0005Fm-00@the-village.bc.nu> <Pine.LNX.4.31.0101130228310.17083-100000@athlon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0101130228310.17083-100000@athlon.local>; from davej@suse.de on Sat, Jan 13, 2001 at 02:43:30AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 02:43:30AM +0000, davej@suse.de wrote:

> > |The system is an AMD K6-3 on a FIC PA-2013 mobo with 3 IDE disks.  The
> > |size of hda is 4.3 GB, the size of hdb is 854 MB and the size of hdc is
> > |1.2 GB.  Hdd is an IDE CDROM drive
> >
> > I think its significant that two reports I have are FIC PA-2013 but not all.
> > What combination of chips is on the 2013 ?
> 
> The FIC PA-2013 is one of the stranger types of MVP3.
> (A mixture of 82c597 host bridge and 82c598 PCI bridge).

598 + 586b

> As discussed some time ago on this list, there are some of these
> boards, which initially seem to be an MVP3, but have the host bridge ID
> set to an VP3. (Real reasoning behind this never figured out).

Windows driver compatibility, so that VP3 drivers would work on MVP3 as
well.

> 2.4 has code in the pci quirks to disable the register which makes
> the chip masquerade as a VP3, and forces it to identify itself as
> an MVP3 part.  I'm curious whether this has an interaction here.

This doesn't do anything but change the ID so that Linux drivers are not
confused anymore. This caused a lot of trouble in 2.2, especially with
the old VIA IDE driver.

> I have a list of known 'hybrid' boards, and known true (both halves) MVP3
> boards and also a collection of lspci -xxx outputs from a selection of
> them. If anyone wants any of this stuff, shout and I'll put it up
> for ftp/www.

Actually, the definitions of what's a 'true VIA xxx chipset' change over
time, as VIA upgrades the southbridges in the specs. You'll now fing
that the VPX chipset is 587vpx + 586b, but when released the 587vpx was
coupled with the old 586 south.

Fortunately all these chips use PIIX-compatible extensions to the PCI
bus, so they are all interchangeable to some degree.

> I'm curious if all of the other boards in Alans bug reports also
> fall into the stranger category.

It's possible. I have a board (VA-503A), which has a masqueraded 598,
which identifies itself as 597, and a 686a southbridge. This got the
2.2 ide driver completely confused, for example. 

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
