Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWAFMKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWAFMKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWAFMKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:10:25 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:918 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751415AbWAFMKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:10:24 -0500
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: jgarzik@pobox.com, bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601061245.55978.mbuesch@freenet.de>
References: <1136541243.4037.18.camel@localhost>
	 <200601061200.59376.mbuesch@freenet.de>
	 <1136547494.7429.72.camel@localhost>
	 <200601061245.55978.mbuesch@freenet.de>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 13:10:23 +0100
Message-Id: <1136549423.7429.88.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> > > How would the virtual interfaces look like? That is quite easy to answer.
> > > They are net_devices, as they transfer data.
> > > They should probaly _not_ be on top of the ethernet, as 80211 does not
> > > have very much in common with ethernet. Basically they share the same
> > > MAC address format. Does someone have another thing, which he thinks
> > > is shared?
> > > How would the master interface look like? A somewhat unusual idea came
> > > up. Using a device node in /dev. So every wireless card in the system
> > > would have a node in /dev associated (/dev/wlan0 for example).
> > > A node for the master device would be ok, because no data is transferred
> > > through it. It is only a configuration interface.
> > > So you would tell the, yet-to-be-written userspace tool wconfig (or something
> > > like that) "I need a STA in INFRA mode and want to drive it on the
> > > wlan0 card". So wconfig goes and write()s some data to /dev/wlan0
> > > telling the 80211 code to setup a virtual net_device for the driver
> > > associated to /dev/wlan0.
> > > The virtual interface is then configured though /dev/wlan0 using write()
> > > (no ugly ioctl anymore, you see...). Config data like TX rate,
> > > current essid,.... basically everything + xyz which is done by WE today,
> > > is written to /dev/wlan0.
> > > This config data is entirely cached in the 80211 code for the /dev/wlan0
> > > instance. This is important, to have the data persistent throughout
> > > suspend/resume cycles, if up/down cycles.
> > > After configuring, a virtual net_device (let's call it wlan0) exists,
> > > which can be brought up by ifconfig and data can be transferred though
> > > it as usual.
> > 
> > what is wrong with using netlink and/or sysfs for it? I don't see the
> > advantage of defining another /dev something interface.
> 
> Nothing is wrong with that.
> "brainstorming" was the most dominant word in the whole text. ;)

so I might got the wrong impression, because it seemed you put a lot of
thinking into the /dev/wlanX stuff without even considering netlink or
something else.

> I just personally liked the idea of having a device node in /dev for
> every existing hardware wlan card. Like we have device nodes for
> other real hardware, too. It felt like a bit of a "unix way" to do
> this to me. I don't say this is the way to go.
> If a netlink socket is used (which is possible, for sure), we stay with
> the old way of having no device node in /dev for networking devices.
> That is ok. But that is really only an implementation detail (and for sure
> a matter of taste).

At the OLS last year, I think the consensus was to use netlink for all
configuration task. However this was mainly driven by Harald Welte and
he might be able to talk about the pros and cons of netlink versus a
character device.

> The _real_ main point I wanted to make was to _not_ use a net_device for
> the master device. What else should be used for master device, let it
> be a device node or a netlink socket, is rather unimportant at
> this stage.

I am all for it, because I don't like dummy Ethernet devices that are
only used for configuration. I am still not happy that IrDA uses irda0
to get somekind of packet management etc. instead of implementing a real
suitable hardware abstraction.

Regards

Marcel


