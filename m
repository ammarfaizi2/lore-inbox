Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRKLJQC>; Mon, 12 Nov 2001 04:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281163AbRKLJP5>; Mon, 12 Nov 2001 04:15:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:17377 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281077AbRKLJPk>; Mon, 12 Nov 2001 04:15:40 -0500
Date: Mon, 12 Nov 2001 10:15:36 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: johann.pfefferl.jp@germany.agfa.com
cc: linux-kernel@vger.kernel.org
Subject: Re: loop Device doesn't work in kernel 2.4.14
In-Reply-To: <OFC9FBD042.EA509C88-ON41256B02.002FCAEC@bayer-ag.com>
Message-ID: <Pine.NEB.4.40.0111121014480.10103-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001 johann.pfefferl.jp@germany.agfa.com wrote:

> Hello,

Hi Hans,

>...
> # modprobe -v loop
> /sbin/insmod /lib/modules/2.4.14/kernel/drivers/block/loop.o
> Using /lib/modules/2.4.14/kernel/drivers/block/loop.o
> Symbol version prefix ''
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol deactivate_page
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod /lib/modules/2.4.14/kernel/drivers/block/loop.o failed
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed
>
> # find /usr/src/linux-2.4.14 -type f -name '*.[ch]' |xargs grep deactivate_page
> /usr/src/linux-2.4.14/drivers/block/loop.c:             deactivate_page(page);
>...
> There seems to be a problem with the routine deactivate_page, which is no longer present
> in the 2.4.14 kernel but is used somehow in the loop device code.

this is a known bug.

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

> Hans

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

