Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272624AbRHaHns>; Fri, 31 Aug 2001 03:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272625AbRHaHni>; Fri, 31 Aug 2001 03:43:38 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:45698 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S272624AbRHaHnW>; Fri, 31 Aug 2001 03:43:22 -0400
Date: Fri, 31 Aug 2001 08:43:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] __alloc_pages cleanup -R6 Was: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-ID: <20010831084335.A4222@flint.arm.linux.org.uk>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com> <20010829232929Z16206-32383+2351@humbolt.nl.linux.org> <20010830164634.3706d8f8.skraw@ithnet.com> <200108302357.BAA11235@mailb.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108302357.BAA11235@mailb.telia.com>; from roger.larsson@skelleftea.mail.telia.com on Fri, Aug 31, 2001 at 01:53:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 01:53:24AM +0200, Roger Larsson wrote:
> Some ideas implemented in this code:
> * Reserve memory below min for atomic and recursive allocations.
> * When being min..low on free pages, free one more than you want to allocate.
> * When being low..high on free pages, free one less than wanted.
> * When above high - don't free anything.
> * First select zones with more than high free memory.
> * Then those with more than high 'free + inactive_clean - inactive_target'
> * When freeing - do it properly. Don't steal direct reclaimed pages

Hmm, I wonder.

I have a 1MB DMA zone, and 31MB of normal memory.

The machine has been running lots of programs for some time, but not under
any VM pressure.  I now come to open a device which requires 64K in 8K
pages from the DMA zone.  What happens?

I suspect that the chances of it failing will be significantly higher with
this algorithm - do you have any thoughts for this?

I don't think we should purely select the allocation zone based purely on
how much free it contains, but also if it's special (like the DMA zone).

You can't clean in-use slab pages out on demand like you can for fs
cache/user pages.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

