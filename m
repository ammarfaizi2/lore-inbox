Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUCEUUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUCEUUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:20:08 -0500
Received: from mail.shareable.org ([81.29.64.88]:39559 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262099AbUCEUUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:20:05 -0500
Date: Fri, 5 Mar 2004 20:19:55 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, peter@mysql.com, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305201954.GB7254@mail.shareable.org>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org> <20040304045212.GG4922@dualathlon.random> <20040303211042.33cd15ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303211042.33cd15ce.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>   We believe that this could cause misbehaviour of such things as the
>   boehm garbage collector.  This patch provides the mprotect() atomicity by
>   performing all userspace copies under page_table_lock.

Can you use a read-write lock, so that userspace copies only need to
take the lock for reading?  That doesn't eliminate cacheline bouncing
but does eliminate the serialisation.

Or did you do that already, and found performance is still very low?

> It is a judgement call.  Personally, I wouldn't ship a production kernel
> with this patch.  People need to be aware of the tradeoff and to think and
> test very carefully.

If this isn't fixed, _please_ provide a way for a garbage collector to
query the kernel as to whether this race condition is present.

-- Jamie
