Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318713AbSH1FKT>; Wed, 28 Aug 2002 01:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSH1FKS>; Wed, 28 Aug 2002 01:10:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:41996 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318713AbSH1FKS>;
	Wed, 28 Aug 2002 01:10:18 -0400
Date: Tue, 27 Aug 2002 22:14:06 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 port PnP BIOS to the driver model RESEND #1
Message-ID: <20020828051406.GA26263@kroah.com>
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com> <3D6BF1E6.9010701@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6BF1E6.9010701@netscape.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:40:54PM +0000, Adam Belay wrote:
> As we discussed earlier, I converted the PnP BIOS driver to the driver 
> model  Please advice on any changes you would like.  I look forward to 
> hearing from you.

Hi,

I don't have a box with a PnP BIOS (well, I don't think I do...), so
could you send the relevant portions of the driverfs tree, showing the
new devices that you add for this bus?

Also a few minor comments on the patch:
	- pnpbios_bus_type should probably be made static, along with
	  alloc_pnpbios_root().
	- You don't check for out of memory in alloc_pnpbios_root() when
	  you call kmalloc().
	- why are you modifying the set_limit() parameters at the top of
	  your patch?  That doesn't seem relevant to the driverfs
	  changes.
	- in pnpbios_bus_match(), don't you have to check the value of
	  the call to match_device() to make sure you have a match?
	  That would keep pnpbios_device_probe() from being called for
	  every device like it looks your patch causes.
	- the pnpbios_device_probe() call should return a negative error
	  number if the device does not match, or some error happens.
	  Returning 1 does not mean success.  You also need to save off
	  the device specific info somehow in your structure, so that
	  the pnpbios_device_remove() can remove it.  Or am I just
	  missing something here?

And is there some way you can inline the patch?  It wasn't that big...

thanks,

greg k-h
