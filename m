Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVBDQHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVBDQHB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbVBDQHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:07:00 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:51135 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S261815AbVBDQGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:06:36 -0500
Date: Fri, 4 Feb 2005 08:06:31 -0800
To: Stelian Pop <stelian@popies.net>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204160631.GB26748@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204130127.GA3467@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 02:01:27PM +0100, Stelian Pop wrote:
> On Thu, Feb 03, 2005 at 02:28:54PM -0800, Larry McVoy wrote:
> 
> > > > 		CVS		BitKeeper [*]
> > > > 	Deltas	235,956		280,212
> > > 
> > > Indeed, for now the differences are rather small. But with more and
> > > more BK trees and more merges between them the proportion will raise.
> > 
> > Actually that's not been the case to date, it's held pretty constant
> > and in fact the ratio has gotten better.  The last time we visited 
> > these numbers it wasn't as good as it is today in CVS>
> 
> In fact I am looking at the number of *changesets*, not the sum of all
> file revisions.
> 
> 			CVS		BitKeeper
> 	Changesets:	26419		59220 (minus 6994 empty merges)
> 
> This isn't 16%, its more or less 50%, and this is the loss I was
> complaining about.
> 
> It is true that 34% of the changesets could be recreated by analysing
> the 'per file' commit logs, but the 16% are not recreatable (those
> 16% correspond to the case when someone makes several changes to a same
> file without pushing to Linus between the two).

You need to rethink your math, you are way off.  I'll explain it so that
the rest of the people can see this is just pure FUD.  

To make sure this was apples to apples I went to the BK and CVS trees
which are in lock step and reran the numbers:

			CVS		BitKeeper	% in CVS
	file deltas	210,609		218,742		96%
	changsets	26,603		59,220		44%

You are not factoring out the ChangeSet deltas, which are BK metadata, 
they aren't part of the source tree.  If you remove those then the
difference between CVS and BK revision history is 209K deltas vs
221K deltas.  

In other words, the CVS tree is missing no more than 4% of the deltas
to the source files.

READ THAT AGAIN, PLEASE.

The CVS tree has 96% of all the deltas to all your source files.  96%.  

My good friend Stelian would have you believe that you are missing 50%
of your data when in fact you are missing NONE of your data, you have 
ALL of your data in an almost the identical form.

What Stelian is complaining about is the patch set which is easily 
extractable from CVS is at a coarser granularity than the patch set
extractable from BK.  That's true but so what?  Before BK you only
a handful of patches between releases, now you have thousands.

I suppose what we could do is stick the BK changeset key into the 
delta history so that if you really wanted to get the BK level
granularity you could.  

> [describes violating the license]
> But you may consider this contrary to the 'non competitor' clause of
> the BKL (clause 3d), that's why I need some authorization from you
> before starting.

And you most certainly do not have it, as you are aware it is a
violation of the license.  Asking for an exception is about as polite as
me asking for an exception from the GPL's requirements.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
