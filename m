Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310154AbSCFUJB>; Wed, 6 Mar 2002 15:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310155AbSCFUIw>; Wed, 6 Mar 2002 15:08:52 -0500
Received: from mark.mielke.cc ([216.209.85.42]:4106 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S310154AbSCFUIc>;
	Wed, 6 Mar 2002 15:08:32 -0500
Date: Wed, 6 Mar 2002 15:03:37 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Rose, Billy" <wrose@loislaw.com>
Cc: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
        Pavel Machek <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020306150337.A21655@mark.mielke.cc>
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD06307869@loisexc2.loislaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD06307869@loisexc2.loislaw.com>; from wrose@loislaw.com on Tue, Mar 05, 2002 at 05:04:11PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I had to choose between a file system that guaranteed recovery of
files within a relatively short timespan (60 seconds? 60 minutes? 
until it next happens to overwrite the blocks of data that the file
previously used?  the latter of the last two?), or a faster file
system with relatively no fragmentation on disk, I would choose the
faster file system with relatively no fragmentation on disk.

Unless you happen to reserve the blocks used by recently unlinked
inodes until some condition is reached (time, free block threshold,
...), there is no guarantee that your data exists 200ms after the user
removes the file. As such, by the time the user calls the
administrator to demand that the administrator restore their file that
they wrecklessly, or negligently removed, there is a possibility that
it is already gone. On a file server with many users all making
changes at the same time, the possibility of this to occur is only
significantly greater.

What is the value of having a few users being able to remove a few
files, and be able to restore them without using backups, every so
often, compared to people that find their computer speed limited by
the speed of their hard disk, and the file system that accesses the
hard disk? What of development time for Linux, and bloat for ext2/3?
"It is already bloated" isn't a true argument against. "It is already
bloated" is an argument that the bloat should be removed.

I appreciate your (Billy Rose) situation, however, there are
alternatives.  For one, if you can appreciate that your users should
be using some sort of configuration management software (such as CVS),
why not pursue that end? The benefits of using a configuration
management solution are more than being able to restore a file removed
by user error. One is able to allow parallel development among other
things.

"Undelete" support gives you nothing that a hammer to the head of
your users wouldn't give you.`

So... that leaves... what is "undelete" for? It is a pretty feature
that could be used once in a blue moon, that may not be reliable, that
if extended, would require a great deal of effort to extend, and would
likely affect the performance of the file system that supported it
either in terms of fragmentation, or efficiency, or both.

Usually additional figuring would eliminate the fragmentation concern,
and the reliability (ability to reliably make use of the future)
concern, but would degrade the efficiency. Less figuring would
eliminate the efficiency concern, but decrease reliability, and
increase fragmentation. Nothing comes for free.

Companies pay a lot of money for good backup support. They don't
bother assuming that the file system that they use 'might' be able to
restore the data.

On Tue, Mar 05, 2002 at 05:04:11PM -0600, Rose, Billy wrote:
> P.S. I got 2981.88 BogoMIPS today from a new install of RedHat 7.2 on a P4
> 1.5Ghz!

You'll have to update the BogoMIPS mini-howto. They document the highest
value as:

    1.2 The highest single-CPU Linux boot sequence BogoMips value 

    Gary Bridgewater, gbdsb@pacbell.net 
    Intel Pentium 4, at 1500 MHz 
    2962.23 BogoMips 

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

