Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136479AbREDS35>; Fri, 4 May 2001 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136480AbREDS3r>; Fri, 4 May 2001 14:29:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8430 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136479AbREDS3c>;
	Fri, 4 May 2001 14:29:32 -0400
Date: Fri, 4 May 2001 14:29:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        volodya@mindspring.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0105041048290.521-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105041418550.21896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Linus Torvalds wrote:

> 
> On Fri, 4 May 2001, Alexander Viro wrote:
> > 
> > Ehh... There _is_ a way to deal with that, but it's deeply Albertesque:
                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 	* add pagecache access for block device
> > 	* put your "real" root on /dev/loop0 (setup from initrd)
> > 	* dd
> 
> You're one sick puppy.

[snip]
/me bows

Nice to see that imitation was good enough ;-) Seriously, I half-expected
Albert to show up at that point of thread and tried to anticipate what
he'd produce.

ObProcfs: I don't think that walking the page tables is a good way to
compute RSS, especially since VM maintains the thing. Mind if I rip
it out? In effect, implementation of /prc/<pid>/statm
	* produces extremely bogus values (VMA is from library if it goes
	  beyond 0x60000000? Might be even true 7 years ago...) and nobody
	  had cared about them for 6-7 years
	* makes stuff like top(1) _walk_ _whole_ _page_ _tables_ _of_ _all_
	  _processes_ each 5 seconds. No wonder it's slow like hell and eats
	  tons of CPU time.

