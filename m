Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265793AbUFXWRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265793AbUFXWRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUFXWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:16:09 -0400
Received: from holomorphy.com ([207.189.100.168]:1677 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265768AbUFXWIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:08:55 -0400
Date: Thu, 24 Jun 2004 15:08:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624220823.GO21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, andrea@suse.de,
	nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
	tripperda@nvidia.com, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624145441.181425c8.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 02:54:41PM -0700, Andrew Morton wrote:
> We decided earlier this year that the watermark stuff should be
> forward-ported in toto, but I don't recall why.  Nobody got around to doing
> it because there have been no bug reports.
> It irks me that the 2.4 algorithm gives away a significant amount of
> pagecache memory.  It's a relatively small amount, but it's still a lot of
> memory, and all the 2.6 users out there at present are not reporting
> problems, so we should not penalise all those people on behalf of the few
> people who might need this additional fallback protection.
> It should be runtime tunable - that doesn't seem hard to do.  All the
> infrastructure is there now to do this.
> Note that this code was sigificantly changed between 2.6.5 and 2.6.7.
> First thing to do is to identify some workload which needs the patch. 
> Without that, how can we test it?

That does sound troublesome, especially since it's difficult to queue up
the kinds of extended stress tests needed to demonstrate the problems.
The prolonged memory pressure and so on are things that we've
unfortunately had to wait until extended runtime in production to see. =(
The underutilization bit is actually why I keep going on and on about
the pinned pagecache relocation; it resolves a portion of the problem
of pinned pages in lower zones without underutilizing RAM, then once
pinned user pages can arbitrarily utilize lower zones, pinned kernel
allocations (which would not be relocatable) can be denied fallback
entirely without overall underutilization. I've actually already run
out of ideas here, so just people just saying what they want me to
write might help. Tests can be easily contrived (e.g. fill a swapless
box' upper zones with file-backed pagecache, then start allocating
anonymous pages), but realistic situations are much harder to trigger.

-- wli
