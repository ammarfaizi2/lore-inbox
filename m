Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSEINTR>; Thu, 9 May 2002 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSEINTQ>; Thu, 9 May 2002 09:19:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43187 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311320AbSEINTN>;
	Thu, 9 May 2002 09:19:13 -0400
Date: Thu, 09 May 2002 06:07:03 -0700 (PDT)
Message-Id: <20020509.060703.121443473.davem@redhat.com>
To: hugh@veritas.com
Cc: torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0205091416360.10889-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Thu, 9 May 2002 14:18:49 +0100 (BST)

   On Thu, 9 May 2002, David S. Miller wrote:
   > Wrong, consider the case where we do early COW in do_no_page, you miss
   > a flush on the new-new page.
   
   Of course we do, and then we don't map it into user address space;
   if it ever gets mapped into user address space later, do_no_page
   does the flush_page_to_ram then.

You miss the fact that if we do an early COW and another process
recently WROTE into that page via a shared MMAP, we will potentially
copy old data into the COW page we use for the current process.

Your changes are wrong and will cause corruption.
