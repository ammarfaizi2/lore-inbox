Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315327AbSEAHUW>; Wed, 1 May 2002 03:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315328AbSEAHUV>; Wed, 1 May 2002 03:20:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315327AbSEAHUV>;
	Wed, 1 May 2002 03:20:21 -0400
Message-ID: <3CCF9792.8CDF274@zip.com.au>
Date: Wed, 01 May 2002 00:21:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.12 -- Unresolved symbols in fs/jfs/jfs.o:  block_flushpage
In-Reply-To: <1020236572.16071.19.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.12/kernel/fs/jfs/jfs.o
> depmod:         block_flushpage
> 

block_flushpage() used to be a macro which pointed at the
exported discard_bh_page().  I turned block_flushpage() into
a real function but forgot the export.

--- linux-2.5.12/fs/buffer.c	Tue Apr 30 17:56:30 2002
+++ 25/fs/buffer.c	Wed May  1 00:19:10 2002
@@ -1231,6 +1231,7 @@ int block_flushpage(struct page *page, u
 
 	return 1;
 }
+EXPORT_SYMBOL(block_flushpage);
 
 /*
  * We attach and possibly dirty the buffers atomically wrt


-
