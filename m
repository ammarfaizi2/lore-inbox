Return-Path: <linux-kernel-owner+w=401wt.eu-S932300AbXAIRgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbXAIRgR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbXAIRgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:36:17 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54634 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293AbXAIRgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:36:16 -0500
Date: Tue, 9 Jan 2007 12:34:27 -0500
Message-Id: <200701091734.l09HYRHB009290@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Jan Kara <jack@suse.cz>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Tue, 09 Jan 2007 13:26:45 +0100."
             <20070109122644.GB1260@atrey.karlin.mff.cuni.cz> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20070109122644.GB1260@atrey.karlin.mff.cuni.cz>, Jan Kara writes:
> > In message <20070108111852.ee156a90.akpm@osdl.org>, Andrew Morton writes:
> > > On Sun,  7 Jan 2007 23:12:53 -0500
> > > "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> > > 
> > > > +Modifying a Unionfs branch directly, while the union is mounted, is
> > > > +currently unsupported.
> > > 
> > > Does this mean that if I have /a/b/ and /c/d/ unionised under /mnt/union, I
> > > am not allowed to alter anything under /a/b/ and /c/d/?  That I may only
> > > alter stuff under /mnt/union?
> > > 
> > > If so, that sounds like a significant limitation.
>   <snip>
> > Now, we've discussed a number of possible solutions.  Thanks to suggestions
> > we got at OLS, we discussed a way to hide the lower namespace, or make it
> > readonly, using existing kernel facilities.  But my understanding is that
> > even it'd work, it'd only address new processes: if an existing process has
> > an open fd in a lower branch before we "lock up" the lower branch's name
> > space, that process may still be able to make lower-level changes.
> > Detecting such processes may not be easy.  What to do with them, once
> > detected, is also unclear.  We welcome suggestions.
>   Yes, making fs readonly at VFS level would not work for already opened
> files. But you if you create new union, you could lock down the
> filesystems you are unioning (via s_umount semaphore), go through lists
> of all open fd's on those filesystems and check whether they are open
> for write or not. If some fd is open for writing, you simply fail to
> create the union (and it's upto user to solve the problem). Otherwise
> you mark filesystems as RO and safely proceed with creating the union.
> I guess you must have come up with this solution. So what is the problem
> with it?

Jan, all of it is duable: we can downgrade the f/s to readonly, grab various
locks, search through various lists looking for open fd's and such, then
decide if to allow the mount or not.  And hopefully all of that can be done
in a non-racy manner.  But it feels just rather hacky and ugly to me.  If
this community will endorse such a solution, we'll be happy to develop it.
But right now my impression is that if we posted such patches today, some
people will have to wipe the vomit off of their monitors... :-)

Seriously, can someone suggest a step-by-step procedure to handling this
issue, maybe even sprinkle some pseudo code there?  Is there a procedure
that is clean and acceptable to all?  We'd love to hear it.

> 								Honza
> -- 
> Jan Kara <jack@suse.cz>
> SuSE CR Labs

Thanks,
Erez.
