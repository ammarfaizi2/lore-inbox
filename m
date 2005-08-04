Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVHDVoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVHDVoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVHDVnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:43:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:51386 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262738AbVHDVld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:41:33 -0400
Date: Thu, 4 Aug 2005 23:41:32 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA policy interface
Message-ID: <20050804214132.GF8266@wotan.suse.de>
References: <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net> <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net> <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net> <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net> <20050804211445.GE8266@wotan.suse.de> <Pine.LNX.4.62.0508041416490.10150@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508041416490.10150@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 02:21:09PM -0700, Christoph Lameter wrote:
> Yes he mentioned that patch earlier in this thread.
> 
> > > 5. No means to figure out where the memory was allocated although
> > >    mempoliy.c implements scans over ptes that would allow that 
> > >    determination.
> > 
> > You lost me here.
> 
> There is this scan over the page table that verifies if all nodes are 
> allocated according to the policy. That scan could easily be used to 
> provide a map to the application (and to /proc/<pid>/smap) of where the

The application can already get it. But it's an ugly feature
that I only used for debugging and I was actually considering
to remove it.

Doing it for external users is a completely different thing though.
I still think those have business in messing with other people's
virtual addresses. In addition I expect it will cause problems
longer term
(did you ever look why mmap on /proc/*/mem is not allowed - it used
to be long ago, but it was impossible to make it work race free and
before that was always a gapping security hole) 

> > > The long term impact of this missing functionality is already showing 
> > > in the numbers of workarounds that I have seen at a various sites, 
> > 
> > Examples? 
> 
> Two of the high profile ones are NASA and APA. One person from the APA 
> posted in one of our earlier discussions.

Ok. I think for those the swapoff per process is the right because
simplest and easiest solution. No complex patch sets needed,
just some changes to an existing code path.

If they cannot afford enough disk space it might be possible
to do the page migration in swap cache like Hugh proposed.

-Andi

