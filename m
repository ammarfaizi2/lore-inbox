Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268699AbTCCSYl>; Mon, 3 Mar 2003 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268698AbTCCSYk>; Mon, 3 Mar 2003 13:24:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10001 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268699AbTCCSYj>;
	Mon, 3 Mar 2003 13:24:39 -0500
Date: Mon, 3 Mar 2003 10:25:53 -0800
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
Message-ID: <20030303182553.GG16741@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D680392F82C-100000@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D680392F82C-100000@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:57:05AM -0600, Matt Domsch wrote:
> A lot of PCI drivers today use the pci_device_id table model to specify 
> what IDs the driver supports.  I'd like to be able to do 2 things with 
> this information:
> 1) display it in sysfs

That info is already exported to userspace through the modules.pcimap
file.  It's also available in raw form in the .o file if you want to
export it to any other format that you may want to use.  Why export it
again through sysfs?

> 2) Add new IDs at runtime and have the drivers probe for the new IDs.

Ick, no.  If a driver really wants to have a user provide new ids on the
fly, they usually provide a module paramater to do this.  A number of
the USB drivers do this already (and to be honest, they have caused
nothing but trouble, as users use that option for new devices, that the
driver can't control at all due to protocol or register location
changes.)

In short, it's not a good idea to allow users to change these values on
the fly, the driver author usually knows best here :)

thanks,

greg k-h
