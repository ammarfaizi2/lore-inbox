Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267040AbRGNAZH>; Fri, 13 Jul 2001 20:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267046AbRGNAY5>; Fri, 13 Jul 2001 20:24:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61190 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267040AbRGNAYn>; Fri, 13 Jul 2001 20:24:43 -0400
Date: Fri, 13 Jul 2001 19:53:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM statistics code
In-Reply-To: <20010714121150.B6048@weta.f00f.org>
Message-ID: <Pine.LNX.4.21.0107131946410.3892-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Chris Wedgwood wrote:

> On Fri, Jul 13, 2001 at 07:08:23PM -0300, Marcelo Tosatti wrote:
> 
>     With this data we are able to know more about what is really going
>     on in the VM.
> 
>     +vm_pglaunder: nr of page_launder() calls 
>     +vm_pglaunder_write: nr of times page_launder() started writting out data to free 
>     +memory.
>     +vm_refill_inactive_scan: nr of refill_inactive_scan() calls
>     +vm_alloc_resched: nr of reschedule's in __alloc_pages() due to a memory shortage.
>     +vm_kswapd_wakeup: nr of kswapd wakeup's 
>     +vm_kreclaimd_wakeup: nr of kreclaimd wakeup's 
>     +vm_kflushd_wakeup: nr of kflushd wakeup's 
>     +
>     +Per-zone statistics:
>     +free shortage: per-zone free shortage
>     +inactive shortage: per-zone inactive shortage
>     +vm_launder_pgscan: number of pages scanned by page_launder
>     +vm_pgclean: number of pages cleaned (moved to the inactive clean list) by page_launder
>     +vm_pgskiplocked: number of locked pages skipped by page_launder
>     +vm_pgskipdirty: number of dirty pages skipped by page_launder
>     +vm_pglaundered: laundered pages by page_launder
>     +vm_pgreact: pages reactivated in page_launder
>     +vm_pgrescue: pages rescue in reclaim_page
>     +vm_pgagescan: pages scanned by refill_inactive_scan()
>     +vm_pgagedown: pages aged down by refill_inative_scan()
>     +vm_pgageup: pages aged up by refill_inactive_scan()/try_to_swap_out()
>     +vm_pgdeact: deactivated pages by deactivate_page
>     +vm_pgdeactfail_age: nr of deactivation failures on refill_inactive_scan() 
>     +due to >0 age
>     +vm_pgdeactfail_ref: nr of deactivation failures on refill_inactive_scan()
>     +due to zero aged pages with more users than the pagecache
>     +vm_reclaimfail: failures of reclaim_page() (no freeable clean pages in the inactive
>     +clean list for this zone)
>     +vm_ptescan: nr of present ptes scanned by swap_out()
>     +vm_pteunmap: nr of present ptes unmapped by swap_out()
> 
> Some of these seem very specialised and low-level.

Yes they are.

> Perhaps another /proc entry might be a better idea along with either a
> different vmstat, 

Maybe. Personally I don't really care about the way we are doing this, as
long as I can get the information. I can add /proc/vmstat easily if
needed...

Linus, how do you want this thing done to be accepted in the stock tree? 

> or changes to vmstat such that it will behave as always if not given a
> magic command line switch and/or this new /proc entry isn't present?

Well, I don't want to include this stuff on the stock vmstat code right
now. I've done an ugly hack in vmstat.c to get the thing to work and thats
it.

I will keep an updated version of the "hacked" vmstat.c on my homepage
until I find time/balls to code something which does not stink. 

> Right now, much of what comes form vmstat vaguley resembles other OSs,
> with the above, it will be very different.

Indeed.

