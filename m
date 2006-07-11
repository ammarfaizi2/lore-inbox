Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWGKX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWGKX4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGKX4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:56:00 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:8089 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932274AbWGKXz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:55:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EH5sZWWehsfM4GwWhxwVdVlpiAUBEWvGNaNxiJVvUEDlz9ZNgDTZUukK19jvppYTFlkfxHL0J9Wq8/7MnbAz70IIwajbLIKKfVHzyeKZfHRzGa588ld3EmSMhT/9Zb2dofdyhvnMXJVlkzOdCJXNqsOECnzjXLVMy+Uuqbn3jP8=
Date: Tue, 11 Jul 2006 16:55:53 -0700
From: Clay Barnes <clay.barnes@gmail.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>
Subject: Re: short term task list for Reiser4
Message-ID: <20060711235553.GH9220@HAL_5000D.tc.ph.cox.net>
References: <44B42064.4070802@namesys.com>
	<20060711222903.GG9220@HAL_5000D.tc.ph.cox.net>
	<44B43019.9010402@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B43019.9010402@namesys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:11 Tue 11 Jul     , Hans Reiser wrote:
> Clay Barnes wrote:
> >On 15:04 Tue 11 Jul     , Hans Reiser wrote:
> >>6) optimize fsync --- substantive task which requires using fixed area
> >>for write twice logging, and using write twice logging for fsync'd
> >>data.  It might require creating mount options to choose whether to
> >>optimize for serialized sequential fsyncs vs. lazy fsyncs.
> >With the serialized sequential fsync, is that essentially what I was
> >talking about earlier with slowly streaming dirty writes to disk when
> >the HDD is idle?  If that's the case, I don't see the advantage in having
> >lazy fsyncs
> if you are optimizing throughput rather than latency, then you let
> things get to disk whenever they get there, and you let the app hang
> while it waits. A mailer processing many requests in parallel might find
> 30 seconds of latency to be just fine but a database might find 3
> seconds of latency to be too much. (I make up these examples, mailer
> programmers please correct me.)
I see your point, but here's where I'm still uncertain:

If you have a lazy write policy, what exactly is gained by intentionally
delaying writes (beyond a certain size that is necessary to make things
like dancing trees actually effecient)?  If you trickle some data to
disk, then when memory pressure causes (or an app calls) a big sync,
then you have less to actually write.  What I'm suggesting, now, is not
a major write policy change, but rather a light process that is limited
to extremely low resource use (I/O, CPU, etc.).  It would take some of
the edge off of major syncs, and for many (most?) non-server users, it
could wholly eliminate memory pressure-induced heavy syncs.

--Clay
