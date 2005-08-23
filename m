Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVHWPQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVHWPQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVHWPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:16:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52191 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932194AbVHWPQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:16:34 -0400
Subject: Re: 2.6.13-rc6 JFS Oops trace
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050822070520.GA5011@oepkgtn.mshome.net>
References: <20050822070520.GA5011@oepkgtn.mshome.net>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 10:16:17 -0500
Message-Id: <1124810177.9271.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 09:05 +0200, Mateusz Berezecki wrote:
> Hello list readers,
> 
> I attach the oops trace for 2.6.13-rc6 kernel. I believe the bug is 100%
> reproducible but I don't know what triggers it yet. It appears that
> kernel crashes when dealing with large amount of small files (possible
> fs issue - i.e. jfs ?) 
> 
> I attach oops trace and config for my kernel

It looks to me like cache_alloc_refill is trapping on line 2065 of
slab.c:
	list_del(&slabp->list);

I think slabp->list.next is corrupted.

Could you try to reproduce it with CONFIG_DEBUG_SLAB defined?

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

