Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWB1WcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWB1WcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWB1WcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:32:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62926 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932657AbWB1WcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:32:02 -0500
Date: Tue, 28 Feb 2006 23:30:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Message-ID: <20060228223050.GA5831@elf.ucw.cz>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140686994.4672.4.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060223124152.GA4008@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 23-02-06 13:41:53, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Thursday 23 February 2006 10:29, Arjan van de Ven wrote:
> > > This patch adds an entry for a cleared page to the task struct. The main
> > > purpose of this patch is to be able to pre-allocate and clear a page in a
> > > pagefault scenario before taking any locks (esp mmap_sem),
> > > opportunistically. Allocating+clearing a page is an very expensive 
> > > operation that currently increases lock hold times quite bit (in a threaded 
> > > environment that allocates/use/frees memory on a regular basis, this leads
> > > to contention).
> > > 
> > > This is probably the most controversial patch of the 3, since there is
> > > a potential to take up 1 page per thread in this cache. In practice it's
> > > not as bad as it sounds (a large degree of the pagefaults are anonymous 
> > > and thus immediately use up the page). One could argue "let the VM reap
> > > these" but that has a few downsides; it increases locking needs but more,
> > > clearing a page is relatively expensive, if the VM reaps the page again
> > > in case it wasn't needed, the work was just wasted.
> > 
> > Looks like an incredible bad hack. What workload was that again where 
> > it helps? And how much? I think before we can consider adding that 
> > ugly code you would a far better rationale.
> 
> yes, the patch is controversial technologically, and Arjan pointed it 
> out above. This is nothing new - and Arjan probably submitted this to 
> lkml so that he can get contructive feedback.

Actually, I think I have to back Andi here. This looked like patch for
inclusion (signed-off, cc-ed Andrew). And yes, Arjan pointed out that
it is controversial, but the way patch was worded I could imagine
Andrew merging it...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
