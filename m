Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281355AbRKRBOg>; Sat, 17 Nov 2001 20:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281845AbRKRBO0>; Sat, 17 Nov 2001 20:14:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:26865 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281355AbRKRBOV>; Sat, 17 Nov 2001 20:14:21 -0500
Date: Sun, 18 Nov 2001 02:14:19 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@pluto.fachschaften.tu-muenchen.de
To: Peter Jay Salzman <psalzman@lifshitz.ucdavis.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 compiling failed
In-Reply-To: <20011117164437.A6361@lifshitz.ucdavis.edu>
Message-ID: <Pine.NEB.4.40.0111180210580.19952-100000@pluto.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Peter Jay Salzman wrote:

> this is probably known already, but just in case, 2.4.14 compiling just
> failed on me:
>...
>   drivers/block/block.o: In function `lo_send':
>   drivers/block/block.o(.text+0xa57f): undefined reference to `deactivate_page'
>   drivers/block/block.o(.text+0xa5c9): undefined reference to `deactivate_page'
>   make: *** [vmlinux] Error 1
>...
> so i went to update to 2.4.14.  and the compile just failed.
>
> no big deal -- i can live with it until 2.4.15 comes out, but i thought
> someone should know about this.
>
> no response is required.  i know how busy everyone here is.

I hope you don't mind that I respond.  ;-)

This is a known bug.
If you want to run 2.4.14 the following simple patch solves the problem:

--- linux-2.4.14-broken/drivers/block/loop.c	Thu Oct 25 13:58:34 2001
+++ linux-2.4.14/drivers/block/loop.c	Mon Nov  5 17:06:08 2001
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


> pete  (not subscribed)

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400


