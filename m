Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262101AbSJNTGc>; Mon, 14 Oct 2002 15:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbSJNTGc>; Mon, 14 Oct 2002 15:06:32 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:41103 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S262101AbSJNTGa>; Mon, 14 Oct 2002 15:06:30 -0400
Date: Mon, 14 Oct 2002 14:12:07 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Wim Van Sebroeck <wim@iguana.be>
cc: rob@osinvestor.com, <davej@codemonkey.org.uk>, <rddunlap@osdl.org>,
       <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Watchdog drivers
In-Reply-To: <20021014184031.A19866@medelec.uia.ac.be>
Message-ID: <Pine.LNX.4.44.0210141408400.13924-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Also, I've got patches around from Matt Domsch that did the 
> > > move, and changed
> > > around the necessary drivers/char/ files.  I haven't been 
> > > keeping them up-to- date, maybe Matt has.
> > 
> > I haven't been, but it doesn't look too painful to do it.  The Natsemi
> > SCx200 merge is what's screwing up BK's automerge of it (I hadn't updated
> > that tree since April...).
> > 
> > The move work took me a few hours last time I did it, I can resurrect that
> > now that there's interest.  Give me a few hours, today's kind of busy...
> 
> I just did it myself this afternoon. It's indeed not to painfull to do this.
> I'll prepare some first patches tonight, so that people can start playing 
> with it. Second patch will be to make sure that it's all C99 designated 
> initializers.

I think this does it...  Builds right on x86, all the drivers that are in 
the tree right now...

Please do a
	bk pull http://mdomsch.bkbits.net/linux-2.5-mvwatchdog

This will update the following files:

 drivers/char/acquirewdt.c            |  242 ------------
 drivers/char/advantechwdt.c          |  270 --------------
 drivers/char/eurotechwdt.c           |  507 --------------------------
 drivers/char/i810-tco.c              |  385 --------------------
 drivers/char/i810-tco.h              |   45 --
 drivers/char/ib700wdt.c              |  301 ---------------
 drivers/char/machzwd.c               |  559 -----------------------------
 drivers/char/mixcomwd.c              |  279 --------------
 drivers/char/pcwd.c                  |  663 -----------------------------------
 drivers/char/sbc60xxwdt.c            |  355 ------------------
 drivers/char/scx200_wdt.c            |  277 --------------
 drivers/char/shwdt.c                 |  419 ----------------------
 drivers/char/softdog.c               |  197 ----------
 drivers/char/w83877f_wdt.c           |  342 ------------------
 drivers/char/wd501p.h                |   91 ----
 drivers/char/wdt.c                   |  566 -----------------------------
 drivers/char/wdt285.c                |  197 ----------
 drivers/char/wdt977.c                |  352 ------------------
 drivers/char/wdt_pci.c               |  655 ----------------------------------
 drivers/char/Config.help             |  436 -----------------------
 drivers/char/Config.in               |   33 -
 drivers/char/Makefile                |   32 -
 drivers/char/watchdog/Config.help    |  220 +++++++++++
 drivers/char/watchdog/Config.in      |   36 +
 drivers/char/watchdog/Makefile       |   49 ++
 drivers/char/watchdog/acquirewdt.c   |  242 ++++++++++++
 drivers/char/watchdog/advantechwdt.c |  270 ++++++++++++++
 drivers/char/watchdog/eurotechwdt.c  |  507 ++++++++++++++++++++++++++
 drivers/char/watchdog/i810-tco.c     |  385 ++++++++++++++++++++
 drivers/char/watchdog/i810-tco.h     |   45 ++
 drivers/char/watchdog/ib700wdt.c     |  301 +++++++++++++++
 drivers/char/watchdog/machzwd.c      |  559 +++++++++++++++++++++++++++++
 drivers/char/watchdog/mixcomwd.c     |  279 ++++++++++++++
 drivers/char/watchdog/pcwd.c         |  663 +++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/sbc60xxwdt.c   |  355 ++++++++++++++++++
 drivers/char/watchdog/scx200_wdt.c   |  277 ++++++++++++++
 drivers/char/watchdog/shwdt.c        |  419 ++++++++++++++++++++++
 drivers/char/watchdog/softdog.c      |  197 ++++++++++
 drivers/char/watchdog/w83877f_wdt.c  |  342 ++++++++++++++++++
 drivers/char/watchdog/wd501p.h       |   91 ++++
 drivers/char/watchdog/wdt.c          |  566 +++++++++++++++++++++++++++++
 drivers/char/watchdog/wdt285.c       |  197 ++++++++++
 drivers/char/watchdog/wdt977.c       |  352 ++++++++++++++++++
 drivers/char/watchdog/wdt_pci.c      |  655 ++++++++++++++++++++++++++++++++++
 44 files changed, 7013 insertions, 7197 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (02/10/14 1.852)
   watchdog: move from drivers/char to drivers/char/watchdog

<mdomsch@humbolt.us.dell.com> (02/04/12 1.373.15.2)
   remove left-behind Config.help watchdog entries, change Makefile comment

<mdomsch@humbolt.us.dell.com> (02/04/12 1.373.15.1)
   Move watchdog drivers to drivers/char/watchdog


Also in patch form:
http://domsch.com/linux/patches/watchdog/linux-2.5.42-mvwatchdog.patch
http://domsch.com/linux/patches/watchdog/linux-2.5.42-mvwatchdog.patch.asc

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


