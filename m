Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274671AbSITCXQ>; Thu, 19 Sep 2002 22:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbSITCXP>; Thu, 19 Sep 2002 22:23:15 -0400
Received: from ns.suse.de ([213.95.15.193]:5124 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S274671AbSITCXP>;
	Thu, 19 Sep 2002 22:23:15 -0400
Date: Fri, 20 Sep 2002 04:28:19 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, akpm@digeo.com, taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20020920042819.A1289@wotan.suse.de>
References: <20020920032346.A22949@wotan.suse.de> <20020919.182739.48496975.davem@redhat.com> <20020920040619.A30304@wotan.suse.de> <20020919.190154.57630807.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919.190154.57630807.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 07:01:54PM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Fri, 20 Sep 2002 04:06:19 +0200
> 
>    > See "montdq/movnti", the latter of which even works on register
>    > registers.  Ben LaHaise pointed this out to me earlier today.
>    
>    The issue is that you really want to do prefetching in these loops
>    (waiting for the hardware prefetch is too slow because it needs several
>    cache misses to trigger) so for cache hints on reading only prefetch
>    instructions are interesting.
>    
> I'm talking about using this to bypass the cache on the stores.
> The prefetches are a seperate issue and I agree with you on that.

I was talking generally. You cannot really use these instructions on Athlon,
because they're microcoded and slow or do not exist. On Athlon it needs
3dnow write combining functions (adding FPU overhead so may not be worth
it). On P3/P4 you can use movnti/movntdq yes.

Just doing it for reads is more tricky/dubious.

-Andi
