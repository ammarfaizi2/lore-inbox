Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTKQSRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTKQSRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:17:24 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:58121 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263607AbTKQSRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:17:22 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>, rusty@rustcorp.com.au
Subject: Re: file2alias - incorrect? aliases for USB
Date: Mon, 17 Nov 2003 21:11:28 +0300
User-Agent: KMail/1.5.3
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200311092155.19924.arvidjaar@mail.ru> <20031110093703.GA5449@kroah.com>
In-Reply-To: <20031110093703.GA5449@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311172111.30795.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 12:37, Greg KH wrote:
> On Sun, Nov 09, 2003 at 09:55:19PM +0300, Andrey Borzenkov wrote:
> > file2aliases puts in alias device ID high and low numbers directly from
> > match specifications. E.g. for this match table entry:
> >
> > usb-storage          0x000f      0x04e6   0x0006    0x0100       0x0205
> > ...
> >
> > it generates alias
> >
> > alias usb:v04E6p0006dl0100dh0205dc*dsc*dp*ic*isc*ip* usb_storage
> >
[...]
>
> I would suggest just ignoring the bcdDevice value, and loading all
> modules that match the idVendor and idProduct values, and let the kernel
> sort it out :)
>

the obvious point that this leaves unneeded modules in kernel aside ...

that won't work that easy. You have to build name to match line from 
modules.alias. But to match you have to put exact values for `dl' and `dh'. 
Those values are simply not available when hotplug agent is called.

i.e. for the above line to match you have to supply exact values for vendor, 
product, device low, device high. Any other values are not important but 
these must be exact. But neither device low nor device high are known.

apparently the only way is to remove them and hope that usually the same 
vendor/product combination is handled by single driver.

> So for your example, you would just:
> 	modprobe usb:v04E6p0006dl*dh*dc*dsc*dp*ic*isc*ip*
>

that won't match, sorry. wildcards can be in aliases; they can't be in module 
names.

-andrey

