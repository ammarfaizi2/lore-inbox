Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318335AbSGYBSZ>; Wed, 24 Jul 2002 21:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318336AbSGYBSY>; Wed, 24 Jul 2002 21:18:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25607 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318335AbSGYBSX>;
	Wed, 24 Jul 2002 21:18:23 -0400
Message-ID: <3D3F521F.ECB4DBC4@zip.com.au>
Date: Wed, 24 Jul 2002 18:19:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] updated low-latency zap_page_range
References: <3D3F4A2F.B1A9F379@zip.com.au> <1027559785.17950.3.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> I hope it compiles to nothing!  There is a false in an if... oh, wait,
> to preserve possible side-effects gcc will keep the need_resched() call
> so I guess we should reorder it as:
> 
>         if (preempt_count() == 1 && need_resched())
> 
> Then we get "if (0 && ..)" which should hopefully be evaluated away.
> Then the inline is empty and nothing need be done.

I think someone changed the definition of preempt_count()
while you weren't looking.

Plus it's used as an lvalue :(

-
