Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268066AbRGZPIA>; Thu, 26 Jul 2001 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268026AbRGZPHu>; Thu, 26 Jul 2001 11:07:50 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:46213 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S268063AbRGZPHk>; Thu, 26 Jul 2001 11:07:40 -0400
Date: Thu, 26 Jul 2001 17:07:44 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RFC: chattr/lsattr +DS? was: ext3-2.4-0.9.4
Message-ID: <20010726170744.T17244@emma1.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>, <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au>, <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <3B602494.784F0315@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B602494.784F0315@zip.com.au>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Andrew Morton wrote:

> > Would you deem it
> > possible to get such an option done before ext3fs 1.0.0?
> 
> We'd prefer not - we're trying to stabilise things quite
> sternly at present. However that doesn't prevent work
> on 1.1.0 :)
> 
> Seems like a worthwhile thing to do - I'll cut a branch
> and do this.  It'll take a couple of weeks - as usual, most
> of the work is in development and use of test tools...
> But I can't predict at this time when we'll merge it into
> the mainline fs.

So the summary of all this is, as I understand it: for ext3fs 1.0, treat
it with chattr +S and the like as if it was ext2fs, it may or may not be
faster with "mount -o data=journalled" and is well worthwhile for an MTA
to try, a weaker sync option may be introduced after ext3fs 1.0.

Sounds good.

I'm dropping the ext3-users mailing list for now since this is getting
more general.


However, since the ReiserFS team also showed interest in a similar
functionality, and they don't yet support chattr, would it be useful to
specify a "D" option for chattr already?

I have a suggestion: if D is set, but S isn't, no effect. If S is set,
but D is unset, treat S as in the past. If S is set, and D is set,
directory updates are synchronous like with S, but data updates are
asynchronous in spite of S.

This way, booting a kernel without chattr "D" flag support or mounting
the file system as ext2 would have it default to the safer
everything-synchronously mode.

-- 
Matthias Andree
