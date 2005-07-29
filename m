Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVG2Jkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVG2Jkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVG2Jkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:40:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbVG2Jke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:40:34 -0400
Date: Fri, 29 Jul 2005 02:39:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: jonsmirl@gmail.com, ink@jurassic.park.msu.ru, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4: dma_timer_expiry [was 2.6.13-rc2 hangs at boot]
Message-Id: <20050729023921.0950968f.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0507291132130.13321@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
	<9e47339105070618273dfb6ff8@mail.gmail.com>
	<20050728233408.550939d4.akpm@osdl.org>
	<Pine.GSO.4.58.0507291105480.12940@tukki.cc.jyu.fi>
	<20050729012452.16ee2a31.akpm@osdl.org>
	<Pine.GSO.4.58.0507291132130.13321@tukki.cc.jyu.fi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tero Roponen <teanropo@cc.jyu.fi> wrote:
>
> On Fri, 29 Jul 2005, Andrew Morton wrote:
> 
> > Tero Roponen <teanropo@cc.jyu.fi> wrote:
> > >
> > > Hi,
> > >
> > > I just tested 2.6.13-rc4. At boot it prints:
> > > "dma_timer_expiry: dma status == 0x61" many times.
> > > That's the same problem as in 2.6.13-rc2.
> > >
> > > If I apply the following patch, everything seems to be fine.
> > > I'm not sure if this is the right thing to do, but it works for me.
> > >
> > > -
> > > Tero Roponen
> > >
> > >
> > > --- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
> > > +++ linux/drivers/pci/setup-bus.c	Fri Jul  8 10:25:20 2005
> > > @@ -40,8 +40,8 @@
> > >   * FIXME: IO should be max 256 bytes.  However, since we may
> > >   * have a P2P bridge below a cardbus bridge, we need 4K.
> > >   */
> > > -#define CARDBUS_IO_SIZE		(4096)
> > > -#define CARDBUS_MEM_SIZE	(32*1024*1024)
> > > +#define CARDBUS_IO_SIZE		(256)
> > > +#define CARDBUS_MEM_SIZE	(32*1024*1024)
> > >
> >
> > hm, how did you come up with that fix?  Those numbers have been like that
> > since forever.
> >
> > What's the latest 2.6 kernel which worked OK?
> >
> > Would it be possible for you to generate the `dmesg -s 100000' output for
> > both good and bad kernels, see what the differences are?
> >
> > Thanks.
> 
> Hi,
> 
> that patch was from Ivan Kokshaysky (http://lkml.org/lkml/2005/7/8/25)

OK.

> My original report is here: http://lkml.org/lkml/2005/7/6/174

I see.  Ivan, do we know what's going on here?
