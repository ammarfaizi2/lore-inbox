Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUEWUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUEWUYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUEWUYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:24:53 -0400
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:12164 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263555AbUEWUYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:24:51 -0400
Date: Sun, 23 May 2004 22:24:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040523202444.GL804@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz> <20040521162044.7ad42db2.akpm@osdl.org> <20040523175444.GE804@elf.ucw.cz> <20040523130809.03ca7209.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523130809.03ca7209.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >
> >  > > +#ifdef CONFIG_SOFTWARE_SUSPEND
> >  > > +	{
> >  > > +		extern char swsusp_pg_dir[PAGE_SIZE];
> >  > > +		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
> >  > > +	}
> >  > > +#endif
> >  > 
> >  > Please move the declaration of swsusp_pg_dir[] to a header file where it is
> >  > visible to both the users and the definition site, then resend.
> > 
> >  Hmm, on second thought, it is accessed from one C file and once from
> >  assembly => prototype should not be needed.
> > 
> >  Upon popular request I made it depend on CONFIG_PM (pmdisk will need
> >  it, too, and suspend2 wants it also). If you don't like that please
> >  simply replace CONFIG_PM with CONFIG_SOFTWARE_SUSPEND...
> 
> Mabe it's a sign of advancing years, but I still think that 4k is worth
> saving ;)  I ended up with the below.

Ok, thanks ;-).

> You say that pmdisk needs this.  I assume that means that we should also
> replace swapper_pg_dir with swsusp_pg_dir in pmdisk.S?

Yes, that should do the trick.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
