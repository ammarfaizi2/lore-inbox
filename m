Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUFENTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUFENTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 09:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFENTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 09:19:48 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:6613 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S261358AbUFENTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 09:19:44 -0400
Message-ID: <40C1C892.8A73EA24@users.sourceforge.net>
Date: Sat, 05 Jun 2004 16:20:18 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: =?iso-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlinks for building external modules
References: <200406031858.09178.agruen@suse.de> <yw1x8yf44lgp.fsf@kth.se> <20040603173656.GA2301@mars.ravnborg.org> <40C0AE16.F4F222DD@users.sourceforge.net> <20040604192304.GB3530@mars.ravnborg.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jun 04, 2004 at 08:15:02PM +0300, Jari Ruusu wrote:
> > How long have you recommended building external modules like this:
> >
> >  make -C /lib/modules/`uname -r`/build modules SUBDIRS=`pwd`
> >   or
> >  make -C /lib/modules/`uname -r`/build modules M=`pwd`
> >
> > Now they all have to be changed to:
> >
> >  make -C /lib/modules/`uname -r`/source modules SUBDIRS=`pwd`
> >   or
> >  make -C /lib/modules/`uname -r`/source modules M=`pwd`
> 
> That would not work either.
> You need to tell kbuild both where to find the source and the output files.
> So you have to specify both -C ... and O=...
> KERNEL=/lib/modules/`uname -r`
> make -C $KERNEL/source O=$KERNEL/build M=`pwd`
> 
> There is no way to do the proposed chang and be backward compatible
> when the kernel is build using seperate output directories.

What I and Måns Rullgård are saying is this: A symlink to object directory
is missing. The fix is to add the damn symlink. However, breaking symlink to
source directory at the same time is unacceptable.

In other words:
build  ->  Symlink to kernel sources and build machinery, Makefiles and
           scripts. No change here.
object ->  Symlink to separate object tree. This is new.

Existing functionality when using separate source and object directories is
that only the 'build' symlink exists, and that points to kernel build
machinery. And that 'build' symlink must stay that way.

> Plese note that the patch Andreas made did not break existing setups
> if a seperate output directory was not used. The only effect
> would be an additional symlink to the same dir. (build and source would
> be links to the same dir).

All code that uses the 'build' symlink needs to be changed if Andreas' patch
is merged to mainline. That is quite breakage.

Sam, you are wrong here. I hope you have enough balls to admit that instead
of forcing everyone to deal with the proposed breakage.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
