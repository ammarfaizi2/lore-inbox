Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280832AbRKYLyj>; Sun, 25 Nov 2001 06:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRKYLya>; Sun, 25 Nov 2001 06:54:30 -0500
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:19670 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280832AbRKYLyP>; Sun, 25 Nov 2001 06:54:15 -0500
Message-ID: <3C00DBE1.7A523308@mandrakesoft.com>
Date: Sun, 25 Nov 2001 06:54:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Network hardware: "Network Media Detection"
In-Reply-To: <E167ja2-0004fF-00@carbon.btinternet.com> <9tpiio$n4u$1@cesium.transmeta.com> <20011125224259.A4844@higherplane.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:
> 
> On Sat, Nov 24, 2001 at 05:47:04PM -0800, H. Peter Anvin wrote:
> > > Hi
> > > I was wondering if there was any way in linux to use what redmond calls
> > > "Network Media Detection"?
> > This is basically taking the interface down when the link disappears
> > (and vice versa.)  Rather useful for portable systems.  Don't think
> > anyone has implemented it, but it should be easy enough to do.
> 
> is there a common field in net_device{} for link state (not just up or
> down, but media type too)?
> 
> all the various ethernet drivers seem to handle link changes rather
> differently.  being able to notify userspace of media changes in a
> not-driver-specific manner would be nice as links flapping from 10 to
> 100Mbps and back often means problems are afoot.
> 
> also i am undecided on _how_ to tell userspace about it...  the current
> hotplug system only seems to handle plug/unplug, whereas this is a
> device state change and as such doesn't really fit the mould...

Functions provided by kernel that net drivers should be using:
netif_carrier_on
netif_carrier_off
netif_carrier_ok

ioctl that should be handled by net drivers, to provide link status to
userspace:
ETHTOOL_GLINK

Long term, we want to send a netlink message when link status changes.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

