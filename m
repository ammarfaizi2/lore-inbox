Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278630AbRKNWu7>; Wed, 14 Nov 2001 17:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278633AbRKNWut>; Wed, 14 Nov 2001 17:50:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:29402 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S278630AbRKNWuf>; Wed, 14 Nov 2001 17:50:35 -0500
Date: Wed, 14 Nov 2001 23:50:22 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: bredroll@atari.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.14 compile fail (block.o)
In-Reply-To: <20011112160632.A11922@earth.dsh.org.uk>
Message-ID: <Pine.NEB.4.40.0111142349540.3491-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Ian Norton wrote:

> Hi :-),
>
> -- One Liner: make dep is fine but block.o fails to compile
>
> --Problem:
> Make menuconfig for a pretty standard kernel, set for no driver modules, make
> bzImage fails at block.o,
>
> # drivers/block/block.o: In function `lo_send':
> # drivers/block/block.o(.text+0x895f): undefined reference to `deactivate_page'
> # drivers/block/block.o(.text+0x89a9): undefined reference to `deactivate_page'
>...

This is a known bug.

The following patch fixes it:

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


> Ian Norton


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

