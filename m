Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279615AbRKKRVr>; Sun, 11 Nov 2001 12:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279629AbRKKRVh>; Sun, 11 Nov 2001 12:21:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:14312 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S279615AbRKKRVc>; Sun, 11 Nov 2001 12:21:32 -0500
Date: Sun, 11 Nov 2001 18:21:26 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Peter Sozanski d'Alancaisez" <peter.sozanski@balliol.ox.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: drivers/block/block.o - undefined referedce
 to'deactivate_page' when compiling 2.4.14
In-Reply-To: <1005493999.850.4.camel@alancaisez.balliol.ox.ac.uk>
Message-ID: <Pine.NEB.4.40.0111111820590.6432-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2001, Peter Sozanski d'Alancaisez wrote:

> [1] drivers/block/block.o - undefined referedce to 'deactivate_page' when compiling 2.4.14
>
> [2] When compiling 2.4.14 with exactly the same config as my (operational) 2.4.12, make bxImage gets stuck on
> devices/block/block.o In function 'lo_send'
> devices/block/block.o .text+0x8f06 undefined reference to 'deactivate_page'
> devices/block/block.o .text+0x8f44 undefined reference to 'deactivate_page'
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

> Any ideas? Many thanks,
>
> Peter


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

