Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317854AbSFNAFp>; Thu, 13 Jun 2002 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSFNAFo>; Thu, 13 Jun 2002 20:05:44 -0400
Received: from holomorphy.com ([66.224.33.161]:18086 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317854AbSFNAFn>;
	Thu, 13 Jun 2002 20:05:43 -0400
Date: Thu, 13 Jun 2002 17:05:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Alexander Viro <viro@math.psu.edu>, engler@csl.Stanford.EDU,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Message-ID: <20020614000506.GJ22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, Alexander Viro <viro@math.psu.edu>,
	engler@csl.Stanford.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <m3d6uvxdts.fsf@averell.firstfloor.org> <Pine.GSO.4.21.0206131420010.20315-100000@weyl.math.psu.edu> <20020613210130.A27417@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 09:01:30PM +0200, Andi Kleen wrote:
> if you see all possible paths through the program as a tree which branches 
> for every decision then you only need to cut off the branches that are 
> actually pointing upward the tree again. This would still allow to follow
> down into the callees of the recursive function because there should be 
> at least one path that is non recursive (if not Checker should definitely
> complain ;) 
> e.g.
>        ----<-----------------+
> 	   v                     |
>  IF   TRUE                RECURSION
> -------+------ some path ----+
>        |
> 	  ELSE                    non recursive path 
>        +-------------------------- other functions ---------->
> Other functions can be still checked, you only need to prune the cycle.
> I have no idea if checker's algorithms actually work like this, but I could
> imagine that it would be one possible implementation.

Why would you do it this way? AFAICT this is more naturally phrased as
cycle detection in a digraph.

Cheers,
Bill
