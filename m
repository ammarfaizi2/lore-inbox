Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTFAK7q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 06:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFAK7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 06:59:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57563 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263319AbTFAK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 06:59:44 -0400
Date: Sun, 1 Jun 2003 13:13:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.5 patch] let USB_GADGET depend on USB
Message-ID: <20030601111303.GV29425@fs.tum.de>
References: <20030531221855.GM29425@fs.tum.de> <3ED93D30.4070704@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED93D30.4070704@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 04:39:28PM -0700, David Brownell wrote:
> Adrian Bunk wrote:
> >USB_GADGET is still selectable even with USB disabled. It seems the 
> >following is intended:
> 
> This is wrong.
> 
> CONFIG_USB has always represented the master/host side ... while
> CONFIG_USB_GADGET represents just the slave/gadget side.
> 
> The two are completely independent.  Hardware that supports
> one will typically _not_ support the other.  And systems
> that support the slave/gadget side will have no use at all
> for the 100KB+ of "usbcore".
>...

Well, CONFIG_USB_GADGET without CONFIG_USB gives me the following link 
error in 2.5.70-mm3:

<--  snip  -->

...
  LD      .tmp_vmlinux1
security/built-in.o(.text+0x246d): In function `find_usb_device':
: undefined reference to `usb_bus_list_lock'
security/built-in.o(.text+0x2481): In function `find_usb_device':
: undefined reference to `usb_bus_list_lock'
security/built-in.o(.text+0x248d): In function `find_usb_device':
: undefined reference to `usb_bus_list'
security/built-in.o(.text+0x2493): In function `find_usb_device':
: undefined reference to `usb_bus_list'
security/built-in.o(.text+0x24b3): In function `find_usb_device':
: undefined reference to `usb_bus_list'
security/built-in.o(.text+0x24ba): In function `find_usb_device':
: undefined reference to `usb_bus_list_lock'
security/built-in.o(.text+0x24c0): In function `find_usb_device':
: undefined reference to `usb_bus_list_lock'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


If you disagree with my patch please fix the compilation of 
CONFIG_USB_GADGET without CONFIG_USB.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

