Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbSLRTMT>; Wed, 18 Dec 2002 14:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbSLRTMT>; Wed, 18 Dec 2002 14:12:19 -0500
Received: from gate.perex.cz ([194.212.165.105]:35598 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267321AbSLRTMR>;
	Wed, 18 Dec 2002 14:12:17 -0500
Date: Wed, 18 Dec 2002 20:17:55 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
In-Reply-To: <20021218182135.GD31197@kroah.com>
Message-ID: <Pine.LNX.4.33.0212182013070.550-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002, Greg KH wrote:

> > ChangeSet 1.885.1.5, 2002/12/18 10:13:22+01:00, perex@suse.cz
> 
> <snip>
> 
> > diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
> > --- a/sound/usb/usbaudio.c	Wed Dec 18 10:07:34 2002
> > +++ b/sound/usb/usbaudio.c	Wed Dec 18 10:07:34 2002
> > @@ -526,7 +526,11 @@
> >  /*
> >   * complete callback from data urb
> >   */
> > +#ifndef OLD_USB
> >  static void snd_complete_urb(struct urb *urb, struct pt_regs *regs)
> > +#else
> > +static void snd_complete_urb(struct urb *urb)
> > +#endif
> >  {
> >  	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
> >  	snd_usb_substream_t *subs = ctx->subs;
> > @@ -551,7 +555,11 @@
> >  /*
> >   * complete callback from sync urb
> >   */
> > +#ifndef OLD_USB
> >  static void snd_complete_sync_urb(struct urb *urb, struct pt_regs *regs)
> > +#else
> > +static void snd_complete_sync_urb(struct urb *urb)
> > +#endif
> >  {
> >  	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
> >  	snd_usb_substream_t *subs = ctx->subs;
> > @@ -583,6 +591,9 @@
> 
> Ick, you're kidding me, right?  Why do this?  Are you trying to keep a
> common code base with 2.4 and 2.5 USB drivers?  If so, I don't recommend
> it, as the code will be sprinkled with these ifdef's...

Not much. We have 9 #ifdef's and all trying to resolve the conflicts with 
new function prototypes which is difficult to replace with defines or 
inline functions. Perhaps, you'll have an idea to solve this problem.

For us, it's very important to have only one code base for all kernels, 
but on the other hand, we're trying to leave the 2.2/2.4 kernel code 
specific parts separate in our CVS repository if possible.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

