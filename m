Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281650AbRKPXor>; Fri, 16 Nov 2001 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281652AbRKPXoh>; Fri, 16 Nov 2001 18:44:37 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:56824 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S281650AbRKPXob>; Fri, 16 Nov 2001 18:44:31 -0500
Date: Fri, 16 Nov 2001 15:38:07 -0800
From: Chris Wright <chris@wirex.com>
To: Per-Olof Pettersson <peope@peope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: compiling 2.4.14 fails in block.o (probably loopback)
Message-ID: <20011116153806.B32600@figure1.int.wirex.com>
Mail-Followup-To: Per-Olof Pettersson <peope@peope.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BF59D71.1020705@peope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF59D71.1020705@peope.net>; from peope@peope.net on Sat, Nov 17, 2001 at 12:12:49AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Per-Olof Pettersson (peope@peope.net) wrote:
> [1.]
> compiling 2.4.14 fails in block.o (probably loopback)

this is a known problem (it's helpful to search the archives ;-).
to fix, apply the following patch:

cheers,
-chris

--- linux-2.4.14/drivers/block/loop.c	Thu Oct 25 13:58:34 2001
+++ linux-2.4.14-loop/drivers/block/loop.c	Mon Nov  5 17:06:08 2001
@@ -207,7 +207,6 @@
 		index++;
 		pos += size;
 		UnlockPage(page);
-		deactivate_page(page);
 		page_cache_release(page);
 	}
 	return 0;
@@ -218,7 +217,6 @@
 	kunmap(page);
 unlock:
 	UnlockPage(page);
-	deactivate_page(page);
 	page_cache_release(page);
 fail:
 	return -1;
