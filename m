Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbUDEVlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDEVid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:38:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:47833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263366AbUDEVgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:36:13 -0400
Date: Mon, 5 Apr 2004 14:38:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink core hashes on small systems
Message-Id: <20040405143824.7f9b7020.akpm@osdl.org>
In-Reply-To: <20040405211916.GH6248@waste.org>
References: <20040405204957.GF6248@waste.org>
	<20040405140223.2f775da4.akpm@osdl.org>
	<20040405211916.GH6248@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Longer term, I think some serious thought needs to go into scaling
> hash sizes across the board, but this serves my purposes on the
> low-end without changing behaviour asymptotically.

Can we make longer-term a bit shorter?  init_per_zone_pages_min() only took
a few minutes thinking..

I suspect what we need is to replace num_physpages with nr_free_pages(),
then account for PAGE_SIZE, then muck around with sqrt() for a while then
apply upper and lower bounds to it.

That hard-wired breakpoint seems just too arbitrary to me - some sort of
graduated thing which has a little thought and explanation behind it would
be preferred please.

