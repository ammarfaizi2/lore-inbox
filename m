Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269954AbTGPAEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTGPAEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:04:51 -0400
Received: from www.13thfloor.at ([212.16.59.250]:17085 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S269954AbTGPAEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:04:45 -0400
Date: Wed, 16 Jul 2003 02:19:43 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Jan Kara <jack@ucw.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Quota Hash Abstraction 2.4.22-pre6
Message-ID: <20030716001942.GA17459@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Jan Kara <jack@ucw.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20030715164049.GA27550@www.13thfloor.at> <20030715234507.GA25420@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030715234507.GA25420@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Honza!

On Wed, Jul 16, 2003 at 01:45:07AM +0200, Jan Kara wrote:
> > 
> > this is the first step, and it is neither tuned for
   ~~~~~~~~~~~~~~~~~~~~~~~
> > performance nor the final implementation, it's just 
> > a in-between step to some future quota enhancements 
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > like the folowing ...
> > 
> >  - faster and smaller quota hashes
>   Actually I think we don't care too much about performance here - the
> number of dquots is rougly #active_users*#filesystems_with_quota and we
> do lookup only on open()...

hmm, actually we do the lookup in each dqget, which from
dquot_initialize (open), dquot_transfer (chown,chgrp), 
and vfs_get_dqblk/vfs_set_dqblk (quota ctls) ...

but I agree that we do not care too much about performance ...

> >  - not only per super_block hashes, maybe per vfsmount?
>   For current quota you must have per super_block hashes. If you'd like
> to have some "directory based" one the per vfsmount makes sense.

exactly, this is one of the future quota enhancements, 
I have in mind ... not exactly directory based, but more
vfsmount based ... (which includes the superblock case)

> >  - not hardcoded user/group quota ...
>   After a quick look I don't see any changes wrt this. What exactly do
> you mean by this?

as I wrote "first step", "future quota enhancements" ...

this hopefully will be in the next step, or the step after ...

> >  - better interface for quota extensions
> > 
> > please, if somebody has any quota tests, which he/she
> > is willing to do on this code, or just want to do some 
> > testing with this code, do it and send me the results ...
> > 
> > I'm not interested in getting this into 2.4 without
>   Actually I don't think you'll be able to get some change like this to
> 2.4 but 2.6 might be possible.

at the moment, I do not care if this is for 2.4, 2.6 
or 2.8 or for my personal tree ;) I just want to test 
some of my ideas regarding quota improvements/extensions, 
and the current design isn't flexible enough to allow it ... 

>   BTW: don't you need some locking on dqhash list when
> creating/destorying hashes?

I guess this is right, but I assume the kernel lock 
will do nicely (any objections? if not I'll add that)

thanks for looking at it ... ;)

best,
Herbert 

