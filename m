Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSK2WSb>; Fri, 29 Nov 2002 17:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSK2WSb>; Fri, 29 Nov 2002 17:18:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46340 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267160AbSK2WSa>;
	Fri, 29 Nov 2002 17:18:30 -0500
Date: Fri, 29 Nov 2002 23:25:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Romain Lievin <rlievin@free.fr>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kconfig (gkc): patch & help about Makefile
Message-ID: <20021129222543.GA2579@mars.ravnborg.org>
Mail-Followup-To: Romain Lievin <rlievin@free.fr>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021110132750.GB6256@free.fr> <Pine.LNX.4.44.0211101502460.2113-100000@serv> <20021128091059.GB388@free.fr> <Pine.LNX.4.44.0211281204030.2113-100000@serv> <20021128141223.GA601@free.fr> <Pine.LNX.4.44.0211282111110.2113-100000@serv> <20021128221239.GA1305@free.fr> <Pine.LNX.4.44.0211282318590.2113-100000@serv> <20021129214802.GA8225@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129214802.GA8225@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 10:48:02PM +0100, Romain Lievin wrote:
> 
> Nevertheless, I have a small problem: I did not manage to use gcc rather than
> g++ in the Makefile.

ifeq ($(MAKECMDGOALS),$(obj)/gkc)
        gkc-objs        := kconfig_load.o
        gkc-cxxobjs     := gconf.o
endif

In this part you tell kbuild that gconf.o is made from a .cc file
[implying C++] and g++ will be used.

If your gconf.cc really is a C-file (looks like it) then you only
need one line:
gkc-objs := gconf.o kconfig_load.o

But then you need to rename gconf.cc to gconf.c as well.

I tried to apply your patch, but it failed because I did
not have 'pkg-config'. I guess I need some GTK developer kit?

	Sam
