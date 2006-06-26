Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933043AbWFZVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbWFZVIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbWFZVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:08:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60867 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933043AbWFZVIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:08:47 -0400
Date: Mon, 26 Jun 2006 23:03:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060626210355.GA16827@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <4497EAC6.3050003@yahoo.com.au> <1150807630.3856.1372.camel@quoit.chygwyn.com> <44980064.6040306@yahoo.com.au> <20060623144530.GA32291@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623144530.GA32291@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > The part where you needed file_read_actor looks like pretty much a stright
> > cut and paste from __generic_file_aio_read, which indicates that you might
> > be exporting at the wrong level.
> 
> A definitive NACK to this export.  All other filesystems manage to use 
> the generic file read code so GFS should do so aswell.  And there's a 
> technical reason for not exporting aswell as the generic file read 
> interface is far too complicated already.

GFS is different here mostly due to locking, because one of its strong 
features is an implementation of pretty strict POSIX semantics in a 
clustered environment, something that no other Linux FS (that is 
available in source code) has done so far. (OCFS2 does not do it as 
strictly - it has a very specific application in mind)

so i'd reformulate your request as a request to extend the VFS to unify 
clustering filesystems - which is a nice cleanup goal but not a merge 
showstopper to me.

> > Not sure about the tty_ export. Would it be better to make a generic 
> > printfish interface on top of it and also replace the interesting 
> > dquot.c gymnastics? (I don't know)
> 
> In fact neither gfs nor dquot should use it at all.  The xfs quota 
> code is fine without this nonsense.

yeah, the tty_ export is unnecessary and should be fixed. But this seems 
quite easy to do.

	Ingo
