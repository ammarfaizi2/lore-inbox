Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268289AbTAMTAq>; Mon, 13 Jan 2003 14:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268293AbTAMTAq>; Mon, 13 Jan 2003 14:00:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3590 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268289AbTAMTAp>;
	Mon, 13 Jan 2003 14:00:45 -0500
Date: Mon, 13 Jan 2003 11:09:35 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Problems with USB
Message-ID: <20030113190935.GB8394@kroah.com>
References: <OF5C27F452.AC6AECA2-ONC1256CAC.0070FAA4@vgd.cz> <mailman.1042437481.27105.linux-kernel2news@redhat.com> <200301131859.h0DIx9s10713@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301131859.h0DIx9s10713@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 01:59:09PM -0500, Pete Zaitcev wrote:
> > On Sun, Jan 12, 2003 at 09:44:42PM +0100, Petr.Titera@whitesoft.cz wrote:
> >>      I have problems with USB in recent kernels (tested on 2.5.56) and
> >> RedHat 8.0. Right after end of script  '/etc/rc.d/rc.sysinit' and before
> >> script '/etc/rc.d/rc' which runs after USB  daemon khubd gets some signal
> >> and ends.
> 
> > greg k-h
> > 
> > # USB: Fix from Jeff and Pete to keep khubd from being able to be killed
> > #      by a signal
> > 
> > diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > --- a/drivers/usb/core/hub.c	Sun Jan 12 22:03:13 2003
> > +++ b/drivers/usb/core/hub.c	Sun Jan 12 22:03:13 2003
> > @@ -1085,6 +1085,12 @@
> >  
> >  	daemonize();
> >  
> > +	/* keep others from killing us */
> > +	spin_lock_irq(&current->sig->siglock);
> > +	sigemptyset(&current->blocked);
> > +	recalc_sigpending();
> > +	spin_unlock_irq(&current->sig->siglock);
> > +
> >  	/* Setup a nice name */
> >  	strcpy(current->comm, "khubd");
> >  
> 
> For the record, I disagree with this strongly.

Ok, Arjan also just convinced me to revert this patch, as Ingo's patch
is the correct fix.

thanks,

greg k-h
