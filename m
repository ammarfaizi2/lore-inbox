Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278707AbRJXSpG>; Wed, 24 Oct 2001 14:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278710AbRJXSo5>; Wed, 24 Oct 2001 14:44:57 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:8465 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S278707AbRJXSoh>; Wed, 24 Oct 2001 14:44:37 -0400
Date: Wed, 24 Oct 2001 13:44:27 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110241844.NAA32059@tomcat.admin.navo.hpc.mil>
To: jas88@cam.ac.uk, Rik van Riel <riel@conectiva.com.br>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
cc: Jan Kara <jack@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland <jas88@cam.ac.uk>:
> On Wed, 24 Oct 2001, Rik van Riel wrote:
> > On Wed, 24 Oct 2001, James Sutherland wrote:
> >
> > > Yep, you're right: you'd need to ascend the target directory tree,
> > > increasing the cumulative size all the way up, then do the move and
> > > decrement the old location's totals in the same way. All wrapped up in a
> > > transaction (on journalled FSs) or have fsck rebuild the totals on a dirty
> > > mount. Fairly clean and painless on a JFS,
> >
> > It's only clean and painless when you have infinite journal
> > space. When your filesystem's journal isn't big enough to
> > keep track of all the quota updates from an arbitrarily deep
> > directory tree, you're in big trouble.
> 
> Good point. You should be able to do it in constant space, though:
> identify the directory being modified, and the "height" to which you have
> ascended so far. That'll allow you to back out or redo the transaction
> later, which is enough I think?

There still remains the problem of hard links... They could be counted
in two or more trees as long as two or more trees exist on one filesystem.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
