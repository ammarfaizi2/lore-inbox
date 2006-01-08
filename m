Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWAHVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWAHVBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWAHVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:01:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:23559 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932773AbWAHVBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:01:44 -0500
Date: Sun, 8 Jan 2006 22:01:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernelrelase only recomputed when necessary
Message-ID: <20060108210127.GA8545@mars.ravnborg.org>
References: <20060108203749.GA7193@mars.ravnborg.org> <Pine.LNX.4.64.0601081250441.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601081250441.3169@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:51:37PM -0800, Linus Torvalds wrote:
> This part looks bogus:
> 
> > diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
> > index a9cd42e..663dbdb 100644
> > --- a/arch/x86_64/Makefile
> > +++ b/arch/x86_64/Makefile
> > @@ -80,7 +80,7 @@ bzlilo: vmlinux
> >  bzdisk: vmlinux
> >  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
> >  
> > -install fdimage fdimage144 fdimage288: vmlinux
> > +install fdimage fdimage144 fdimage288:
> >  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
> >  
> >  archclean:
> 
> 
> That rule should probably be:
> 
> 	fdimage fdimage144 fdimage288: vmlinux
> 	install:
> 		$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
> 
> since the fdimages should still depend on vmlinux.
> 
> No?

I failed to apply the path from hpa before starting on the
kernelrelesase stuff - so what you see above was just a
quick hack allowing me to test "make install" and should have been
deleted before I sent out the mail - sorry.

hpa already do the right thing in his patch - similar to what you
suggest.

	Sam
