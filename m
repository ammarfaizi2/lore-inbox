Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVC3T5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVC3T5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVC3T5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:57:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:16059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbVC3Txu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:53:50 -0500
Date: Wed, 30 Mar 2005 11:53:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: trond.myklebust@fys.uio.no, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-Id: <20050330115326.3c291016.akpm@osdl.org>
In-Reply-To: <20050330142056.GA3043@elte.hu>
References: <1112137487.5386.33.camel@mindpipe>
	<1112138283.11346.2.camel@lade.trondhjem.org>
	<1112139155.5386.35.camel@mindpipe>
	<1112139263.11892.0.camel@lade.trondhjem.org>
	<20050330080224.GB19683@elte.hu>
	<1112191860.10634.29.camel@lade.trondhjem.org>
	<20050330142056.GA3043@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > No. Coalescing on the client makes tons of sense. The overhead of
>  > sending 8 RPC requests for 4k writes instead of sending 1 RPC request
>  > for a single 32k write is huge: among other things, you end up tying up
>  > 8 RPC slots on the client + 8 nfsd threads on the server instead of just
>  > one of each.
> 
>  yes - coalescing a few pages makes sense, but linearly scanning 
>  thousands of entries is entirely pointless.

If each object has a unique ->wb_index then they could all be placed into a
radix tree rather than a list.  Use the gang-lookup functions to perform
the sorting.

