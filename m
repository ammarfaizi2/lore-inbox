Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUFJVZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUFJVZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUFJVZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:25:28 -0400
Received: from gprs214-205.eurotel.cz ([160.218.214.205]:53889 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263062AbUFJVZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:25:26 -0400
Date: Thu, 10 Jun 2004 23:24:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040610212448.GD6634@elf.ucw.cz>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610105629.GA367@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -803,32 +804,31 @@
> >  		return 0;
> >  	}
> >  
> > +	err = -ENOMEM;
> >  	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
> >  		memset(m, 0, PAGE_SIZE);
> 
> BTW, what does this memset do?

Here's incremental fix, it compiles but not tested.

BTW I have problems getting mail to you:

This is the Postfix program at host atrey.karlin.mff.cuni.cz.

I'm sorry to have to inform you that the message returned
below could not be delivered to one or more destinations.

For further assistance, please send mail to <postmaster>

If you do so, please include this problem report. You can
delete your own text from the message returned below.

                        The Postfix program

<herbert@gondor.apana.org.au>: host arnor.apana.org.au[203.14.152.115]said:
    550 mail from 195.113.31.123 rejected: administrative prohibition

									Pavel

--- tmp/linux/kernel/power/swsusp.c	2004-06-10 23:16:05.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-10 23:09:07.000000000 +0200
@@ -962,7 +962,7 @@
 	}
 
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
-		memset(m, 0, PAGE_SIZE);
+		memset(m, 0, PAGE_SIZE << pagedir_order);
 		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
 			break;
 		eaten_memory = m;

-- 
People were complaining that M$ turns users into beta-testers...

