Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268353AbTCCFO1>; Mon, 3 Mar 2003 00:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268354AbTCCFO1>; Mon, 3 Mar 2003 00:14:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:5855 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268353AbTCCFO1>;
	Mon, 3 Mar 2003 00:14:27 -0500
Date: Sun, 2 Mar 2003 21:25:00 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] potential deadlocks
Message-Id: <20030302212500.72fe9b87.akpm@digeo.com>
In-Reply-To: <200303030335.h233ZTt07857@csl.stanford.edu>
References: <200303030335.h233ZTt07857@csl.stanford.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 05:24:46.0317 (UTC) FILETIME=[341E01D0:01C2E145]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
>
> Any feedback on the results would be great.  My understanding of linux's
> sprawling locking rules is less than impressive.

We would be impressed if it wasn't :)

> Also, if there are
> known deadlocks, let me know and I can make sure we're finding them.

There are some real ones there.  The ones surrounding lock_kernel() and
semaphores are false positives.

lock_kernel() is special, in that the lock is dropped when the caller
performs a voluntary context switch.  So there are no ordering requirements
between lock_kernel and the sleeping locks down(), down_read(), down_write().

lock_kernel() inside a spinlock is not necessarily a bug, but almost always
is.  It should be warned about.

