Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSEUX2n>; Tue, 21 May 2002 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316783AbSEUX2m>; Tue, 21 May 2002 19:28:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:20890 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316782AbSEUX2k>;
	Tue, 21 May 2002 19:28:40 -0400
Date: Wed, 22 May 2002 01:27:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020521232732.GA16320@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com> <Pine.LNX.4.33.0205211614200.15094-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Applied. Nothing needed but some time for me to look through it.
> 
> Well, I may have to revert that.

Sorry about that. Safety check that should not be needed.

> 	mm/mm.o: In function `rw_swap_page':
> 	mm/mm.o(.text+0xaeb2): undefined reference to `suspend_device'
> 
> Please send me a fix asap.

This fixes it. I also broke compilation in ACPI but not SWSUSP case
(but it ate disks before, so ... :-).

									Pavel

--- linux-swsusp.linus/mm/page_io.c	Tue May 21 23:33:38 2002
+++ linux-swsusp/mm/page_io.c	Wed May 22 01:20:04 2002
@@ -86,15 +86,11 @@
  *  - it's marked as being swap-cache
  *  - it's associated with the swap inode
  */
-extern long suspend_device;
 void rw_swap_page(int rw, struct page *page)
 {
 	swp_entry_t entry;
 
 	entry.val = page->index;
-
-	if (suspend_device)
-		panic("I refuse to corrupt memory/swap.");
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);


-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
