Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWJPABE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWJPABE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWJPABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:01:04 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:44470 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030299AbWJPABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:01:01 -0400
Date: Sun, 15 Oct 2006 17:01:00 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Adrian Bunk <bunk@stusta.de>
cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 08/18] V4L/DVB (4734): Tda826x:
 fix	frontend selection for dvb_attach
In-Reply-To: <20061015123804.GW30596@stusta.de>
Message-ID: <Pine.LNX.4.58.0610151647590.29589@shell2.speakeasy.net>
References: <20061014115356.PS36551000000@infradead.org>
 <20061014120050.PS78628900008@infradead.org> <20061014121608.GN30596@stusta.de>
 <45312819.4080909@linuxtv.org> <20061014183322.GS30596@stusta.de>
 <45313306.104@linuxtv.org> <20061014191441.GU30596@stusta.de>
 <1160877306.28666.21.camel@praia> <20061015123804.GW30596@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006, Adrian Bunk wrote:
> > > To be honest and after looking deeper at it, I don't like this
> > > CONFIG_DVB_FE_CUSTOMIZE approach at all since it adds that much
> > > complexity for not much gain.
> > Yes, it adds some complexity. The gain, however, is to allow having
> > smaller kernel size on embedded systems and DVR using MythTV or Freevo.
> > There's a similar feature for V4L (Autoselect pertinent
> > encoders/decoders and other helper chips), that allows selecting just
> > the needed stuff.
>
> I understand this, but I still don't like the solution.
> But unless I can send a patch with a better solution, this is nothing I
> can complain about...

There used to be a different way of selecting which front-ends get
built/loaded, that was recently replaced with DVB_FE_CUSTOMISE.  It was
even more complex and only worked for a few card drivers that specially
supported it.

What is nice about the new DVB_FE_CUSTOMISE way is that there is very
little code needed.  There is a boilerplate #if in the font-end header file
for the _attach function, and that's it.

> There are two things that might be changed even now:
>
> The "default m if DVB_FE_CUSTOMISE" is something I do not like that
> much, especially considering that embedded users caring about kernel
> size are likely to use CONFIG_MODULES=n.

A front-end could default to the highest level of the card drivers which
utilizes it.  I'm not sure how to express that in a Kconfig file, and it
would be more work to maintain.  One has to go into the FE customisation
menu to turn on DVB_FE_CUSTOMISE anyway, at which point it seems like there
is little difference between disabling the drivers one doesn't want vs
enabling the drivers one does.
