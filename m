Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUHBEzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUHBEzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 00:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUHBEzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 00:55:40 -0400
Received: from digitalimplant.org ([64.62.235.95]:61844 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266254AbUHBEzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 00:55:36 -0400
Date: Sun, 1 Aug 2004 21:55:28 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [14/25] Merge pmdisk and swsusp
In-Reply-To: <20040718221909.GF31958@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408012154420.25997-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
 <20040718221909.GF31958@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jul 2004, Pavel Machek wrote:

> > +int swsusp_write_header(swp_entry_t * entry)
> > +{
> > +	return swsusp_write_page((unsigned long)&swsusp_info,entry);
> > +}
>
> I do not think this function matches its documentation.

Heh, you're right. Patch below fixes that.


	Pat

ChangeSet@1.1852, 2004-08-01 21:46:15-07:00, mochel@digitalimplant.org
  [swsusp] Kill unneeded write_header().

  - Just inline and remove bad comment.

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-08-01 21:46:21 -07:00
+++ b/kernel/power/swsusp.c	2004-08-01 21:46:21 -07:00
@@ -336,32 +336,17 @@
 	dump_info();
 }

-/**
- *	write_header - Fill and write the suspend header.
- *	@entry:	Location of the last swap entry used.
- *
- *	Allocate a page, fill header, write header.
- *
- *	@entry is the location of the last pagedir entry written on
- *	entrance. On exit, it contains the location of the header.
- */
-
-static int write_header(swp_entry_t * entry)
-{
-	return write_page((unsigned long)&swsusp_info,entry);
-}
-
-
 static int close_swap(void)
 {
 	swp_entry_t entry;
 	int error;
-	error = write_header(&entry);

-	printk( "S" );
-	if (!error)
+	error = write_page((unsigned long)&swsusp_info,&entry);
+	if (!error) {
+		printk( "S" );
 		error = mark_swapfiles(entry);
-	printk( "|\n" );
+		printk( "|\n" );
+	}
 	return error;
 }

