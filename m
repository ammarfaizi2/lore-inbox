Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280999AbRKTJqX>; Tue, 20 Nov 2001 04:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281004AbRKTJqM>; Tue, 20 Nov 2001 04:46:12 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:62974 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S280999AbRKTJqE>; Tue, 20 Nov 2001 04:46:04 -0500
Date: Tue, 20 Nov 2001 10:45:43 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Terje Dalen <t.dalen@no.parkairsystems.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:  Kernel link problem (block.o)
In-Reply-To: <766E81E1DE3AD411BAD400508B6B830B09DD46@mailserver.parkairsystems.net>
Message-ID: <Pine.NEB.4.40.0111201044450.5039-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Terje Dalen wrote:

> Hi,

Hi Terje,

>...
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xb2e9): undefined reference to
> `deactivate_page'
> drivers/block/block.o(.text+0xb325): undefined reference to
> `deactivate_page'
>
>
> I can see from in the changelog that the swap.h have been changed and the
> deactivate_page function has been removed. I guess someone forgot to update
> the loop.c file. Is there a patch available for the correction of loop.c?
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


> Best regards
> Terje

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

