Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUGGVPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUGGVPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUGGVPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:15:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:39907 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265354AbUGGVPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:15:02 -0400
Subject: Re: Unnecessary barrier in sync_page()?
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040707210608.GS28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet>
	 <20040707182025.GJ28479@dualathlon.random>
	 <20040707112953.0157383e.akpm@osdl.org>
	 <20040707184202.GN28479@dualathlon.random>
	 <1089233823.3956.80.camel@watt.suse.com>
	 <20040707210608.GS28479@dualathlon.random>
Content-Type: text/plain
Message-Id: <1089234901.3956.88.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 17:15:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 17:06, Andrea Arcangeli wrote:
> On Wed, Jul 07, 2004 at 04:57:04PM -0400, Chris Mason wrote:
> > I wasn't worried about the locked bit when I added the barrier, my goal
> > was to order things with people that set page->mapping to null.
> 
> page->mapping cannot change from NULL to non-NULL there.
> 
> it can only change from non-NULL to NULL, and there's no way to
> serialize with the truncate without taking the page lock.
> 
> The one extremely important fix you did around the same time, has been
> to "cache" the value of "mapping" in the kernel stack, so that it
> remains the same during the while function (so that it cannot start
> non-NULL an finish NULL). But the smp_mb() itself cannot make a
> difference as far as I can tell.

As Andrew pointed out back then, page->mapping can go to null, but even
if we have a stale copy of page->mapping, the mapping can't be freed. 
So you're right that it should be enough to keep the change to cache the
value of mapping.  

I was hunting the backing dev info bugs back then, and seem to have
talked myself into the barriers while testing...

-chris


