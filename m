Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269197AbUIHXWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269197AbUIHXWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269208AbUIHXWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:22:30 -0400
Received: from unthought.net ([212.97.129.88]:29126 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S269197AbUIHXWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:22:12 -0400
Date: Thu, 9 Sep 2004 01:22:11 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040908232210.GL390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040908123524.GZ390@unthought.net> <20040909074046.A3958243@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909074046.A3958243@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:40:47AM +1000, Nathan Scott wrote:
> Hi there,
> 
...
> > 
> > A fairly simple patch is available, which solves the problem in the most
> > common cases.  This simple patch has *not*yet* been included in 2.6.8.1.
> > 
> 
> Have you asked Christoph if he thinks that patch is ready for
> inclusion?  Its possibly just fallen through the cracks.

With the feedback I've seen thus far, it seems that one possible
explanation for this is, that the patch only papers over the problem (by
changing XFS), but that the real problem is not in XFS and thus might be
fixed for real by a completely different set of patches (which sort of
makes sense since the small patch only cures the problem in the common
cases).

We'll know more about this tomorrow, hopefully, if Anders gets the new
test system up and running.

> > On the 24th of august, William Lee Irwin gives some suggestions and
> > mentions  "xfs has some known bad slab behavior."
> 
> Hmm?  Which message was that?

http://lkml.org/lkml/2004/8/24/140

> 
> > ...
> > While the small server seems to be running well now, the large one has
> > an average uptime of about one day (!)   Backups will crash it reliably,
> > when XFS doesn't OOM the box at random.
> 
> It would be a good idea to track the memory statistics while you're
> running your workloads to see where in particular the memory is being
> used when you hit OOM - /proc/{meminfo,slabinfo,buddyinfo}.

Slab usage in kilo-kilo-bytes (one K on the graph is one Megabyte):
  http://saaby.com/slabused.gif

This was presented earlier in
  http://lkml.org/lkml/2004/8/24/53

>  I'd also
> be interested to hear if that vfs_cache_pressure tweak that someone
> recommended helps your load at all, thanks.

Anders will hopefully get a lot of this testing done tomorrow - by then
hopefully we'll know a lot more about all this.

> 
> Is this xfsdump you're running for backups?

Veritas BackupExec was used, as far as I know

xfsdump will be tested soon.

The "small server" is backed up with tar (by Amanda).

> 
> > Is anyone actually maintaining/bugfixing XFS?
> 
> Yes, there's a group of people actively working on it.
> 
> > Yes, I know the MAINTAINERS file,
> 
> But haven't figured out how to use it yet?

Read on   ;)

> 
> > ...
> > trivial-to-trigger bugs that crash the system and have simple fixes,
> > have not been fixed in current mainline kernels.
> 
> If you have trivial-to-trigger bugs (or other bugs) then please let
> the folks at linux-xfs@oss.sgi.com know all the details (test cases,
> etc, are quite useful).

They've known for 7 months (bug 309 in your bugzilla), but the problem
is still trivially triggered in 2.6.8.1.

That's why I posted to LKML.

We got a lot of very useful feedback from a broad audience, and it seems
that it *might* turn out that this XFS problem was never really a
problem in XFS itself.

Let's see what tomorrow brings.

Thaks all!

-- 

 / jakob

