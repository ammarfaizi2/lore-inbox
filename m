Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264439AbVBDWen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbVBDWen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbVBDWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:18:55 -0500
Received: from sd291.sivit.org ([194.146.225.122]:15324 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S266670AbVBDVkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:40:18 -0500
Date: Fri, 4 Feb 2005 22:40:16 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204214015.GF5028@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204201157.GN27707@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 12:11:57PM -0800, Larry McVoy wrote:

> > > So, do you think you can sign up the usual suspects to being happy with
> > > this answer?
> > 
> > I'll let them answer themselves.
> 
> You'll need to rally them to speak up or this is going nowhere.  We
> can't afford to spend engineering dollars one unhappy person at a time
> to try and get you happy.  We need concensus.

I understand.

> > > And do you mind spelling out exactly what it is that you
> > > think is being offered so there is no confusion later?
> > 
> > Informaly, exactly what I said before: Be able to find enough information
> > in the CVS tree which would allow anybody to trace back each change
> > to what was submitted by the author of the change (= patch + comment).
> 
> Yup, seems reasonable.

I'm glad we agree on this.

> > (and know I agreed at the moment), but thinking again about this I'm not
> > sure anymore how "sticking the BK changeset key into the delta history"
> > gives us "BK level granularity". From what I understand (but you are the
> > SCM expert not me so I may be missing something) there is exactly 
> > one delta per 'trunk' changeset, so if you have a file being modified
> > several times on a branch you will end with one single delta which is
> > the merge of the separate patches. I'm not sure how, by adding several
> > 'BK changeset keys' into the log entry of the merged delta you make
> > one able to resplit the delta later.
> 
> First, you have to remember that BK is capturing 96% of the deltas made
> to files.  Some of those deltas get clumped into one CVS commit because
> of the flattening of the graph structure.  If each delta had the
> changeset key for the BK changeset to which it belonged you could 
> split the coarse commit into the sub patches which happened on the
> collapsed branch.  You wouldn't get 100% of the information but you'd
> have 96% of it in a way that could be used for debugging, which is what
> I suspect you are after.  

Isn't what you're proposing just making more simpler the same thing one
could already do today by a smart analysis of the log message contents ?

Explanation: Looking at a merge changeset log, one can split the log
into parts and then search from the set of files containing deltas in
this changeset the ones having each message part. Based on that, 
individual sub-patches can be reconstruct. Yeah, it is prone to errors
if log messages are identical, but it would probably work most of the
time.

I still fail to see how one could get the sub-patches from changes
happening to *a same file*, like I was asking previously. Or is this
part what you call 'the 4% loss' ?

This isn't theoretical at all, it's very practical: suppose I have to
make several changes to, let's say, drivers/usb/Makefile. There are
several logical changes so I make a couple of incremental patches, just
like the kernel developers like.

I send those patches to Greg KH, he puts them into BK, and later on
Linus pulls from this tree. My changes go into the Linus tree using
a BK branch, and finally get exported to CVS as _a single delta_.

Now, suppose one of my patches introduced a problem. How can someone
not using BK isolate the patch which introduced the problem ? All he
can do is to back out the entire set of patches, and the whole point
of having split the patch initialy into logical changes is lost.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
