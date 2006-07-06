Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWGFCml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGFCml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWGFCml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:42:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751053AbWGFCmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:42:39 -0400
Date: Wed, 5 Jul 2006 19:42:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: petkan@users.sourceforge.net, linux-kernel@vger.kernel.org,
       david-b@pacbell.net, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Message-Id: <20060705194229.8ffe85d9.akpm@osdl.org>
In-Reply-To: <a44ae5cd0607051934o2656a40bs88393dc0d6591249@mail.gmail.com>
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
	<20060703014016.9f598cef.akpm@osdl.org>
	<a44ae5cd0607030704q63f1f64x5e46688cef6fa44c@mail.gmail.com>
	<20060703121717.b36ef57e.akpm@osdl.org>
	<a44ae5cd0607051144w5734ce4bkd38320adda99ae43@mail.gmail.com>
	<a44ae5cd0607051934o2656a40bs88393dc0d6591249@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 19:34:52 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> On 7/5/06, Miles Lane <miles.lane@gmail.com> wrote:
> > Hi Petko,
> >
> > David Brownell pointed out that you are the author of this driver (rtl8150).
> > My laptop is crashing every time I remove the Linksys EtherFast 10/100
> > Compact Network Adapter (model USB100M) from the USB port.
> >
> > Here's a link to the discussion thus far:
> > http://groups.google.com/group/linux.kernel/tree/browse_frm/thread/8c93e310c7b71242/a8a1e3edb1601906?rnum=1&q=miles+lane&_done=%2Fgroup%2Flinux.kernel%2Fbrowse_frm%2Fthread%2F8c93e310c7b71242%2Fc8a8ba47c49c39fc%3Ftvc%3D1%26q%3Dmiles+lane%26#doc_a8a1e3edb1601906
> >
> > Here's the stacktrace:
> > http://www.zip.com.au/~akpm/linux/patches/stuff/00003.jpg
> >
> > I have reproduced the bug with vanilla 2.6.17.  I am currently working my
> > back through kernel versions to try to isolate the responsible patches.
> 
> 2.6.15 is the first kernel earliest kernel that seems to work with Ubuntu 6.06's
> implementation of hal / udev / dbus.  It does set up the adapter successfully.
> 
> I was able to reproduce the crash with 2.6.15.  I have attached a screenshot
> of the stacktrace.  It may help, since it differs quite a bit from the one for
> 2.6.17-mm5.

The attachment will be too large to make it onto most mailing lists.  I put
a copy here: http://www.zip.com.au/~akpm/linux/patches/stuff/00005.jpg

> BTW, should I join linux-usb-devel and CC that list?  Also, should I take
> this discussion off of LKML?

Nah, spread it around.  Who knows, somoene might actually fix the bug ;)

(cc added)

(Summary: oops in tasklet_action after hot-unplugging a usbnet-driven adapter)

> Here's the detection of the RTL8150:
> 
> usb 1-2: new full speed USB device using uhci_hcd and address 3
> usb 1-2: ep0 maxpacket = 8
> usb 1-2: default language 0x0409
> usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-2: Product: Linksys USB LAN Adapter
> usb 1-2: Manufacturer: Linksys
> usb 1-2: SerialNumber: 5322
> usb 1-2: hotplug
> usb 1-2: adding 1-2:1.0 (config #1, interface 0)
> usb 1-2:1.0: hotplug
> hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0004
> eth1: RealTek RTL8139 at 0xf9060800, 00:c0:9f:95:18:1b, IRQ 10
> eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
> 
> Bus 002 Device 002: ID 0bda:8150 Realtek Semiconductor Corp. RTL8150
> Fast Ethernet Adapter
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0bda Realtek Semiconductor Corp.
>   idProduct          0x8150 RTL8150 Fast Ethernet Adapter
>   bcdDevice            1.00
>   iManufacturer           1 Linksys
>   iProduct                2 Linksys USB LAN Adapter
>   iSerial                 3 5322
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           39
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower              120mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0
>       bInterfaceProtocol    255
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval               1
> Device Status:     0x0000
>   (Bus Powered)
> 
