Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLLVB4>; Tue, 12 Dec 2000 16:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQLLVBq>; Tue, 12 Dec 2000 16:01:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49031 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129414AbQLLVBa>;
	Tue, 12 Dec 2000 16:01:30 -0500
Date: Tue, 12 Dec 2000 12:14:57 -0800
Message-Id: <200012122014.MAA05129@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: groudier@club-internet.fr
CC: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012121958390.1389-100000@linux.local> (message
	from Gérard Roudier on Tue, 12 Dec 2000 20:17:21 +0100 (CET))
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.10.10012121958390.1389-100000@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 12 Dec 2000 20:17:21 +0100 (CET)
   From: Gérard Roudier <groudier@club-internet.fr>

   On Mon, 11 Dec 2000, David S. Miller wrote:

   > Tell me one valid use of this information first :-)

   SCRIPTS. Have a look into my kind :-) response to Martin.

Ok, this I understand.

   > b) If you wish to interpret the BAR values and use them from a BUS
   >    perspective somehow, you still need to go through some interface
   >    because you cannot assume what even the hw BAR values mean.
   >    This is precisely the kind of interface I am suggesting.

   The BAR values make FULL sense on the BUS.

I am saying there may be systems where it does not make any sense,
f.e. actually used bits of BAR depend upon whether CPU, or DEVICE on
that bus, or DEVICE on some other bus make the access.

Forget all the PCI specifications, it is irrelevant here.  All your
PCI expertiece means nothing, nor mine.  People build dumb machines
with "PCI implementations" and we need to handle them.

   I will wait for your .txt file that describes your idea. Your
   documentation about the new DMA mapping had been extremally useful.
   Let me thank you again for it.

It requires no .txt file :-), it will just be formalization of
existing bus_to_dvma_whatever hack :-) Specify PDEV (device) and
RESNUM (which I/O or MEM resource for that device), returns either
error or address as seen by BUS that PDEV is on.  You may offset
this return value as desired, up to the size of that resource.

I could make a more elaborate interface (add new parameter,
PDEV_MASTER which is device which wishes to access area described by
PDEV+RESNUM), allowing full PCI peer-to-peer setup, as described by
someone else in another email of this thread.  This version would have
an error return, since there will be peer2peer situations on some
systems which cannot be made.  But I feel this is inappropriate until
2.5.x, others can disagree.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
