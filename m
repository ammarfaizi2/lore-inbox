Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWBWJnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWBWJnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWBWJnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:43:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:17631 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751678AbWBWJm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:42:59 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@intel.linux.com>
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Date: Thu, 23 Feb 2006 10:41:00 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140686994.4672.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1140686994.4672.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231041.00566.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 10:29, Arjan van de Ven wrote:
> This patch adds an entry for a cleared page to the task struct. The main
> purpose of this patch is to be able to pre-allocate and clear a page in a
> pagefault scenario before taking any locks (esp mmap_sem),
> opportunistically. Allocating+clearing a page is an very expensive 
> operation that currently increases lock hold times quite bit (in a threaded 
> environment that allocates/use/frees memory on a regular basis, this leads
> to contention).
> 
> This is probably the most controversial patch of the 3, since there is
> a potential to take up 1 page per thread in this cache. In practice it's
> not as bad as it sounds (a large degree of the pagefaults are anonymous 
> and thus immediately use up the page). One could argue "let the VM reap
> these" but that has a few downsides; it increases locking needs but more,
> clearing a page is relatively expensive, if the VM reaps the page again
> in case it wasn't needed, the work was just wasted.

Looks like an incredible bad hack. What workload was that again where it helps?
And how much? I think before we can consider adding that ugly code you would a far better
rationale.

-Andi

