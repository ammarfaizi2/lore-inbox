Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUBVR4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUBVR4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:56:21 -0500
Received: from mail.shareable.org ([81.29.64.88]:5762 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261716AbUBVR4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:56:19 -0500
Date: Sun, 22 Feb 2004 17:55:54 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       cw@f00f.org, mfedyk@matchmail.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222175554.GD25664@mail.shareable.org>
References: <20040221221553.01b1b71c.akpm@osdl.org> <38800000.1077466122@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38800000.1077466122@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> So it still seems likely to me that we'll blow away at least half of
> the dcache entries before we free any significant number of pages at
> all. That seems insane to me.

It's not totally insane to free dcache entries from pages that won't
be freed.  It encourages new entries to be allocated in those pages.

Ideally you'd simply mark those dcache entries as prime candidates for
recycling when new entries are needed, without actually freeing them
until new entries are needed - or until their whole pages can be
released.

Also, biasing new allocations to recycle those old dcache entries, but
also biasing them to recently used pages, so that recently used
entries tend to cluster in the same pages.

(I'm not sure how those ideas would work out in practice; they're just
hand-waving).

-- Jamie
