Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269292AbRHCDrd>; Thu, 2 Aug 2001 23:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269295AbRHCDrZ>; Thu, 2 Aug 2001 23:47:25 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:35545 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S269292AbRHCDrI>; Thu, 2 Aug 2001 23:47:08 -0400
Message-ID: <3B6A1EBF.CF292235@sympatico.ca>
Date: Thu, 02 Aug 2001 23:47:11 -0400
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: using ramdisk as root filesystem seems to cause carrier errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUMMARY: Booting with a ramdisk as the root filesystem causes spurious errors
(or possibly spurious detection of errors) on an ethernet interface configured
later on, while the ethernet interface configured by the init scripts works
fine. Booting with an nfs-mounted rootdisk with contents identical to the
ramdisk works fine.

DETAILS: We have a Motorola G4-based compact PCI card with dual DEC 21143-based
ethernet ports.  We are using a 2.2.17 kernel with various patches, but none to
the ethernet driver.  We've been working on this card for months now without
seeing any real problems, but recently someone was doing bandwidth tests through
each link and noticed a discrepency.  We then looked at the output of ifconfig
and saw all kinds of carrier errors (one for each packet transmitted) on the
problem link.

The normal method of booting this card is with a largish (34MB uncompressed)
ramdisk as the root filesystem.  In this scenario, one ethernet link is
configured by the system based on information obtained from the bootp server,
and the other ethernet link is brought up automatically later on based on the
first address that was configured.  What we've noticed is that the ethernet link
that is configured later on shows a carrier error for every packet transmitted
through that link.  Interestingly the vast majority of those packets are
actually making it through--a "ping -f" from another machine to the affected
link shows about .1% packet loss.  It doesn't matter which link is configured
automatically by the system (we've tried it both ways), the carrier errors
always occur on the other link.

If we boot the exact same kernel (actually its the kernel and ramdisk glommed
together into one file, loaded via tftp) but then override the boot args to use
an nfs-mounted root filesystem that is identical to the one in the ramdisk, then
everything works fine.  We configure one ethernet link at startup based on bootp
requests and the other one gets configured later on.  Everything works
perfectly, "ping -f" from another machine gives a few dropped packets out of a
few hundred thousand, through either link.  No errors.

Can anyone think of what could possibly be causing this?  Somehow, the act of
using a ramdisk as our root filesystem is causing problems with our ethernet
links.  Are there any known gotchas that may be biting us?  Other than the
problems with one of the two links, the system seems to be working perfectly.

Thanks for any theories you might have,

Chris Friesen
Nortel Networks
Ottawa, ON

PS.  This is my third time sending this, since my first two tries (from two
different addresses) don't seem to have made it onto the list at all.  Anyone
else seeing this?
