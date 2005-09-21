Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVIUPEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVIUPEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVIUPEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:04:06 -0400
Received: from ns.suse.de ([195.135.220.2]:7638 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750975AbVIUPEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:04:05 -0400
Date: Wed, 21 Sep 2005 17:04:04 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Daniel Jacobowitz <dan@debian.org>, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20050921150404.GD12810@verdi.suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <1127242785.11080.20.camel@cog.beaverton.ibm.com> <20050921040342.GA7175@nevyn.them.org> <200509211015.09356.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509211015.09356.raybry@mpdtxmail.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:15:08AM -0500, Ray Bryant wrote:
> On Tuesday 20 September 2005 23:03, Daniel Jacobowitz wrote:
> 
> >
> > FYI, at least I have reproduced this without powernow loaded.
> 
> There are cases that we are aware of where the TSC will count slower while the 
> processor is halted.    This can make TSC's get out of sync on dual cores.

Ok thanks for the confirmation. I guess John's patch is ok then.
Drawback is much slower to extremly slow gettimeofday  (depending
if the chipset/BIOS has usable HPET, most seem not to) 

> 
> I wonder if you can reproduce this problem while also running a pair of cpu 
> bound tasks on your dual core box.   If you can't, then this is the culprit.
> 
> In general, however, on multisocket systems, you can't depend on TSC's being 
> synchronized between sockets, so all of this is moot.   We just have to deal 
> with it. 

We handle this, but single socket dual core was special cased because
I was told previously it should be ok.

-Andi
