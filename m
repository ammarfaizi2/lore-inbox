Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbREUKUN>; Mon, 21 May 2001 06:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbREUKUD>; Mon, 21 May 2001 06:20:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262441AbREUKTz>;
	Mon, 21 May 2001 06:19:55 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.60362.447922.780857@pizda.ninka.net>
Date: Mon, 21 May 2001 03:19:54 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <15112.59880.127047.315855@pizda.ninka.net>
In-Reply-To: <20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521115631.I30738@athlon.random>
	<15112.59880.127047.315855@pizda.ninka.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller writes:
 > 
 > 1) I showed you in a private email that I calculated the
 >    maximum possible IOMMU space that one could allocate
 >    to bttv cards in a fully loaded Sunfire sparc64 system
 >    to be between 300MB and 400MB.  This is assuming that
 >    every PCI slot contained a bttv card, and it still
 >    used only ~%35 of the available IOMMU resources.

This is totally wrong in two ways.

Let me fix this, the IOMMU on these machines is per PCI bus, so this
figure should be drastically lower.

Electrically (someone correct me, I'm probably wrong) PCI is limited
to 6 physical plug-in slots I believe, let's say it's 8 to choose an
arbitrary larger number to be safe.

Then we have:

max bytes per bttv: max_gbuffers * max_gbufsize
		    64           * 0x208000      == 133.12MB

133.12MB * 8 PCI slots == ~1.06 GB

Which is still only half of the total IOMMU space available per
controller.

Later,
David S. Miller
davem@redhat.com

