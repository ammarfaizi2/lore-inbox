Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTHZDn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbTHZDn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:43:26 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:30165 "EHLO
	mwinf0202.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262529AbTHZDnU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:43:20 -0400
From: jjluza <jjluza@yahoo.fr> (by way of jjluza <jjluza@yahoo.fr>)
Subject: Re: Problem with 2.6-testXX and alcatel speedtouch usb modem
Date: Tue, 26 Aug 2003 05:43:16 +0200
User-Agent: KMail/1.5.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308260543.16739.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 25 Août 2003 11:31, vous avez écrit :
> On Wednesday 20 August 2003 02:03, jjluza wrote:
> > I try to make this modem working.
> > It works very well on kernel 2.4 series.
> > It work with some kernel 2.6 until test2-mm1.
> > But since test2-mm1, the newer kernel doesn't work anymore.
> > There is 2 related drivers for this modem.
> > The one which is included in the kernel and which can be found here :
> > http://www.linux-usb.org/SpeedTouch/
> > and the one which I've always used until now :
> > speedtouch.sourceforge.net
> >
> > when I notice that the old one doesn't work anymore, I try with the
> > driver which included in the kernel, without success.
>
> Did you follow the instructions on http://www.linux-usb.org/SpeedTouch/ ?
>
> > It crashed when I do "pppd call adsl".
>
> From what I see below you are still using the userspace driver (pppoa3),
> which is being called by pppd.  This won't work when you have the kernel
> module loaded.  You need to use a pppoa aware pppd and not call pppd.
>
> > I can load the firmware.
> >
> > And here is messages in syslog :
> > Aug 19 22:00:26 serveur modem_run[337]: modem_run version 1.1 started by
> > root uid 0
> > Aug 19 22:00:28 serveur kernel: usb 1-2: bulk timeout on ep5in
> > Aug 19 22:00:28 serveur kernel: usbfs: USBDEVFS_BULK failed dev 2 ep 0x85
> > len 512 ret -110
> > Aug 19 22:00:43 serveur modem_run[337]: ADSL synchronization has been
> > obtained Aug 19 22:00:43 serveur modem_run[337]: ADSL line is up (608
> > kbit/s down | 160 kbit/s up)
> > Aug 19 22:00:43 serveur modprobe: FATAL: Module ipv6 not found.
> > Aug 19 22:00:43 serveur pppd[345]: pppd 2.4.1 started by root, uid 0
> > Aug 19 22:00:43 serveur pppd[345]: Using interface ppp0
> > Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
> > Aug 19 22:00:44 serveur kernel: ip_conntrack version 2.1 (768 buckets,
> > 6144 max) - 300 bytes per conntrack
> > Aug 19 22:00:44 serveur pppoa3[346]: PPPoA3 version 1.1 started by root
> > (uid 0)
> > Aug 19 22:00:44 serveur pppoa3[346]: Control thread ready
> > Aug 19 22:00:44 serveur pppoa3[352]: ppp(d) --> pppoa3 --> modem  stream
> > ready Aug 19 22:00:44 serveur pppoa3[353]: modem  --> pppoa3 --> ppp(d)
> > stream ready Aug 19 22:00:44 serveur pppoa3[353]: Error reading usb urb
> > Aug 19 22:00:44 serveur pppoa3[346]: Woken by a sem_post event -> Exiting
> > Aug 19 22:00:44 serveur pppoa3[346]: Read from ppp Canceled
> > Aug 19 22:00:44 serveur pppoa3[346]: Write to ppp Canceled
> > Aug 19 22:00:44 serveur pppoa3[346]: Exiting
> > Aug 19 22:00:44 serveur pppd[345]: Modem hangup
> > Aug 19 22:00:44 serveur pppd[345]: Connection terminated.
> > Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
> > Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a
> > release() function, it is broken and must
> > be fixed.
> > Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at
> > drivers/base/class.c:201
> > Aug 19 22:00:44 serveur kernel: Call Trace:
> > Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64]
> > kobject_cleanup+0x36/0x40
> > Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464]
> > netdev_run_todo+0x10b/0x1d0
> > Aug 19 22:00:44 serveur kernel:  [_end+114517535/1070384712]
> > ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
> > Aug 19 22:00:44 serveur kernel:  [_end+114504362/1070384712]
> > ppp_ioctl+0x802/0x820 [ppp_generic]
> > Aug 19 22:00:44 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
> > Aug 19 22:00:44 serveur kernel:  [sys_ioctl+263/640]
> > sys_ioctl+0x107/0x280 Aug 19 22:00:44 serveur kernel:
> > [syscall_call+7/11] syscall_call+0x7/0xb Aug 19 22:00:44 serveur kernel:
> > Aug 19 22:00:44 serveur kernel: ip_tables: (C) 2000-2002 Netfilter core
> > team Aug 19 22:00:44 serveur pppd[345]: Using interface ppp0
> > Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
> > Aug 19 22:00:44 serveur pppoa3[364]: PPPoA3 version 1.1 started by root
> > (uid 0)
> > Aug 19 22:00:44 serveur pppoa3[364]: Control thread ready
> > Aug 19 22:00:44 serveur pppoa3[374]: ppp(d) --> pppoa3 --> modem  stream
> > ready Aug 19 22:00:44 serveur pppoa3[375]: modem  --> pppoa3 --> ppp(d)
> > stream ready Aug 19 22:00:44 serveur pppoa3[375]: Error reading usb urb
> > Aug 19 22:00:44 serveur pppoa3[364]: Woken by a sem_post event -> Exiting
> > Aug 19 22:00:44 serveur pppoa3[364]: Read from ppp Canceled
> > Aug 19 22:00:44 serveur pppoa3[364]: Write to ppp Canceled
> > Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
> > Aug 19 22:00:44 serveur pppoa3[364]: Exiting
> > Aug 19 22:00:44 serveur pppd[345]: Modem hangup
> > Aug 19 22:00:44 serveur pppd[345]: Connection terminated.
> > Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a
> > release() function, it is broken and must
> > be fixed.
> > Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at
> > drivers/base/class.c:201
> > Aug 19 22:00:44 serveur kernel: Call Trace:
> > Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64]
> > kobject_cleanup+0x36/0x40
> > Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464]
> > netdev_run_todo+0x10b/0x1d0
> > Aug 19 22:00:44 serveur kernel:  [_end+114517535/1070384712]
> > ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
> > Aug 19 22:00:44 serveur kernel:  [_end+114504362/1070384712]
> > ppp_ioctl+0x802/0x820 [ppp_generic]
> > Aug 19 22:00:44 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
> > Aug 19 22:00:44 serveur kernel:  [sys_ioctl+263/640]
> > sys_ioctl+0x107/0x280 Aug 19 22:00:44 serveur kernel:
> > [syscall_call+7/11] syscall_call+0x7/0xb Aug 19 22:00:44 serveur kernel:
> > Aug 19 22:00:44 serveur pppoa3[386]: PPPoA3 version 1.1 started by root
> > (uid 0)
> > Aug 19 22:00:44 serveur pppoa3[386]: Control thread ready
> > Aug 19 22:00:44 serveur pppoa3[389]: ppp(d) --> pppoa3 --> modem  stream
> > ready Aug 19 22:00:44 serveur pppoa3[390]: modem  --> pppoa3 --> ppp(d)
> > stream ready Aug 19 22:00:44 serveur pppoa3[390]: Error reading usb urb
> > Aug 19 22:00:44 serveur pppoa3[386]: Woken by a sem_post event -> Exiting
> > Aug 19 22:00:44 serveur pppoa3[386]: Read from ppp Canceled
> > Aug 19 22:00:44 serveur pppoa3[386]: Write to ppp Canceled
> > Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
> > Aug 19 22:00:44 serveur pppd[345]: Using interface ppp0
> > Aug 19 22:00:44 serveur pppoa3[386]: Exiting
> > Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
> > Aug 19 22:00:44 serveur pppd[345]: ioctl(PPPIOCSASYNCMAP): Inappropriate
> > ioctl for device(25)
> > Aug 19 22:00:44 serveur pppd[345]: tcflush failed: Input/output error
> > Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a
> > release() function, it is broken and must
> > be fixed.
> > Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at
> > drivers/base/class.c:201
> > Aug 19 22:00:44 serveur kernel: Call Trace:
> > Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64]
> > kobject_cleanup+0x36/0x40
> > Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464]
> > netdev_run_todo+0x10b/0x1d0
> > Aug 19 22:00:45 serveur kernel:  [_end+114517535/1070384712]
> > ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
> > Aug 19 22:00:45 serveur kernel:  [_end+114504362/1070384712]
> > ppp_ioctl+0x802/0x820 [ppp_generic]
> > Aug 19 22:00:45 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
> > Aug 19 22:00:45 serveur kernel:  [sys_ioctl+263/640]
> > sys_ioctl+0x107/0x280 Aug 19 22:00:45 serveur kernel:
> > [syscall_call+7/11] syscall_call+0x7/0xb Aug 19 22:00:45 serveur kernel:
> > Aug 19 22:00:45 serveur pppd[345]: Exit.
> >
> >
> > so, the last kernel which work with this adsl modem is test2-mm1.
>
> It looks like usbfs is broken again.  I should be able to look into
> this next week.  In the meantime, please try the kernel module.
>
> All the best,
>
> Duncan.

So, I just retry to use the way explain here :
 http://www.linux-usb.org/SpeedTouch/
and I don't succeed
It seems that the howto page is too old
the pppd I should use is a bit old too (several year)
when I try to run pppd, it tells me "illegal instruction" (but I follow
closely the documentation
The doc says that modem_run work, but it don't work for me (it tells me
another instance is running when speedtch is loaded)

So, I'm bored to make it works whereas speedtouch.sourceforge.net is a great
project which have made my life easier for several years  ;)
I decide to not try again to use other solutions. If futur kernels don't work
with my modem, I keep on using older kernel anyway, like test2-mm1

The usb problem I got is fixed in test4-mm1 : good thing

Cordially.

jj

