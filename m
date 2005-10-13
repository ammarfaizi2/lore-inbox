Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVJMVf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVJMVf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVJMVf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:35:28 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:63190 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964868AbVJMVf2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:35:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ko55QDEwoAL95Htkpxl0VQk1lH1gZl+AqiT3w1DJXGjRhbYRbiondNghAwdjF3SAII6RscMIZD491eKXCYRFjFDN6FyjBEoSugDQ9UGAS/kVWBAsV2Yt0JtfijSPLs0hPxTCtj0IDOFfzKYg2eDNcd45tgzpM26s4CbWKiJFRfY=
Message-ID: <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com>
Date: Thu, 13 Oct 2005 16:35:25 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Cc: Greg KH <gregkh@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <20051013105826.GA11155@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051013020844.GA31732@kroah.com>
	 <20051013105826.GA11155@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
>
> The nesting classes implement a fraction of a device hierarchy in
> /sys/class. It moves arbitrary relation information into the class
> directory, where nothing else than device classification belongs.
> What is the rationale behind sticking device trees into class?
>
> Instead of that, I propose a unification of "/sys/devices-devices"
> and "class-devices". The differentiation of both does not make sense
> in a wold where we can't really tell if a device is hardware or virtual.
>
> We should model _all_ devices with its actual realationship in
> /sys/devices and /sys/class should only be a pinter to the actual
> devices in that place. Device like "mice", which have no parent, would
> sit at the top level of /sys/devices. All devices in /sys/class are
> only symlinks and never devices by itself.
> That way userspace can read all device relation at _one_ place in a sane
> way, and we keep the clean class interface to have easy access to all
> devices of a specific group.
> It gives us the right abstraction and is future proof, cause
> the class interface will not change when the relation between devices
> changes. The destinction between classes and buses would no longer be
> needed, and as we see in the "input" case never made sense anyway.
>
> /sys/class/block would look exactly like /sys/block today. The only
> difference is that there are symlinks to follow instead of class devices
> on its own. With every device creation we will get the whole dependency
> path of the device in the DEVPATH and a "classsification symlink" in
> /sys/class. The input devices are all clearly modeled in its hierarchy,
> in /sys/devices but we also get clean class interfaces:
>

Hi,

Kay eased my task by enumerating all issues I have with Greg's
approach. Not all the world is udev and not all class devices have
"/dev" represetation so haveing one program being able to understand
new sysfs hierarchy is not enough IHMO.

However I do not think that "moving" class devices into /sys/devices
hierarchy is the right solution either because one physical device
could easily end up belonging to several classes. I recenty got an
e-mail from Adam Belay (whom I am pulling into the discussion)
regarding his desire to rearrange net/wireless representation. I think
it would be quite natural to have /sys/class/net/interfaces and
/sys/class/net/wireless /sys/class/net/irda, and /sys/class/net/wired
subclasses where "interfaces" would enumerate _all_ network interfaces
in the system, and the rest would show only devices of their class.

--
Dmitry
