Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275044AbSITFEX>; Fri, 20 Sep 2002 01:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275045AbSITFEX>; Fri, 20 Sep 2002 01:04:23 -0400
Received: from holomorphy.com ([66.224.33.161]:902 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275044AbSITFEW>;
	Fri, 20 Sep 2002 01:04:22 -0400
Date: Thu, 19 Sep 2002 22:03:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [patch] remove page->virtual
Message-ID: <20020920050320.GH3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D8AAA58.41BC835F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8AAA58.41BC835F@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 09:55:52PM -0700, Andrew Morton wrote:
> set_page_address() and page_address() implementations consume 0.4% and
> 1.3% of CPU time respectively.   I think that's OK. (Plus the tested code
> was doing an unneeded lookup in set_page_address(), for debug purposes)

Looks yummy. I'll take it for a spin tonight on my benchmark-o-matic.
Clearing some more air in ZONE_NORMAL is always welcome here.


On Thu, Sep 19, 2002 at 09:55:52PM -0700, Andrew Morton wrote:
> c01884f2 6914     10.5108     .text.lock.dir
> c01546b3 5847     8.88872     .text.lock.namei
> c01eb99e 3811     5.79355     .text.lock.dec_and_lock
> c01515dc 3775     5.73883     link_path_walk
> c015207c 3567     5.42262     path_lookup
> c015aba4 3194     4.85558     __d_lookup
> c01eb690 2814     4.2779      __generic_copy_to_user
> c01eb950 2562     3.8948      atomic_dec_and_lock
> c0187580 2473     3.7595      ext2_readdir
> c0155d3c 2172     3.30192     filldir64
> c0151114 1786     2.71511     path_release
> c0145b6a 1753     2.66494     .text.lock.open

What's going on here? fs stuff is really hurting. At any rate, the
overhead of the address calculation and hashtable lookup is microscopic
according to this, and I want space.


Cheers,
Bill
