Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbREPPUk>; Wed, 16 May 2001 11:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbREPPUa>; Wed, 16 May 2001 11:20:30 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:43270 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S261979AbREPPUV>;
	Wed, 16 May 2001 11:20:21 -0400
Date: Wed, 16 May 2001 16:20:14 +0100 (BST)
From: Matt Bernstein <mb@dcs.qmw.ac.uk>
To: Steve Lord <lord@sgi.com>
cc: <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.3-XFS 
In-Reply-To: <200105161505.f4GF5So17570@jen.americas.sgi.com>
Message-ID: <Pine.LNX.4.33.0105161606240.2837-100000@nick.dcs.qmw.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> However, in testing a directory with lots (~177000) of files, we get the
>> following oops (copied by hand, and run through ksymoops on a Red Hat box
>> since the Debian one segfaulted :( )

>Can you describe your testing beyond using a directory with 177000 files
>in it?
>Also, can you explain how you obtained the xfs code, from a patch, from
>the cvs development tree, or from somewhere else?

Certainly :) (have been investigating further through the day)

The code was obtained as the patches for 2.4.3, (it was also patched for a
scsi changer, but all the scsi stuff is modules that weren't loaded), and
we used your Red Hat ISO in rescue mode to convert our root partition to
XFS.

I'd been trying to hammer a partition remotely. I'd exported it with
knfsd, but the oops I posted was caused by trying to tar said directory
(locally--no NFS involvement) to a file in its parent (which does contain
some large (~4GB) files.

kernel built with egcs-1.1.2, not very much in it, modules loaded at the
time were nfs, sunrpc, lockd, autofs (but I will test again without any of
those loaded when the box is less busy)--I had removed nfsd and friends.

We tried to recreate this on a second box a couple of hours ago and
failed, so we can't rule out a hardware/other non-XFS problem. Two
immediate potential culprits are the VIA KT133 UDMA and the drive itself
(NB the second box has the same motherboard, but not a WDC drive):

# hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD400BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6R1239029
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=78165360
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 mode5

Thanks for the reply. Any more information on request :)

Matt
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Apqx1vU/2MhEp5cRAgecAJ0bAm1Jlay2AjHjGaQ1Zck7/1vOewCgujgD
mAnEXzuyabuUwcPy22e1avM=
=41+h
-----END PGP SIGNATURE-----

