Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129456AbRBHWFP>; Thu, 8 Feb 2001 17:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRBHWFJ>; Thu, 8 Feb 2001 17:05:09 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:19953 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S129067AbRBHWEu>;
	Thu, 8 Feb 2001 17:04:50 -0500
Date: Thu, 8 Feb 2001 16:26:08 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, jes@linuxcare.com
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A83017D.D84AD6B1@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10102081555500.7141-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Jeff Garzik wrote:

> > Well, I decided to bite the bullet and port my zerocopy starfire
> > changes to the official tree, properly ifdef'ed. So here it goes,
>
> I would prefer that the zerocopy changes stay in DaveM's external patch
> until they are ready to be merged.  Zerocopy is still changing and being

Good idea -- I expect that there will be significant interface changes
before the zero-copy code stabilizes.

> > + * The ia64 doesn't allow for unaligned loads even of integers being
> > + * misaligned on a 2 byte boundary. Thus always force copying of
> > + * packets as the starfire doesn't allow for misaligned DMAs ;-(
...
> Note that I have not yet sent this patch onto Linus for a reason... 
> Here is Don Becker's comment on the subject:

> > Oh, and this is completely bogus.
> > This isn't a fix, it's a hack that covers up the real problem.
> > 
> > The align-copy should *never* be required because the alignment differs
> > between DIX and E-II encapsulated packets.  The machine shouldn't crash
> > because someone sends you a different encapsulation type!

This is true for a number of drivers -- triggering the copy-align code
might eliminate the misaligned traps on your local network, but it's not
a solution.

I saw the Adaptec people last week at LinuxWorld.  The 2.4.0 starfire
has a number of actual bugs that should be fixed RSN:
   The consistency check in the Rx code was broken.  Did anyone ever try
   the driver after the changes?  The test triggers with every received
   packet.  The easiest patch is to just get rid the consistency checks
   inside "#ifndef final_version".

   The region resource was not released, requiring a reboot between each
   driver test.  Trivial fix.

   The MII read code is no longer reliable.  I spent twenty minutes at
   the show, but couldn't figure out the problem.  I haven't been able
   reproduce the problem locally with my 2.2 code and someone older
   hardware.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
