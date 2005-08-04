Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVHDPXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVHDPXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVHDPVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:21:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34945 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262577AbVHDPTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:19:40 -0400
Date: Thu, 4 Aug 2005 17:19:38 +0200
From: Andi Kleen <ak@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       cr@sap.com, linux-mm@kvack.org
Subject: Re: Getting rid of SHMMAX/SHMALL ?
Message-ID: <20050804151938.GZ8266@wotan.suse.de>
References: <20050804113941.GP8266@wotan.suse.de> <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com> <20050804132338.GT8266@wotan.suse.de> <20050804142040.GB22165@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804142040.GB22165@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 05:20:40PM +0300, Matti Aarnio wrote:
> SHM resources are non-swappable, thus I would not by default

Not true.

> let user programs go and allocate very much SHM spaces at all.
> Such is usually spelled as: "denial-of-service-attack"
> For that reason I would not raise builtin defaults either.

It is equivalent to allocating anymous memory in programs.

In theory you could limit it for each user by RLIMIT_NPROC*RLIMIT_AS,
but in practice that would be usually
If Linux ever gets a "max memory total used per user" rlimit it may make
sense to limit the shm growth caused by them to that, but that is not
there yet. In addition I want to point out that there are a zillion
of subsystems which can be used to allocate quite a lot of memory
(e.g. fill the socket buffers of a few hundred sockets)
So far nobody knows how to limit all of these and it's probably too hard
to do. The general wisdom is that if you want strong isolation like
that use a virtualized environment.

> > 
> > I think we should just get rid of the per process limit and keep
> > the global limit, but make it auto tuning based on available memory.
> 
> Err...  No thanks!   I would prefer to have even finer grained control
> of how much SHM somebody can allocate.  For normal user the value
> might be zero, but for users in a group "SHM1" there could be a level
> of N MB, etc.  (Except that such mechanisms are rather complex...)

shmmni will stay, although the defaults will be larger. If you really
want you can lower it, but in practice it won't buy you much if anything.

-Andi
