Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUCLThl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCLThl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:37:41 -0500
Received: from mail.shareable.org ([81.29.64.88]:907 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262427AbUCLTgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:36:08 -0500
Date: Fri, 12 Mar 2004 19:35:47 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Mark_H_Johnson@raytheon.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mfedyk@matchmail.com,
       m.c.p@wolk-project.de, owner-linux-mm@kvack.org, plate@gmx.tm
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Message-ID: <20040312193547.GD18799@mail.shareable.org>
References: <OF62A00090.6117DDE8-ON86256E55.004FED23@raytheon.com> <4051D39D.80207@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4051D39D.80207@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> In Linux, all reclaim is driven by a memory shortage. Often it
> is just because more memory is being requested for more file
> cache.

Is reclaim the same as swapping, though?  I'd expect pages to be
written to the swapfile speculatively, before they are needed for
reclaim.  Is that one of those behaviours which everyone agrees is
sensible, but it's yet to be implemented in the 2.6 VM?

> But presumably if you are running into memory pressure, you really
> will need to free those free list pages, requiring the page to be
> read from disk when it is used again.

The idea is that you write pages to swap _before_ the memory pressure
arrives, which makes those pages available immediately when memory
pressure does arrive, provided they are still clean.  It's speculative.

I thought Linux did this already, but I don't know the current VM well.

-- Jamie
