Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVBUMqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVBUMqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 07:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVBUMqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 07:46:45 -0500
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:20084 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261960AbVBUMqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 07:46:42 -0500
Date: Mon, 21 Feb 2005 07:41:54 -0500
From: David Roundy <droundy@abridgegame.org>
To: darcs-users@darcs.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050221124153.GB27294@abridgegame.org>
Mail-Followup-To: darcs-users@darcs.net, linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <845b6e8705021803533ba8cc34@mail.gmail.com> <20050218125057.GE2071@opteron.random> <200502190410.31960.pmcfarland@downeast.net> <20050219164213.GB7247@opteron.random> <20050219171457.GA20285@abridgegame.org> <20050219175348.GE7247@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219175348.GE7247@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 06:53:48PM +0100, Andrea Arcangeli wrote:
> On Sat, Feb 19, 2005 at 12:15:02PM -0500, David Roundy wrote:
> > The linux-2.5 tree right now (I'm re-doing the conversion, and am up to
> > October of last year, so far) is at 141M, if you don't count the pristine
> > cache or working directory.  That's already compressed, so you don't get
> > any extra bonuses.  Darcs stores with each changeset both the old and new
> > versions of each hunk, which gives you some redundancy, and probably
> > accounts for the factor of two greater size than CVS.  This gives a bit of
> > redundancy, which can be helpful in cases of repository corruption.
> 
> Double size of the compressed backup is about the same as SVM with fsfs
> (not tested on l-k tree but in something much smaller). Why not to
> simply checksum instead of having data redundancy? Knowing when
> something is corrupted is a great feature, but doing raid1 without the
> user asking for it, is a worthless overhead.

There are internal issues that would cause trouble here--darcs assumes that
if it knows a given patch, it also knows the patch's inverse.

> > I hope to someday (when more pressing issues are dealt with) add a per-file
> > cache indicating which patches affect which files, which should largely
> > address this problem, although it won't help at all with files that are
> > touched by most of the changesets, and won't be optimimal in any case. :(
> 
> Wouldn't using the CVS format help an order of magnitude here? With
> CVS/SCCS format you can extract all the patchsets that affected a single
> file in a extremely efficient manner, memory utilization will be
> extremely low too (like in cvsps indeed). You'll only have to lookup the
> "global changeset file", and then open the few ,v files that are
> affected and extract their patchsets. cvsps does this optimally
> already. The only difference is that what cvsps is a "readonly" cache,
> while with a real SCM it would be a global file that control all the
> changesets in an atomic way.

The catch is that then we'd have to implement a smart server to keep users
from having to download the entire history with each update.  That's not a
fundamentally hard issue, but it would definitely degrade darcs' ease of
use, besides putting additional load on the server.  So if something like
this were implemented, I think it would definitely have to be as an
optional format.

Also, we couldn't actually store the data in CVS/SCCS format, since in
darcs a patch to a single file isn't uniquely determined by two states of
that file.  But storing separately the patches relevant to different files
would definitely be an optimization worth considering.
-- 
David Roundy
http://www.darcs.net
