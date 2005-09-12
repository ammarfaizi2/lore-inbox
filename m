Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVILCPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVILCPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 22:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVILCPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 22:15:44 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:479 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751132AbVILCPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 22:15:43 -0400
Date: Mon, 12 Sep 2005 04:15:37 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read-from-all-disks support for RAID1?
Message-ID: <20050912021537.GA2660@xi.wantstofly.org>
References: <20050910123902.GA9461@xi.wantstofly.org> <17188.49961.268818.355923@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17188.49961.268818.355923@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:52:09AM +1000, Neil Brown wrote:

> > I recently had a case where one disk in a two-disk RAID1 array went
> > subtly bad, effectively refusing to write to certain sectors without
> > reporting an error.  Basically, parts of the disk went undetectably
> > read-only, causing file system corruption that wouldn't go away after
> > fsck, and all kinds of other fun.
> 
> That really isn't something that a drive should do.  If a write fails,
> you need to be told that it failed.

Agreed.


> If anything else happens, maybe you should consider boycotting that
> manufacturer, or at least buying more expensive drives (do I guess
> right that there were fairly cheap??).

The drive was a Western Digital Protege WD400 40G PATA drive, no idea
whether that is to be considered 'cheap' but it wasn't exactly cheap
when I bought it.

I've had drives from lots of drive manufacturers (IBM, Hitachi, Samsung,
Maxtor, Western Digital, Spinpoint (?), Seagate) fail on me so far.  I
don't mind always buying known-good brand X, but how will I be sure that
one of brand X's drives won't eventually fail in a similar manner?

If you say that "The RAID1 driver design doesn't tolerate these kinds
of failures.", that sounds fair enough, but it would still be nice to
have an option to enable some extra consistency checking that would
catch this.


> > Would it be hard/wise to add an option for RAID1 mode to read from all
> > devices on a read, and report an error to syslog or simply return an
> > I/O error if there is a mismatch?  (Or use majority voting and tell
> > people to use 3-disk RAID1 arrays from now on ;-)
> 
> No, I don't think so.  The overhead would be substantial, so people
> would be very unlikely to use it.

I personally wouldn't care if I have put three disks in every box I
build and if reads and writes are 500% slower if I would then be sure
that this silent failure would not occur.  I value data integrity
above performance even if that means slowing stuff down substantially.


> The only raid-layer option that I can think of that makes much sense
> is to have a regular background scan that reads all blocks and makes
> sure all mirrors are consistent.  If an error is found, you generate a
> warning and possibly fix it.  This wouldn't report errors immediately,
> but at least you would find out proactively instead of through weird
> data corruption.

That sounds like a nice thing to have in any case.


--L
