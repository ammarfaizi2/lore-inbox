Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSGEJEK>; Fri, 5 Jul 2002 05:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSGEJEJ>; Fri, 5 Jul 2002 05:04:09 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:6674 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316235AbSGEJEI>; Fri, 5 Jul 2002 05:04:08 -0400
Date: Fri, 5 Jul 2002 10:06:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch 18/27] always update page->flags atomically
Message-ID: <20020705100637.B23355@flint.arm.linux.org.uk>
References: <3D24E04A.F4A8B170@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D24E04A.F4A8B170@zip.com.au>; from akpm@zip.com.au on Thu, Jul 04, 2002 at 04:54:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 04:54:50PM -0700, Andrew Morton wrote:
> It had no right to go clearing PG_arch_1.  I'm now clearing PG_arch_1
> inside rmqueue() which is still a bit presumptious.

Davem should know the right behaviour for this bit.  It's not a generic
"architecture" bit, but it has some defined behaviour behind it.  See
cachetlb.txt:

  void flush_dcache_page(struct page *page)
...
        There is a bit set aside in page->flags (PG_arch_1) as
	"architecture private".  The kernel guarantees that,
	for pagecache pages, it will clear this bit when such
	a page first enters the pagecache.

I think you may have broken this... ;(

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
