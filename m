Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVCaHSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVCaHSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVCaHSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:18:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:43700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbVCaHSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:18:21 -0500
Date: Wed, 30 Mar 2005 23:18:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: trond.myklebust@fys.uio.no, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-Id: <20050330231801.129b0715.akpm@osdl.org>
In-Reply-To: <20050331065942.GA14952@elte.hu>
References: <1112137487.5386.33.camel@mindpipe>
	<1112138283.11346.2.camel@lade.trondhjem.org>
	<1112192778.17365.2.camel@mindpipe>
	<1112194256.10634.35.camel@lade.trondhjem.org>
	<20050330115640.0bc38d01.akpm@osdl.org>
	<1112217299.10771.3.camel@lade.trondhjem.org>
	<1112236017.26732.4.camel@mindpipe>
	<20050330183957.2468dc21.akpm@osdl.org>
	<1112237239.26732.8.camel@mindpipe>
	<1112240918.10975.4.camel@lade.trondhjem.org>
	<20050331065942.GA14952@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
>  * Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
>  > > The 7 ms are spent in this loop:
>  >
>  > Which is basically confirming what the guys from Bull already told me, 
>  > namely that the radix tree tag stuff is much less efficient that what 
>  > we've got now. I never saw their patches, though, so I was curious to 
>  > try it for myself.
> 
>  i think the numbers are being misinterpreted. I believe this patch is a 
>  big step forward. The big thing is that nfs_list_add_request() is O(1) 
>  now - while _a single request addition to the sorted list_ triggered the 
>  1+ msec latency in Lee's previous trace.

Well.  The radix-tree approach's best-case is probably quite a lot worse
than the list-based approach's best-case.  It hits a lot more cachelines
and involves a lot more code.

But of course the radix-tree's worst-case will be far better than list's.

And presumably that list-based code rarely hits the worst-case, else it
would have been changed by now.

