Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTBLL7q>; Wed, 12 Feb 2003 06:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbTBLL7q>; Wed, 12 Feb 2003 06:59:46 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:36578 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267042AbTBLL7p>; Wed, 12 Feb 2003 06:59:45 -0500
Date: Wed, 12 Feb 2003 13:09:33 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] jiffies wrap fixes for 2.5.60
In-Reply-To: <200302112231.41592.roger.larsson@skelleftea.mail.telia.com>
Message-ID: <Pine.LNX.4.33.0302121304510.18564-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- linux-2.5.60/arch/cris/drivers/usb-host.c	Fri Jan 17 03:21:51 2003
> > +++ linux-2.5.60-jfix/arch/cris/drivers/usb-host.c	Mon Feb 10 23:07:11 2003
> > @@ -459,7 +459,7 @@
> >  	*R_DMA_CH8_SUB2_CMD = IO_STATE(R_DMA_CH8_SUB2_CMD, cmd, stop);
> >  	/* Somehow wait for the DMA to finish current activities */
> >  	i = jiffies + 100;
> > -	while (jiffies < i);
> > +	while (time_before(jiffies, i));
>
> Busy wait? For several jiffies! Please...
> I hope that interrupts are not disabled.
>
>
> > --- linux-2.5.60/drivers/char/moxa.c	Fri Jan 17 03:22:44 2003
> > +++ linux-2.5.60-jfix/drivers/char/moxa.c	Mon Feb 10 23:01:59 2003

[...]
>
> But even worse useage is:
>
> void MoxaPortSendBreak(int port, int ms100)
[...]
>
> And there are more uses like this...

I completely agree this is very bad practice. Still I prefer several
miliseconds of busy-waiting to a potential 49 days busy wait.

Tim

