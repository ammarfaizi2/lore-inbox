Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131646AbRASO1S>; Fri, 19 Jan 2001 09:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRASO1J>; Fri, 19 Jan 2001 09:27:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:45845 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131646AbRASO07>; Fri, 19 Jan 2001 09:26:59 -0500
Date: Fri, 19 Jan 2001 15:27:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: adilger@turbolinux.com, linux-kernel@vger.kernel.org,
        zippel@fh-brandenburg.de
Subject: Re: Is sendfile all that sexy? (fwd)
Message-ID: <20010119152718.C3447@athlon.random>
In-Reply-To: <200101191058.LAA29762@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101191058.LAA29762@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Fri, Jan 19, 2001 at 11:58:03AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 11:58:03AM +0100, Rogier Wolff wrote:
> Now if we design the NUMA support correctly, just filling in "disk has
> a seek-time of 10ms, and 20Mb per second throughput when accessed
> linearly" NUMA may on it's own "tune" the swapper to do the right
> thing. And once parametrized like this, we can also handle say a
> leftover piece of framebuffer!

In NUMA we have to deal with RAM and PCI buses that are faster when accessed in
the local node and slower when accessed in a remote node.  Addressing such
single problem is much much less generic than being able to say "plug in this
thing and threat it as memory that goes so fast". I believe we don't need all
such generic interface because it looks quite a bit of overhead, certainly not
at the first approch.

We could easily choose to bind a swap space to a certain node if irqs happens
in the local node and the controller of the disk is attached to a local PCI bus
indeed. But that still has much less generalization than the one you supposed.
And I believe anything that trying to optimize non-RAM backed virtual memory
accesses is worthless because the numa toys have some houndred giga of ram so
you're not going to use anything other than RAM as beckend for virtual
memory...  There are much more worthwhile parts to optimize.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
