Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUK2Wnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUK2Wnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUK2WlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:41:10 -0500
Received: from colino.net ([213.41.131.56]:38903 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261851AbUK2WgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:36:25 -0500
Date: Mon, 29 Nov 2004 23:34:35 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second
 take)
Message-ID: <20041129233435.4e0d125c@jack.colino.net>
In-Reply-To: <1101767183.15463.17.camel@gaston>
References: <20041126113021.135e79df@pirandello>
	<200411260928.18135.david-b@pacbell.net>
	<20041126183749.1a230af9@jack.colino.net>
	<200411260957.52971.david-b@pacbell.net>
	<1101507130.28047.29.camel@gaston>
	<20041129090406.5fb31933@pirandello>
	<1101767183.15463.17.camel@gaston>
X-Mailer: Sylpheed-Claws 0.9.12cvs176.1 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2004 at 09h11, Benjamin Herrenschmidt wrote:

Hi, 

> Hrm... there is some problem in communication here. I asked you which
> controller out of the 3 OHCIs you have in this machine is the culprit,
> you give me a list of all of them but without PCI IDs ... From the
> archive, I think it was USB bus #4 no ? not sure which of these
> controllers it matches. 
> 
> The iBook G4 has actually 3 "Apple" OHCI's in KeyLargo/Intrepid but
> with 2 of them disabled by the firmware (not wired) plus one NEC USB2
> controller (which contains 1 EHCI and 2 OHCIs) on the PCI bus. The
> code managing their sleep process is very different.

Sorry, i was away and had a problem of /proc/bus/usb being empty. As my
link was on the wireless stick I couldn't reload usb modules. The
culprit is usb 4-1, I think it would be this one (as the stick is bus
004 device 001):

Bus 004 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB              10.01
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            6.02
  iManufacturer           3 Linux 2.6.9 ohci_hcd
  iProduct                2 NEC Corporation USB (#2)
  iSerial                 1 0001:10:1b.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

-- 
Colin
