Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbRGLLUo>; Thu, 12 Jul 2001 07:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbRGLLUe>; Thu, 12 Jul 2001 07:20:34 -0400
Received: from www.wen-online.de ([212.223.88.39]:17683 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267474AbRGLLUZ>;
	Thu, 12 Jul 2001 07:20:25 -0400
Date: Thu, 12 Jul 2001 13:19:28 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Steffen Persvold <sp@scali.no>
cc: Ho Chak Hung <hunghochak@netscape.net>, <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages 4 order allocation failed
In-Reply-To: <3B4D527B.786F7461@scali.no>
Message-ID: <Pine.LNX.4.33.0107121233050.332-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Steffen Persvold wrote:

> Mike Galbraith wrote:
> >
> > On Wed, 11 Jul 2001, Ho Chak Hung wrote:
> >
> > > Hi,
> > > but there isn't any call in the module to allocate 4 order pages. There are only calls to allocate 0 order pages. alloc_pages(GFP_KERNEL, 0)is the only call to allocate page in the whole module.
> >
> > Then it's not your module :)
> >
> > Some driver may be asking for order 4, but settling for less when
> > that fails.
> >
> Why did this get worse on the 2.4 kernel ?. On 2.2 I always seemed to get my high order
> allocations  and GFP_ATOMIC seldom failed when there was available memory.

If 2.2 manages to service high order allocations better than 2.4, I'd
say it must be due to dumb luck more than anything else.  If you keep
most of your ram allocated (both 2.2 and 2.4 do), and don't do active
defragmentation (neither does), it's a roll of the dice whether you
have a contiguous chunk of ram to dole out or not.

wrt GFP_ATOMIC failing when memory is available, that doesn't happen
unless they are high order allocations.  If you mean caches when you
say 'available', cache pages are not necessarily reclaimable at all,
much less instantly as would be required to service atomic allocations.

	-Mike

