Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272053AbTHNAOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272066AbTHNAOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:14:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:64196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272053AbTHNAOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:14:23 -0400
Date: Wed, 13 Aug 2003 17:00:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: markw@osdl.org
Cc: piggin@cyberone.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bounce buffers and i/o schedulers with aacraid
Message-Id: <20030813170007.61694cbb.akpm@osdl.org>
In-Reply-To: <200308132316.h7DNGao27969@mail.osdl.org>
References: <200308132316.h7DNGao27969@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
>
> We're still trying to avoid bounce buffers with the aacraid driver and
> noticed something interesting in some profiles (which I'll copy farther
> down) with the deadline scheduler and AS.  Using our DBT-2 workload, we
> see with the deadline scheduler our patch to avoid bounce buffers
> doesn't change the profile much.  But with AS, we don't see
> bounce_copy_vec or __blk_queue_bounce near the top of the profile.  Any
> ideas why?

It shouldn't make any difference.

One thing to be careful about is to make sure that the pages which are
being put under I/O are in the same place across different tests.

Suppose your machine already had 3G of pagecache and you then run the test.
You would magically find that newly allocated pages come out of
ZONE_NORMAL and no bouncing is needed for them.  So the moral is to make
sure that the starting conditions are the same for each test: almost all
memory free.

