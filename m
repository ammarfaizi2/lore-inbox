Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUFGTLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUFGTLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUFGTLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:11:39 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:55693 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265005AbUFGTLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:11:35 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Date: Mon, 7 Jun 2004 21:11:32 +0200
User-Agent: KMail/1.6.2
Cc: "Zephaniah E. Hull" <warp@babylon.d2dc.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>
References: <20040604193911.GA3261@babylon.d2dc.net> <200406070905.41145.baldrick@free.fr> <20040607154310.GA10404@babylon.d2dc.net>
In-Reply-To: <20040607154310.GA10404@babylon.d2dc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406072111.32827.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To give some background, the libusb backend of pilot-link is a slightly
> odd design, we do the init work, reset the device, and then setup a read
> thread, which basicly does a continuous loop of bulk no-timeout reads
> from USB.
> 
> In the primary thread we do most of the work, including doing the USB
> bulk writes to do things like ask the pilot for information.
> 
> Which, once I had things working again, sometimes resulted in the
> following issue:
> 
> lt-pilot-xfer D 00000010     0  3351   3097  3398               (NOTLB)
> ca93dec0 00000082 00000001 00000010 cdaa434c caac11e8 cdaa43ec caac11a0
>        ca93ded4 ce8b4318 c03a2fc0 00000000 3904f0c0 000f42ec cb7fe398 ca913c24
>        00000246 ca93c000 ca93defc c0336735 ca913c2c cb7fe1f0 00000001 cb7fe1f0
> Call Trace:
>  [<c0336735>] __down+0x85/0x120
>  [<c033692f>] __down_failed+0xb/0x14
>  [<c0273245>] .text.lock.devio+0xe5/0x120
>  [<c015a45d>] file_ioctl+0x5d/0x170
>  [<c015a686>] sys_ioctl+0x116/0x250
>  [<c0103f8f>] syscall_call+0x7/0xb
> 
> lt-pilot-xfer D 00000001     0  3398   3351                     (NOTLB)
> ca8ebe1c 00000082 00000000 00000001 0ca97854 ce5bca08 d7d85000 00000001
>        ce5bca08 00000246 ca8ebe2c 00000000 38200f00 000f42ec cb7fe938 ca8ebeac
>        ca8ea000 ca8ea000 ca8ebe70 c0336eb8 00000000 cb7fe790 c01146a0 00000000
> Call Trace:
>  [<c0336eb8>] wait_for_completion+0x78/0xf0
>  [<c026cc0a>] usb_start_wait_urb+0x7a/0xc0
>  [<c0271866>] proc_bulk+0x116/0x220
>  [<c0272f61>] usbdev_ioctl+0x581/0x710
>  [<c015a45d>] file_ioctl+0x5d/0x170
>  [<c015a686>] sys_ioctl+0x116/0x250
>  [<c0103f8f>] syscall_call+0x7/0xb
> 
> With the device not sending us any more data until it receives the
> write, and the write not getting to send until the bulk read finishes or
> the device goes away.
> 
> With the predictable annoyance this causes, of course.

This is my fault.  I will fix it.

Ciao,

Duncan.
