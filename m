Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTJRI0j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 04:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTJRI0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 04:26:39 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5760 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261500AbTJRI0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 04:26:34 -0400
Date: Sat, 18 Oct 2003 09:27:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310180827.h9I8Rxw8000383@81-2-122-30.bradfords.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m37k33igui.fsf@defiant.pm.waw.pl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <3F8BBC08.6030901@namesys.com>
 <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
 <20031017102436.GB10185@bitwizard.nl>
 <200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
 <m3zng0yun9.fsf@defiant.pm.waw.pl>
 <200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk>
 <m37k33igui.fsf@defiant.pm.waw.pl>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is off-topic for linux-kernel.  Please move the discussion
elsewhere if you want to continue it.

> > I said an _additional_ bit.  I am assuming that N-1 reads returned the
> > same, (bad), data, which was identified as bad.  Read N encountered
> > one too many flipped bits and returned a false positive.  Perfectly
> > possible, and arguably more likely than all of the existing incorrect
> > bits flipping back, resulting in the correct data being read back, in
> > some cases.
> 
> In some cases, theoretically, yes. But I've never got anything like that
> in practice.
> 
> BTW: Hard drives apparently use more sophisticated algorithms,
> involving measuring head signal level even when there is no problem
> reading the data, and eventually remapping a sector on read before the
> information is lost.

Yes, but some blocks on drives that are used for archiving data may
not have been read for months or even years.  They may have multiple
errors which have not been detected and remapped.

This is a simplified example, but say in one particular drive, the
error correction can cope with around 25% of the bits on the platter
being incorrect, and still recover the data.  If 50% of the bits are
incorrect, and you read it N-1 times and get an error, but get no
error on try N, what is more likely, that suddenly there are only 25%
incorrect bits or that 51% are now wrong, and you are getting a false
positive?

Now, I am not saying that the false positive is always more likely - a
change in temperature, or slight head movement so that it is reading
the track off-centre and getting a less corrupted signal as a result,
could make the error rate drop to 25%, but I wouldn't assume that had
happened.

> > Tell this to the drive manufacturers.  They are the ones who can sell
> > you a specialist firmware if you want to do data recovery, not me.
> 
> Maybe. But, you know, it's Linux and I don't want to pay for additional
> software just to use disks already paid for. Especially when it's all
> working fine now.

Well, the original firmware wasn't 'free' in any sense of the word, so
I wouldn't expect a more advanced firmware to be 'free' either.

Drive manufacturers could sell advanced firmware to data recovery
companies for a price that would pay for itself after 3-4 data
recovery jobs.  Given that you could then do far more advanced
recovery then people could themselves, I am suprised this hasn't
happened before.  Of course, free and open firmware would be nice in
general, but that hasn't arrived yet.

Besides, I don't think it is all working fine now.  About your only
method of data recovery is to retry reading a bad block over and over
again, possibly varying things like the temperature of the drive.  You
can't get the raw bits off of the platter, or accurately position the
heads off-centre from the tracks, for example.

> > Your argument is flawed - how can you claim the current situation is
> > sane when at least some drive manufactuers don't publish simple facts
> > such as what happens when defective blocks are encountered on reads
> > and on writes?
> 
> Do you think you can make them publish such things? It would be great.
> 
> > If a system got in to a state as extreme as that, I'd generally take
> > the hole system down.  Electromagnatic interference that affects one
> > drive immediately noticably may well be affecting other components in
> > subtle ways - possible _silent_ data corruption in other words.
> 
> Possibly. Possibly the machine will immediately freeze. But data on
> disk platters will probably be ok, and you'll be able to read it
> when the conditions are back in specs.

