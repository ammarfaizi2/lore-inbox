Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTAQEPL>; Thu, 16 Jan 2003 23:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTAQEPL>; Thu, 16 Jan 2003 23:15:11 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:46498 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267353AbTAQEPJ>; Thu, 16 Jan 2003 23:15:09 -0500
Date: Thu, 16 Jan 2003 22:24:04 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Anders Gustafsson <andersg@0x63.nu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
In-Reply-To: <20030117041628.GB1794@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.LNX.4.44.0301162220160.19302-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Anders Gustafsson wrote:

> On Thu, Jan 16, 2003 at 10:12:23PM -0600, Kai Germaschewski wrote:
> > > ./scripts/kconfig/mconf arch/i386/Kconfig
> > > arch/i386/Kconfig:1185: can't open file "drivers/eisa/Kconfig"
> > > make: *** [menuconfig] Error 1
> > 
> > 	bk -r get -q
> > 
> > or just
> > 
> > 	bk get drivers/eisa
> > 
> > in this case. I guess this is becoming a FAQ.
> 
> It would be cool if the the Makefile let make knew about these dependencies
> so they would be checked out automagically.

Unfortunately, the Makefile doesn't really know about the Kconfig files, 
the "source drivers/whatever/Kconfig" commands are in Kconfig, and 
duplicating them into the Makefile would be rather error-prone.

Even if that was done, the Makefiles also cannot know about e.g. headers 
included into C files, so it'd die at that point. At some point I hacked a 
LD_PRELOAD library which would try to exec a "get" when open(2) fails, 
which fixes gcc, kconfig and whatnotsoever. I suppose a better solution is 
"checkout: get", though.

--Kai


