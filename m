Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWC3UjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWC3UjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWC3UjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:39:14 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:29576 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750742AbWC3UjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:39:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] mm: swsusp shrink_all_memory tweaks
Date: Fri, 31 Mar 2006 06:38:23 +1000
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200231.50666.kernel@kolivas.org> <200603241714.48909.rjw@sisk.pl> <200603301912.32204.rjw@sisk.pl>
In-Reply-To: <200603301912.32204.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603310638.23873.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 03:12, Rafael J. Wysocki wrote:
> OK, I have the following observations:

Thanks.
>
> 1) The patch generally causes more memory to be freed during suspend than
> the unpatched code (good).

Yes I know you meant less, that's good.

> 2) However, if more than 50% of RAM is used by application data, it causes
> the swap prefetch to trigger during resume (that's an impression; anyway
> the system swaps in a lot at that time), which takes some time (generally
> it makes resume 5-10s longer on my box).

Is that with this "swsusp shrink_all_memory tweaks" patch alone? It doesn't 
touch swap prefetch.

> 3) The problem with returning zero prematurely has not been entirely
> eliminated.  It's happened for me only once, though.

Probably hard to say, but is the system in any better state after resume has 
completed? That was one of the aims. Also a major part of this patch is a 
cleanup of the hot balance_pgdat function as well, which suspend no longer 
touches with this patch.

Cheers,
Con
