Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTJQTec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJQTec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:34:32 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:46466 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263587AbTJQTeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:34:19 -0400
Date: Fri, 17 Oct 2003 20:35:36 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m3zng0yun9.fsf@defiant.pm.waw.pl>
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
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Krzysztof Halasa <khc@pm.waw.pl>:
> John Bradford <john@grabjohn.com> writes:
> 
> > Besides, are you positive that you always got the correct data off the
> > disk?  See the discussions about hashing algorithms - maybe the drive
> > simply returned data that had an additional bit flipped and wasn't
> > identified as bad.
> 
> One bit? No chance. The same as with ECC RAM - one bit error will always
> be detected.

I said an _additional_ bit.  I am assuming that N-1 reads returned the
same, (bad), data, which was identified as bad.  Read N encountered
one too many flipped bits and returned a false positive.  Perfectly
possible, and arguably more likely than all of the existing incorrect
bits flipping back, resulting in the correct data being read back, in
some cases.

> >  If you are having to try over 1000 times from
> > userspace, the drive is in a bad way.  You shouldn't really make
> > assumptions that you do usually, (that the error correction is good
> > enough to ensure bad data isn't returned as good data).  If you are
> > recovering data from a spreadsheet, for example, the errors could go
> > unnoticed, but have catastrophic results.
> 
> Then you have to abandon using any hard drivers. Or computers at all.

Hardly.  The point I was trying to make is that the likelyhood of a
critical fault is greater when you are experiencing many non-critical
faults.

> Well, mirrors (with read-and-compare) are probably good enough for you,
> but it has to be done at application level.
> 
> > Of course you will - it's remapped, the data isn't overwritten!  You
> > may need more advanced tools,
> 
> = in practice, it's lost. Have you seen such tools?

Tell this to the drive manufacturers.  They are the ones who can sell
you a specialist firmware if you want to do data recovery, not me.

> > but you can still seek the heads to that
> > part of the platter and get data from the head-amp.  Just because you
> > couldn't use your simple method anymore is real reason to argue
> > against fixing the problem.
> 
> against _changing_ the problem (it doesn't go away), breaking things
> which are now sane.

Your argument is flawed - how can you claim the current situation is
sane when at least some drive manufactuers don't publish simple facts
such as what happens when defective blocks are encountered on reads
and on writes?

> > This may be more sensible, but not for the reasons you are suggesting,
> > and not in the way that you are suggesting.
> 
> Then note that a drive can be temporarily unable to read most of the
> data - due to, say, incorrect supply voltage or very high level of
> electromagnetic interferences.

If a system got in to a state as extreme as that, I'd generally take
the hole system down.  Electromagnatic interference that affects one
drive immediately noticably may well be affecting other components in
subtle ways - possible _silent_ data corruption in other words.

> Would you like to trash _all_ your data in such case automatically?

Yes.  Or more specifically, I wouldn't trust that data without
verifying it.  It's easy to ignore such problems and say that
everything is probably OK, and maybe 99% of the time you would be
right, but so what?  What about that 1%?

> > Suspect drive?  Bin it.  Do you really not value your data enough to
> > do that?
> 
> Do you really not value your data enough to mark it as inaccessible?

Not sure what you mean - in what context?

> If it comes to non-standard recovery then you should rather go for
> backups.

Data recovery is always a last resort.  On the other hand, backing up
data daily can still result in 23 hours of lost data, so I consider
early detection of faulty disks very important.  Mirroring brings it's
own problems to consider - more devices to possibly fail, and if they
are connected to the same controller, a serious fault with any one
could usually theoretically destroy all of them.

John.
