Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTLQTXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLQTXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:23:01 -0500
Received: from mail.shareable.org ([81.29.64.88]:49029 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264319AbTLQTW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:22:59 -0500
Date: Wed, 17 Dec 2003 19:22:44 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031217192244.GB12121@mail.shareable.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> My personal guess is that modern RAID0 stripes should be on the order of
> several MEGABYTES in size rather than the few hundred kB that most people
> use (not to mention the people who have 32kB stripes or smaller - they
> just kill their IO access patterns with that, and put the CPU at
> ridiculous strain).

If a large fs-level I/O transaction is split into lots of 32k
transactions by the RAID layer, many of those 32k transactions will be
contiguous on the disks.

That doesn't mean they're contiguous from the fs point of view, but
given that all modern hardware does scatter-gather, shouldn't the
contiguous transactions be merged before being sent to the disk?

It may strain the CPU (splitting and merging in a different order lots
of requests), but I don't see why it should kill I/O access patterns,
as they can be as large as if you had large stripes in the first place.

-- Jamie
