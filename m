Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRFGPXk>; Thu, 7 Jun 2001 11:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRFGPXa>; Thu, 7 Jun 2001 11:23:30 -0400
Received: from ns.suse.de ([213.95.15.193]:49673 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261425AbRFGPXW>;
	Thu, 7 Jun 2001 11:23:22 -0400
Date: Thu, 7 Jun 2001 17:22:51 +0200
From: Olaf Hering <olh@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.5-ac9 console NULL pointer pointer dereference
Message-ID: <20010607172251.B29309@suse.de>
In-Reply-To: <UTC200106071436.QAA224593.aeb@vlet.cwi.nl> <20010607165638.A19959@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010607165638.A19959@suse.de>; from olh@suse.de on Thu, Jun 07, 2001 at 04:56:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, Olaf Hering wrote:

> On Thu, Jun 07, Andries.Brouwer@cwi.nl wrote:
> 
> >     From: Olaf Hering <olh@suse.de>
> > 
> >     this happend with 2.4.5-ac9 with serial console on i386.
> > 
> >     Unable to handle kernel NULL pointer dereference0x02f8 (irq = 3) at virtual address 00000004
> >     Oops: 0000
> >     >>EIP; c01967c7 <poke_blanked_console+1b/5c>   <=====
> > 
> > Sounds like this should help:
> > 
> > --- console.c~  Fri Feb  9 20:30:22 2001
> > +++ console.c   Thu Jun  7 16:28:59 2001
> > @@ -2684,7 +2684,7 @@
> >  void poke_blanked_console(void)
> >  {
> >         del_timer(&console_timer);      /* Can't use _sync here: called from tasklet */
> > -       if (vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
> > +       if (!vt_cons[fg_console] || vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
> >                 return;
> >         if (console_blanked) {
> >                 console_timer.function = unblank_screen_t;
> 
> That was ok, but:
> ....
> INIT: Id "1" respawning too fast: disabled for 5 minutes
> INIT: Id "2" respawning too fast: disabled for 5 minutes
> INIT: Id "3" respawning too fast: disabled for 5 minutes
> INIT: Id "5" respawning too fast: disabled for 5 minutes
> INIT: Id "6" respawning too fast: disabled for 5 minutes
> INIT: Id "4" respawning too fast: disabled for 5 minutes
> 
> 
> Welcome to SuSE Linux 7.2 (i386) - Kernel 2.4.5-ac9 (ttyS0).
> ....

Appearently not a .config bug. Any ideas?
http://www.penguinppc.org/~olaf/bugs/245-ac9/config.gz



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
