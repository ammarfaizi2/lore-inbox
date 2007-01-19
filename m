Return-Path: <linux-kernel-owner+w=401wt.eu-S932832AbXASS1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbXASS1N (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXASS1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:27:13 -0500
Received: from pat.uio.no ([129.240.10.15]:60523 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932832AbXASS1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:27:12 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, pj@sgi.com
In-Reply-To: <1169229461.6197.154.camel@twins>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
	 <1169070763.5975.70.camel@lappy>
	 <1169070886.6523.8.camel@lade.trondhjem.org>
	 <1169126868.6197.55.camel@twins>
	 <1169135375.6105.15.camel@lade.trondhjem.org>
	 <1169199234.6197.129.camel@twins> <1169212022.6197.148.camel@twins>
	 <Pine.LNX.4.64.0701190912540.14617@schroedinger.engr.sgi.com>
	 <1169229461.6197.154.camel@twins>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 13:26:52 -0500
Message-Id: <1169231212.5775.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.5, required=12.0, autolearn=disabled, AWL=-2.500)
X-UiO-Scanned: 18AAF535D1D4F7ED2BD0D7B73330F43BE3BC0074
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: -24 maxlevel 200 minaction 2 bait 0 mail/h: 150 total 22585 max/h 22585 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 18:57 +0100, Peter Zijlstra wrote:
> On Fri, 2007-01-19 at 09:20 -0800, Christoph Lameter wrote:
> > On Fri, 19 Jan 2007, Peter Zijlstra wrote:
> > 
> > > +	/*
> > > +	 * NFS congestion size, scale with available memory.
> > > +	 *
> > 
> > Well this all depends on the memory available to the running process.
> > If the process is just allowed to allocate from a subset of memory 
> > (cpusets) then this may need to be lower.
> > 
> > > +	 *  64MB:    8192k
> > > +	 * 128MB:   11585k
> > > +	 * 256MB:   16384k
> > > +	 * 512MB:   23170k
> > > +	 *   1GB:   32768k
> > > +	 *   2GB:   46340k
> > > +	 *   4GB:   65536k
> > > +	 *   8GB:   92681k
> > > +	 *  16GB:  131072k
> > 
> > Hmmm... lets say we have the worst case of an 8TB IA64 system with 1k 
> > nodes of 8G each.
> 
> Eeuh, right. Glad to have you around to remind how puny my boxens
> are :-)
> 
> >  On Ia64 the number of pages is 8TB/16KB pagesize = 512 
> > million pages. Thus nfs_congestion_size is 724064 pages which is 
> > 11.1Gbytes?
> > 
> > If we now restrict a cpuset to a single node then have a 
> > nfs_congestion_size of 11.1G vs an available memory on a node of 8G.
> 
> Right, perhaps cap this to a max of 256M. That would allow 128 2M RPC
> transfers, much more would not be needed I guess. Trond?

That would be good as a default, but I've been thinking that we could
perhaps also add a sysctl in /proc/sys/fs/nfs in order to make it a
tunable?

Cheers,
  Trond

