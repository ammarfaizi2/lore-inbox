Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTJQKrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTJQKrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:47:51 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:44928 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263384AbTJQKrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:47:49 -0400
Date: Fri, 17 Oct 2003 11:49:11 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031017102436.GB10185@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <3F8BBC08.6030901@namesys.com>
 <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
 <20031017102436.GB10185@bitwizard.nl>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Rogier Wolff <R.E.Wolff@BitWizard.nl>:
> On Fri, Oct 17, 2003 at 06:40:01PM +0900, Norman Diamond wrote:
> > I explained to them why the LBA sector number should still get
> > reallocated even though the data are lost.
> 
> This is unbelievably bad: Sometimes it is worth it, to try and read
> the block again and again. We've seen blocks getting read after we've
> retried over 1000 times from "userspace". That doesn't include the
> retries that the drive did for us "behind the scenes". 

That's moving in to the realms of more advanced data recovery.  You
shouldn't really expect to be able to do those kind of forensics on
intellegent drives using standard filesystem system calls.

Besides, are you positive that you always got the correct data off the
disk?  See the discussions about hashing algorithms - maybe the drive
simply returned data that had an additional bit flipped and wasn't
identified as bad.  If you are having to try over 1000 times from
userspace, the drive is in a bad way.  You shouldn't really make
assumptions that you do usually, (that the error correction is good
enough to ensure bad data isn't returned as good data).  If you are
recovering data from a spreadsheet, for example, the errors could go
unnoticed, but have catastrophic results.

> If you manage to convince Toshiba to remap the sector on a "bad read",
> we'll never ever be able to recover the sector.

Of course you will - it's remapped, the data isn't overwritten!  You
may need more advanced tools, but you can still seek the heads to that
part of the platter and get data from the head-amp.  Just because you
couldn't use your simple method anymore is real reason to argue
against fixing the problem.

> We've also been able to provide a different environment (e.g. other
> ambient temperature) to a drive so that previously bad sectors could
> be read.
> 
> No, the only way is to realloc on write.

This may be more sensible, but not for the reasons you are suggesting,
and not in the way that you are suggesting.  I have nothing really
against not re-allocating on read, although ideally, it should be an
option, but marking the sector as "don't touch, don't even re-map in
case we confuse the OS", after a bad read is NOT acceptable in my
opinion.

In any case, a S.M.A.R.T. test should remap all suspect sectors - if
an admin has deliberately run a S.M.A.R.T. test, I think we can assume
they know what they are doing.

> (but it should remember that
> the data was bad, and treat the physical area with extra caution. It's
> possible that something happened while writing that sector, so that
> rewriting it this time will fix the problem for good, but on the other
> hand, that area of the drive demonstrated the abilitty to lose data,
> so you shouldn't trust any data to it!)

Suspect drive?  Bin it.  Do you really not value your data enough to
do that?

John.
