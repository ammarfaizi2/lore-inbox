Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVARV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVARV6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVARV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:58:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:53679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261441AbVARV6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:58:38 -0500
Date: Tue, 18 Jan 2005 13:58:20 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
Message-ID: <20050118215820.GA17371@kroah.com>
References: <41ED23A3.5020404@suse.de> <20050118213002.GA17004@kroah.com> <d120d50005011813495b49907c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005011813495b49907c@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 04:49:34PM -0500, Dmitry Torokhov wrote:
> On Tue, 18 Jan 2005 13:30:02 -0800, Greg KH <greg@kroah.com> wrote:
> > On Tue, Jan 18, 2005 at 03:56:35PM +0100, Hannes Reinecke wrote:
> > > Hi all,
> > >
> > > the input subsystem is using call_usermodehelper directly, which breaks
> > > all sorts of assertions especially when using udev.
> > > And it's definitely going to fail once someone is trying to use netlink
> > > messages for hotplug event delivery.
> > >
> > > To remedy this I've implemented a new sysfs class 'input_device' which
> > > is a representation of 'struct input_dev'. So each device listed in
> > > '/proc/bus/input/devices' gets a class device associated with it.
> > > And we'll get proper hotplug events for each input_device which can be
> > > handled by udev accordingly.
> > 
> > Hm, why another input class?  We already have /sys/class/input, which we
> > get hotplug events for.  We also have the individual input device
> > hotplug events, which is what I think we really want here, right?
> 
> These are a bit different classes. One is a generic input device class
> device. Then you have several class device interfaces (evdev,
> mousedev, joydev, tsdev, keyboard) that together with generic input
> device produce concrete input devices (mouse, js, ts) that you have
> implemented with class_simple.

Hm, but we still need to make the input_dev a "real" struct device,
right?  And if you do that, then you just hooked up your hotplug event
properly, with no userspace breakage.

Then, if you want to still make the evdev, mousedev, and so on as
class_device interfaces, that's fine, but the main point of this patch
was to allow the call_usermodehelper call to be removed, so that the
input subsytem will work properly with the kernel event and hotplug
systems.

thanks,

greg k-h
