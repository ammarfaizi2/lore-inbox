Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUKGAL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUKGAL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 19:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKGALZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 19:11:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:29141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbUKGALW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 19:11:22 -0500
Date: Sat, 6 Nov 2004 16:11:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: balance_pgdat(): where is total_scanned ever updated?
Message-Id: <20041106161114.1cbb512b.akpm@osdl.org>
In-Reply-To: <200411061418_MC3-1-8E17-8B6C@compuserve.com>
References: <200411061418_MC3-1-8E17-8B6C@compuserve.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Kernel version is 2.6.9, but I see no updates to this function in BK-current.
> How is total_scanned ever updated?  AFAICT it is always zero.

It's a bug which was introduced months ago when we added struct
reclaim_state.

> In mm/vmscan.c:balance_pgdat(), there are these references to total_scanned
> (missing whitepace indicated by "^"):
> 
> 
>  977:        int total_scanned, total_reclaimed;
> 
>  983:        total_scanned = 0;
> 
> 1076:                        if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
> 1077:                            total_scanned > total_reclaimed+total_reclaimed/2)
>                                                                ^ ^             ^ ^
> 
> 1088:                if (total_scanned && priority < DEF_PRIORITY - 2)
> 
> 
> Could this be part of the problems with reclaim?  Or have I missed something?

I had a patch which fixes it in -mm for a while.  It does increase the
number of pages which are reclaimed via direct reclaim and decreases the
number of pages which are reclaimed by kswapd.  As one would expect from
throttling kswapd.  This seems undesirable.

I'm leaving this alone until it can be demonstrated that fixing it improves
kernel behaviour in some manner.

