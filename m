Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135721AbRD2L2T>; Sun, 29 Apr 2001 07:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135724AbRD2L2J>; Sun, 29 Apr 2001 07:28:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37771 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135721AbRD2L1v>;
	Sun, 29 Apr 2001 07:27:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15083.64180.314190.500961@pizda.ninka.net>
Date: Sun, 29 Apr 2001 04:27:48 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
	<200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
	<9cg7t7$gbt$1@cesium.transmeta.com>
	<3AEBF782.1911EDD2@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > After a couple of suggestions for improving things, Linus chimed in
 > with the magic page suggestion.

Since this is being brought up again, I want to mention something.

If we are going to map in a page like this, there are other cool
things one could do with this page.  We should keep it at _1_ page
so people don't go crazy with ideas of stuff to put here btw...

The idea is that the one thing one tends to optimize for new cpus
is the memcpy/memset implementation.  What better way to shield
libc from having to be updated for new cpus but to put it into
the kernel in this magic page?

There is a secondary effect to doing this on systems with physically
indexed caches (read as: most if not all x86 cpus today), the kernel's
memcpy/memset call icache usage can be shared with the user.

This also allows things like "kernel disabled cpu feature XYZ because
of a hardware bug, so instead of the usual optimized memcpy for this
processor, memcpy FOO is now faster since the feature is disabled, so
that is what we'll use" Really, libc shouldn't know things like this.

I thought about doing something along these lines on sparc64 sometime
around the next to last Linux EXPO held in North Caroline (the one
which was on the Duke university campus).  In fact I believe I
remember specifically mentioning this idea to Jakub Jelinek during
that conference.  It's particularly attractive on sparc64 because you
can use a "global" TLB entry which is thus shared between all address
spaces.

Later,
David S. Miller
davem@redhat.com
