Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSEINED>; Thu, 9 May 2002 09:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSEINEC>; Thu, 9 May 2002 09:04:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32691 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310637AbSEINEB>;
	Thu, 9 May 2002 09:04:01 -0400
Date: Thu, 09 May 2002 05:52:00 -0700 (PDT)
Message-Id: <20020509.055200.111470847.davem@redhat.com>
To: andrea@suse.de
Cc: hugh@veritas.com, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020509150146.O12382@dualathlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Thu, 9 May 2002 15:01:46 +0200

   On Thu, May 09, 2002 at 04:56:43AM -0700, David S. Miller wrote:
   > Wrong, consider the case where we do early COW in do_no_page, you miss
   > a flush on the new-new page.
   
   so you mean we need a flush_page_to_ram also before the
   copy_user_highpage to be sure we copy uptodate contents of the
   pagecache? (possibly mapped writeable elsewhere in the user address
   space?)
   
That is correct.

The fact that this ends up with multiple flushes is one of
several reasons why Documentation/cachetlb.txt encourages
ports to move to the newer way to handle this (flush_dcache_page()
plus bits in {copy,clear}_user_page() to handle the cache issues
and not using flush_page_to_ram() at all).

Franks a lot,
David S. Miller
davem@redhat.com
