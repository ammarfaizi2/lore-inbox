Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266779AbUGLKQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266779AbUGLKQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUGLKQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:16:57 -0400
Received: from gate.in-addr.de ([212.8.193.158]:55988 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S266779AbUGLKQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:16:54 -0400
Date: Mon, 12 Jul 2004 12:14:39 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Cc: Daniel Phillips <phillips@redhat.com>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712101439.GG3933@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407061734.51023.phillips@redhat.com> <20040707181650.GD12255@marowsky-bree.de> <200407072114.07291.phillips@redhat.com> <20040708091043.GS12255@marowsky-bree.de> <20040708105338.GA16115@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040708105338.GA16115@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-08T18:53:38,
   David Teigland <teigland@redhat.com> said:

> I'm afraid the fencing issue has been rather misrepresented.  Here's
> what we're doing (a lot of background is necessary I'm afraid.)  We
> have a symmetric, kernel-based, stand-alone cluster manager (CMAN)
> that has no ties to anything else whatsoever.  It'll simply run and
> answer the question "who's in the cluster?" by providing a list of
> names/nodeids.

Excuse my ignorance, but does this ensure that there's concensus among
the nodes about this membership?

> has quorum.  It's a very standard way of doing things -- we modelled it
> directly off the VMS-cluster style.  Whether you care about this quorum value
> or what you do with it are beside the point. 

OK, I agree with this. As long as the CMAN itself doesn't care about
this either but just reports it to the cluster, that's fine.

> What about Fencing?  Fencing is not a part of the cluster manager, not
> a part of the dlm and not a part of gfs.  It's an entirely independent
> system that runs on its own in userland.  It depends on cman for
> cluster information just like the dlm or gfs does.  I'll repeat what I
> said on the linux-cluster mailing list:

I doubt it can be entirely independent; or how do you implement lock
recovery without a fencing mechanism?

> This fencing system is suitable for us in our gfs/clvm work.  It's
> probably suitable for others, too.  For everyone? no. 

It sounds useful enough even for our work, given appropriate
notification of fencing events; instead of scheduling a fencing event,
we'd need to make sure that the node joins a fencing domain and later
block until receiving a notification. It's not as fine grained, but our
approach (based on the dependencies of the resources managed, basically)
might have been more fine grained than required in a typical
environment.

Yes, I can see how that could be made to work.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

