Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSLTNTy>; Fri, 20 Dec 2002 08:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSLTNTy>; Fri, 20 Dec 2002 08:19:54 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:48067 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261907AbSLTNTx>;
	Fri, 20 Dec 2002 08:19:53 -0500
Date: Fri, 20 Dec 2002 14:24:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Bjorn Helgaas <bjorn_helgaas@hp.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] joydev: fix HZ->millisecond transformation
Message-ID: <20021220142443.A26184@ucw.cz>
References: <200212161227.38764.bjorn_helgaas@hp.com> <3E02F3EE.C1367073@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E02F3EE.C1367073@mvista.com>; from george@mvista.com on Fri, Dec 20, 2002 at 02:41:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 02:41:50AM -0800, george anzinger wrote:
> Bjorn Helgaas wrote:
> > 
> > * fix a problem with HZ->millisecond transformation on
> >   non-x86 archs (from 2.5 change by vojtech@suse.cz)
> > 
> > Applies to 2.4.20.
> > 
> > diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
> > --- a/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > +++ b/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > @@ -50,6 +50,8 @@
> >  #define JOYDEV_MINORS          32
> >  #define JOYDEV_BUFFER_SIZE     64
> > 
> > +#define MSECS(t)       (1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
> Uh...                                                
> ^^^^^^^^^^^^^^^^
> by definition this is zero, is it not?

No, both parts of the equaition can be nonzero.

Though it might be easier to say (1000 * t) / HZ, now that I think about
it.

-- 
Vojtech Pavlik
SuSE Labs
