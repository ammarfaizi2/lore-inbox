Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJ1O3O>; Mon, 28 Oct 2002 09:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbSJ1O3O>; Mon, 28 Oct 2002 09:29:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61866 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261264AbSJ1O3N>;
	Mon, 28 Oct 2002 09:29:13 -0500
Date: Mon, 28 Oct 2002 06:26:08 -0800 (PST)
Message-Id: <20021028.062608.78045801.davem@redhat.com>
To: willy@debian.org
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, hugh@veritas.com,
       akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021028143226.N27461@parcelfarce.linux.theplanet.co.uk>
References: <1035216742.27318.189.camel@irongate.swansea.linux.org.uk>
	<20021028.061059.38206858.davem@redhat.com>
	<20021028143226.N27461@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Mon, 28 Oct 2002 14:32:26 +0000

   s/well maintained port/port that linus takes patches from regularly/
   
If you can't get purely arch/* include/asm-* patches to him,
that isn't my problem.

Yes, you might have to retransmit that patch 20/30 times over the
course of a few days depending upon how busy Linus is, just get over
it. :-)

   What do you want to do about flush_icache_page?  You want to change it
   to flush_dcache_page at eviction time, and then we can purge that page
   from our icache in update_mmu_cache?
   
That's the idea.  The other idea is "well these particular call spots
really are special, so let's document flush_icache_page properly".

   You may as well drop this hunk from the diff; our current tree doesn't
   even have these functions; just:
   
   static inline void
   flush_page_to_ram(struct page *page)
   {
   }
   
I gave Alan a patch that applies to 2.5.44 as-is, that is the most
useful form of the patch.

If you code is different now, you or Alan can deal with the conflict
once it does arrise and your "other code" is in 2.5.x.  For now it
isn't so it doesn't make any sense for me to patch against something
that isn't there :-)
