Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264607AbSIVW6Y>; Sun, 22 Sep 2002 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264608AbSIVW6Y>; Sun, 22 Sep 2002 18:58:24 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:17281 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264607AbSIVW6V>; Sun, 22 Sep 2002 18:58:21 -0400
Date: Sun, 22 Sep 2002 18:03:25 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <3D8E4A06.5010603@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0209221756130.11808-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Jeff Garzik wrote:

> Kai Germaschewski wrote:
> > On Sun, 22 Sep 2002, Jeff Garzik wrote:
> > 
> > 
> >>One cosmetic thing I mentioned to Roman, Config.new needs to be changed 
> >>to something better, like conf.in or build.conf or somesuch.
> > 
> > 
> > I agree. (But I'm not particularly good at coming up with names ;) 
> > build.conf is maybe not too bad considering that there may be a day where 
> > it is extended to support "<driver>.conf" as well.
> 
> We want to make sure the config format is extensible in case we want to 
> add Makefile rules or some other metadata (i.e. <driver>.conf contains 
> all config/make info needed to build a driver, just drop it in)
> 
> 
> > One other thing I wanted to mention but forgot was that lkc now
> > does a quiet "make oldconfig" when .config changed or does not exist, 
> > which is changed behavior.
> 
> 
> Can you elaborate a bit on that?  'make oldconfig' is one of the things 
> we want to keep working as-is...  That was a downside of ESR's system. 
> If you're saying "silent" as in, if-no-changes-occurred or 
> defconfig-copied-as-is, that's cool...

Roman probably knows better than I do, but anyway.

AFAICS, "quiet" only means the same thing as the traditional "make 
oldconfig", but suppressing questions where the answers are known. (Which 
I think is fine)

I was just referring to the following, which really is not in the subtle 
change category:

-------------------------------------------------------------
[kai@zephyr linux-2.5.make]$ rm .config
[kai@zephyr linux-2.5.make]$ make
***
*** You have not yet configured your kernel!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
make: *** [.config] Error 1
-------------------------------------------------------------

whereas lkc changes this to run (the quiet) make oldconfig automatically.

Same thing for 

-------------------------------------------------------------
[kai@zephyr linux-2.5.make]$ cp ../config-2.5 .config
[kai@zephyr linux-2.5.make]$ make
make[1]: Entering directory 
`/home/kai/src/kernel/v2.5/linux-2.5.make/scripts'
make[1]: Leaving directory 
`/home/kai/src/kernel/v2.5/linux-2.5.make/scripts'
***
*** You changed .config w/o running make *config?
*** Please run "make oldconfig"
***
-------------------------------------------------------------

Since people run automated builds, erroring out is IMHO preferable to 
dropping into interactive mode, which likely happens when you run make 
oldconfig.


--Kai



