Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269232AbRHGRf4>; Tue, 7 Aug 2001 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269234AbRHGRfq>; Tue, 7 Aug 2001 13:35:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59913 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269222AbRHGRfe>; Tue, 7 Aug 2001 13:35:34 -0400
Date: Tue, 7 Aug 2001 19:35:30 +0200
From: Jan Kara <jack@suse.cz>
To: Chris Meadors <clubneon@hereintown.net>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk quotas not staying in sync?
Message-ID: <20010807193530.A32704@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010807175132.D13001@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.31.0108071311110.3577-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.31.0108071311110.3577-100000@rc.priv.hereintown.net>; from clubneon@hereintown.net on Tue, Aug 07, 2001 at 01:41:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Tue, 7 Aug 2001, Jan Kara wrote:
> 
> >   And anyway if root deletes file of some user, allocation is removed from
> > user so it doesn't matter. Can you check if output of df(1) changes
> > appropriately to deleted files - in other case the files might just
> > remain somewhere unlinked but open..
> 
> I figured that if anyone removed the file it would come out of the user's
> quota.  It wouldn't make sense any other way, but was just making sure.
> I didn't get a chance to look at the output of df.  But I know from before
> when I was updating my glibc that open but unlinked files can be a real
> pain.
  Yes they can :).

> There is a similar thread going on with someone else deleting files from a
> quota enabled partition and not seeing the space being freed up.  The
> files that were being deleted from the user's home directory shouldn't
> have been open by any program.  Week old mail, year old webpages.  But
> still deleting them was not freeing them from the total quota usage
> (immediately).  It did seem that it might have been possible that the
> quotas were freed later, but I don't have any good observed evidence
> either way.  Is it possible that the quota code itself in the kernel was
> keeping the files open?
  No. Quota has opened only quotafiles. It doesn't open any other files.
That's why I think quota has no direct impact on disk space not being freed
(what is - if I understood it well - the problem in that l-k thread).
I can imagine leak in accounting of used space for quotas but not anywhere
else...

> > > I have run quotacheck once at boot to see if it would help.  It got the
> > > stuff in sync for a little while, but soon I started to see the same
> > > problem again.  quotacheck on a cold cache takes a LONG time to run.
> 
> I just got done with a reboot and quotacheck, everything syched up nicely,
> I'm hoping it stays that way this time.
  Hope too but I'm curious about that leak :).


							Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
