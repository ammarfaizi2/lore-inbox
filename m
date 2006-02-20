Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWBTXmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWBTXmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWBTXmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:42:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964832AbWBTXmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:42:11 -0500
Date: Mon, 20 Feb 2006 15:40:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: efault@gmx.de, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       "Bernhard R. Link" <brlink@debian.org>
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Message-Id: <20060220154025.0b547085.akpm@osdl.org>
In-Reply-To: <200602210036.30836.rjw@sisk.pl>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<1140449123.7563.2.camel@homer>
	<20060220124122.1a38a065.akpm@osdl.org>
	<200602210036.30836.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Monday 20 February 2006 21:41, Andrew Morton wrote:
> > MIke Galbraith <efault@gmx.de> wrote:
> > >
> > > On Mon, 2006-02-20 at 16:07 +0100, Helge Hafting wrote:
> > >  > pentium IV single processor, gcc (GCC) 4.0.3 20060128
> > >  > 
> > >  > During boot, I normally get:
> > >  > parport0: irq 7 detected
> > >  > lp0: using parport0 (polling).
> > >  > 
> > >  > Instead, I got this, written by hand:
> > > 
> > >  ........
> > > 
> > >  > This oops is simplified. I can get the exact text if
> > >  > that really matters.  It is much more to write down and
> > >  > I don't usually have my camera at work.
> > > 
> > >  I get the same, and already have the serial console hooked up.
> > > 
> > >  BUG: unable to handle kernel NULL pointer dereference at virtual address 000000e8
> > 
> > Thanks.  Could someone try reverting
> > register-sysfs-device-for-lp-devices.patch?
> 
> That helps on my system.

OK, thanks.  I'll drop it.

> An unrelated problem is that USB host drivers (ohci-hcd, ehci-hcd) refuse to
> suspend.  [Investigating ...]

Me too.

Try reverting reset-pci-device-state-to-unknown-after-disabled.patch.  It
seems that my machine likes the bug which that fixes.  Something's most
mucked up in PM land.

