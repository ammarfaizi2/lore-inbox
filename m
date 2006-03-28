Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWC1XHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWC1XHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWC1XG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:06:59 -0500
Received: from ultra7.eskimo.com ([204.122.16.70]:24583 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S964799AbWC1XG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:06:58 -0500
Date: Tue, 28 Mar 2006 15:05:59 -0800
From: Elladan <elladan@eskimo.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
Message-ID: <20060328230559.GI28146@eskimo.com>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet> <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 10:15:47AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 23 Mar 2006, Marcelo Tosatti wrote:
> > 
> > IMHO the page replacement framework intent is wider than fixing the     
> > currently known performance problems.
> > 
> > It allows easier implementation of new algorithms, which are being
> > invented/adapted over time as necessity appears.
> 
> Yes and no.
> 
> It smells wonderful for a pluggable page replacement standpoint, but 
> here's a couple of observations/questions:
>  a) the current one actually seems to have beaten the on-comers (except 
>     for loads that were actually made up to try to defeat LRU)
>  b) is page replacement actually a huge issue?
> 
> Now, the reason I ask about (b) is that these days, you buy a Mac Mini, 
> and it comes with half a gig of RAM, and some apple users seem to worry 
> about the fact that the UMA graphics removes 50MB or something of that is 
> a problem.

Data point:

I run into swap all the time on my 1gig machine.  There are a few reasons for
this.

* Applications are incredibly bloated.  Just running a bunch of gnome apps
  sucks down 1000 megs almost instantly.  However, these apps don't seem to use
  most of the space they bloat into, so after a bit of fighting for VM the
  chaff gets forced out and they run fine.

* Apps are also incredibly buggy.  Eg. Firefox seems to leak up to 50 megs per
  second in some workloads, so I run it for a day or two and my machine tends
  to go heavily into swap.

* VM system prefers disk cache over applications.  Eg. updated runs at 
  3am and indexes all my files.  Since the applications were idle, the 
  VM decides to page out all my executables and fill my ram with page 
  cache which is only used once.  In the morning, my machine spends a few
  minutes paging everything back in.

* Similarly, I have a 2gig machine available, and it's also showing about 512MB
  swapped out and also 500MB free.

-J
