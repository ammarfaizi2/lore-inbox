Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVBHWbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVBHWbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVBHWbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:31:00 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:28639 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261589AbVBHWau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:30:50 -0500
Date: Mon, 7 Feb 2005 19:51:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: David Fries <dfries@mail.win.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Message-ID: <20050207185143.GA2006@ucw.cz>
References: <20041123212813.GA3196@spacedout.fries.net> <d120d500050201072413193c62@mail.gmail.com> <20050206131241.GA19564@ucw.cz> <200502062021.13726.dtor_core@ameritech.net> <20050207122033.GA16959@ucw.cz> <d120d500050207062257490ae2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050207062257490ae2@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 09:22:19AM -0500, Dmitry Torokhov wrote:

> On Mon, 7 Feb 2005 13:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Sun, Feb 06, 2005 at 08:21:13PM -0500, Dmitry Torokhov wrote:
> > > > > Opening braces should go on the same line as the statement (if (...) {).
> > > >  
> > > > How about this patch?
> > >
> > > Looks fine now. Hmm, wait a sec... Don't we also need kill_fasync calls in
> > > disconnect routines as well?
> > 
> > This should do it:
> > 
> 
> Not quite...
> 
> > +               list_for_each_entry(list, &evdev->list, node)
> > +                       kill_fasync(&list->fasync, SIGIO, POLLHUP | POLLERR);
> 
> Wrong band constants - for SIGIO POLL_HUP and POLL_ERR should be used.

Obviously only one of them, since they're not designed for ORing. I used POLL_HUP then.

> /*
>  * SIGPOLL si_codes
>  */
> #define POLL_IN         (__SI_POLL|1)   /* data input available */
> #define POLL_OUT        (__SI_POLL|2)   /* output buffers available */
> #define POLL_MSG        (__SI_POLL|3)   /* input message available */
> #define POLL_ERR        (__SI_POLL|4)   /* i/o error */
> #define POLL_PRI        (__SI_POLL|5)   /* high priority input available */
> #define POLL_HUP        (__SI_POLL|6)   /* device disconnected */
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
