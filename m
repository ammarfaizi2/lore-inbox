Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTLQP4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTLQP4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:56:37 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:9176 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S264449AbTLQP4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:56:33 -0500
Subject: Re: [PATCH 2.4] Wolfson AC97 touch screen driver - Input
	Event	interface
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3FE076A2.9050406@pobox.com>
References: <1071672291.23686.2634.camel@cearnarfon>
	 <3FE076A2.9050406@pobox.com>
Content-Type: text/plain
Message-Id: <1071676584.23686.2731.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 17 Dec 2003 15:56:24 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-17 at 15:30, Jeff Garzik wrote:

> > +/*
> > + * Pen down detection
> > + * 
> > + * Pen down detection can either be via an interrupt (preferred) or
> > + * by polling the PDEN bit. This is an option because some systems may
> > + * not support the pen down interrupt.
> > + *
> > + * Set pen_int to 1 to enable interrupt driven pen down detection.
> > + */
> > +MODULE_PARM(pen_int,"i");
> > +MODULE_PARM_DESC(pen_int, "Set pen down interrupt");
> > +static int pen_int = 0;	
> 
> I wouldn't call this "detection"  ;-)
> 
> This module option is awful for users.  How do users know what to do? 
> (rhetorical question...)   IMO this should be selected automatically on 
> a per-chipset basis.  I'm sure there is _some_ way to notice 
> programmatically, for instance selected by chipset or selecting by 
> sending a test interrupt.
> 
> XScale PDA users just aren't going to know this kind of information off 
> the top of their heads...
> 
> 

Yeah, your right. I was aiming this configuration option at developers.
Currently the driver can either poll the pen down status (expensive, but
platform agnostic) or it could be interrupted (if supported on the
platform) when the pen up / down status changed.

I'll make this automatically be determined at build time. 

> >  /*
> >   * ADC sample delay times in uS
> >   */
> >  static const int delay_table[16] = {
> > -	21,		// 1 AC97 Link frames
> > -	42,		// 2
> > -	84,		// 4
> > -	167,		// 8
> > -	333,		// 16
> > -	667,		// 32
> > -	1000,		// 48
> > -	1333,		// 64
> > -	2000,		// 96
> > -	2667,		// 128
> > -	3333,		// 160
> > -	4000,		// 192
> > -	4667,		// 224
> > -	5333,		// 256
> > -	6000,		// 288
> > -	0 		// No delay, switch matrix always on
> > +	21,// 1 AC97 Link frames
> > +	42,// 2
> > +	84,// 4
> > +	167,// 8
> > +	333,// 16
> > +	667,// 32
> > +	1000,// 48
> > +	1333,// 64
> > +	2000,// 96
> > +	2667,// 128
> > +	3333,// 160
> > +	4000,// 192
> > +	4667,// 224
> > +	5333,// 256
> > +	6000,// 288
> > +	0 // No delay, switch matrix always on
> >  };
> 
> is this a mistake?  You just made the code more difficult to read.

Yep, I seem to have some unintentional whitespace/tab changes.


> > +// Todo
> > +static void wm97xx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> > +{
> > +	info("int recv");
> > +}
> 
> hmmmm.
> 
> This change doesn't seem terribly appropriate for the 2.4.x stable series...
> 
> 

Work in progress. Will remove for 2.4.x

I'll address the remaining issues create another patch.

Liam

