Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbTAQT7k>; Fri, 17 Jan 2003 14:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267654AbTAQT7j>; Fri, 17 Jan 2003 14:59:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48903 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267652AbTAQT7c>;
	Fri, 17 Jan 2003 14:59:32 -0500
Date: Fri, 17 Jan 2003 21:07:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Anders Gustafsson <andersg@0x63.nu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117200740.GA9911@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Anders Gustafsson <andersg@0x63.nu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0301171326040.8910-100000@vervain.sonytel.be> <Pine.LNX.4.44.0301171035120.15056-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301171035120.15056-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 10:36:54AM -0600, Kai Germaschewski wrote:
> > Isn't all of this in .depend?
> 
> In 2.5 things work differently, so no.

The longer answer, if you feel bored :-)

In 2.5 kbuild generate a file that list all dependencies:
.foo.o.cmd

This file is generated the first time the file is compiled, and contains
dependencies too all included files + all referred CONFIG_* options.

What to keep in mind is that make does NOT know the dependencies when run
the very first time. Thats because there is no need to generate the
.foo.o.cmd file when the .o file does not exist - make will build it no
matter what.
Therefore if foo.c depends on <linux/whatever.h> make will not
see this dependency, and gcc will complain.

Though - at the second run make will know the dependency and 'get' the file.

Kconfig files are special in the sense that we do not always check
the full dependency on them.
We have autoconf.h, config/MARKER and more magic involved here.

Since kconfig does not generate a .config.cmd when it fails to locate
a Kconfig file, it would not help to clean up this - with respect to
BK/CVS integration.

HTH,
	Sam - kbuild apprentice ;-)
