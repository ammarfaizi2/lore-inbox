Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272238AbRHWMYp>; Thu, 23 Aug 2001 08:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272241AbRHWMYg>; Thu, 23 Aug 2001 08:24:36 -0400
Received: from ns.ithnet.com ([217.64.64.10]:25609 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272238AbRHWMYW>;
	Thu, 23 Aug 2001 08:24:22 -0400
Date: Thu, 23 Aug 2001 14:24:07 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marc Heckmann <heckmann@hbesoftware.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: small patch for 2.4.9 VM
Message-Id: <20010823142407.54c332e9.skraw@ithnet.com>
In-Reply-To: <20010823072104.A13430@hbe.ca>
In-Reply-To: <20010823072104.A13430@hbe.ca>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001 07:21:04 -0400
Marc Heckmann <heckmann@hbesoftware.com> wrote:

> [not on list, please CC me]
> 
> Hi,
> 
> I've been tracking the vm changes in the 2.4.9-pre series. I was seeing
> really good improvements with 2.4.9-pre3 but then in pre4 it went to shit
> on my box (192mb, 200mb swap). The page cache was huge at all times and
> went pretty deep into swap on light loads. staring at the diff between
> pre3 and pre4, I noticed that background page aging in kswapd has changed
> [see do_try_free_pages], instead of just doing refill_inactive_scan(), it
> now does swap_out() first, then refill_inactive. Somehow, this seems to
> prevent proper page aging or something [please correct me if i'm wrong,
> haven't had the time to stare at swap_out() yet]. Anyway the short patch
> below, makes it behave like pre3 which is quite good for me.  This might
> also be the cause of other peoples mm problems with 2.4.9 final.

Sorry it isn't. I tested it and it has exactly the same problem under 2.4.9 with this patch than the straight kernel. Interestingly the error message from alloc_pages does not come up, but NFS-copy fails anyway when all the physical mem is eaten up by caches.
meminfo in failing state:
        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 918994944  2732032        0  6815744 823762944
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:          2668 kB
MemShared:           0 kB
Buffers:          6656 kB
Cached:         804456 kB
SwapCached:          0 kB
Active:         276020 kB
Inact_dirty:    528988 kB
Inact_clean:      6104 kB
Inact_target:     6628 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:          2668 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

Good about it: it does not swap. Bad: it does not work either.
Forget this patch.

Regards,
Stephan

