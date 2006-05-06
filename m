Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWEFSYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWEFSYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWEFSYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:24:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:16119 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751078AbWEFSYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:24:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MbK6O4EDQd5NuiBdr0nuEky9BjWA6V2dZzCTYOydpedOEQ1kO0tWurEoiGOz2YC1ZlVhvW4lMFP1CeyGUW+sDhh8PMT6OKE51kXJG4JuIZFJhgWC4SWx67f8Zyvip6m5cjpj68iuAjt9ZXm0jQ30Bu+SLlknPnS2sfdU4Yl9F4k=
Message-ID: <9e4733910605061124u6b1c4b88nd84faa914c72521f@mail.gmail.com>
Date: Sat, 6 May 2006 14:24:35 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Dave Airlie" <airlied@gmail.com>, "Greg KH" <greg@kroah.com>,
       "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m34q036n46.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Substitute vga with the name of whatever class of device you are
> > working on and build it a minimal driver for it. The technique is
> > generic.
>
> The card in question _has_ a driver. I, for example, just need a way
> to write EEPROM data to it (vendor/device ID etc). The card has to be
> selected by PCI bus and slot (device) number, not by device class
> and/or IDs, because it can contain garbage and/or some generic IDs
> with generic device class.

Hardware like you describe violates the PCI spec and it should not be
expected that Linux will support it in the general case. It sounds
like this is some kind of prototype hardware.

I would probably handle this by writing an unbound device driver that
exposes a sysfs file for bus:slot. When you write the bus:slot to the
file it would then bind to the appropriate hardware and enable it. The
newly bound driver would support the driver firmware loader interface
as a means of getting your data in.

>
> I'm not against the additional driver but it has to be able to work
> with any specified card (as setpci does). But if it's that simple
> then why not do that in the PCI code instead (holding some device
> file open isn't a problem)?
> --
> Krzysztof Halasa
>


--
Jon Smirl
jonsmirl@gmail.com
