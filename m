Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWG3K5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWG3K5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWG3K5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:57:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53126 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751392AbWG3K5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:57:11 -0400
Date: Sun, 30 Jul 2006 12:56:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] Begin abstraction of sensitive instructions: asm files
Message-ID: <20060730105657.GA5830@elf.ucw.cz>
References: <1153527274.13699.36.camel@localhost.localdomain> <20060730105228.GA5810@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730105228.GA5810@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Abstract sensitive instructions in assembler code, replacing them with
> > macros (which currently are #defined to the native versions).  We use
> > long names: assembler is case-insensitive, so if something goes wrong
> > and macros do not expand, it would assemble anyway.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> > @@ -76,8 +76,15 @@
> >  NT_MASK		= 0x00004000
> >  VM_MASK		= 0x00020000
> >  
> > +/* These are replaces for paravirtualization */
> > +#define DISABLE_INTERRUPTS		cli
> > +#define ENABLE_INTERRUPTS		sti
> > +#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
> > +#define INTERRUPT_RETURN		iret
> 
> Could we use some less verbose names, like possibly CLI, STI,
> STI_SYSEXIT, IRET ?

Apparently I can't read, it was explained in changelog. Could we still
use something shorter, like perhaps _CLI / _STI / _IRET ?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
