Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWBBVhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWBBVhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWBBVhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:37:51 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:11133 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932291AbWBBVhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:37:50 -0500
X-IronPort-AV: i="4.02,81,1139212800"; 
   d="scan'208"; a="400016446:sNHT29479926"
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Question about memory barriers
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44L0.0602021607100.5016-100000@iolanthe.rowland.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 02 Feb 2006 13:37:48 -0800
In-Reply-To: <Pine.LNX.4.44L0.0602021607100.5016-100000@iolanthe.rowland.org> (Alan
 Stern's message of "Thu, 2 Feb 2006 16:12:16 -0500 (EST)")
Message-ID: <adamzh9xx03.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 02 Feb 2006 21:37:49.0460 (UTC) FILETIME=[E9F1E540:01C62840]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Stern <stern@rowland.harvard.edu> writes:

    Alan> The kernel's documentation about memory barriers is rather
    Alan> skimpy.  I gather that rmb() guarantees that all preceding
    Alan> reads will have completed before any following reads are
    Alan> made, and wmb() guarantees that all preceding writes will
    Alan> have completed before any following writes are made.  I also
    Alan> gather that mb() is essentially the same as rmb() and wmb()
    Alan> put together.

Most of this is correct, except that mb() is stronger than just rmb()
and wmb() put together.  All memory operations before the mb() will
complete before any operations after the mb().  A better way to
understand this is to look at the sparc64 definition:

#define mb()    \
        membar_safe("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad")

    Alan> But suppose I need to prevent a read from being moved past a
    Alan> write?  It doesn't look like either rmb() or wmb() will do
    Alan> this.  And if mb() is the same as "rmb(); wmb();" then it
    Alan> won't either.  So what's the right thing to do?

As described above, mb() will work in this case.  It actually
guarantees more than you need, so you could conceivably define a new
primitive, but the current barriers are hard enough for people to
figure out ;)

 - R.
