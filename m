Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266784AbUFYQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUFYQOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbUFYQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:14:22 -0400
Received: from gprs214-83.eurotel.cz ([160.218.214.83]:49280 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266784AbUFYQOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:14:20 -0400
Date: Fri, 25 Jun 2004 18:10:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp.S: meaningfull assembly labels
Message-ID: <20040625161050.GB30073@elf.ucw.cz>
References: <20040625115936.GA2849@elf.ucw.cz> <Pine.LNX.4.53.0406250827250.28070@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0406250827250.28070@chaos>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This introduces meaningfull labels instead of .L1234, meaning code is
> > readable, kills alignment where unneccessary, and kills TLB flush that
> > was only pure paranoia (and slows it down a lot on emulated
> > systems). Please apply,
> >
> > 								Pavel
> >
> > --- linux-cvs//arch/i386/power/swsusp.S	2004-05-25 17:41:18.000000000 +0200
> > +++ linux/arch/i386/power/swsusp.S	2004-06-24 14:39:01.000000000 +0200
> > @@ -18,7 +18,7 @@
> >  ENTRY(do_magic)
> >  	pushl %ebx
> >  	cmpl $0,8(%esp)
> > -	jne .L1450
> > +	jne resume
> >  	call do_magic_suspend_1
> >  	call save_processor_state
> >
...
> NO! You just made those labels public! The LOCAL symbols need to
> begin with ".L".  Now, if you have a 'copy_loop' in another module,
> linked with this, anywhere in the kernel, they will share the
> same address -- not what you expected, I'm sure! The assembler
> has some strange rules you need to understand. Use `nm` and you
> will find that your new labels are in the object file!

Are you sure? I thought theare not visible from other moduless unless
"ENTRY()" is used.  See for example entry.S.
							Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
