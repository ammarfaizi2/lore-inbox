Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRKIJgg>; Fri, 9 Nov 2001 04:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279782AbRKIJg2>; Fri, 9 Nov 2001 04:36:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:7106 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S279778AbRKIJgO>; Fri, 9 Nov 2001 04:36:14 -0500
Date: Fri, 9 Nov 2001 10:36:09 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: erasmo perez <erasmo@aztlan.fb10.tu-berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Loopback device support, kernel 2.4.14, can not compile ?
In-Reply-To: <E161zcz-00009M-00@aztlan>
Message-ID: <Pine.NEB.4.40.0111091034450.18756-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, erasmo perez wrote:

> hello

Hi Erasmo,

>...
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x894f): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0x8999): undefined reference to `deactivate_page'
> make: *** [vmlinux] Error 1
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


> thank you very much
>
> erasmo perez

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

