Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUDISIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDISIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:08:22 -0400
Received: from mr1.uky.edu ([128.163.2.150]:61358 "EHLO mr1.uky.edu")
	by vger.kernel.org with ESMTP id S261580AbUDISIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:08:19 -0400
Message-ID: <4076E38D.7030102@uky.edu>
Date: Fri, 09 Apr 2004 13:55:25 -0400
From: Steven Walter <srwalt2@uky.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040224)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com
Subject: Re: USB/BlueTooth oops in 2.6.5
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-Router: No infection found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a very similar oops backtrace, but from a different cause.  
Whenever I plug in my Zaurus for the /second/ time (i.e., plug it in, 
let usbnet find it, unplug it, then plug it in again), I get the 
attached oops backtrace.  This did not occur with 2.6.3; unsure about 2.6.4.

Just like in the bluetooth case, usb_disable_interface is causing the 
oops, and is being called by usb_set_interface.  I tried the patch in 
the comments of your linked bug, however that did not fix the problem.

usb0: unregister usbnet usb-0000:00:11.2-1.1, Sharp Zaurus SL-5x00
usb 1-1.1: new full speed USB device using address 7
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
e18c4ef4
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e18c4ef4>]    Not tainted
EFLAGS: 00010286   (2.6.5)
EIP is at usb_disable_interface+0x14/0x50 [usbcore]
eax: de363cc0   ebx: 00000000   ecx: decb6000   edx: dffff0c0
esi: 00000001   edi: 00000000   ebp: de2b5000   esp: decb7d60
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5367, threadinfo=decb6000 task=deb0cd00)
Stack: 00000001 0000000b 00000001 00000001 de73f418 de2b5000 e18c5177 
de2b5000
       de363cc0 0000000b 00000001 00000001 00000001 00000000 00000000 
00001388
       00000000 de363cc0 de73f418 de73f418 de73f2c0 00000001 e19890c1 
de2b5000
Call Trace:
 [<e18c5177>] usb_set_interface+0xb7/0x180 [usbcore]
 [<e19890c1>] get_endpoints+0xb1/0x120 [usbnet]
 [<e198925f>] generic_cdc_bind+0xcf/0x220 [usbnet]
 [<e198ac57>] usbnet_probe+0x3c7/0x400 [usbnet]
 [<c0169d22>] dput+0x22/0x210
 [<e18bf081>] usb_probe_interface+0x61/0x80 [usbcore]
 [<c01f9acf>] bus_match+0x3f/0x70
 [<c01f9b41>] device_attach+0x41/0xa0
 [<c01f9d2b>] bus_add_device+0x5b/0xa0
 [<c01f8bd1>] device_add+0xa1/0x130
 [<e18c5516>] usb_set_configuration+0x1d6/0x270 [usbcore]
 [<e18c00e9>] usb_new_device+0x249/0x3c0 [usbcore]
 [<e18c1a18>] hub_port_connect_change+0x178/0x280 [usbcore]
 [<e18c1dea>] hub_events+0x2ca/0x340 [usbcore]
 [<e18c1e8d>] hub_thread+0x2d/0xf0 [usbcore]
 [<c010725e>] ret_from_fork+0x6/0x14
 [<c011a180>] default_wake_function+0x0/0x20
 [<e18c1e60>] hub_thread+0x0/0xf0 [usbcore]
 [<c0105291>] kernel_thread_helper+0x5/0x14
 
Code: 80 7b 04 00 74 26 31 f6 8d 74 26 00 8b 43 0c 47 0f b6 44 30

-- 
--Steven
"A is A."
	-Ayn Rand
GnuPG Fingerprint: 889A 5BED F01D 61BC 930F  A915 DB55 2585 0010 A205

