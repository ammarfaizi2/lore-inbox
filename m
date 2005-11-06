Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVKFMo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVKFMo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 07:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKFMo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 07:44:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:45027 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750755AbVKFMo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 07:44:58 -0500
Date: Sun, 6 Nov 2005 13:44:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, thang@redhat.com, linux-kernel@vger.kernel.org,
       Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH] kbuild updates
In-Reply-To: <20051106101844.GA11921@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0511061341290.12843@scrub.home>
References: <20051106101844.GA11921@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 6 Nov 2005, Sam Ravnborg wrote:

> kconfig: fix xconfig on fedora 2 & 3 (x86_64)
> 
> From: Than Ngo <than@redhat.com>
> qt as installed on fedora core (2 and 3) does not work with vanilla
> kernel. The linker fails to locate the qt lib:
> 
> Actual Results:  # make xconfig
>   HOSTLD  scripts/kconfig/qconf
>   /usr/bin/ld: cannot find -lqt
>   collect2: ld returned 1 exit status
> 
> Than Ngo has provided following fix for the bug.
> 
> Cc: Than Ngo <than@redhat.com>
> Acked-by: Dave Jones <davej@redhat.com>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> ---
> commit ab919c06144cfb11c05b5b5cd291daa96ac2e423
> tree 8747dc3122c0c2ebefaf004a2d71e2cb7bd97615
> parent 2dd34b488a99135ad2a529e33087ddd6a09e992a
> author Sam Ravnborg <sam@mars.ravnborg.org> Sun, 06 Nov 2005 11:05:21 +0100
> committer Sam Ravnborg <sam@mars.ravnborg.org> Sun, 06 Nov 2005 11:05:21 +0100
> 
>  scripts/kconfig/Makefile |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 0dd9691..455aeab 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -129,7 +129,7 @@ endif
>  HOSTCFLAGS_lex.zconf.o	:= -I$(src)
>  HOSTCFLAGS_zconf.tab.o	:= -I$(src)
>  
> -HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(QTLIB) -ldl
> +HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(LIBS_QT) -ldl
>  HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include -D LKC_DIRECT_LINK
>  
>  HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
> @@ -163,11 +163,16 @@ $(obj)/.tmp_qtcheck:
>  	  false; \
>  	fi; \
>  	LIBPATH=$$DIR/lib; LIB=qt; \
> -	$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
> -	  LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
> -	if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
> +	if [ -f $$QTLIB/libqt-mt.so ] ; then \
> +		LIB=qt-mt; \
> +		LIBPATH=$$QTLIB; \
> +	else \
> +		$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
> +		LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
> +		if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
> +	fi; \
>  	echo "QTDIR=$$DIR" > $@; echo "QTLIBPATH=$$LIBPATH" >> $@; \
> -	echo "QTLIB=$$LIB" >> $@; \
> +	echo "LIBS_QT=$$LIB" >> $@; \
>  	if [ ! -x $$DIR/bin/moc -a -x /usr/bin/moc ]; then \
>  	  echo "*"; \
>  	  echo "* Unable to find $$DIR/bin/moc, using /usr/bin/moc instead."; \

What exactly is the problem? How does Fedora use QTLIB?

bye, Roman
