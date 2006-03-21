Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWCURyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWCURyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWCURyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:54:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:56073 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030295AbWCURyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:54:05 -0500
Date: Tue, 21 Mar 2006 18:53:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>, Paul Smith <psmith@gnu.org>
Subject: Re: [PATCH 35/46] kbuild: change kbuild to not rely on incorrect GNU make behavior
Message-ID: <20060321175346.GA10388@mars.ravnborg.org>
References: <1142958057218-git-send-email-sam@ravnborg.org> <11429580571656-git-send-email-sam@ravnborg.org> <20060321172820.GQ20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321172820.GQ20746@lug-owl.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 06:28:20PM +0100, Jan-Benedict Glaw wrote:
> On Tue, 2006-03-21 17:20:57 +0100, Sam Ravnborg <sam@ravnborg.org> wrote:
> > diff --git a/scripts/package/Makefile b/scripts/package/Makefile
> > index c201ef0..d3038b7 100644
> > --- a/scripts/package/Makefile
> > +++ b/scripts/package/Makefile
> > @@ -82,7 +82,7 @@ clean-dirs += $(objtree)/debian/
> >  
> >  # tarball targets
> >  # ---------------------------------------------------------------------------
> > -.PHONY: tar%pkg
> > +PHONY += tar%pkg
> >  tar%pkg:
> >  	$(MAKE) KBUILD_SRC=
> >  	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
> 
> This part is wrong. $(PHONY) isn't subject to pattern matching, so all
> targets that match 'tar%pkg' must be listed here. Fortunately, that's
> only three:
> 
> PHONY += tar-pkg targz-pkg tarbz2-pkg

Correct. It is fixed in a later patch were I kill the use of PHONY in
this file.
I got replaced by specifying FORCE as a prerequsite.

	Sam
