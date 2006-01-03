Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWACOWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWACOWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWACOWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:22:04 -0500
Received: from hera.kernel.org ([140.211.167.34]:25323 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751425AbWACOWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:22:02 -0500
Date: Tue, 3 Jan 2006 10:21:09 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/9] clockpro-clockpro.patch
Message-ID: <20060103122109.GC5288@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> <20051230224312.765.58575.sendpatchset@twins.localnet> <20051231224021.GA5184@dmt.cnet> <1136111854.17853.77.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136111854.17853.77.camel@twins>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 11:37:34AM +0100, Peter Zijlstra wrote:
> On Sat, 2005-12-31 at 20:40 -0200, Marcelo Tosatti wrote:
> > On Fri, Dec 30, 2005 at 11:43:34PM +0100, Peter Zijlstra wrote:
> > > 
> > > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > Peter,
> > 
> > I tried your "scan-shared.c" proggy which loops over 140M of a file
> > using mmap (on a 128MB box). The number of loops was configured to "5".
> > 
> > The amount of major/minor pagefaults was exactly the same between
> > vanilla and clockpro, isnt the clockpro algorithm supposed to be
> > superior than LRU in such "sequential scan of MEMSIZE+1" cases?
> 
> yes it should, hmm, have to look at that then.
> 
> What should happen is that nr_cold_target should drop to the bare
> minimum, which effectivly pins all hot pages and only rotates the few
> cold pages.

I screwed up the tests. Here are the real numbers.

Test: scan 140MB file sequentially, 5 times.
Env: 128Mb machine

CLOCK-Pro:	0:49:98elapsed	18%CPU
		7358maj+95308min

vanilla:
		1:28.05elapsed	11%CPU
		12950maj+166374min

Kicking some large arses!

