Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275808AbRJBFJJ>; Tue, 2 Oct 2001 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRJBFJA>; Tue, 2 Oct 2001 01:09:00 -0400
Received: from unthought.net ([212.97.129.24]:58011 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S275823AbRJBFIp>;
	Tue, 2 Oct 2001 01:08:45 -0400
Date: Tue, 2 Oct 2001 07:09:13 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Chris Andrews <chrisa@inweb.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
Message-ID: <20011002070913.A5302@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Chris Andrews <chrisa@inweb.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <00c401c14a71$f8c478f0$1e1cd2d5@chris>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <00c401c14a71$f8c478f0$1e1cd2d5@chris>; from chrisa@inweb.co.uk on Mon, Oct 01, 2001 at 01:09:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 01:09:50PM +0100, Chris Andrews wrote:
> Evan Harris (eharris@puremagic.com) said:
> 
> > I have a 6 disk RAID5 scsi array that had one disk go offline through a
> > dying power supply, taking the array into degraded mode, and then another
> > went offline a couple of hours later from what I think was a loose cable.
> 
> I had much the same happen, except that I lost 6 disks out of 12 (power
> failure to one external rack of two), so I had no chance of starting in
> degraded mode. In this situation, where there are not enough disks for a
> viable raid, what is the recommended solution? In my case, there was nothing
> wrong with the six disks, but their superblock event counters were out of
> step.

The solution is exactly the same as before:  re-create the array with N-1
disks, so that parity reconstruction will not begin.

Find the "oldest" disk and mark that one as failed - in case you lose an
entire rack of disks, any one of those should do.

Re-create the RAID, fsck (and don't worry about quite some inconsistency), and
most of your data should be back.

If you screw up (eg. re-order disks), your data will never know what hit them.

> 
> Is the best idea to modify /etc/raidtab as discussed, and run mkraid with
> the real force option? What I actually did was to hand-edit the superblocks
> on the disks, and got the array going. That experience would lead me to
> suggest that there's room for some more options to allow the use of disks
> where there's actually nothing wrong, but right now the raid code won't use
> them. I'm thinking of a set of '--ignore' options to raidstart:
> --ignore-eventcounter, --ignore-failedflag, etc, which an admin could use as
> an alternative to trying mkraid.

re-creating the RAID does exactly that: "hand-modifies" the superblocks to
let the array run again.

Your idea is pretty good:  if you did not have to re-write the superblocks from
the raidtab, you would not risk screwing up drive-ordering because of
inconsistent raidtabs.

I'd do a patch if I wasn't busy re-constructing/creating/moving/reconfiguring
RAID arrays right now  ;)

> 
> Right now it seems that software-raid works well, until it doesn't, at which
> point you're stuck - there's very little in the way of tools or overrides to
> sort problems out. Something other than 'try mkraid force as a last resort'
> would be useful.

You're not stuck.  You have plenty of options, just as you stated in your post.

With a hardware solution you'd be *stuck* - not as in "there's no pretty tool",
but as in "game over, sucker!"   ;)

But I agree with you that the process could be improved, and I really like your
suggestion with --ignore-eventcounter (or --try-recover maybe ?).

> 
> (If anyone thinks this is a good idea, yes, I am volunteering to provide
> patches...)

Aha !

I think it's a great idea !

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
