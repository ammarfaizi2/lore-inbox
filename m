Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUEQPt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUEQPt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUEQPt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:49:59 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:29317 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261723AbUEQPtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:49:53 -0400
In-Reply-To: <1084807424.20437.60.camel@watt.suse.com>
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040517141427.GD29054@work.bitmover.com> <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org> <20040517145217.GA30695@work.bitmover.com> <Pine.LNX.4.58.0405170758260.25502@ppc970.osdl.org> <1084807424.20437.60.camel@watt.suse.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D111BB40-A819-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@bitmover.com>, support@bitmover.com,
       Linus Torvalds <torvalds@osdl.org>, adi@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 09:49:44 -0600
To: Chris Mason <mason@suse.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 17, 2004, at 9:23 AM, Chris Mason wrote:

> On Mon, 2004-05-17 at 11:02, Linus Torvalds wrote:
>> Of course, my theory also depended on a page unlock happening in a 
>> place
>> where it didn't actually happen, so the exact details of my theory are
>> crap. I'll need to re-think that part.
>
> You've described it correctly for reiserfs though, we unlock the page
> too soon.  I'll fix the page locking for reiserfs_file_write.  Steven,
> we need to figure out why you're seeing this on ext3.

I'll have to wait until tonight since I've only been able to trigger 
this
using dialup, and I don't have that here at work.  The failures were 
only
seen with PREEMPT of course, and very early in the testing I ran the
test on ext3 too, to exonerate reiserfs as a primary cause.  However, I
did not examine or preserve the RESYNC/SCCS/s.ChangeSet file on ext3
since I didn't know what the issues were at that early stage of testing.
So, I don't really know any details of the failure on ext3, apart from
the most superficial symptoms.

>
> The two filesystems don't share much code for the normal write path, 
> and
> I don't see how you can trigger this on ext3 without truncate jumping
> into the fun.
>
> -chris

The "Assertion `s && s->tree' failed" happened fairly quickly (on the
3rd bk pull) on reiserfs with PREEMPT enabled.  I'll let you know
how ext3 behaves later tonight.

	Steven

