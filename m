Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUG0ETk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUG0ETk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 00:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUG0ETk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 00:19:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:5587 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266242AbUG0ETh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 00:19:37 -0400
Subject: Re: [PATCH] fix readahead breakage for sequential after random
	reads
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20040726170843.3fe5615c.akpm@osdl.org>
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	 <20040726162950.7f4a3cf4.akpm@osdl.org>
	 <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
	 <20040726170843.3fe5615c.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2004 21:18:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 17:08, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > Andrew,
> > 	Yes the patch fixes a valid bug.
> > 
> 
> Please don't top-post :(
> > RP
> > 
> > On Mon, 2004-07-26 at 16:29, Andrew Morton wrote:
> > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > Current readahead logic is broken when a random read pattern is
> > > >  followed by a long sequential read.  The cause is that on a window
> > > >  miss ra->next_size is set to ra->average, but ra->average is only
> > > >  updated at the end of a sequence, so window size will remain 1 until
> > > >  the end of the sequential read.
> > > > 
> > > >  This patch fixes this by taking the current sequence length into
> > > >  account (code taken from towards end of page_cache_readahead()), and
> > > >  also setting ra->average to a decent value in handle_ra_miss() when
> > > >  sequential access is detected.
> > > 
> > > Thanks.   Do you have any performance testing results from this patch?
> > > 
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > Andrew,
> > 	Yes the patch fixes a valid bug.
> 
> Fine, but the readahead code is performance-sensitive, and it takes quite
> some time for any regressions to be discovered.  So I'm going to need to
> either sit on this patch for a very long time, or extensively test it
> myself, or await convincing test results from someone else.
> 
> Can you help with that?

yes I will run all my standard testsuites before we take this patch.
(DSS workload, iozone, sysbench). I will get back with some results
sooon. Probably by the end of this week.

Also I think the bug that Miklos, found is really hard to reproduce. Did
he find this bug by code inspection? Its really really hard to get into
a state where the current window is of size 1 page with zero pages in
the readahead window, and then the sequential read pattern to just right
then. 

RP

> 

