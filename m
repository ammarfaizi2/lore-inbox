Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRKIJiq>; Fri, 9 Nov 2001 04:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279782AbRKIJig>; Fri, 9 Nov 2001 04:38:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:4034 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S279749AbRKIJi3>; Fri, 9 Nov 2001 04:38:29 -0500
Date: Fri, 9 Nov 2001 10:38:24 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Michel Valin <michel.valin@ec.gc.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with kernel 2.4.14  drivers/block/loop.c mm/swap.c
In-Reply-To: <3BEB4299.C41D414D@ec.gc.ca>
Message-ID: <Pine.NEB.4.40.0111091036280.18756-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Michel Valin wrote:

> drivers/block/loop.c used by loopback filesystem code uses function
>
> deactivate_page that was defined in mm/swap.c in kernel 2.4.13
>
> deactivate_page seems to have been suppressed at kernel level 2.4.14
> from
> mm/swap.c
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



cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

