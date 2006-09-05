Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWIEQCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWIEQCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWIEQCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:02:17 -0400
Received: from main.gmane.org ([80.91.229.2]:63901 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965131AbWIEQCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:02:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Steve Fox" <drfickle@us.ibm.com>
Subject: Re: 2.6.18-rc5-mm1 dependency on curses devel still there
Date: Tue, 5 Sep 2006 16:00:59 +0000 (UTC)
Message-ID: <edk6vr$i0u$1@sea.gmane.org>
References: <20060901015818.42767813.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 24-159-201-235.dhcp.roch.mn.charter.com
User-Agent: pan 0.109 (Beable)
Cc: linux-kernel-announce@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 01:58:18 -0700, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/

The dependency on having curses installed reported by Andy Whitcroft for
2.6.18-rc4-mm1 is still there. I've included the prior discussion below.
Could this patch be reverted or fixed to not build things which use
curses? Thanks.

Andy Whitcroft wrote:
> Andy Whitcroft wrote:
> > Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/ 
> >>
> > 
> >>  git-lxdialog.patch
> > 
> > This tree seems to change the Makefile dependancies in the kconfig 
> > subdirectory such that a plain compile of the kernel leads to an attempt 
> > to build the menuconfig targets.  This in turn adds a new dependancy on 
> > the curses development libraries.
> > 
> >   08/15/06-05:23:09 building kernel - make -j4 vmlinux
> >     HOSTCC  scripts/kconfig/lxdialog/checklist.o
> >   In file included from scripts/kconfig/lxdialog/checklist.c:24:
> >               scripts/kconfig/lxdialog/dialog.h:31:20: error: curses.h:
> >               No such file or directory
> > 
> > This seems to come from this rather innocent sounding change in that tree:
> > 
> > commit 9238251dddc15b52656e70b74dffe56193d01215
> > Author: Sam Ravnborg <sam@mars.ravnborg.org>
> > Date:   Mon Jul 24 21:40:46 2006 +0200
> > 
> >     kconfig/lxdialog: refactor color support
> > 
> 
> Ok, reading the patch as if its git output isn't a good plan.  The 
> changeset appears to be this one:
> 
> commit 49140e7b29bb1fcc195efef3e1c54c144dd2eff7
> Author: Sam Ravnborg <sam@mars.ravnborg.org>
> Date:   Thu Jul 27 22:10:27 2006 +0200
> 
>      kconfig/menuconfig: lxdialog is now built-in
> 
> 
> > which also seems to change the Makefile about, specifically bringing the 
> > sub Makefile into the top level one.
> > 
> > [...]
> > -       $(Q)$(MAKE) $(build)=scripts/kconfig/lxdialog
> > [...]
> > +# lxdialog stuff
> > +check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
> > [...]
> > 
> > Sam?
> > 
> > -apw

Andy Whitcroft wrote:
> Sam Ravnborg wrote:
> > On Wed, Aug 16, 2006 at 10:41:59AM +0100, Andy Whitcroft wrote:
> >> This tree seems to change the Makefile dependancies in the kconfig 
> >> subdirectory such that a plain compile of the kernel leads to an attempt 
> >> to build the menuconfig targets.  This in turn adds a new dependancy on 
> >> the curses development libraries.
> > What I see is that "make defconfig" builds _all_ *config targets -
> > strange...
> 
> Well it could be trying to build them all for me too, but as I don't 
> have curses development libraries it would fail at that point.  I don't 
> think we want it to build the ones its not using.  Thats daft :).
-- 

Steve Fox
IBM Linux Technology Center

