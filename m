Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbULUHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbULUHta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 02:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULUHta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 02:49:30 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:48544 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261573AbULUHtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 02:49:22 -0500
Subject: Re: USB storage (pendrive) problems
From: Attila BODY <compi@freemail.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41C75E8B.1020200@osdl.org>
References: <1103579679.23963.14.camel@localhost>
	 <200412202325.20064.andrew@walrond.org>  <41C75E8B.1020200@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 09:35:03 +0200
Message-Id: <1103614504.6222.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 15:21 -0800, Randy.Dunlap wrote:
> Andrew Walrond wrote:
> > On Monday 20 December 2004 21:54, Attila BODY wrote:
> > 
> >>Hi,
> >>
> >>I have some weird problems with my pendrives recently. I just compile a
> >>2.6.9 to check if the problem is still exists there.
> >>
> >>current kernel is 2.6.10-rc3 and the situation is the following:
> >>
> >>If I copy more than few megabytes to the drive, the activity LED keeps
> >>flashing forever. sync, umount keeps runing forever, normal reboot is
> >>inpossible (alt+sysreq+b seems to work)
> >>
> >>Tested with usb 1.1 and 2.0 pendrives, behaviour is the same.
> >>
> > 
> > 
> > I'm doing exactly that with 2.6.10-rc3. umount does take a very long time (but 
> > I had just written 600Mb+ over usb 1.1)
> > 
> > Are you sure it doesn't come back if you leave it long enough?
> > 
> > Do the throughput sums; you'll be suprised how long it takes to send more than 
> > a few Mb over usb 1.1 (1.5Mb/s). Eg 600Mb = 7minutes
> > 
> > Usb 2 should be much faster; Do you have EHCI loaded?
> 
> and which usb driver are you using?
> ub or usb-storage?  (what's the /dev name that you mount?)
Hi,

Here is the log snipet when plug the pendrive in, i thin It should be
clear from this that is uses ehci_hcd, ub, hotplug and udev. For 1.1 it
uses uhci_hcd

Dec 21 08:58:51 smiley kernel: ehci_hcd 0000:00:10.3: port 6 high speed
Dec 21 08:58:51 smiley kernel: ehci_hcd 0000:00:10.3: GetStatus port 6
status 001005 POWER sig=se0  PE CONNECT
Dec 21 08:58:51 smiley kernel: usb 1-6: new device strings: Mfr=2,
Product=3, SerialNumber=4
Dec 21 08:58:51 smiley kernel: usb 1-6: default language 0x0409
Dec 21 08:58:51 smiley kernel: usb 1-6: Product: Cruzer Mini
Dec 21 08:58:51 smiley kernel: usb 1-6: Manufacturer: SanDisk
Corporation
Dec 21 08:58:51 smiley kernel: usb 1-6: SerialNumber: 00567026
Dec 21 08:58:51 smiley kernel: usb 1-6: hotplug
Dec 21 08:58:51 smiley kernel: usb 1-6: adding 1-6:1.0 (config #1,
interface 0)
Dec 21 08:58:51 smiley kernel: usb 1-6:1.0: hotplug
Dec 21 08:58:51 smiley kernel: ub 1-6:1.0: usb_probe_interface
Dec 21 08:58:51 smiley kernel: ub 1-6:1.0: usb_probe_interface - got id
Dec 21 08:58:51 smiley usb.agent[6288]:      ub: already loaded
Dec 21 08:58:52 smiley kernel: uba: device 3 capacity nsec 512000 bsize
512
Dec 21 08:58:52 smiley kernel: uba: device 3 capacity nsec 512000 bsize
512
Dec 21 08:58:52 smiley kernel: /dev/ub/a: p1
Dec 21 08:58:52 smiley udev[6328]: creating device node '/dev/uba1'
Dec 21 08:58:52 smiley udev[6321]: creating device node '/dev/uba'

The problem is reproducable with 2.6.9. Unfortunately I have no time
right now to check 2.6.8.1 if the problem already presists there.
It seems however that the 1.1 device recovers if I wait long enough, but
I left the 2.0 device here all night and it did not. To make it worse,
it seems that the whole USB 2.0 system went down, there was no activity
even if i reconnected the pen, had to reboot to be detected and powered
on again (normal reboot was not an option again, so I had to use
alt-sysrq-B).

Hope this helps to track down this problem.

compi

P.S.: Please cc, I'm not subscribed.

