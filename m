Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVJQJ0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVJQJ0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVJQJ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:26:23 -0400
Received: from styx.suse.cz ([82.119.242.94]:50601 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932223AbVJQJ0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:26:23 -0400
Date: Mon, 17 Oct 2005 11:26:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: dtor_core@ameritech.net, Greg KH <gregkh@suse.de>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051017092621.GA10522@ucw.cz>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014084554.GA19445@vrfy.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 10:45:54AM +0200, Kay Sievers wrote:

> Sure, than that physical (while that distinction is silly by itself)
> will just have several child devices. Look at the mouse0 and event0 in
> the ascii drawing.
> 
> That solution would keep a better device separation, sure. But it is
> completely incompatible with everything we ever had in sysfs and
> nobody wants to rewrite _all_ userspace programs.
> 
> It invents artificial subclass names below a "master" class, which is
> absolutely not needed.
> 
> It creates the magic "interfaces" directory, which is confusing, cause
> it classifies devices by itself.
> 
> It doesn't represent any relationship and hierarchy of devices and
> adding a forest of magic symlinks and "device" pointers is a very bad
> design. The proposed "inter-class" symlinks make it even harder to
> understand sysfs as it already is.
> 
> The biggest problem with current sysfs is that the driver hacker has
> to decide if the device is "hardware" or "virtual" which in a lot of
> cases just can't tell and this distiction doesn't make any sense
> today.
> 
> All the more complex subsystems use "virtual buses" and an unconnected
> bunch of class-devices to model its sysfs represention, which is just
> to work around a major design flaw in sysfs!  We really should get
> _one_ device tree with its natural hierarchy, get rid of the stupid
> "device"-link, the PHYSDEVPATH and the unconnected class devices.
> Every device should just carry its dependency tree in it _own_
> devpath!
> 
> I'm very sure, we want a unified tree in /sys/devices, regardless of
> the type of device, to represent the global hierarchy wich is exactly
> what you want to know from a device tree!  That way we stack "virtual"
> _and_ "physical" in a sane manner and at the same time get very clean
> class interfaces. We would stop to mix up "hierarchy" and "classes"
> all over the tree.
 
Let me just say: I completely agree here. The hard distinction between
'real' and 'virtual' devices causes more problems than it solves.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
