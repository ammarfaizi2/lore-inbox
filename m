Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbRETRMx>; Sun, 20 May 2001 13:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbRETRMn>; Sun, 20 May 2001 13:12:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6424 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262092AbRETRMb>; Sun, 20 May 2001 13:12:31 -0400
Date: Sun, 20 May 2001 19:12:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520191206.A30738@athlon.random>
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random>, <20010520154958.E18119@athlon.random>; <20010520181803.I18119@athlon.random> <3B07EEFE.43DDBA5C@uow.edu.au>, <3B07EEFE.43DDBA5C@uow.edu.au>; <20010520184411.K18119@athlon.random> <3B07F6B8.4EAB0142@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B07F6B8.4EAB0142@uow.edu.au>; from andrewm@uow.edu.au on Mon, May 21, 2001 at 02:54:16AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 02:54:16AM +1000, Andrew Morton wrote:
> No.  Most of the pci_map_single() implementations just
> use virt_to_bus()/virt_to_phys(). [..]

then you are saying that on the platforms without an iommu the pci_map_*
cannot fail, of course, furthmore even a missing pci_unmap cannot
trigger an iommu address space leak on those platforms. That has nothing
to do with the fact pci_map_single can fail or not, the device drivers
are not architectural specific.

> [..]  Even sparc64's fancy
> iommu-based pci_map_single() always succeeds.

Whatever sparc64 does to hide the driver bugs you can break it if you
pci_map 4G+1 bytes of phyical memory.  Otherwise it means it's sleeping
or looping inside the pci_map functions which would break things in
another manner.

Andrea
