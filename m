Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275789AbRI1CMh>; Thu, 27 Sep 2001 22:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275790AbRI1CM1>; Thu, 27 Sep 2001 22:12:27 -0400
Received: from smtp6.us.dell.com ([143.166.83.101]:517 "EHLO smtp6.us.dell.com")
	by vger.kernel.org with ESMTP id <S275789AbRI1CMT>;
	Thu, 27 Sep 2001 22:12:19 -0400
Date: Thu, 27 Sep 2001 21:12:25 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
 2.4.9-ac14/15(+stuff)]
In-Reply-To: <20010928014720.Z14277@athlon.random>
Message-ID: <Pine.LNX.4.33.0109272108400.29056-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Andrea Arcangeli wrote:

> 
> Moving clear_bit just above submit_bh will fix it (please Robert make
> this change before testing it), because if we block in submit_bh in the
> bounce, then we won't deadlock on ourself because of the pagehighmem
> check, and all previous non-pending bh are ok too, (only the next are
> problematic, and they're still marked pending_IO so we can't deadlock on
> them).
> 
It worked. The box did not freeze.

We can try Linus' patch as well if needed. I had actually applied 
it and rebooted before the warning, and as predicted, it froze very 
early in the boot process.

Thanks Andrea. I'll see if we can repeat the 0-page alloc again.
Robert

