Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSDCW1u>; Wed, 3 Apr 2002 17:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSDCW1b>; Wed, 3 Apr 2002 17:27:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3340 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312419AbSDCW1U>; Wed, 3 Apr 2002 17:27:20 -0500
Date: Thu, 4 Apr 2002 00:27:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brian Gerst <bgerst@didntduck.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn users about machines with non-working WP bit
Message-ID: <20020403222722.GB29825@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020403215457.GA1050@elf.ucw.cz> <3CAB8133.1AAF5338@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This might be good idea, as those machines are not safe for multiuser
> > systems.
> > 
> > --- clean.2.5/arch/i386/mm/init.c       Sun Mar 10 20:06:31 2002
> > +++ linux/arch/i386/mm/init.c   Mon Mar 11 21:49:14 2002
> > @@ -383,7 +383,7 @@
> >         local_flush_tlb();
> > 
> >         if (!boot_cpu_data.wp_works_ok) {
> > -               printk("No.\n");
> > +               printk("No (that's security hole).\n");
> >  #ifdef CONFIG_X86_WP_WORKS_OK
> >                 panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
> >  #endif
> > 
> >                                                                         Pavel
> 
> The "bug" is really the lack of a feature present on 486+ cpus.  A 386
> will allow the kernel to write to a write-protected user page (but not a
> write-protected kernel page).  In user mode, write protect works as it
> should.  The kernel works around this by doing extra checks when writing
> to user pages (check the *_user() functions).  It is not a security

It is, because those checks are racy when clone() is in use. Linus
stated that few times.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