Possibly, but look at the wider picture - data in RAM may be badly
corrupted.  If you shut down the machine gracefully, that corrupted
data may get written to disk.  If you force the machine off, that data
is lost.  Either way, I wouldn't just turn it back on and hope for the
best.  OK, if it was my own data, or there was a good reason to, (for
example, the client decides that time is more critical than data
integrity), maybe I would, but if somebody is paying for consultancy,
especially if it is at a rate that makes the cost of a hard disk
fairly insignificant, then not at least considering the possibility of
silent data corruption is irresponsible.  Concluding that the risk of
data corruption is so small that it is insignificant may suffice in
some cases, but not necessarily all of them.

> > Yes.  Or more specifically, I wouldn't trust that data without
> > verifying it.  It's easy to ignore such problems and say that
> > everything is probably OK, and maybe 99% of the time you would be
> > right, but so what?  What about that 1%?
> 
> That's not 1% - rather something like 10^-17 or so.
> See the specs.

Hmmm, that sounds like you're talking about the chance of an error in
a single block.

If a machine starts showing sudden, noticable problems because of
something like a volate spike, I don't think you can reliably predict
what may have happened to data in RAM, including the cache on the
disk, which will presumably be flushed when you powrer down, unless
the disk has been put in to a very confused state by the voltage
spike, or whatever else has caused the problem.

Infact, if a PSU is failing, how do you know mains voltage won't
suddenly fly through the machine?  Don't claim that has never
happened!

> And we have CRCs all over the place - damaged .gnumeric file will
> probably fail gunzip stage.

Yes, but presumably you want to identify such a corrupted file _now_
instead of in 6 months time.  Verifying CRCs may well be sufficient in
many cases, I am not disputing that.

> BTW: the probability of silently corrupting, say, (D)RAM contents is
> much much higher than that of corrupting HDD data. Even if you use
> ECC RAM.

In a typical machine, usually yes.

> > > Do you really not value your data enough to mark it as inaccessible?
> > 
> > Not sure what you mean - in what context?
> 
> Remapping a sector on read without actually copying the data makes
> it inaccessible. Unless you have manufacturer-provided software, of
> course, but I haven't seen any.

On a very busy proxy or news server, maybe you'd rather remap the
sector, write zeros to the new one, and obtain a new copy of the data
over the network, without the disk spending ages trying to recover the
data.  If the disk is part of an array, and another disk got your data
for you, you might want to remap the sector immediately.

Although, to be honest, except where performance is critical, remap on
read is pointless.  It saves you from having to identify the bad block
again when you write to it.  Generally, guaranteed remap on write is
what I want.  What happens on read is less important if your data
isn't intact.  I can see your point of view for not re-mapping on read
given that advanced firmwares are not available, and the fact that it
allows you to do some form of data recovery.  Overall, though, if it
gets to the point where you have to start doing such data recovery,
downtime is usually significant, and for some applications, having the
data in a week's time may be little more than useless.  Predicting
possible disk fauliures is a good idea.

> > Data recovery is always a last resort.  On the other hand, backing up
> > data daily can still result in 23 hours of lost data, so I consider
> > early detection of faulty disks very important.  Mirroring brings it's
> > own problems to consider - more devices to possibly fail, and if they
> > are connected to the same controller, a serious fault with any one
> > could usually theoretically destroy all of them.
> 
> It all depends on requirements. If you need 100% uninterrupted service
> you can use mirrored servers, possibly installed in different locations.
> This will fix potential problems, while remapping on failed read will
> not.

I never actually suggested that remapping on an unrecovered failed
read would solve any data integrity problems.

I did suggest that data which was recovered automatically by the drive
on a second or subsequent read should result in a remapping of that
block.

My most important point is that writes should never fail on a good
drive.  If they do, I would not use the drive for critical data
anymore.  Presumably typical drive firmware will try several times to
do a write before reporting an error to the user - presumably it would
have to incase one or more replacement blocks are bad too.  Maybe such
failiures were temporary, caused by a voltage spike, for example, but
it would still be the case that the drive couldn't get itself back in
to a good state and retry the operation, and I would be suspicious of
it being reliable in the long term.

John.
