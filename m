Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVARVti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVARVti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVARVti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:49:38 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:5261 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261437AbVARVtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:49:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sOON6ePx8xXpMSO7/IwUHZjhDpq7ud4mCw0/Yto51c45x/CQNSFfM2Y4A8e1Oldyl4OxPBHm9JF21JeaG3UhT4BgVEE3xkzoUaaWF3Cpr/72rRF8lR8P1Q7q3aO3Dsm0puPaD2dplqB+dZWwOtZa4YsCalqDcW6AfniEN5mmB+M=
Message-ID: <d120d50005011813495b49907c@mail.gmail.com>
Date: Tue, 18 Jan 2005 16:49:34 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
In-Reply-To: <20050118213002.GA17004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED23A3.5020404@suse.de> <20050118213002.GA17004@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 13:30:02 -0800, Greg KH <greg@kroah.com> wrote:
> On Tue, Jan 18, 2005 at 03:56:35PM +0100, Hannes Reinecke wrote:
> > Hi all,
> >
> > the input subsystem is using call_usermodehelper directly, which breaks
> > all sorts of assertions especially when using udev.
> > And it's definitely going to fail once someone is trying to use netlink
> > messages for hotplug event delivery.
> >
> > To remedy this I've implemented a new sysfs class 'input_device' which
> > is a representation of 'struct input_dev'. So each device listed in
> > '/proc/bus/input/devices' gets a class device associated with it.
> > And we'll get proper hotplug events for each input_device which can be
> > handled by udev accordingly.
> 
> Hm, why another input class?  We already have /sys/class/input, which we
> get hotplug events for.  We also have the individual input device
> hotplug events, which is what I think we really want here, right?

These are a bit different classes. One is a generic input device class
device. Then you have several class device interfaces (evdev,
mousedev, joydev, tsdev, keyboard) that together with generic input
device produce concrete input devices (mouse, js, ts) that you have
implemented with class_simple.

At least that's the picture I had in my mind at some point.

-- 
Dmitry
