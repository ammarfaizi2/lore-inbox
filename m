Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266335AbSLIW2F>; Mon, 9 Dec 2002 17:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSLIW2E>; Mon, 9 Dec 2002 17:28:04 -0500
Received: from holomorphy.com ([66.224.33.161]:6810 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266335AbSLIW2D>;
	Mon, 9 Dec 2002 17:28:03 -0500
Date: Mon, 9 Dec 2002 14:35:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jim Houston <jim.houston@attbi.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
Message-ID: <20021209223515.GC20686@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jim Houston <jim.houston@attbi.com>, akpm@digeo.com,
	linux-kernel@vger.kernel.org, george@mvista.com
References: <3DF4B5C1.D36D4CCF@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF4B5C1.D36D4CCF@attbi.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:24:49AM -0500, Jim Houston wrote:
> I got started on this before Ingo did his magic for hashing
> pids.  I prototyped in user space and did a quick hack to
> make it work in the kernel.  Yes, it uses a recursive approach
> for the allocate and remove path.  The recursion is limited 
> to only a few levels and the stack frame is tiny.  For example
> if there are 1000000 ids it will have 6 levels of recursion.

I'm not Ingo but you'll figure it out.

Recursion is unnecessary; the depths are bounded by BITS_PER_LONG
divided by the log of the branch factor and looping over levels
directly suffices.

I started somewhat before the first for_each_task-* patches are
dated on kernel.org, which puts it sometime before May (obviously
I spent time writing & testing before dropping it onto an ftp site).

My original allocator(s) used a radix tree structured bitmap like this
in order to provide hard constant time bounds, but statically-allocated
them. Static allocation didn't fit in with larger pid space, though.

Bill
