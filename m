Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280089AbRKIUjV>; Fri, 9 Nov 2001 15:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280091AbRKIUjM>; Fri, 9 Nov 2001 15:39:12 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:30965 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S280089AbRKIUjE>; Fri, 9 Nov 2001 15:39:04 -0500
Date: Fri, 9 Nov 2001 21:38:57 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Roby <robylit@inwind.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: The module loop.o has an unresolved dependency:
 deactivate_page()
In-Reply-To: <20011109193802Z280062-17408+12724@vger.kernel.org>
Message-ID: <Pine.NEB.4.40.0111092138340.23406-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Roby wrote:

> Kernel 2.4.14
>
> [1.] The module loop.o has an unresolved dependency: deactivate_page()
> [2.] If I compile the module loop.o as a module it compiles fine,but then it
> has un unresolved dependency: deactivate_page(). This function once was in
> the source file mm/swap.c, but in the kernel 2.4.14 it disappeared. I know
> the function existed in the kernel 2.4.10.
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

