Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRCAUYg>; Thu, 1 Mar 2001 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129876AbRCAUYQ>; Thu, 1 Mar 2001 15:24:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5512 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129865AbRCAUYL>;
	Thu, 1 Mar 2001 15:24:11 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.44863.375642.847562@pizda.ninka.net>
Date: Thu, 1 Mar 2001 12:21:19 -0800 (PST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <19350124132125.27547@smtp.wanadoo.fr>
In-Reply-To: <15006.40524.929644.25622@pizda.ninka.net>
	<19350124132125.27547@smtp.wanadoo.fr>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > Also, the problem of finding where the legacy ISA IOs of a given PCI bus
 > are is a bit different that simply mmap'ing a BAR. Some video cards
 > require some access to their VGA IOs without having a BAR covering them,
 > in some case it's necessary to switch the chip from VGA to MMIO mode.

Many platforms, sparc64 included, do not have an ISA IO space nor do
they provide VGA accesses at all.

If things such as XFree86 are coded for such platforms to not require
VGA accesses (the 'ati' driver is already like this when certain
build time defines are set), this could become a non-issue in this
case.

 > So what would be a preferred way ? Create that fake ISA bus number and
 > provide functions for looking them up, getting their IO and mem bases,
 > and eventually mapping PCI busses to ISA busses ? Or does someone have a
 > better idea ? The goal is to try not to change the semantics of inb/outb
 > and friends so that most legacy drivers can still work using the
 > "default" IO bus if they are not upgraded to the new scheme.

There is no 'fake' ISA bus number you need.  There is a 'real' one,
the one on which the PCI-->ISA bridge lives, why not use that one
:-)

Then you could find such an ISA bridge, open that PCI device, then
finally perform the PCI_IOCTL_GETIOBASE thingy on it, but I don't like
this get-iobase idea at all, see my next email in this thread for why.

Later,
David S. Miller
davem@redhat.com
