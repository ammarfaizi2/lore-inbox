Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVJYXOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVJYXOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVJYXOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:14:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24801 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932472AbVJYXOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:14:52 -0400
Date: Wed, 26 Oct 2005 01:14:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ben Dooks <ben@fluff.org.uk>
Cc: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sharp zaurus: prevent killing spitz-en
Message-ID: <20051025231444.GG3380@elf.ucw.cz>
References: <20051025190829.GA1788@elf.ucw.cz> <20051025225815.GA31679@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051025225815.GA31679@home.fluff.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is wrong solution, but it prevents breaking flashing mechanism on
> > spitz with too big kernel. It may be handy to someone...
> > 
> > 								Pavel
> > 
> > --- clean-rp/arch/arm/boot/Makefile	2004-12-25 13:34:57.000000000 +0100
> > +++ linux-rp/arch/arm/boot/Makefile	2005-10-25 20:43:58.000000000 +0200
> > @@ -53,6 +53,12 @@
> >  $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
> >  	$(call if_changed,objcopy)
> >  	@echo '  Kernel: $@ is ready'
> > +	@ls -al $@
> > +	@wc -c $@ | ( read SIZE Y; \
> > +		if [ $$SIZE -gt 1294336 ]; then \
> > +			echo '  Kernel is too big, would kill spitz'; \
> > +			rm $@; \
> > +		fi )
> >  
> >  endif
> 
> It would be better for each machine to export an config option
> from the Kconfig to specify if they have a maximum size.

It is probably best to stop it at the flasher script, but ... this was
quite a quick hack.
							Pavel
-- 
Thanks, Sharp!
