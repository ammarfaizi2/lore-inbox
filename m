Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTFJXWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJXWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:22:05 -0400
Received: from thunk.org ([140.239.227.29]:6082 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262063AbTFJXV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:21:58 -0400
Date: Tue, 10 Jun 2003 19:35:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lincoln Durey <lincoln@EmperorLinux.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kent E Yoder <yoder1@us.ibm.com>,
       Burt Silverman <burts@us.ibm.com>, Bradford Jones <brad1@us.ibm.com>,
       Alexandre Tr?panier <atrepani@ca.ibm.com>,
       Ken Aaker <kdaaker@rchland.vnet.ibm.com>,
       Janice Girouard <girouard@us.ibm.com>, Robert Finn <finnr@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Martin List-Petersen <martin@list-petersen.dk>,
       Greg KH <greg@kroah.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Jon maddog Hall <maddog@li.org>
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
Message-ID: <20030610233519.GA2054@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lincoln Durey <lincoln@EmperorLinux.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kent E Yoder <yoder1@us.ibm.com>, Burt Silverman <burts@us.ibm.com>,
	Bradford Jones <brad1@us.ibm.com>,
	Alexandre Tr?panier <atrepani@ca.ibm.com>,
	Ken Aaker <kdaaker@rchland.vnet.ibm.com>,
	Janice Girouard <girouard@us.ibm.com>,
	Robert Finn <finnr@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>,
	Martin List-Petersen <martin@list-petersen.dk>,
	Greg KH <greg@kroah.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Jon maddog Hall <maddog@li.org>
References: <1054658974.2382.4279.camel@tori>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054658974.2382.4279.camel@tori>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 12:49:34PM -0400, Lincoln Durey wrote:
> 
> As I gather more info, it becomes clear that the IBM T40 has a TCPA chip
> in it with a "white list" of _allowed_ cards.  Apparently IBM has made a
> _policy_ decision to disallow any wifi card not on the list. (more
> below).  In doing this they have (perhaps unknowingly) severely limited
> the usefulness of the entire T40 (and X31 by extension) laptop lines for
> the many users of the Linux OS on those IBM systems.  Surely this was
> not intentional....

One bit of clarification here.  First of all, the prohibition as
absolutely nothing to do with TCPA.  Irrespective of what you might
think of the code in the BIOS which refuses to allow the machine to
boot with a unsupported card, this is completely orthoganal to the
functionality provided by the Embedded Security Subsystem chip, which
on the internal SM bus and merely is an encryption engine with some
key management magic.  It encrypts and decrypts blobs of data upon
request (assuming that you have the right keys and/or encrypted key
blocks); nothing more.

Please see:   http://www.research.ibm.com/gsal/tcpa/tcpa_rebuttal.pdf

For more information for some of the misinformation that's been going
around about TCPA.  TCPA is completely different and frequently
confused with Microsoft's Palladium, which *IS* evil.  :-)


As far as why there is a list of approved mini-PCI cards which are the
only ones accepted by BIOS, and why the BIOS refuses to boot if an
unsupported mini-PCI card is installed, I can only speculate.  (And I
am **NOT** speaking for IBM here.)  My initial reaction as soon as I
saw the story was FCC certification issues.  Yes, other laptop vendors
may not be as careful; however, I can easily believe than an IBM
lawyer was simply being ultra-paranoid, and required the lockout code
in the BIOS.  (Which, if you think about it, is very simple to
implement, and doesn't require any kind of special "chip", TCPA or
otherwise).


If the goal is simply to let a T40p laptop work with an internal
wireless card, there is a solution that works today.  Simply use the
Cisco MPI 350 mini-pci card instead, which *is* a supported card and
works just fine with the T40p.  The Cisco 350 wireless card is much
better than most generic Prism-2 cards anyway, since they support LEAP
(802.1x wireless authentication and encryption) and have more a
powerful transmitter (100mW) and a more sensitive receiver that most
other 802.11 cards out there.

I recently purchased a T40p with my own money (it's not a company
laptop), and knowing that there was going to be problems with the
802.11 a/b wireless, I also purchased the Cisco 350 mini-pci wireless
card.  The Cisco mini-PCI card was shipped separately from the laptop,
and so I had to install it myself (which required partial disassembly
of my laptop, and the use of a security torx driver, but any competent
hardware hacker shouldn't have a problem with it).  That means that I
still have the 802.11a/b mini-pci card, saved away for the day when a
driver might become available for it.

You can download the mpi350.c driver from the Cisco web page, and I
was able to drop it into a 2.4 Linux kernel tree and build it.  For
more details please see http://thunk.org/tytso/linux/t40.html.

							- Ted
