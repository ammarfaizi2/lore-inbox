Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264792AbUD1ORQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbUD1ORQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbUD1OPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:15:40 -0400
Received: from [80.72.36.106] ([80.72.36.106]:40845 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264802AbUD1OOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:14:32 -0400
Date: Wed, 28 Apr 2004 16:14:24 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB related oops in 2.6.6-rk2-bk3 (similar with 2.6.5)
In-Reply-To: <c6o9vn$4rr$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.58.0404281610010.11167@alpha.polcom.net>
References: <Pine.LNX.4.58.0403272228360.2662@alpha.polcom.net>
 <Pine.LNX.4.58.0404270115260.5772@alpha.polcom.net> <c6o9vn$4rr$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Bill Davidsen wrote:

> Grzegorz Kulewski wrote:
> > Hi,
> > 
> > I experienced this oops. I have uhci-hcd and two devices. One is usb 
> > camera (TC111 - probably not supported under linux?) and the 
> > second is speedtouch modem. Everytime I shut down my system (Gentoo) with 
> > 2.6.5 and newer I get some oops but system log is down before that and I 
> > have no time to hack start scripts to stop shuting syslog. It occures when  
> > removing some usb modules. So I stopped speedtouch and removed the modules 
> > manually (in stop scripts order I hope). But I have not removed uhci-hcd 
> > module (this module is removed in other part of stop scripts). And... 
> > nothing happened. So I unplugged speedtouch and replugged it back. And I 
> > immendiatelly got atached oops. (I think that I should use ksymoops, but 
> > it is searching for /proc/ksyms that is not present in 2.6 and it does not 
> > like /proc/kallsyms... And it produces nothing but warnings. What options 
> > should I use?)
> > 
> > What can I do to help track the problem down?
> 
> Does it happen without preempt?

Yes, it does. Here is the log:

Apr 28 16:10:50 polb01 usb 1-1: USB disconnect, address 2
Apr 28 16:10:50 polb01 Unable to handle kernel paging request at virtual 
address ddc03f64
Apr 28 16:10:50 polb01 printing eip:
Apr 28 16:10:50 polb01 e0943d73
Apr 28 16:10:50 polb01 *pde = 00077067
Apr 28 16:10:50 polb01 *pte = 1dc03000
Apr 28 16:10:50 polb01 Oops: 0002 [#1]
Apr 28 16:10:50 polb01 DEBUG_PAGEALLOC
Apr 28 16:10:50 polb01 CPU:    0
Apr 28 16:10:50 polb01 EIP:    0060:[<e0943d73>]    Not tainted
Apr 28 16:10:50 polb01 EFLAGS: 00010282   (2.6.6-rc2-bk3)
Apr 28 16:10:50 polb01 EIP is at driver_disconnect+0x13/0x40 [usbcore]
Apr 28 16:10:50 polb01 eax: db346ef8   ebx: db346ef8   ecx: db346f08   
edx: ddc03f38
Apr 28 16:10:50 polb01 esi: e0954be0   edi: db346f08   ebp: dabdfe7c   
esp: dabdfe74
Apr 28 16:10:50 polb01 ds: 007b   es: 007b   ss: 0068
Apr 28 16:10:50 polb01 Process khubd (pid: 5338, threadinfo=dabde000 
task=dee39a10)
Apr 28 16:10:50 polb01 Stack: e0954be0 db346f08 dabdfe98 e09380f6 db346ef8 
db346ef8 db346f08 db346f08
Apr 28 16:10:50 polb01 e0954c00 dabdfeb0 c030e0c6 db346f08 db346f30 
e09544e0 e095452c dabdfecc
Apr 28 16:10:50 polb01 c030e23d db346f08 00000042 db346f08 c03f3488 
dbebfcdc dabdfee8 c030d0be
Apr 28 16:10:50 polb01 Call Trace:
Apr 28 16:10:50 polb01 [<e09380f6>] usb_unbind_interface+0x76/0x80 
[usbcore]
Apr 28 16:10:50 polb01 [<c030e0c6>] device_release_driver+0x66/0x70
Apr 28 16:10:50 polb01 [<c030e23d>] bus_remove_device+0x6d/0xb0
Apr 28 16:10:50 polb01 [<c030d0be>] device_del+0x6e/0xb0
Apr 28 16:10:50 polb01 [<c030d114>] device_unregister+0x14/0x20
Apr 28 16:10:50 polb01 [<e09401d1>] usb_disable_device+0x71/0xb0 [usbcore]
Apr 28 16:10:50 polb01 [<e0938d26>] usb_disconnect+0xc6/0x120 [usbcore]
Apr 28 16:10:50 polb01 [<e093b77f>] hub_port_connect_change+0x28f/0x2a0 
[usbcore]
Apr 28 16:10:50 polb01 [<e093b141>] hub_port_status+0x41/0xb0 [usbcore]
Apr 28 16:10:50 polb01 [<e093baee>] hub_events+0x35e/0x4d0 [usbcore]
Apr 28 16:10:50 polb01 [<e093bc95>] hub_thread+0x35/0x100 [usbcore]
Apr 28 16:10:50 polb01 [<c0118cd0>] default_wake_function+0x0/0x20
Apr 28 16:10:50 polb01 [<e093bc60>] hub_thread+0x0/0x100 [usbcore]
Apr 28 16:10:50 polb01 [<c01022b1>] kernel_thread_helper+0x5/0x14
Apr 28 16:10:50 polb01
Apr 28 16:10:50 polb01 Code: c7 42 2c 00 00 00 00 8b 40 04 0f b6 40 02 0f 
b3 82 88 00 00

In my first post there was some warning that spinlock was not initialized. 
Isn't this the source of problem?


Grzegorz Kulewski

