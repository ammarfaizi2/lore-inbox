Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWEHF1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWEHF1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEHF1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:27:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:55676 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932311AbWEHF1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:27:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0EzuFE215mga0DXbHEuIXCIsDg0cpNxmcUvlsfMOmYBkK/09kzWlmXeJzszHuD/kSSrK0n97S4jtOWJTL9j1J+VAG444vJulseXoWd0k/+t6tcnX7FU5jKlgs7nJRg7UKy6cmCPJl4B1OgQFksejx950p6ICh7eBTCJ4VQAE9Q=
Message-ID: <9e4733910605072227v5ade4afcp2cce663e77637f7d@mail.gmail.com>
Date: Mon, 8 May 2006 01:27:32 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@linux.ie>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Greg KH" <greg@kroah.com>, "Ian Romanick" <idr@us.ibm.com>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605080503001.6291@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <445BA584.40309@us.ibm.com>
	 <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	 <20060505202603.GB6413@kroah.com>
	 <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	 <20060505210614.GB7365@kroah.com>
	 <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	 <20060505222738.GA8985@kroah.com>
	 <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	 <Pine.LNX.4.64.0605080503001.6291@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/06, Dave Airlie <airlied@linux.ie> wrote:
> >
> > So as a result of this every interrupt service routine should now
> > include pci_enable(). If you don't include this and someone from user
> > space disables the hardware you're going to GPF. fbdev is already
> > forced to take defensive measures like this since X will randomly
> > disable it's hardware while it has an ISR active.
>
> Jon please stop spouting crap at least, every ISR doesn't need pci_enable,
> as it doesn't need it now, you are NOT listening, adding the enable bit
> DOES NOT change things, if someone runs setpci from userspace now they can
> do this, ROOT CAN CRASH YOUR MACHINE, FILM AT 11.

Do what you want, this has gone on too long. There are simple schemes
that can fix these holes but nobody seems to want to use them.  Just
because something was broken in the past doesn't justify a new API to
continue supporting the breakage in the future. I am amazed at the
amount energy being expended to support this flawed API when
alternatives are available.

> If you enable the rom at the moment you can crash things, some devices
> don't have enough address decoders to decode a bar and the ROM, so me
> enabling ROM decoding as your original patch did, can cause system
> lockups,
>
> why is this different, why didn't you write the ROM code patch properly
> then and we woulnd't have to to hear about it now...

This is a known part of the PCI spec, it is not a bug. There is a ROM
API that the driver for the offending hardware should call to disable
(or copy) the ROM attribute.  If the driver is missing the ROM disable
call that is a bug. I don't know what hardware has the address decoder
problem so I can't fix the drivers. This is documented in the header
file and has been posted to LKML. This hardware is uncommon, but If
you do identify hardware that is missing the address decoder please
inform me and the driver maintainer and we will add a call to disable
the ROM attribute.

As far as I know only a single person has hit this and they didn't
tell me the PCI ID of the problem hardware. I suspect the problem
hardware is an older Adaptec RAID controller.

--
Jon Smirl
jonsmirl@gmail.com
