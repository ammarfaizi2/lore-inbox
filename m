Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbSLRToC>; Wed, 18 Dec 2002 14:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbSLRToC>; Wed, 18 Dec 2002 14:44:02 -0500
Received: from [213.171.53.133] ([213.171.53.133]:58633 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267331AbSLRTnh>;
	Wed, 18 Dec 2002 14:43:37 -0500
Date: Wed, 18 Dec 2002 22:51:27 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Jaroslav Kysela <perex@perex.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
In-Reply-To: <Pine.LNX.4.33.0212182013070.550-100000@pnote.perex-int.cz>
Message-ID: <Pine.BSF.4.05.10212182234560.25928-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002, Jaroslav Kysela wrote:

> On Wed, 18 Dec 2002, Greg KH wrote:
> 
> > > ChangeSet 1.885.1.5, 2002/12/18 10:13:22+01:00, perex@suse.cz
> > 
> > <snip>
> > 
> > > diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
> > > --- a/sound/usb/usbaudio.c	Wed Dec 18 10:07:34 2002
> > > +++ b/sound/usb/usbaudio.c	Wed Dec 18 10:07:34 2002
> > > @@ -526,7 +526,11 @@
> > >  /*
> > >   * complete callback from data urb
> > >   */
> > > +#ifndef OLD_USB
> > >  static void snd_complete_urb(struct urb *urb, struct pt_regs *regs)
> > > +#else
> > > +static void snd_complete_urb(struct urb *urb)
> > > +#endif
> > >  {
> > >  	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
> > >  	snd_usb_substream_t *subs = ctx->subs;
> > > @@ -551,7 +555,11 @@
> > >  /*
> > >   * complete callback from sync urb
> > >   */
> > > +#ifndef OLD_USB
> > >  static void snd_complete_sync_urb(struct urb *urb, struct pt_regs *regs)
> > > +#else
> > > +static void snd_complete_sync_urb(struct urb *urb)
> > > +#endif
> > >  {
> > >  	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
> > >  	snd_usb_substream_t *subs = ctx->subs;
> > > @@ -583,6 +591,9 @@
> > 
> > Ick, you're kidding me, right?  Why do this?  Are you trying to keep a
> > common code base with 2.4 and 2.5 USB drivers?  If so, I don't recommend
> > it, as the code will be sprinkled with these ifdef's...
> 
> Not much. We have 9 #ifdef's and all trying to resolve the conflicts with 
> new function prototypes which is difficult to replace with defines or 
> inline functions. Perhaps, you'll have an idea to solve this problem.
> 
> For us, it's very important to have only one code base for all kernels, 
> but on the other hand, we're trying to leave the 2.2/2.4 kernel code 
> specific parts separate in our CVS repository if possible.
> 
> 						Jaroslav
> 
Hello, Jaroslav and All.
How about other changes in new 2.5 kernel, like new PnP layer (Adam Belay)
or changes with module & boot params (Rusty Russel)? There are now some
changes in 2.5.52 kernel in sound/isa/opl3sa2.c that make this driver not
compatible with other kernels. May be it's better split your tree in
several trees for each version of kernels?
					Ruslan.


