Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSJVWRL>; Tue, 22 Oct 2002 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSJVWRL>; Tue, 22 Oct 2002 18:17:11 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:21921 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264939AbSJVWRK>;
	Tue, 22 Oct 2002 18:17:10 -0400
Date: Wed, 23 Oct 2002 00:23:19 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: vm scenario tool / mincore(2) functionality for regular pages?
Message-ID: <20021022222319.GA18272@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>
References: <20021022184313.GA12081@outpost.ds9a.nl> <3DB5BBFC.479BE5DD@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB5BBFC.479BE5DD@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:58:36PM -0700, Andrew Morton wrote:

> mincore needs to be taught to walk pagetables and to look up
> stuff in swapcache.

As mincore appears to be entirely unstandardized, we can get away with
extending its functionality.

> Also it currently assumes that vma->vm_file is mapped linearly,
> so it will return incorrect results with Ingo's nonlinear mapping
> extensions.

It also appears to fail if the memory range it is offered lives in multiple
vmas. I'm unsure if this is possible, but I recall reading about mozilla
needing 'vma merging', which seems to imply that a process can have more of
them.

> But if we were to use Ingo's "file pte's" for all mmappings, mincore
> only needs to do the pte->pagecache lookup, so it can lose the
> "vma is linear" arithmetic.

The pagetable walking and swapcache lookup is orthogonal to this? 

By the way, version 0.1 which is mildly functional is on
http://ds9a.nl/vmloader-0.1.tar.gz , it currently does mincore only for
mmapped files. Use 'mkfile name 100' to create a 100mb file, 'map name' to
map it.

It is interesting to note that 2.4.20-pre9 allows me to allocate 250
megabytes and touch it sequentially without dire behaviour on a 186 megabyte
(or so) machine. RSS is a reasonable 153MB afterwards.

Reading that 250 megabytes from the start again however causes massive
swapping and takes way longer than the initial touching. Probably some kind
of 'use once' heuristic that is suddenly disabled.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
