Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWEHADi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWEHADi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 20:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWEHADi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 20:03:38 -0400
Received: from khc.piap.pl ([195.187.100.11]:31762 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751172AbWEHADi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 20:03:38 -0400
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
	<m3mzdum448.fsf@defiant.localdomain>
	<E4FD2AAC-98AA-42EF-951D-02757C24550C@mac.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 08 May 2006 02:03:34 +0200
In-Reply-To: <E4FD2AAC-98AA-42EF-951D-02757C24550C@mac.com> (Kyle Moffett's message of "Sun, 7 May 2006 15:07:08 -0400")
Message-ID: <m3r735mlgp.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> This is *exactly* what we don't want to do!  The whole point of this
> thread is to prevent the need to use /dev/mem and /dev/kmem for
> anything except debugging.

Look, it's me who's using that and I tell you I want just that :-)

> Ewww, I certainly wouldn't trust a binary statically-linked binary
> program that mmaps /dev/mem or /dev/kmem

And would you trust a binary which doesn't have "/dev/mem" string
in it?

Anyway you can compile it yourself if you want. It's not about trust,
it's about simplicity and robustness.

>    #! /bin/sh
>    cp firmware.bin /lib/firmware/some_firmware_file.bin
>    echo -n eeprom_load_driver >/sys/device/$PCI_ID/bind
>    echo -n 1 >/sys/device/$PCI_ID/unbind
>
> Simple, obviously correct, and uses a nice reuseable driver too!

Sure. If the driver is loaded/available. What if, say, the
distribution you use doesn't have it?

> No!  That would be even worse!  You're then having userspace poke at
> the driver while a kernel driver is loaded, which is *exactly* what X
> is getting into trouble for doing.

So what? The driver and EEPROM updater don't conflict.

>  If you want to add firmware
> update capability, add it to the preexisting primary driver.

It will not load with blank or invalid EEPROM :-)

> No, not an "enable" interface.  In this case the kernel should do
> basically all of the poking at PCI resources for you.

Because?

>  If you
> _really_ want to do that kind of update in userspace, write a stub
> driver which just enables the device on bind, disables it on unbind,
> and mmap and write to the sysfs "rom" file.

It has nothing to do with any "ROM".
-- 
Krzysztof Halasa
