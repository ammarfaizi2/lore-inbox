Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTIFE3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 00:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIFE3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 00:29:23 -0400
Received: from waste.org ([209.173.204.2]:33946 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262231AbTIFE3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 00:29:21 -0400
Date: Fri, 5 Sep 2003 23:29:14 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jan Ischebeck <mail@jan-ischebeck.de>,
       viro@parcelfarce.linux.theplanet.co.uk
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-mm6
Message-ID: <20030906042914.GP31897@waste.org>
References: <1062766000.2081.11.camel@JHome.uni-bonn.de> <20030905145124.GF454@parcelfarce.linux.theplanet.co.uk> <1062810478.2101.27.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062810478.2101.27.camel@JHome.uni-bonn.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 03:07:58AM +0200, Jan Ischebeck wrote:
> Am Fr, 2003-09-05 um 16.51 schrieb
> viro@parcelfarce.linux.theplanet.co.uk:
> > On Fri, Sep 05, 2003 at 02:46:40PM +0200, Jan Ischebeck wrote:
> > > Seems like I got the reason for X not starting:
> > > 
> > > pseudo terminals can't be acquired and only two consoles are
> running.
> > > 
> > > -> X11 can't get console Vt7
> > > -> pppd doesn't work either
> > > 
> > > This definitely worked with -mm5.
> > 
> > Grr...  Dumb typo.  Patch below should fix that...
> > 
> > diff -urN B4-misc3/drivers/char/tty_io.c
> B4-current/drivers/char/tty_io.c
> > +++ B4-current/drivers/char/tty_io.c  Fri Sep  5 10:46:59 2003
> > @@ -1334,7 +1334,7 @@
> >               return -ENODEV;
> >       }
> >  
> > -     if (device == MKDEV(TTY_MAJOR,2)) {
> > +     if (device == MKDEV(TTYAUX_MAJOR,2)) {
> >  #ifdef CONFIG_UNIX98_PTYS
> >               /* find a device that is not in use. */
> >               retval = -1;
> 
> Thank you, that solved the problem with X.
> 
> But PPP is still broken, I get the following errors when I've tried to
> setup a connection. And after trying to use ppp the machine oops at
> shutdown.

Probably related badness: ttyS[01] have disappeared from
/proc/interrupts (though still show up in dmesg) and while serial
console appears to still work, kgdb over serial appears to have gone
south as well. Last tested in -mm4.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
