Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWBEIlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWBEIlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 03:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBEIlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 03:41:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31448 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964867AbWBEIlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 03:41:14 -0500
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Jackson <pj@sgi.com>
Cc: christoph@lameter.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       manfred@colorfullife.com
In-Reply-To: <20060204180026.b68e9476.pj@sgi.com>
References: <1139060024.8707.5.camel@localhost>
	 <Pine.LNX.4.62.0602040709210.31909@graphe.net>
	 <1139070369.21489.3.camel@localhost> <1139070779.21489.5.camel@localhost>
	 <20060204180026.b68e9476.pj@sgi.com>
Date: Sun, 05 Feb 2006 10:41:12 +0200
Message-Id: <1139128872.11782.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-02-04 at 18:00 -0800, Paul Jackson wrote:
> Two issues I can see:
> 
>   1) This patch increased the text size of mm/slab.o by 776
>      bytes (ia64 sn2_defconfig gcc 3.3.3), which should be
>      justified.  My naive expectation would have been that
>      such a source code consolidation patch would be text
>      size neutral, or close to it.

Ah, sorry about that, I forgot to verify the NUMA case. The problem is
that to kmalloc_node() is calling cache_alloc() now which is forced
inline. I am wondering, would it be ok to make __cache_alloc()
non-inline for NUMA? The relevant numbers are:

   text    data     bss     dec     hex filename
  15882    2512      24   18418    47f2 mm/slab.o (original)
  16029    2512      24   18565    4885 mm/slab.o (inline)
  15798    2512      24   18334    479e mm/slab.o (non-inline)

>   2) You might want to hold off this patch for a few days,
>      until the dust settles from my memory spread patch.

Sure.

			Pekka

