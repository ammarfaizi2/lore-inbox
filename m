Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUCZD7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbUCZD7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:59:19 -0500
Received: from waste.org ([209.173.204.2]:49581 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263928AbUCZD7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:59:18 -0500
Date: Thu, 25 Mar 2004 21:59:05 -0600
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/22] /dev/random: kill unrolled SHA code
Message-ID: <20040326035905.GE8366@waste.org>
References: <16.524465763@selenic.com> <40638AB1.7080201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40638AB1.7080201@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 08:43:13PM -0500, Jeff Garzik wrote:
> Matt Mackall wrote:
> >/dev/random  kill unrolled SHA code
> >
> >Kill the unrolled SHA variants. In the future, we can use cryptoapi
> >for faster hash functions.
> >
> > tiny-mpm/drivers/char/random.c |  146 
> > 1 files changed, 146 deletions(-)
> >
> >diff -puN drivers/char/random.c~kill-sha-variants drivers/char/random.c
> >13:38:34.000000000 -0600
> >+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:34.000000000 -0600
> >@@ -885,9 +885,6 @@ EXPORT_SYMBOL(add_disk_randomness);
> > #define HASH_BUFFER_SIZE 5
> > #define HASH_EXTRA_SIZE 80
> > 
> >-/* Various size/speed tradeoffs are available.  Choose 0..3. */
> >-#define SHA_CODE_SIZE 0
> 
> 
> So we go from "fast" to "I hope it gets faster in the future"?

No, we go from "moderately fast and dead code duplicated in /crypto"
to "same speed and one step closer to merging with /crypto". This bit
can be dropped for now, I've got the other bits deeper in my queue.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
