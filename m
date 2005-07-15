Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVGOVkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVGOVkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 17:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGOVkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 17:40:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63630 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261788AbVGOVi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 17:38:56 -0400
Date: Fri, 15 Jul 2005 14:38:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: [PATCH 2.6.13-rc3] kbuild: When checking depmod version, redirect stderr
Message-ID: <20050715213854.GY7741@smtp.west.cox.net>
References: <20050715145636.GU7741@smtp.west.cox.net> <20050715142432.15f6752b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715142432.15f6752b.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 02:24:32PM -0700, randy_dunlap wrote:
> On Fri, 15 Jul 2005 07:56:36 -0700 Tom Rini wrote:
> 
> > When running depmod to check for the correct version number, extra
> > output we don't need to see, such as "depmod: QM_MODULES: Function not
> > implemented" may show up.  Redirect stderr to /dev/null as the version
> > information that we do care about comes to stdout.
> > 
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > 
> > diff --git a/Makefile b/Makefile
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -875,7 +875,7 @@ modules_install: _modinst_ _modinst_post
> >  
> >  .PHONY: _modinst_
> >  _modinst_:
> > -	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
> > +	@if [ -z "`$(DEPMOD) -V 2>/dev/null | grep module-init-tools`" ]; then \
> >  		echo "Warning: you may need to install module-init-tools"; \
> >  		echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
> >  		sleep 1; \
> 
> Well, seeing "QM_MODULES" is a great indicator that someone is using
> modutils instead of module-init-tools, so I'd like to see it stay.
> IOW, I somewhat disagree with "extra output we don't need to see."

This shows up when building a 2.6 kernel with incorrect tools installed.
What shows up when building a 2.6 kernel on a 2.4 machine that's
properly setup to do both is "depmod: Can't open
/lib/modules/.../modules.dep for writing".

-- 
Tom Rini
http://gate.crashing.org/~trini/
