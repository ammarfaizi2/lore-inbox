Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbREVPAx>; Tue, 22 May 2001 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbREVPAn>; Tue, 22 May 2001 11:00:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5164 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261842AbREVPAd>; Tue, 22 May 2001 11:00:33 -0400
Date: Tue, 22 May 2001 17:00:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net,
        "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522170016.D15155@athlon.random>
In-Reply-To: <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010522184409.A791@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, May 22, 2001 at 06:44:09PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 06:44:09PM +0400, Ivan Kokshaysky wrote:
> No, it wasn't the cause of the crashes on pyxis, so I left it as is.

Ok.

> But probably it worth to be changed, at least for correctness.

I must be changed, specs says "must be zero" so if the machine crashes
if you set it to 1 it has the full rights to. I am waiting to know if it
helps on the es40 that so far needed the artificial alignment (the
artificial alignment incidentally workarounds completly the above bug
because with the artificial alignment the iommu will never see a
corrupted pte of that kind [~1UL] so I'm still optimistic even if we
cannot drop the align_entry all together ;).

I'm also wondering if ISA needs the sg to start on a 64k boundary,
core_titan assumes that but I don't see why core_titan would need that
and not the others, not being an ISA expert I'm not sure but it sounds
like potential all platforms with real ISA (so where the sg_isa isn't
only used for generating low pci addresses for broken pci32) needs
that.

Andrea
