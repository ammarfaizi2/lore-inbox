Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbTBYScL>; Tue, 25 Feb 2003 13:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268143AbTBYScL>; Tue, 25 Feb 2003 13:32:11 -0500
Received: from ns.suse.de ([213.95.15.193]:7945 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268140AbTBYScL>;
	Tue, 25 Feb 2003 13:32:11 -0500
Date: Tue, 25 Feb 2003 19:42:21 +0100
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030225184221.GA9013@wotan.suse.de>
References: <3E5BB7EE.5090301@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5BB7EE.5090301@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure that this will help?
> With a smaller table, you might cause fewer cache misses for the table 
> lookup. Instead you get longer hash chains. Walking linked lists 
> probably causes more cache line misses than the single array lookup.

That's true when the hash table has a reasonable size. But with 1MB 
and bigger hash tables you are guaranteed to get a cache miss for most
head bucket access, no matter how many dentries you have. The hash
function is actively working against your cache here.

The dentries are actually more likely to fit into dcache because they
don't get artificially spread out over the cache space.

-Andi
