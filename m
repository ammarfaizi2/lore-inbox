Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbRGZUlA>; Thu, 26 Jul 2001 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbRGZUku>; Thu, 26 Jul 2001 16:40:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:27923 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268654AbRGZUkl>; Thu, 26 Jul 2001 16:40:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: ext3-2.4-0.9.4
Date: Thu, 26 Jul 2001 22:45:21 +0200
X-Mailer: KMail [version 1.2]
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> <0107261731550N.00907@starship> <3B603BEC.CF55FEAB@zip.com.au>
In-Reply-To: <3B603BEC.CF55FEAB@zip.com.au>
MIME-Version: 1.0
Message-Id: <01072622452102.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 26 July 2001 17:49, Andrew Morton wrote:
> Daniel Phillips wrote:
> > Ext3 does *not* leave a
> > lot of dirty blocks hanging around in normal operation, so sync is
> > not nearly as slow as it is with good old Ext2.
>
> eek.
>
> In fully-journalled data mode, we write everything to the journal
> in a linear chunk, wait on it, write a commit block, wait on that
> and then release all the just-journalled data into the main
> filesystem for conventional bdflush/kupdate writeback in twenty
> seconds time.
>
> Calling anything which uses fsync_dev() would cause all that
> writeback data to be written out and waited on, with the
> consequential seeking storm.  Disastrous.

Whoops, ok, no, this is not particularly sync-friendly.  On the other
hand, I don't think your seek storm would be as bad as all that.  You
can still feed enough blocks to the elevator to give it something to
chew on.  On the third hand, since you are still using the generic
flushing machinery I can see you'd have quite a lot of work to do to
control the flushing accurately in this way.

> Note that fsync() is OK - in full data journalling mode nothing
> is ever attached to i_dirty_buffers.

Somewhere in there is a beautiful optimization trying to get out...

--
Daniel
