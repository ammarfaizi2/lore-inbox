Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKKXOn>; Mon, 11 Nov 2002 18:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSKKXOn>; Mon, 11 Nov 2002 18:14:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261550AbSKKXOl>;
	Mon, 11 Nov 2002 18:14:41 -0500
Date: Mon, 11 Nov 2002 15:19:29 -0800 (PST)
Message-Id: <20021111.151929.31543489.davem@redhat.com>
To: hugh@veritas.com
Cc: akpm@digeo.com, dmccr@us.ibm.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Mon, 11 Nov 2002 18:25:25 +0000 (GMT)

   On some architectures (cachetlb.txt gives HyperSparc as an example)
   it is essential to flush_cache_page while pte is still valid: the
   rmap VM diverged from the base 2.4 VM before that fix was made,
   so this error has crept back into 2.5.
...   
   (I wonder, what happens if userspace now modifies the page
   after the flush_cache_page, before the pte is invalidated?)

Thanks for catching this.

On architectures that are affected (such as the mentioned HyperSPARC
chips), the cpu will take a trap and OOPS the kernel if the PTE is
invalidated before the cache flush is made.
