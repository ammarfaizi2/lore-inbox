Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269202AbRHGR1g>; Tue, 7 Aug 2001 13:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269212AbRHGR10>; Tue, 7 Aug 2001 13:27:26 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:34457 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S269202AbRHGR1J>; Tue, 7 Aug 2001 13:27:09 -0400
Date: Tue, 7 Aug 2001 13:41:56 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Jan Kara <jack@suse.cz>
cc: Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk quotas not staying in sync?
In-Reply-To: <20010807175132.D13001@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.31.0108071311110.3577-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just completed the change to Alan's kernel with ext3 and of course the
new quota code.  Here are my wrapping up comments along with replying to
myself a little bit.

On Tue, 7 Aug 2001, Jan Kara wrote:

>   And anyway if root deletes file of some user, allocation is removed from
> user so it doesn't matter. Can you check if output of df(1) changes
> appropriately to deleted files - in other case the files might just
> remain somewhere unlinked but open..

I figured that if anyone removed the file it would come out of the user's
quota.  It wouldn't make sense any other way, but was just making sure.

I didn't get a chance to look at the output of df.  But I know from before
when I was updating my glibc that open but unlinked files can be a real
pain.

There is a similar thread going on with someone else deleting files from a
quota enabled partition and not seeing the space being freed up.  The
files that were being deleted from the user's home directory shouldn't
have been open by any program.  Week old mail, year old webpages.  But
still deleting them was not freeing them from the total quota usage
(immediately).  It did seem that it might have been possible that the
quotas were freed later, but I don't have any good observed evidence
either way.  Is it possible that the quota code itself in the kernel was
keeping the files open?

> > I have run quotacheck once at boot to see if it would help.  It got the
> > stuff in sync for a little while, but soon I started to see the same
> > problem again.  quotacheck on a cold cache takes a LONG time to run.

I just got done with a reboot and quotacheck, everything syched up nicely,
I'm hoping it stays that way this time.

> > So when is ext3 going in the kernel?  (ducks)  But really that is
> > something I will look at.

What do you know, the -ac patches now include ext3, how nice.  I guess
they do play well together.  :)

>   You may also try also just some quota fixes from
> ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/quota-fix-2.4.7-2.diff.gz
>   But they are mostly tested only with other patch implementing new quota
> format (can be found in same directory as quota-patch-2.4.7-1.diff.gz).

Well I went with 2.4.7-ac8, as it included everything I was looking for in
one nice package (tested with -ac4 at home, figured I'd try out the
joural, hit the reset, had the kernel hang with the read-write mount bug,
spent the next hour or so beating my head trying to figure out how to get
back into my machine when I had no boot disks with newer e2fsutils, when I
finally got everything straight, I checked my mail to see the bug reported
and -ac5, well it was a learning experience. :)

> Jan Kara <jack@suse.cz>
> SuSE Labs

Ah, just the person I was looking for.  I probally should have made this a
seperate e-mail, but I'm on a roll.  If you just have comments about this
part, please take it off list, unless you think it is important to anyone
else.

Just 2 little things.

One, repquota in quota-tools 3.0-pre8 is many, many times slower than the
same command in the 2.0 package.  Is there anything that can be done about
that?  I used to use it to get a quick overview of people who were running
up on their quota (thank you for the longer username display along with
the ' ' before the --).  But now my interactive scripts take a long time
to run.

Two, the configure script in 3.0-pre8 looks for and fails to find
ext2fs.h, and says that direct support won't be compiled, but quotacheck
still links against libext2fs (I found out the hard way. :).


Thanks everyone, Andreas for the first reply, Jan for this one, and Alan
keep those patches coming the techs love it when I reboot the server,
-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

