Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWEGMGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWEGMGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWEGMGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:06:03 -0400
Received: from khc.piap.pl ([195.187.100.11]:2821 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750931AbWEGMGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:06:01 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	<20060505210614.GB7365@kroah.com>
	<9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	<20060505222738.GA8985@kroah.com>
	<9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	<21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
	<9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com>
	<m3d5er729f.fsf@defiant.localdomain>
	<9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com>
	<m34q036n46.fsf@defiant.localdomain>
	<9e4733910605061124u6b1c4b88nd84faa914c72521f@mail.gmail.com>
	<m33bfm4ud2.fsf@defiant.localdomain>
	<9E6FFBE8-39F0-4C3D-8D6C-B0EC59AD5D22@mac.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 07 May 2006 14:05:59 +0200
In-Reply-To: <9E6FFBE8-39F0-4C3D-8D6C-B0EC59AD5D22@mac.com> (Kyle Moffett's message of "Sun, 7 May 2006 01:56:11 -0400")
Message-ID: <m3mzdum448.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> "device class and/or IDs ... can contain garbage".  That seems to
> violate PCI spec to me.

Well, maybe not exactly garbage but just no useful IDs.

> Jon Smirl gave a great description of exactly how to write such a
> "driver".  I seem to recall that we already have the ability to
> trigger manual PCI binding by bus:slot number; in combination with an
> appropriate "write EEPROM with firmware file" driver that has no
> default list of PCI devices; you could easily manually trigger a bind
> of the device.

Writing EEPROM is not a problem and can be done safely from user space
(mmap /dev/mem). Doing it in the kernel seems like an overkill,
especially if you do the operation once in few years it's much easier
to just download a (statically linked?) binary than messing with
the kernel.

It doesn't even interfere with the "main" driver and can be done while
the device is operating (given that previous EEPROM made sense,
otherwise the driver would not load).

> On the other hand I would personally never put such a
> device in my system, what if the garbage device IDs happened to match
> a device with poorly-written PCI IDE drivers that panic when they
> bind to a device which does not match their expectations?

That isn't possible in this case.

The EEPROM has to be written somehow anyway.

>  In any
> case what you really need for all those cases is a simplistic stub
> driver that provides some sort of in-kernel mutual exclusion.

Right. I.e., "enable" interface with, possibly, locking mechanism,
instead of some per-class "driver".
-- 
Krzysztof Halasa
