Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129683AbQL0UOn>; Wed, 27 Dec 2000 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbQL0UOe>; Wed, 27 Dec 2000 15:14:34 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12619 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129683AbQL0UO0>; Wed, 27 Dec 2000 15:14:26 -0500
Date: Wed, 27 Dec 2000 20:43:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gregory Maxwell <greg@linuxpower.cx>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: high load & poor interactivity on fast thread creation
Message-ID: <20001227204342.D19378@athlon.random>
In-Reply-To: <3A266895.F522A0E2@austin.ibm.com> <20001130081443.A8118@bach.iverlek.kotnet.org> <3A266895.F522A0E2@austin.ibm.com> <4.3.2.7.2.20001227110018.00e5ba90@cam-pop.cambridge.arm.com> <3A4A22A8.D434B7F@holly-springs.nc.us> <20001227122508.A29579@xi.linuxpower.cx> <20001227093236.A1409@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001227093236.A1409@work.bitmover.com>; from lm@bitmover.com on Wed, Dec 27, 2000 at 09:32:36AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 09:32:36AM -0800, Larry McVoy wrote:
> [..] You do
> pay a price for not sharing TLB entries if the OS is stupid (Linux' is
> not).

Even assuming all segments are attached at the same virtual address on all MM
(this can be enforced with MAP_FIXED of course), we can't use the same tlb
entries for accessing the same shared sement from different MM. That's not even
possible on hardware with address space numbers (on x86 it's obvious it's not
possible even with future x86 chips that can tag the TLB entries
with the phisical address of the pgd to skip the full tlb flush during
switch_mm).

I think the main point of using threads instead of shared mappings is
performance.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
