Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSFCLFp>; Mon, 3 Jun 2002 07:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSFCLFo>; Mon, 3 Jun 2002 07:05:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20889 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314787AbSFCLFn>;
	Mon, 3 Jun 2002 07:05:43 -0400
Date: Mon, 03 Jun 2002 03:00:48 -0700 (PDT)
Message-Id: <20020603.030048.15263428.davem@redhat.com>
To: wli@holomorphy.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which
 requires atomic operations to access
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020603110055.GB912@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Mon, 3 Jun 2002 04:00:55 -0700

    	if (PageWriteback(page))
    		BUG();
   -	ClearPageDirty(page);
   -	page->flags &= ~(1<<PG_referenced);
   +
   +	page->flags &= ~((1UL << PG_referenced) | (1UL << PG_dirty));

Umm, nevermind.  Look at ClearPageDirty, it does
"other stuff" so you can't remove it wholesale.

In the end, the code is as it should be right now.
