Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422629AbWJNNcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbWJNNcw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 09:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWJNNcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 09:32:51 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:51368 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1422629AbWJNNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 09:32:51 -0400
Date: Sat, 14 Oct 2006 06:32:50 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Michael Krufky <mkrufky@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, v4l-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [v4l-dvb-maintainer] 2.6.19-rc1: DVB frontend selection causes
 compile errors
In-Reply-To: <20061013222311.6d2b6b74.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.58.0610140612360.3003@shell2.speakeasy.net>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <20061009003146.GA3172@stusta.de> <4529FFDC.5080708@linuxtv.org>
 <20061009080542.GE3172@stusta.de> <452A07EE.9020303@linuxtv.org>
 <20061013222311.6d2b6b74.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Randy Dunlap wrote:
> On Mon, 09 Oct 2006 04:27:26 -0400 Michael Krufky wrote:
> > Adrian Bunk wrote:
> > >> +#if defined(CONFIG_DVB_TDA10086) || defined(CONFIG_DVB_TDA10086_MODULE)
> > >
> > > this breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA1004X=m.
> > >
> > > #if defined(CONFIG_DVB_TDA10086) || (defined(CONFIG_DVB_TDA10086_MODULE) && defined(MODULE))

I'd do this ^^^.

> > > might work, but the whole manual frontend selection IMHO looks a bit
> > > fragile.
> > >
> >
> > That's never going to work --  If the card driver is build as y, then the frontend must also be built y...

The frontend must only be built as 'y' if it the card driver (built as 'y')
wants to use it.  There is no reason you couldn't compile a card driver
into the kernel, and set one of the supported front-ends to be a module, so
that a different card driver, compiled as a module, could use it.  For
instance, use 'y' for all built-in hardware and then 'm' for hot-pluggable
USB devices and their front-ends.

> Where is the connection between the card driver and the frontend(s)?
> Is it in card driver source files or frontend source files
> or in Kconfig files?  I looked but didn't see it (in Kconfig).

It's in the card driver source files.  They call (only) a xxxx_attach()
function to get the frontend.  The Kconfig entry for a card driver has
'select' lines for all the front-ends it can use, when DVB_FE_CUSTOMISE is
turned off.  When DVB_FE_CUSTOMISE is on, the user must turn on the
front-ends they want.
