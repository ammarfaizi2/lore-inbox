Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSKNFTV>; Thu, 14 Nov 2002 00:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKNFTU>; Thu, 14 Nov 2002 00:19:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48293 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262602AbSKNFTU>;
	Thu, 14 Nov 2002 00:19:20 -0500
Date: Wed, 13 Nov 2002 21:20:42 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
cc: <linux-kernel@vger.kernel.org>, <duncan_haldane@users.sourceforge.net>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [OOPS] Help needed for usb semaphore lock in 2.4.20-rc1 (since
 2.4.13)
In-Reply-To: <XFMail.20021114000819.f.duncan.m.haldane@worldnet.att.net>
Message-ID: <Pine.LNX.4.33L2.0211132116580.1569-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| Hi,

On Thu, 14 Nov 2002, Duncan Haldane wrote:

| I am the current maintainer of the cpia webcam driver.
|
| I am tracking down a kernel Oops in 2.4.20-rc1 that was first
| introduced in 2.4.13 by usb semaphore locking changes in usb.c,
| and which was reported a while back on this list. See:
|  http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.1/1504.html
| The Ooops occurs when the  system boots  if usb, video4linux ,
| cpia and cpia_usb are compiled into the kernel.
| There is no problem if they are compiled as modules.
|
|
| No changes in the cpia drivers occurred when the Ooops was
| introduced in 2.4.13.  usb_cpia-init() in drivers/media/video/cpia_usb.c
| calls usb_register() in drivers/usb/usb.c to register itself.   \
| usb_register() calls usb_scan_devices().  The Oops occurs when
| the usb list is locked  in usb_scan_devices(), by a call to
| " down (&usb_bus_list_lock);".
| The result is: "Unable to handle kernel NULL pointer dereference at
| virtual address 00000000","Oops: 0002".

It's good to have this info, but do you also have the decoded
Oops (ksymoops output)?  I'd like to see the code sequence etc.,
unless someone else just posts a patch first.  :)

| If I comment out the lock, things work again. (no OOPS, cpa works).
| So the problem is isolated.   Whats the fix?
|
|
| Assuming this is a usb.c problem , I'm out of my depth here.
|
|
| Or should some new entries to initialize something be added to
| the "static struct usb_driver cpia_driver" declaration in cpia_usb.c below?
| Please give me some hints on what to fix if some new initialization
| in cpia_usb.c is needed since the 2.4.13 usb semaphore changes.
|
| Thanks!
|
| Please cc me directly:
|
| duncan_haldane@users.sourceforge.net

Also copying linux-usb-devel@lists.sf.net .

Thanks,
-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

