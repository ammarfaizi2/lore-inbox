Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbVKBVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbVKBVsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbVKBVsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:48:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:2740 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965267AbVKBVsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:48:45 -0500
Subject: Re: Nick's core remove PageReserved broke vmware...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
	 <4368139A.30701@vc.cvut.cz>
	 <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
	 <1130965454.20136.50.camel@gaston>
	 <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 08:45:36 +1100
Message-Id: <1130967936.20136.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 21:41 +0000, Hugh Dickins wrote:

> The only extant problem here is if the pages are private, and you
> fork while this is going on, and the parent user process writes to the
> area before completion: then COW leaves the child with the page being
> DMAed into, giving the parent a copied page which may be incomplete.

Won't happen, and if it does, it's a user error to rely on that working,
so it doesn't matter.

> It's important that any necessary COW be done at get_user_pages time,
> if there's any possibility that you'll be DMAing into them.  So when
> in doubt, call it for write access.

True, I forgot about COW... it still annoys me to mark dirty pages that
may not be in the end... but hell, the main usefulness of this DMA stuff
is DMA to memory anyway (AGP is good enough for the other direction most
of the time).

> Take a look at Andrew's educational comment on set_page_dirty_lock
> in mm/page-writeback.c.  You do have the list of pages you need to
> page_cache_release, don't you?  So it should be easy to dirty them.

Ok, so just passing 'write' to get_user_pages() is good enough; right ?

Thanks,
Ben.


