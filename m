Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVBUCn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVBUCn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 21:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVBUCn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 21:43:58 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:17481
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261653AbVBUCnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 21:43:53 -0500
Message-ID: <42194AE0.2040209@ev-en.org>
Date: Mon, 21 Feb 2005 02:43:44 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/kmalloc
References: <20050220204743.GE3120@waste.org>
In-Reply-To: <20050220204743.GE3120@waste.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> I've been sitting on this for over a year now, kicking it out in the
> hopes that someone finds it useful. kernel.org was down when I was
> tidying this up so it's against 2.6.10 which is what I had handy.
> 
> /proc/kmalloc allocation tracing
> 
> This quick hack adds accounting for kmalloc/kfree callers. This can
> aid in tracking down memory leaks and large dynamic memory users. The
> stock version use ~280k of memory for hash tables and can track 32k
> active allocations.

One thing I've seen once that might be worth adding is the ability to 
mark generations and then ask "what allocations exist from generation x?".

So you do something like:
echo 5 > /proc/kmalloc_generation
run some tests
echo 6 > /proc/kmalloc_generation
Print all allocations from generation 5:
   echo 5 > /proc/kmalloc_print_generations

Now you get all buffers that were allocated in generation 5 and not 
released. Not all of these are leaks, but it's easier to wade through 
this list to see what is and what isn't a leak.

Sometimes it's better to summarize all allocations according to the 
caller who asked for the allocation, it makes it easier to see if there 
is an undue increase from certain callers.

Just some ideas.

Baruch
