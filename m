Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSLTR2W>; Fri, 20 Dec 2002 12:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSLTR2W>; Fri, 20 Dec 2002 12:28:22 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:19142 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262828AbSLTR2U>;
	Fri, 20 Dec 2002 12:28:20 -0500
Date: Fri, 20 Dec 2002 18:35:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Bjorn Helgaas <bjorn_helgaas@hp.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] joydev: fix HZ->millisecond transformation
Message-ID: <20021220183544.A26785@ucw.cz>
References: <200212161227.38764.bjorn_helgaas@hp.com> <3E02F3EE.C1367073@mvista.com> <20021220142443.A26184@ucw.cz> <3E03526A.2AA4B685@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E03526A.2AA4B685@mvista.com>; from george@mvista.com on Fri, Dec 20, 2002 at 09:24:58AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 09:24:58AM -0800, george anzinger wrote:
> Vojtech Pavlik wrote:
> > 
> > On Fri, Dec 20, 2002 at 02:41:50AM -0800, george anzinger wrote:
> > > Bjorn Helgaas wrote:
> > > >
> > > > * fix a problem with HZ->millisecond transformation on
> > > >   non-x86 archs (from 2.5 change by vojtech@suse.cz)
> > > >
> > > > Applies to 2.4.20.
> > > >
> > > > diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
> > > > --- a/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > > > +++ b/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > > > @@ -50,6 +50,8 @@
> > > >  #define JOYDEV_MINORS          32
> > > >  #define JOYDEV_BUFFER_SIZE     64
> > > >
> > > > +#define MSECS(t)       (1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
> > > Uh...
> > > ^^^^^^^^^^^^^^^^
> > > by definition this is zero, is it not?
> > 
> > No, both parts of the equaition can be nonzero.
> 
> I don't think so.  s%HZ has to be less than HZ.  Then
> dividing that by HZ should result in zero.  Where is my
> thinking flawed?

You first multiply it by 1000.

> > Though it might be easier to say (1000 * t) / HZ, now that I think about
> > it.
> 
> That overflows...  As does the other if HZ is less than 1000....

You're right, t can be all 32 bits.

-- 
Vojtech Pavlik
SuSE Labs
