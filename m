Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTD0W2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 18:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbTD0W2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 18:28:40 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:54923 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261868AbTD0W2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 18:28:39 -0400
Date: Wed, 23 Apr 2003 20:04:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5] include/asm-generic/bitops.h {set,clear}_bit return void
Message-ID: <20030423180409.GC7131@zaurus.ucw.cz>
References: <20030415174010_3e7e@gated-at.bofh.it> <200304152007.h3FK72sD003180@post.webmailer.de> <3E9C7955.7070605@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9C7955.7070605@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 
> > 
> >>+     mask = 1 << (nr & 0x1f);
> >>+     cli();
> >>+     *addr |= mask;
> >>+     sti();
> > 
> > 
> > cli() and sti() are no more. Moreover, the file you are trying to fix is

No. That file is still usefull.

> What is the preferred way to achieve atomicity in an operation now that
> cli() and sti() are gone?

spin_lock_irqsave(&bitops_lock).

> > not even used anywhere. Better submit a patch to remove it completely.
> 
> The point of asm-generic is not to use the files, but to give porters a
> hint about the functionality. Quoting asm-generic/bitops.h:
> 
> /* For the benefit of those who are trying to port Linux to another
>  * architecture, here are some C-language equivalents.  You should
>  * recode these in the native assembly language, if at all possible.
>  * To guarantee atomicity, these routines call cli() and sti() to
>  * disable interrupts while they operate.  (You have to provide inline
>  * routines to cli() and sti().) */
> 
> Or is this comment wrong, too?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

