Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992742AbWJTTgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992742AbWJTTgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992743AbWJTTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:36:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4030
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992742AbWJTTgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:36:35 -0400
Date: Fri, 20 Oct 2006 12:36:35 -0700 (PDT)
Message-Id: <20061020.123635.95058911.davem@davemloft.net>
To: torvalds@osdl.org
Cc: nickpiggin@yahoo.com.au, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
References: <20061019.155939.48528489.davem@davemloft.net>
	<4538DFAC.1090206@yahoo.com.au>
	<Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 20 Oct 2006 08:49:35 -0700 (PDT)

> Why not do the cache flush _after_ the TLB flush? There's still a mapping, 
> and never mind that it's read-only: the _mapping_ still exists, and I 
> doubt any CPU will not do the writeback (the readonly bit had better 
> affect the _frontend_ of the memory pipeline, but affectign the back end 
> would be insane and very hard, since you can't raise a fault any more).
> 
> Hmm?

You get an asynchronous fault from the L2 cache, and that's also what
happens when the TLB entry is missing during L2 writeback too.  You
get a level 15 non-maskable IRQ when these asynchronous errors happen.
