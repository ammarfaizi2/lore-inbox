Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWE3BMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWE3BMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWE3BMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:12:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751535AbWE3BMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:12:47 -0400
Date: Mon, 29 May 2006 18:17:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/6] statistics infrastructure
Message-Id: <20060529181701.05981487.akpm@osdl.org>
In-Reply-To: <1148941028.3005.72.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060524155735.04ed777a.akpm@osdl.org>
	<1148941028.3005.72.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 00:17:08 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> > > +static void statistic_set_sparse(struct statistic *stat, s64 value, u64 total)
> > > +{
> > > +	struct statistic_sparse_list *slist = (struct statistic_sparse_list *)
> > > +						stat->pdata;
> > 
> > Hang on, what's happening here?  statistic.pdata is `struct percpu_data *'.
> > That's
> > 
> > struct percpu_data {
> > 	void *ptrs[NR_CPUS];
> > };
> > 
> > How can we cast that to a statistic_sparse_list* and then start playing
> > with it?  We're supposed to use per_cpu_ptr() to get at the actual data.
> 
> With regard to the data that a statistic feeds on, there are are two
> types of statistics: statistics that accumulate incremental updates
> (pushed - probably frequently - through statistic_add() or
> statistic_inc()), and statistics that accept total numbers (pulled
> through statistic_set() only when read by user). We use per-cpu data for
> the former. As to the latter, per-cpu data would be way to heavy.
> That is why, my code is capable of dealing with both per-cpu data and
> non-per-cpu data. Since a particular statistic is either per-cpu or
> non-per-cpu, I use the same data pointer for both cases in order to keep
> struct statistic as small as possible.
> 
> I admit the cast looks a bit fishy. But lines above are correct.

<head spins>

Perhaps a suitable comment somewhere so people don't fall out of their
chairs when they see this like I did?

