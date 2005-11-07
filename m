Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVKGXC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVKGXC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbVKGXC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:02:27 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:48955 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030190AbVKGXC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:02:26 -0500
Date: Tue, 8 Nov 2005 00:02:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, thang@redhat.com, linux-kernel@vger.kernel.org,
       Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH] kbuild updates
Message-ID: <20051107230243.GC10492@mars.ravnborg.org>
References: <20051106101844.GA11921@mars.ravnborg.org> <Pine.LNX.4.61.0511061341290.12843@scrub.home> <20051106132111.GA9042@mars.ravnborg.org> <Pine.LNX.4.61.0511071102380.12843@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511071102380.12843@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:13:16AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 6 Nov 2005, Sam Ravnborg wrote:
> 
> > On Sun, Nov 06, 2005 at 01:44:32PM +0100, Roman Zippel wrote:
> > > 
> > > What exactly is the problem? How does Fedora use QTLIB?
> > 
> > See:
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137926
> 
> I'm not really happy with this patch. I don't really like relying on 
> QTLIB, it's a really ugly hack.

I've forwarded your mail to Than Ngo (email was wrong in my origianl
mail). As the original patch author I like him to comment/test.

	Sam
	
> If the nonextisting ../lib64 dir is the problem, I'd more prefer a patch 
> like this:
> 
> Index: linux-2.6/scripts/kconfig/Makefile
> ===================================================================
> --- linux-2.6.orig/scripts/kconfig/Makefile	2005-11-06 00:27:29.000000000 +0100
> +++ linux-2.6/scripts/kconfig/Makefile	2005-11-07 11:08:58.000000000 +0100
> @@ -162,9 +164,10 @@ $(obj)/.tmp_qtcheck:
>  	  echo "*"; \
>  	  false; \
>  	fi; \
> -	LIBPATH=$$DIR/lib; LIB=qt; \
> +	LIBPATH=$$DIR/lib; LIB=qt; osdir=""; \
>  	$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
> -	  LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
> +	  osdir=$$($(HOSTCXX) -print-multi-os-directory); \
Common practice is to use $(shell $(HOSTCXX) -print-multi-os-directory)
It's more obvious what you achive.

	Sam
