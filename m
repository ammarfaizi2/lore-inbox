Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281103AbRKKVz4>; Sun, 11 Nov 2001 16:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281105AbRKKVzq>; Sun, 11 Nov 2001 16:55:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:38629 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281103AbRKKVzn>; Sun, 11 Nov 2001 16:55:43 -0500
Date: Sun, 11 Nov 2001 22:55:36 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Joe <joeja@mindspring.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: loop back broken in 2.2.14
In-Reply-To: <3BEEED3E.58867BFE@mindspring.com>
Message-ID: <Pine.NEB.4.40.0111112255180.8577-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Joe wrote:

> compile 2.2.14.
>
> Then
>
> # modprobe -a loop
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
> deactivate_page
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod
> /lib/modules/2.4.14/kernel/drivers/block/loop.o failed
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed
>
> do recursive grep through kernel tree:
>
> # rgrep -rl  deactivate_page *
> drivers/block/loop.c
> drivers/block/loop.o
>
> Is there a fix for this?

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

> Joe

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

