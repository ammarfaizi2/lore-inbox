Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVKUWCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVKUWCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKUWCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:02:14 -0500
Received: from holomorphy.com ([66.93.40.71]:50329 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751116AbVKUWCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:02:13 -0500
Date: Mon, 21 Nov 2005 13:57:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Dave Airlie <airlied@gmail.com>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/11] unpaged: fix sound Bad page states
Message-ID: <20051121215710.GR6916@holomorphy.com>
References: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 06:12:38PM +0000, Hugh Dickins wrote:
> Earlier I unifdefed PageCompound, so that snd_pcm_mmap_control_nopage
> and others can give out a 0-order component of a higher-order page,
> which won't be mistakenly freed when zap_pte_range unmaps it.  But
> many Bad page states reported a PG_reserved was freed after all: I had
> missed that we need to say __GFP_COMP to get compound page behaviour.
> Some of these higher-order pages are allocated by snd_malloc_pages, some
> by snd_malloc_dev_pages; or if SBUS, by sbus_alloc_consistent - but that
> has no gfp arg, so add __GFP_COMP into its sparc32/64 implementations.
> I'm still rather puzzled that DRM seems not to need a similar change.
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
