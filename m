Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDKRlz (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTDKRlz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:41:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32130 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261246AbTDKRlw (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:41:52 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111739.h3BHdIZM001716@81-2-122-30.bradfords.org.uk>
Subject: Completely new idea to virtual memory (Was: Re: [RFC] first try for swap prefetch)
To: 76306.1226@compuserve.com (Chuck Ebbert)
Date: Fri, 11 Apr 2003 18:39:18 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200304111259_MC3-1-3405-E07F@compuserve.com> from "Chuck Ebbert" at Apr 11, 2003 12:57:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We could possibly avoid this by swapping the pages back
> > in after one minute of inactivity, then letting the
> > disk spin down.
> 
> 
> Why not also write pages out to swap before it's really necessary?
> If they were left mapped but marked as having up-to-date copies
> on swap, they could be discarded immediately if the system needed
> memory.  (Of course if they got written to they would have to be
> paged out again.)

Hmmm, interesting...

The laptop-with-disk-configured-to-spin-down scenario would seem, (in
theory), to benefit from a completely different approach to swapping
to what we have at the moment.

Instead of trying to minimise the I/O bandwidth used, we could more or
less ignore it, but consider the initial request, (after a certain
timeout), to be very expensive.

So, all the time the disk was spinning, we'd make sure that the swap
area contained the most useful data, possibly duplicating what was in
RAM, and then spin the disk down at the earliest opportunity.  That
way, you could effectively swap in and swap out without spinning the
disk up.

(Obviously, you can't do _both_ :-), but the idea would be to either
swap out a lot, or swap in a lot, before spinning down, that way you
get a 'free' swap either way, and consolidate disk reads/writes).

John.
