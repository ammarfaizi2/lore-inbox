Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270534AbRHNTNo>; Tue, 14 Aug 2001 15:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270076AbRHNTNf>; Tue, 14 Aug 2001 15:13:35 -0400
Received: from press-gopher.uchicago.edu ([128.135.204.194]:56504 "EHLO
	press-gopher.uchicago.edu") by vger.kernel.org with ESMTP
	id <S269875AbRHNTNY>; Tue, 14 Aug 2001 15:13:24 -0400
Date: Tue, 14 Aug 2001 14:13:26 -0500 (CDT)
From: "Roy C. Bixler" <rcb@press-gopher.uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <Pine.GSO.4.10.10108131229270.27903-100000@press-gopher.uchicago.edu>
Message-ID: <Pine.GSO.4.10.10108141404050.2858-100000@press-gopher.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, I wrote:
> I have just inadvertantly encountered a VM lockup with Linux 2.4.8.  The
> KDE kspread application couldn't handle one spreadsheet I gave it and it
> ran away consuming all memory in the system.  When I first ran into the
> trouble, my machine has 384 Meg. RAM and 184 Meg. of swap.  I tried
> 2.4.8pre8 and the lockup still occurs.  I have increased my swap to 768
> Meg. and 2.4.8 still locks up.  I tried 2.4.7 and it doesn't lockup - it
> correctly OOM kills the runaway process.
> 
> The system feels responcive up until it locks up.  Running 'top' while it
> happens show that the lockup occurs at about the point where swap runs
> out.  Other system details: it is running the latest Debian snapshot.

I've managed to do a little more tracing on this.  I've tried this test on
2.4.8-pre1 and it eventually kills the culprit process.  I tried again
under 2.4.8 and, since the Sys-Rq key combinations worked while the system
was otherwise completely quiet (no disk activity) and unresponcive, I
tried hitting Sys-Rq-P a few times and the stack traces always looked like
this:

do_try_to_free_pages
kswapd
kernel_thread

or

swap_out_vma
swap_out_mm
swap_out
refill_active_zone
refill_inactive
do_try_to_free_pages
kswapd
kernel_thread

I also just tried 2.4.9-pre3 and the system locked before swap filled up
with a screen full of '__alloc_pages: order 0 allocation failed' type
messages.

-- 
Roy Bixler
The University of Chicago Press
rcb@press-gopher.uchicago.edu


