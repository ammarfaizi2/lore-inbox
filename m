Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTA0JP5>; Mon, 27 Jan 2003 04:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTA0JP4>; Mon, 27 Jan 2003 04:15:56 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:33416 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262446AbTA0JPz>;
	Mon, 27 Jan 2003 04:15:55 -0500
Date: Mon, 27 Jan 2003 01:24:54 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Christian Zander <zander@minion.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127092454.GD21959@vana.vc.cvut.cz>
References: <20030127061720.GB13835@vana.vc.cvut.cz> <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu> <12104.1043658131@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12104.1043658131@passion.cambridge.redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 09:02:11AM +0000, David Woodhouse wrote:
> 
> vandrove@vc.cvut.cz said:
> > From my exprience at VMware newsgroups distros have bad troubles even
> > with delivery of basic configured kernel headers matching to kernel
> > binaries they provide (it is not unusual that for example they go from
> > 1GB to 4GB kernel without make mrproper so kmap/kunmap do not have
> > proper versions attached :-( or they even sell headers and binaries
> > with different configs).
> 
> But you _need_ the config. Even with your own makefiles, how are you going
> to get it right for all new kernels that $CRAPDISTRO ships in a broken form, 
> if you don't have the configs?

Yes, but currently you need only 3 files: autoconf.h, version.h, and, eventually
.config, as other headers are read-only and nobody managed to get them
wrong (yet).

When using kernel Makefiles there are at least two more files (main and arch Makefile), 
of which main Makefile is known to be modified by vendors to get their cloneconfig
working: they define additional rules and variables, and you may run into conflict.

> If distros ship broken crap which doesn't let you build modules, there's 
> really not a lot you can do except note their quality control for the 
> record and report it in their bug tracking system.
> 
> You are _always_ going to have problems with people shipping shite, or
> possibly even actively going our of their way to prevent out-of-tree modules
> building. It's fairly much an orthogonal problem though, isn't it?

Increasing number of files needed to build module also increases possibility
that something will go wrong :-( Ok, I'll modify modules build script to
use kernel's build system if /lib/modules/`uname -r`/build/Makefile exists,
and I'll see. 

BTW, is there any way how code outside of Makefile can detect what file was 
generated and where it was stored: whether vmmon.o or vmmon.ko? As it is now,
Makefile contains obj-y := vmmon.o, but you can end up with vmmon.ko... I
need it to make a note for uninstaller which files we added to the system
(and which we can overwrite without prompting on upgrade).

							Petr Vandrovec
