Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSFDSas>; Tue, 4 Jun 2002 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSFDSar>; Tue, 4 Jun 2002 14:30:47 -0400
Received: from air-2.osdl.org ([65.201.151.6]:53894 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316187AbSFDSap>;
	Tue, 4 Jun 2002 14:30:45 -0400
Date: Tue, 4 Jun 2002 11:26:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: device model documentation 1/3
In-Reply-To: <Pine.LNX.4.33.0206041040090.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0206041115540.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jun 2002, Patrick Mochel wrote:

> 
> > > 	int	(*bind)		(struct device * dev, struct device_driver * drv);
> > > };
> > > 
> > 
> > Please - Why do you call it bind? Does it have something with
> > netowrking to do? Please just name it attach. This way the old UNIX
> > guys among us won't have to drag a too big
> > "UNIX to Linux translation dictionary" around with them.
> > As an "added bonus" you will stay consistent with -
> > 
> > PCMCIA code base in kernel
> > USB code base in kernel
> > IDE code base (well recently)
> 
> Ok, I can live with that.

Actually, I take that back. attach is the wrong nomenclature as well for 
the action. 'match' would be more correct.

The entry point is the opportunity for the bus to compare a device ID with
a list of IDs that a particular driver supports. It's a 'compare' or
'match' operation. At this point, the driver is not attaching to the
device; it's only checking that's its ok to attach.

So, how about naming it 'match', and changing the 
{driver,device}_{,un}bind() in drivers/base/core.c to 
{driver,device}_{,un}attach() (since those are what is doing the 
attachment)?

The entire process, though, I think is still best described as "Driver 
Binding", as it is a common, modern term for what's happening.

	-pat

