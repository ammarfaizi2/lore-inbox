Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030766AbWI0U2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030766AbWI0U2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbWI0U2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:28:11 -0400
Received: from gw.goop.org ([64.81.55.164]:25056 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030767AbWI0U2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:28:08 -0400
Message-ID: <451ADEE4.4010508@goop.org>
Date: Wed, 27 Sep 2006 13:28:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/6] Per-processor private data areas for i386
References: <20060925184540.601971833@goop.org> <20060927194600.GA4538@ucw.cz>
In-Reply-To: <20060927194600.GA4538@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> So we have 4% slowdown...
>   

Yes, that would be the worst-case slowdown in the hot-cache case.  
Rearranging the layout of the GDT would remove any theoretical 
cold-cache slowdown (I haven't measured if there's any impact in practice).

> ...and 0.2% smaller kernel. I guess you should demonstrate speedup at
> complex syscalls before wedecide it is worth it...

That would be nice, but this patch series isn't really intended to be a 
performance improvement.  That would be nice, but the main motivation is 
to make inline assembler patching for the paravirt work cleaner.

Rusty and I have also been investigating how to use the %gs-based memory 
to implement all percpu data, rather than the few special cases this 
patch series currently covers, which will help further amortize the 
entry/exit cost.

Rusty has also done more comprehensive benchmarks with his variant of 
this patch series, and found no statistically interesting performance 
difference.  Which is pretty much what I would expect, since it doesn't 
increase cache-misses at all.

    J
