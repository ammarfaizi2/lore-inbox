Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVJWSAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVJWSAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVJWSAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:00:51 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:59355 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750803AbVJWSAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:00:50 -0400
Message-ID: <435BCFB1.4010109@candelatech.com>
Date: Sun, 23 Oct 2005 11:00:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Reuben Farrelly <reuben-lkml@reub.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       acme@conectiva.com.br, davem@davemloft.net
Subject: Re: [3/3] [NEIGH] Fix timer leak in neigh_changeaddr
References: <43534273.2050106@reub.net> <E1ETaJB-0004a0-00@gondolin.me.apana.org.au> <20051023073331.GC17626@gondor.apana.org.au>
In-Reply-To: <20051023073331.GC17626@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> [NEIGH] Fix timer leak in neigh_changeaddr
> 
> neigh_changeaddr attempts to delete neighbour timers without setting
> nud_state.  This doesn't work because the timer may have already fired
> when we acquire the write lock in neigh_changeaddr.  The result is that
> the timer may keep firing for quite a while until the entry reaches
> NEIGH_FAILED.
> 
> It should be setting the nud_state straight away so that if the timer
> has already fired it can simply exit once we relinquish the lock.
> 
> In fact, this whole function is simply duplicating the logic in
> neigh_ifdown which in turn is already doing the right thing when
> it comes to deleting timers and setting nud_state.
> 
> So all we have to do is take that code out and put it into a common
> function and make both neigh_changeaddr and neigh_ifdown call it.

Thanks for all who reproduced and fixed this...I'm glad to know I wasn't
insane when I first tried to fix it and then couldn't reproduce
the problem anymore! :)

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

