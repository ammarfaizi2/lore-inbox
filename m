Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWBTSog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWBTSog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBTSog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:44:36 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:43535 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932237AbWBTSof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:44:35 -0500
Date: Mon, 20 Feb 2006 19:44:19 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060220184419.GF33155@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200602131116.41964.david-b@pacbell.net> <200602181251.09865.david-b@pacbell.net> <43F80ACC.20704@cfl.rr.com> <200602192150.05567.david-b@pacbell.net> <43F9E95A.6080103@cfl.rr.com> <20060220165153.GA33155@dspnet.fr.eu.org> <43FA0867.5060001@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA0867.5060001@cfl.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:20:23PM -0500, Phillip Susi wrote:
> I'm not all that familiar with USB, but I'd imagine it is somewhat like 
> I2C/SMBUS: each device has a descriptor block that contains information 
> about itself.  This is going to be unique for any given device.

That one of the problems, there are no reliable serial numbers or
things of the kind.  It all becomes heuristics (model name, capacity,
partitioning, actual contents...) which kinda suck to have in kernel
space.


> The host controller begins by querying the broadcast address, and
> all unconfigured devices respond.

If I understand USB correctly, it's all point-to-point, there is no
broadcast going on.  For enumeration purposes hubs are not
transparent, and ports are separated.  But I wouldn't rely on the
ports numbers on hubs to stay constant w.r.t the physical ports.  I
don't think it's required.


> Because of this, given the same hardware on the bus, the same 
> enumeration will happen every time, and the host can assign whatever 
> address it wants to each device should it choose to do so rather than 
> just assign them in ascending order.

Since it's an hotplug bus, enumeration before suspend happened as the
devices were plugged in.  So the order a reboot enumeration will see
them is unknown in practice.

It may be fixable by storing some kind of physical address in the
tree, but losing a filesystem because you replugged the usb drive in
the wrong physical port between suspend and resume would be annoying.
And I don't know how stable the "physical" positions are in the first
place.

  OG.

