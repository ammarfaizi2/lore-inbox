Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRKHTWS>; Thu, 8 Nov 2001 14:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277687AbRKHTWI>; Thu, 8 Nov 2001 14:22:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:2763 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S277629AbRKHTVu>; Thu, 8 Nov 2001 14:21:50 -0500
Date: Thu, 8 Nov 2001 20:21:44 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "D'Angelo Salvatore" <dangelo.sasaman@tiscalinet.it>
cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: dependencies problems on loop back device (linux 2.4.14)
In-Reply-To: <3BEB1C43.40002@tiscalinet.it>
Message-ID: <Pine.NEB.4.40.0111082019560.8179-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, D'Angelo Salvatore wrote:

> Hi all,
>
> I was trying to compile the kernel 2.4.14 and I had the following error
> message during the installation of the loopback device module
>
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.14; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.14/kernel/drivers/block/loop.o
> depmod:     deactivate_page
>
> can someone help me?
>...

This is a known bug.

The following patch fixes the problem:

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

