Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUCWK0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUCWK0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:26:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:26764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbUCWKZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:25:48 -0500
Date: Tue, 23 Mar 2004 02:25:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: tiwai@suse.de, andrea@suse.de, rml@ximian.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-Id: <20040323022540.2c0c7154.akpm@osdl.org>
In-Reply-To: <20040323101755.GC3676@in.ibm.com>
References: <20040323101755.GC3676@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> Here is the RCU patch for low scheduling latency Andrew was talking
> about in the other thread. I had done some measurements with
> amlat on a 2.4 GHz P4 xeon box with 256MB memory running dbench
> and it reduced worst case scheduling latencies from 800 microseconds
> to about 400 microseconds.
> 
> It uses per-cpu kernel threads to execute excess callbacks and
> pretty much relies on preemption.

Is simple enough.  Do you expect this will help with the route cache
reaping problem?  I do think it's a bit hard to justify purely on the basis
of the scheduling latency goodness.

> +			list_splice(&RCU_rcudlist(cpu), &list);
> +			INIT_LIST_HEAD(&RCU_rcudlist(cpu));

We have list_splice_init().

