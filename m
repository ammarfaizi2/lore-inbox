Return-Path: <linux-kernel-owner+w=401wt.eu-S1759949AbWLJDR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949AbWLJDR5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 22:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759953AbWLJDR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 22:17:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23316 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759949AbWLJDR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 22:17:56 -0500
Date: Sat, 09 Dec 2006 22:17:55 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] ucb1400_ts depends SND_AC97_BUS
In-reply-to: <200612092205.19358.dtor@insightbb.com>
X-X-Sender: nico@xanadu.home
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0612092212410.2630@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20061209003635.e778ff76.randy.dunlap@oracle.com>
 <200612092150.02940.dtor@insightbb.com>
 <20061209185737.1768315d.randy.dunlap@oracle.com>
 <200612092205.19358.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Dmitry Torokhov wrote:

> On Saturday 09 December 2006 21:57, Randy Dunlap wrote:
> > On Sat, 9 Dec 2006 21:50:01 -0500 Dmitry Torokhov wrote:
> > 
> > > On Saturday 09 December 2006 03:36, Randy Dunlap wrote:
> > > > From: Randy Dunlap <randy.dunlap@oracle.com>
> > > > 
> > > > This driver is an AC97 codec according to its help text.
> > > > However, if SOUND is disabled, the "select SND_AC97_BUS"
> > > > still inserts that into the .config file:
> > > > 
> > > > #
> > > > # Sound
> > > > #
> > > > # CONFIG_SOUND is not set
> > > > CONFIG_SND_AC97_BUS=m
> > > > 
> > > 
> > > I consider this abug in kconfig - users of "select" should not know
> > > full dependency chain for selected symbol.
> > 
> > Seems that I've heard that somewhere else.
> > so I agree with that part.
> > 
> > > > Even if the config software followed dependency chains on selects,
> > > > we should try to limit usage of "select" to library-type
> > > > code that is needed (e.g., CRC functions) instead of bus-type
> > > > support.
> > > >
> > > 
> > > I do not agree here - the way our directory structure is laid out
> > > "sound" comes after "Input device support" menuconfig entry.
> > > Your patch makes user go back and forth in menuconfig, which is
> > > awkward. I think using select is fine when an option depends on
> > > something down the stream. If user already had a chance to select
> > > necessary option then using "depends on" is preferred.
> > 
> > Traversing the menus is not difficult.
> > (It's easier in xconfig or gconfig than menuconfig IMO,
> > but not a big deal in any of them.)
> >
> 
> I agree but many people use menuconfig and may not even be aware of
> a driver if it is hidden because facility it depends on is not
> selected. The same with oldconfig - unless you are closely monitor
> all changelogs (I for example don't, I just pull from Linus) you
> would not even get prompted for UCB1400 if you do not have sound
> enabled.
>  
> > Anyway, are you saying that the only fix for this build error
> > is to fix *config to handle select dependencies?
> > or could propose another way to handle the build error?
> > 
> 
> Would not adding "select SOUND" fix it? We could use it as a bandaid
> until kconfig os fixed.

Please consider what SND_CONFIG_AC97_BUS corresponds to.  It is 
sound/pci/ac97/ac97_bus.c and if you look into this file you'll see that 
it is perfectly buildable even if sound is entirely configured out, just 
like some lib code would be.


Nicolas
