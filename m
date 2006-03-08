Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWCHUaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWCHUaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWCHUaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:30:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34266 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750737AbWCHUaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:30:22 -0500
Subject: Re: [v4l-dvb-maintainer] 2.6.16-rc5: known regressions
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Brian Marete <bgmarete@gmail.com>
Cc: video4linux-list@redhat.com, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <6dd519ae0603080313o4e7b8a61h5002125c33a0e008@mail.gmail.com>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	 <20060227061354.GO3674@stusta.de> <1141308011.5884.5.camel@localhost>
	 <6dd519ae0603080313o4e7b8a61h5002125c33a0e008@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 08 Mar 2006 17:29:30 -0300
Message-Id: <1141849770.7534.55.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow! Lots of people being c/c here! Since all pertinent guys are at
lkml, I've just removed all those spam, keeping copied just the lists,
and Adrian, who warned me about it.

Em Qua, 2006-03-08 às 14:13 +0300, Brian Marete escreveu:
> What you say is quite correct.
> 
> However, my card is not known by the driver, and `card=3' has been working
> for me all the while, with no problems at all. In any case, removing
> `disable_ir=1' from the insmod options hides the problem for me. By the way,
> that option was there since in an an earlier -rc, loading the driver without
> it would cause an oops.
The option disable_ir is, in fact, a workaround. If this is not needed
anymore, this is a progress ;) Anyway, having an OOPS is really bad. We
should go further to avoid oops on it.

IR on some saa7134 cards are really a trouble. Sometimes, it just
generates lots of weird events, since you are gathering a generic io
port (GPIO) from hardware to generate keypressing. Using the wrong port
may generate troubles at the system, by sending wrong events to input.
With a wrong card, if somebody fixed the IR, it may broke for your
board.
> 
> If there are any hints about how I might discover the correct parameters for
> my card to be added to `saa7134-cards.c' I would love to hear them.
> I am tired of the FM radio not working anyway. Next time, I will make sure to
> avoid the cheap, brand less cards made in God Knows Where :)
El Cheapo boards are difficult to support. Most of they don't offer an
unique PCI ID. Others are just OEM cards. The same card is selled on
several different markets with different brand names (sometimes with
different GPIO ports and/or tuners).

For you to include it at kernel, you need to discover gpio ports used on
it. There are some wiki pages at http://linuxtv.org explaining the
process of identifying it using dscaler for m$. Dscaler is a freeware,
and have a small app, called regspy, that enables reading what windoze
is programming at some devices. For more details, please look at:
http://linuxtv.org/v4lwiki/index.php/GPIO_pins
> 
> Thanks,
> Brian Marete.
> 
> On 3/2/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> >
> >
> > > Subject    : Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko
> > > References : http://lkml.org/lkml/2006/2/20/122
> > > Submitter  : Brian Marete <bgmarete@gmail.com>
> > > Status     : unknown
> >
> > This is not a regression, since the user is not configuring saa7134 with
> > the right card.
> >
> > Cheers,
> > Mauro.
> >
> >
> 
> 
> --
> B. Gitonga Marete
> Tel: +254-722-151-590
> _______________________________________________
> v4l-dvb-maintainer mailing list
> v4l-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer
Cheers, 
Mauro.

