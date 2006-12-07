Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031924AbWLGJvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031924AbWLGJvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031926AbWLGJvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:51:10 -0500
Received: from foo.birdnet.se ([213.88.146.6]:38620 "EHLO foo.birdnet.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031924AbWLGJvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:51:07 -0500
Message-ID: <20061207095116.27665.qmail@cdy.org>
Date: Thu, 7 Dec 2006 10:51:16 +0100
From: Peter Stuge <stuge-linuxbios@cdy.org>
To: linuxbios@linuxbios.org
Cc: Andi Kleen <ak@suse.de>, linux-usb-devel@lists.sourceforge.net,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       David Brownell <david-b@pacbell.net>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Mail-Followup-To: linuxbios@linuxbios.org, Andi Kleen <ak@suse.de>,
	linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
References: <5986589C150B2F49A46483AC44C7BCA4907291@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907291@ssvlexmb2.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 01:08:14PM -0800, Lu, Yinghai wrote:
> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Wednesday, December 06, 2006 12:59 PM
> 
> >I haven't looked how the other usb_debug works -- if it's polled
> >too then it wouldn't have much advantage.
> 
> Need to verify if the two sides of debug cable are identical. 

I got my device yesterday and after a small plugfest I can confirm
that only one end of the device enumerates when connected to an ICH7
EHCI driven by 2.6.19.

--8<--
Bus 001 Device 027: ID 0525:127a Netchip Technology, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0525 Netchip Technology, Inc.
  idProduct          0x127a 
  bcdDevice            1.01
  iManufacturer           1 NetChip
  iProduct                2 NetChip TurboCONNECT 2.0
  iSerial                 3 1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
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
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Debug descriptor:
  bLength                 4
  bDescriptorType        10
  bDebugInEndpoint     0x82
  bDebugOutEndpoint    0x01
-->8--

The device is in fact not self-powered.

My theory is that the same set of descriptors are used for both ends,
but one end has been locked to address 127 in order to work with
simpler debug port drivers that assume it will be there.

I guess that the self-powered error is also to simplify life for
debug port drivers. IIRC most if not all USB power management
concerns are noops for debug ports.


//Peter
