Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSEXQTz>; Fri, 24 May 2002 12:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSEXQTy>; Fri, 24 May 2002 12:19:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63213 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314483AbSEXQTy>;
	Fri, 24 May 2002 12:19:54 -0400
Date: Fri, 24 May 2002 09:05:26 -0700 (PDT)
Message-Id: <20020524.090526.105379973.davem@redhat.com>
To: bruce.holzrichter@monster.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc64 pgalloc.h pgd_quicklist question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A775C@nocmail101.ma.tmpw.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
   Date: Fri, 24 May 2002 11:12:25 -0500
   
   Anyway, After looking at the SMP and UP configuration in pgalloc.h, could
   you simply remove the UP/SMP differentiation in the routines, as in my
   attachment?  It looks to me, that the struct for pgt_quicklist is built
   correctly for UP or SMP above this?  I could be wrong on this....

That would waste 3/4 of every page allocated for PGDs.

We use the pointers to keep track of which bits of the page
are allocated to PGDs.  So how about rewriting our code to
use bits in page->flags instead?
