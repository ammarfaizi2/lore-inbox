Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTI3MNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTI3MNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:13:39 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:27270 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261396AbTI3MNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:13:37 -0400
Date: Tue, 30 Sep 2003 14:13:30 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb still broken in -test6
Message-ID: <20030930121330.GB9523@vana.vc.cvut.cz>
References: <1AA960315C3@vcnet.vc.cvut.cz> <20030930104944.GA26681@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930104944.GA26681@bender.home.hensema.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 12:49:44PM +0200, Erik Hensema wrote:
> On Tue, Sep 30, 2003 at 12:08:42PM +0200, Petr Vandrovec wrote:
> > On 30 Sep 03 at 9:24, Erik Hensema wrote:
> > > The simptoms are:
> > > 
> > > - large white bar to the right of the pengiun logo on booting

Do you have vgacon enabled, and do not you use vga=XXX option? This white
region appears when hardware is switch to the SVGA mode before vgacon
was able to read screen contents from it (it reads 0xFF as an attribute,
giving light white letters on light white background).

> > > - (mostly) yellow distortion in the background: parts of the screen that
> > >   should be black, are distorted with a semi-regular pattern. Each line of
> > >   scrolling adds around 5 lines worth of distorion to the bottom of the
> > >   screen. The distorion works its way up until the entire screen is filled
> > >   with it.
> > >   Switching to and from another vc clears it.
> > 
> > Are you sure that you are not running XFree when this yellow distortion
> > occurs? It looks to me like that you are using XFree with DRI in 32bpp,
> > while your console uses 8bpp. Do not do that! DRI permanently smashes
> > accelerator state with its own setting, and this makes any other
> > accelerated work on the system unusable. So either disable matroxfb's
> > acceleration, or explain to your mga_dri that "screen invisble" should
> > mean "you do not own hardware, dude!".
> 
> I'm sure I do run X. Thanks for the explanation.

In that case you have to use same display resolution and color depth in both
X and on the console. Then you'll only get miscolored characters from time
to time, but no large corruption.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
