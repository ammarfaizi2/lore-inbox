Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290779AbSBGWyk>; Thu, 7 Feb 2002 17:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSBGWyX>; Thu, 7 Feb 2002 17:54:23 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:42511 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S287552AbSBGWyG>;
	Thu, 7 Feb 2002 17:54:06 -0500
Date: Thu, 7 Feb 2002 21:21:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020207202059.GD174@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0202060921380.8308-100000@netfinity.realnet.co.sz> <Pine.LNX.4.33.0202061253020.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202061253020.25114-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +static void __init init_8259A_devicefs(void)
> > > +{
> > > +	device_register(&device_i8259A);
> > > +	strcpy(device_i8259A.name, "i8259A");
> > > +	strcpy(device_i8259A.bus_id, "0020");
> > > +	device_i8259A.parent = &sys_iobus;
> > 
> > I'm not entirely familiar with the driverfs API but wouldn't an API 
> > function to do all that strcpy and other init assignments be a bit 
> > cleaner? I see lots of retyping going on otherwise, someone feel free to 
> > hit me with a clue bat if i'm missing something...
> 
> Actually, that's something I didn't notice with the patch: you need a 
> non-NULL bus_id inorder to register the device.
> 
> Something like this for singular devices would work better:
> 
> static struct device device_i8259A = {
> 	name:		"i8259A",
> 	bus_id:		"0020",
> };
> 
> Though, where does that bus_id come from?

It is address on (what used to be) ISA bus. I'm selecting lowest when
I have a choice.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
