Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVDBAgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVDBAgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVDBAdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:33:11 -0500
Received: from waste.org ([216.27.176.166]:25533 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261632AbVDBAb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 19:31:28 -0500
Date: Fri, 1 Apr 2005 16:31:08 -0800
From: Matt Mackall <mpm@selenic.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] quiet ide-cd warning
Message-ID: <20050402003108.GO15453@waste.org>
References: <20050401201111.GH15453@waste.org> <424DDD6D.3010204@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424DDD6D.3010204@tls.msk.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 03:46:53AM +0400, Michael Tokarev wrote:
> Matt Mackall wrote:
> >This shuts up a potential uninitialized variable warning.
> 
> Potential warning or potential uninitialized use?
> The code was right before the change, and if the compiler
> generates such a warning on it, it's the compiler who
> should be fixed, not the code: it's obvious the variable
> can't be used uninitialized here, and moving the things
> around like that makes the code misleading and hard to
> understand...

It's a compiler problem.

With gcc 3.3.5:

drivers/ide/ide-cd.c: In function `cdrom_analyze_sense_data':
drivers/ide/ide-cd.c:433: warning: `s' might be used uninitialized in
this function

Looks like the compiler's being stupid about my earlier patch which
makes printk an inline (and it's the only thing in the tree to do so).
gcc-snapshot doesn't complain.

> /mjt
> 
> >Signed-off-by: Matt Mackall <mpm@selenic.com>
> >
> >Index: af/drivers/ide/ide-cd.c
> >===================================================================
> >--- af.orig/drivers/ide/ide-cd.c	2005-04-01 11:17:37.000000000 -0800
> >+++ af/drivers/ide/ide-cd.c	2005-04-01 11:55:09.000000000 -0800
> >@@ -430,7 +430,7 @@ void cdrom_analyze_sense_data(ide_drive_
> > #if VERBOSE_IDE_CD_ERRORS
> > 	{
> > 		int i;
> >-		const char *s;
> >+		const char *s = "bad sense key!";
> > 		char buf[80];
> > 
> > 		printk ("ATAPI device %s:\n", drive->name);
> >@@ -445,8 +445,6 @@ void cdrom_analyze_sense_data(ide_drive_
> > 
> > 		if (sense->sense_key < ARY_LEN(sense_key_texts))
> > 			s = sense_key_texts[sense->sense_key];
> >-		else
> >-			s = "bad sense key!";
> > 
> > 		printk("%s -- (Sense key=0x%02x)\n", s, sense->sense_key);
> > 
> >

-- 
Mathematics is the supreme nostalgia of our time.
