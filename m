Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWGNJUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWGNJUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWGNJUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:20:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6066 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161002AbWGNJUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:20:44 -0400
Date: Fri, 14 Jul 2006 11:20:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor@insightbb.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
In-Reply-To: <200607132231.46776.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.64.0607141115010.12900@scrub.home>
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com>
 <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com>
 <Pine.LNX.4.64.0607140033030.12900@scrub.home> <200607132231.46776.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Jul 2006, Dmitry Torokhov wrote:

> On Thursday 13 July 2006 18:58, Roman Zippel wrote:
> > Hi,
> > 
> > On Thu, 13 Jul 2006, Dmitry Torokhov wrote:
> > 
> > > config THRUSTMASTER_FF
> > >       bool "ThrustMaster FireStorm Dual Power 2 support (EXPERIMENTAL)"
> > >       depends on HID_FF && EXPERIMENTAL
> > > +       select INPUT_FF_MEMLESS
> > >       help
> > >         Say Y here if you have a THRUSTMASTER FireStore Dual Power 2,
> > >         and want to enable force feedback support for it.
> > > 
> > > Unfortunately this forces INPUT_FF_MEMLESS to always be built-in,
> > > although if HID is a module it could be a module as well. Do you have
> > > any suggestions as to how allow INPUT_FF_MEMLESS to be compiled as a
> > > module?
> > 
> > You need to directly include HID into the dependencies, only the direct 
> > dependencies for config entry are used for the select.
> >
> 
> Oh, this indeed works, thanks a lot! And I was thinking I would need to
> implement something like "select <expr> as <expr>" in kconfig ;)  

What you could do is to use "select INPUT_FF_MEMLESS if HID" to make it 
visible that this dependency is actually for select.
This point is a little subtle and I'm not completely happy with it, maybe 
I'm going to split this into two select variations - one which includes 
all the dependencies and one which only uses the config symbol to select.

bye, Roman
