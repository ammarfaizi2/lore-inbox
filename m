Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTEWKD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 06:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264007AbTEWKD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 06:03:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21988 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264005AbTEWKDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 06:03:55 -0400
Date: Fri, 23 May 2003 03:15:05 -0700 (PDT)
Message-Id: <20030523.031505.55849089.davem@redhat.com>
To: akpm@digeo.com
Cc: rmk@arm.linux.org.uk, LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030523030409.664c9b3a.akpm@digeo.com>
References: <20030523021204.4e3a4954.akpm@digeo.com>
	<20030523.024922.118612798.davem@redhat.com>
	<20030523030409.664c9b3a.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Fri, 23 May 2003 03:04:09 -0700

   "David S. Miller" <davem@redhat.com> wrote:
   > I agree.  Someone should take a close look at the do_file_page()
   > code paths to make sure that's still kosher after such a change.
   
   What would one be looking for?  I don't know what the sideeffects of
   update_mmu_cache() might be.
   
   It looks to be the same as do_no_page() though: the update_mmu_cache() is
   the last substantive thing which happens in the fault or the syscall.
   
Yes, this is what I was talking about, making sure do_file_page()'s
return path isn't doing a update_mmu_cache() call already.

I don't believe this is an error (to do it twice for the same fault)
but it would be superfluous.
