Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUEEHIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUEEHIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 03:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUEEHIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 03:08:21 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:54971 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263435AbUEEHIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 03:08:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Wed, 5 May 2004 02:08:11 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       vojtech@suse.cz
References: <200404230142.46792.dtor_core@ameritech.net> <200404251648.07232.dtor_core@ameritech.net> <20040504210414.GC27037@kroah.com>
In-Reply-To: <20040504210414.GC27037@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405050208.11348.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 May 2004 04:04 pm, Greg KH wrote:
> On Sun, Apr 25, 2004 at 04:48:07PM -0500, Dmitry Torokhov wrote:
> >  
> > No, I am still getting the oops.. hmm.. it seems a little bit different,
> > but still in the hiddev. I investigated further and the oops only happens
> > if I yank a HID device connected to an USB hub or if I yank entire hub with
> > a HID device connected to it. Tried with APC UPS and MS Intellimouse
> > Explorer. If they are connected directly to the laptop's ports everything is
> > fine, also other devices (USB printer for example) handle hub disconnection
> > just fine. It does not matter if I have device open or closed for oops to
> > happen. And, for the record, oops itself:
> 
> Are you still getting this in the 2.6.6-rc3 kernel?
> 
> How about the latest -mm release?
> 

With tonight's bk pull + USB patch from 2.6.6-rc3-mm1 I am still getting the
following oops when pulling a HID device out of a hub:

usb 1-1: USB disconnect, address 2
usb 1-2: USB disconnect, address 3
usb 1-2.3: USB disconnect, address 4
Unable to handle kernel paging request at virtual address e19f6140
 printing eip:
e19f1037
*pde = 1fe1e067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<e19f1037>]    Not tainted
EFLAGS: 00010246   (2.6.6-rc3) 
EIP is at hiddev_cleanup+0x17/0x50 [usbhid]
eax: 00000060   ebx: d8de4f9c   ecx: 00000000   edx: d7d6cb10
esi: e19f5ba0   edi: df905400   ebp: df69be54   esp: df69be48
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 532, threadinfo=df69a000 task=dfa35730)
Stack: df69be54 e185db5f d8c30000 df69be68 e19f0ac8 d8de4f9c e19f5ba0 dfd718b4 
       df69be84 e1858106 dfd718b4 dfd718b4 d7e64660 dfd718c4 e19f5bc0 df69be9c 
       c0210a66 dfd718c4 dfd718ec dfd718c4 df9054cc df69beb4 c0210ba3 dfd718c4 
Call Trace:
 [<e185db5f>] usb_unlink_urb+0x3f/0x50 [usbcore]
 [<e19f0ac8>] hid_disconnect+0xb8/0xe0 [usbhid]
 [<e1858106>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c0210a66>] device_release_driver+0x66/0x70
 [<c0210ba3>] bus_remove_device+0x53/0xa0
 [<c020fa7d>] device_del+0x5d/0xa0
 [<c020fad4>] device_unregister+0x14/0x30
 [<e185e9df>] usb_disable_device+0x6f/0xc0 [usbcore]
 [<e1858d16>] usb_disconnect+0xa6/0x100 [usbcore]
 [<e1858d58>] usb_disconnect+0xe8/0x100 [usbcore]
 [<e185b3e7>] hub_port_connect_change+0x2a7/0x2e0 [usbcore]
 [<e185b763>] hub_events+0x343/0x3b0 [usbcore]
 [<e185b805>] hub_thread+0x35/0xf0 [usbcore]
 [<c0115ef0>] default_wake_function+0x0/0x20
 [<e185b7d0>] hub_thread+0x0/0xf0 [usbcore]
 [<c01032e5>] kernel_thread_helper+0x5/0x10

Code: 89 0c 85 c0 5f 9f e1 c7 44 24 04 9c 5c 9f e1 8b 43 10 8b 80 


If HID device connected directly to laptop's USB port I can yank it without
any trouble.

-- 
Dmitry
