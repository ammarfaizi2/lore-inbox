Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUFXWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUFXWaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUFXW2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:28:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:34445 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265883AbUFXWUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:20:47 -0400
Date: Thu, 24 Jun 2004 15:23:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [PATCH] fix GFP zone modifier interators
Message-Id: <20040624152333.79b36a90.akpm@osdl.org>
In-Reply-To: <200406242140.i5OLeZV4028038@voidhawk.shadowen.org>
References: <200406242140.i5OLeZV4028038@voidhawk.shadowen.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> For each node there are a defined list of MAX_NR_ZONES zones.
> These are selected as a result of the __GFP_DMA and __GFP_HIGHMEM
> zone modifier flags being passed to the memory allocator as part of
> the GFP mask.  Each node has a set of zone lists, node_zonelists,
> which defines the list and order of zones to scan for each flag
> combination.  When initialising these lists we iterate over
> modifier combinations 0 .. MAX_NR_ZONES.  However, this is only
> correct when there are at most ZONES_SHIFT flags.  If another flag
> is introduced zonelists for it would not be initialised.

I don't get it.  If you were going to add a new zone, identified by
__GFP_WHATEVER then you'd need to increase MAX_NR_ZONES
anyway, wouldn't you?

I'm sure you're right, but I haven't worked on this stuff in months and
it's obscure.  Care to explain a little more?

> This patch introduces GFP_ZONEMODS (based on GFP_ZONEMASK) as a
> bound for the number of modifier combinations.

The "ZONEMODS" identifier doesn't really grab me.  ZONETYPES, or something?

Either way, please add a big fat comment over it, explaining to the poor reader
what its semantic meaning is.
