Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268904AbRHGPwA>; Tue, 7 Aug 2001 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268938AbRHGPvu>; Tue, 7 Aug 2001 11:51:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58386 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268904AbRHGPvp>; Tue, 7 Aug 2001 11:51:45 -0400
Date: Tue, 7 Aug 2001 17:51:32 +0200
From: Jan Kara <jack@suse.cz>
To: Chris Meadors <clubneon@hereintown.net>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk quotas not staying in sync?
Message-ID: <20010807175132.D13001@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200108011806.f71I6Ht1006946@webber.adilger.int> <Pine.LNX.4.31.0108011514410.4569-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.31.0108011514410.4569-100000@rc.priv.hereintown.net>; from clubneon@hereintown.net on Wed, Aug 01, 2001 at 03:25:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> > Maybe the problem is caused by root/admin deleting another users files?
> 
> I thought of that first.  But the techs that were deleting mail were
> actually `su`ing to the user and using pine to delete the messages.  So I
> was wondering if pine was doing something strange.  But since we use
> Maildirs when I was cleaning up an account I just `rm`ed their e-mails and
> still ended up seeing the same problem.
  And anyway if root deletes file of some user, allocation is removed from
user so it doesn't matter. Can you check if output of df(1) changes
appropriately to deleted files - in other case the files might just
remain somewhere unlinked but open..

> > Do you run quotacheck at boot time?  It is possible with ext2 that the
> > on-disk quotas are not in sync with the actual files if there is a crash.
> > If you use ext3 then the quota updates and other filesystem updates are
> > kept atomic.
> 
> I have run quotacheck once at boot to see if it would help.  It got the
> stuff in sync for a little while, but soon I started to see the same
> problem again.  quotacheck on a cold cache takes a LONG time to run.
> 
> So when is ext3 going in the kernel?  (ducks)  But really that is
> something I will look at.
> 
> > > Any ideas?  This machine is pretty much standard.  ext2 file systems on
> > > all partitions.  /home is the only one with user disk quotas.  Running
> > > 2.4.7 kernel (but I've seen it in all 2.4 kernels, I was running
> > > 2.4.0-prerelease on the machine when I first put it up, so I don't know
> > > how 2.2 works).
> 
> One thing I forgot to mention about the machine, it is an SMP PIII box.  I
> was really meaning to say it was SMP cause that might be something to look
> at.
> 
> > You should also try the -ac kernels.  I'm pretty sure that they have
> > some fixes to the quota code.  However, I _think_ the changes are not
> > compatible with the non-ac kernel quota on-disk data, so you will have
> > to re-build the quota files (a small price to pay if it actually works).
  You may also try also just some quota fixes from
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/quota-fix-2.4.7-2.diff.gz
  But they are mostly tested only with other patch implementing new quota
format (can be found in same directory as quota-patch-2.4.7-1.diff.gz).

							Honza

--
Jan Kara <jack@suse.cz>
SuSE Labs
