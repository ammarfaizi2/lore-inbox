Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWGSM7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWGSM7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGSM7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:59:03 -0400
Received: from thunk.org ([69.25.196.29]:8348 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964811AbWGSM7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:59:01 -0400
Date: Wed, 19 Jul 2006 08:58:53 -0400
From: Theodore Tso <tytso@mit.edu>
To: joel <joel@mainphrame.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filesystem tuning hints?
Message-ID: <20060719125853.GA7093@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, joel <joel@mainphrame.com>,
	linux-kernel@vger.kernel.org
References: <44BDAD5C.5020209@mainphrame.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BDAD5C.5020209@mainphrame.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to answer your question about tuning a filesystem, it's a
requirement to know something about the workload, and you haven't
provided that.  In general if you haven't been using the latest
e2fsprogs creating ext3 with a larger journal size will help ---
unless you don't have the requisite memory to support having extra
pinned buffers, since your application may end up getting pushed out
to swap.  Many journalling filesystems can get much better performance
by putting the journal on a separate external device, especially if
that device is a battery-backed non-volitile ramdisk.  With ext3,
depending on your workload (if it is fsync-intensive, for example),
using data journalling with can help a lot, especially with an
external journal device.

Finally, be warned that many filesystem benchmarks may be quite
misleading, especially dbench, which doesn't match very many real-life
workloads at all.  It's designed to be half (the disk part) of an
artificial web-based benchmark that was in itself a pretty bad
benchmark that was easily subject to gaming and not very reflective of
real-world workloads.  Its main virtue is that it is easy to run and
can be useful to developers as a good stress/smoke test to detect that
new kernels haven't done something stupid, as long as you ignore its
numbers.  :-)

In many cases, using your actual workload will be the best benchmark.

Regards, 

						- Ted
