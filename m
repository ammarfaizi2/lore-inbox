Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269169AbRGaDY2>; Mon, 30 Jul 2001 23:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269170AbRGaDYS>; Mon, 30 Jul 2001 23:24:18 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:50191 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269169AbRGaDYQ>; Mon, 30 Jul 2001 23:24:16 -0400
Message-ID: <3B662642.4AB6E800@zip.com.au>
Date: Tue, 31 Jul 2001 13:30:10 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony.Lill@ajlc.waterloo.on.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: laptops and journalling filesystems
In-Reply-To: <200107310254.WAA22236@spider.ajlc.waterloo.on.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Tony Lill wrote:
> 
> Do any of the current batch of journalling filesystems NOT diddle the
> disk every 5 seconds? I've tried reiser and ext3 and they're both
> antithetic to spinning down the disk. Any plans to fix this bug in
> future kernels?

If you mount everything with `noatime' there's nothing to
be written unless you're writing stuff.

Unfortunately ext3 defeats the trick of setting the kupdate
interval to something huge.  On my list of things-to-do.

Probably it's as simple as setting the commit timer to
a large interval (grep for "HZ" in fs/jbd/journal.c).

Commits are driven by either a timer expiry or by the
journal getting too full.  If the interval is set large
then probably journal-full will be the main reason for
running a commit.

Of course, if the interval is set to 15 minutes and
you crash, you'll lose up to 15 minutes' work.

-
