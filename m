Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRKFBk5>; Mon, 5 Nov 2001 20:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277176AbRKFBkr>; Mon, 5 Nov 2001 20:40:47 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:33787 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S277024AbRKFBk3>; Mon, 5 Nov 2001 20:40:29 -0500
Date: Mon, 5 Nov 2001 17:35:17 -0800
From: Chris Wright <chris@wirex.com>
To: David Dyck <dcd@tc.fluke.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14 doesn't compile: deactivate_page not defined in loop.c
Message-ID: <20011105173517.A22095@figure1.int.wirex.com>
Mail-Followup-To: David Dyck <dcd@tc.fluke.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111051654140.4708-100000@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111051654140.4708-100000@dd.tc.fluke.com>; from dcd@tc.fluke.com on Mon, Nov 05, 2001 at 04:57:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Dyck (dcd@tc.fluke.com) wrote:
> 
> 
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x8ad9): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0x8b19): undefined reference to `deactivate_page'
> 
> 
> a grep from deactivate_page only shows up in  linux/drivers/block/loop.c

appears that deactivate_page was removed (see patch-2.4.14).  the patch
below Works For Me with limited testing (mount loop back, write,
unmount, remount, stuff i wrote is still there ;-).  YMMV.

cheers,
-chris

diff -X /home/chris/dontdiff -Naur linux-2.4.14/drivers/block/loop.c linux-2.4.14-loop/drivers/block/loop.c
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
