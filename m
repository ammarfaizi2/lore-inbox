Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbQLAKZT>; Fri, 1 Dec 2000 05:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLAKZK>; Fri, 1 Dec 2000 05:25:10 -0500
Received: from Unable.to.handle.kernel.NULL.pointer.dereference.de ([212.6.215.146]:50182
	"EHLO inode.real-linux.de") by vger.kernel.org with ESMTP
	id <S129475AbQLAKY7>; Fri, 1 Dec 2000 05:24:59 -0500
Date: Fri, 1 Dec 2000 10:52:33 +0100
From: Florian Heinz <sky@sysv.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some problems with the raid-stuff in 2.4.0-test12pre3
Message-ID: <20001201105233.D672@inode.real-linux.de>
In-Reply-To: <20001130123322.A672@inode.real-linux.de> <14887.2273.174231.960990@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14887.2273.174231.960990@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Fri, Dec 01, 2000 at 01:11:45PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 01:11:45PM +1100, Neil Brown wrote:
> On Thursday November 30, sky@dereference.de wrote:
> > Hello people,
> > 
> > I have some trouble with the raid-stuff.
> > My machine is a Pentium-III, 256 MB ram and 7 scsi-disks (IBM DNES-318350W
> > 17B). I'm using raid5 for 6 of these disks (chunk-size 8).
> > Machine boots, I do mkraid /dev/md0 and then mke2fs /dev/md0 and that's
> > where the problems start. mkfs tries to write 684 inode-tables and after the
> > first 30 it gets very slow. ps ax (with wchan) tells me it hangs in
> > wakeup_bdflush.
> > I'm rather sure it's related to the raidcode, because without raid the disks
> > work as expected.
> > I'm using an Adaptec 7892A with the aic7xxx-driver, I have disabled the TCQ
> > and the extra checks for the new queueing code, but I have tried with both
> > activated, too.
> > No related messages from the kernel in the syslog.
> > It worked fine with 2.2.x.
> 
> Is it just "very slow", but it eventually finishes, it is it so slow,
> that it actually stops and doesn't make any progress at all?
> 
> raid5 in 2.4 is definately slower than in 2.2.  Could that be all that
> you are seeing?

It's so slow that it's unusable. Especially writing. open() and
close()-calls often hang for 20 seconds or more.
write-calls hang for 3-4 seconds. This has to be a bug.
But yes, after a long time, it finishes ;)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
