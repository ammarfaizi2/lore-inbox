Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSEIMIr>; Thu, 9 May 2002 08:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSEIMIq>; Thu, 9 May 2002 08:08:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3251 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290593AbSEIMIo>;
	Thu, 9 May 2002 08:08:44 -0400
Date: Thu, 09 May 2002 04:56:43 -0700 (PDT)
Message-Id: <20020509.045643.27562731.davem@redhat.com>
To: hugh@veritas.com
Cc: torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0205091252350.1205-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Thu, 9 May 2002 13:03:52 +0100 (BST)

   filemap_nopage and shmem_nopage do flush_page_to_ram before returning
   page, but do_no_page also does flush_page_to_ram on any page it slots
   into the user address space.  It's memory.c's business, remove it from
   shmem and filemap (and cut outdated comment from when filemap copied).
   
Wrong, consider the case where we do early COW in do_no_page, you miss
a flush on the new-new page.

Please don't apply this patch.
