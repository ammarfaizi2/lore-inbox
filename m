Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSLTRRd>; Fri, 20 Dec 2002 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSLTRRd>; Fri, 20 Dec 2002 12:17:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1777 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263137AbSLTRRc>;
	Fri, 20 Dec 2002 12:17:32 -0500
Message-ID: <3E03526A.2AA4B685@mvista.com>
Date: Fri, 20 Dec 2002 09:24:58 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Bjorn Helgaas <bjorn_helgaas@hp.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] joydev: fix HZ->millisecond transformation
References: <200212161227.38764.bjorn_helgaas@hp.com> <3E02F3EE.C1367073@mvista.com> <20021220142443.A26184@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Fri, Dec 20, 2002 at 02:41:50AM -0800, george anzinger wrote:
> > Bjorn Helgaas wrote:
> > >
> > > * fix a problem with HZ->millisecond transformation on
> > >   non-x86 archs (from 2.5 change by vojtech@suse.cz)
> > >
> > > Applies to 2.4.20.
> > >
> > > diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
> > > --- a/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > > +++ b/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > > @@ -50,6 +50,8 @@
> > >  #define JOYDEV_MINORS          32
> > >  #define JOYDEV_BUFFER_SIZE     64
> > >
> > > +#define MSECS(t)       (1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
> > Uh...
> > ^^^^^^^^^^^^^^^^
> > by definition this is zero, is it not?
> 
> No, both parts of the equaition can be nonzero.

I don't think so.  s%HZ has to be less than HZ.  Then
dividing that by HZ should result in zero.  Where is my
thinking flawed?
> 
> Though it might be easier to say (1000 * t) / HZ, now that I think about
> it.

That overflows...  As does the other if HZ is less than
1000....
> 
> --
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
