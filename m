Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290805AbSBFUyv>; Wed, 6 Feb 2002 15:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290806AbSBFUym>; Wed, 6 Feb 2002 15:54:42 -0500
Received: from air-2.osdl.org ([65.201.151.6]:65454 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290805AbSBFUye>;
	Wed, 6 Feb 2002 15:54:34 -0500
Date: Wed, 6 Feb 2002 12:54:45 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <Pine.LNX.4.44.0202060921380.8308-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0202061253020.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Feb 2002, Zwane Mwaikambo wrote:

> On Tue, 5 Feb 2002, Pavel Machek wrote:
> 
> > +static void __init init_8259A_devicefs(void)
> > +{
> > +	device_register(&device_i8259A);
> > +	strcpy(device_i8259A.name, "i8259A");
> > +	strcpy(device_i8259A.bus_id, "0020");
> > +	device_i8259A.parent = &sys_iobus;
> 
> I'm not entirely familiar with the driverfs API but wouldn't an API 
> function to do all that strcpy and other init assignments be a bit 
> cleaner? I see lots of retyping going on otherwise, someone feel free to 
> hit me with a clue bat if i'm missing something...

Actually, that's something I didn't notice with the patch: you need a 
non-NULL bus_id inorder to register the device.

Something like this for singular devices would work better:

static struct device device_i8259A = {
	name:		"i8259A",
	bus_id:		"0020",
};

Though, where does that bus_id come from?

	-pat

