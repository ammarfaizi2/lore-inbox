Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbTL3WUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbTL3WTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:19:14 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23474
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265841AbTL3WKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:10:30 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software suspend in 2.6.0
Date: Tue, 30 Dec 2003 16:09:23 -0600
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200312300000.05201.rob@landley.net> <1072808436.2741.34.camel@laptop-linux>
In-Reply-To: <1072808436.2741.34.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312301609.23407.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 December 2003 12:20, Nigel Cunningham wrote:
> Hi Rob.
>
> Do you have a preemptive kernel? If so, it could be that you're getting
> 'bad scheduling while atomic' messages. Could you check dmesg after the
> second suspend?

Here's a cut and past of the relevant section.  (It's really ugly.)
----------
VFS: busy inodes on changed media.
VFS: busy inodes on changed media.
Stopping tasks: 
================================================================
===================================================|
Freeing memory: <6>eth0: New link status: AP Out of Range (0004)
.<6>eth0: New link status: AP In Range (0005)
eth0: New link status: AP Out of Range (0004)
eth0: New link status: AP In Range (0005)
eth0: New link status: AP Out of Range (0004)
eth0: New link status: AP In Range (0005)
.<6>eth0: New link status: AP Out of Range (0004)
eth0: New link status: AP In Range (0005)
eth0: New link status: AP Changed (0003)
.<6>eth0: New link status: AP Out of Range (0004)
eth0: New link status: AP In Range (0005)
.<6>eth0: New link status: AP Out of Range (0004)
.<6>eth0: New link status: AP In Range (0005)
.<6>eth0: New link status: AP Out of Range (0004)
....<6>eth0: New link status: AP In Range (0005)
eth0: New link status: AP Changed (0003)
.<6>eth0: New link status: AP Out of Range (0004)
................................|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PM: Image restored successfully.
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
eth0: New link status: Connected (0001)
blk: queue cb54ae00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done
VFS: busy inodes on changed media.
psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 
bytes
 away.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:14.0: OHCI Host Controller
ohci_hcd 0000:00:14.0: irq 10, pci mem cc07c000
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 2, assigned address 2
drivers/usb/net/pegasus.c: v0.5.12 (2003/06/06):Pegasus/Pegasus II USB 
Ethernet
driver
drivers/usb/net/pegasus.c: setup Pegasus II specific registers
eth1: Hawking UF100 10/100 Ethernet
drivers/usb/core/usb.c: registered new driver pegasus
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
python2.2: numerical sysctl 1 23 is obsolete.
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
drivers/usb/net/pegasus.c: intr status -84
----------

The "busy inodes on changed media" stuff is from the cd-rom drive.  It's 
repeated about 8 gazillion times before the suspend, and a few afterwards.

All the "new link status" messages were me coming home from the university of 
texas, with the laptop in my bag doing its "I am suspending very slowly" 
thing for 15 minutes.  It still hadn't suspended when I got home (5 minutes 
later), it finally powered off lying next to my bed as I was reading (maybe 
20 minutes from the initial suspend request).  This is not at all unusual, it 
may actually take more time with each susequent suspend attempt.  (It seems 
the swap file usage goes up as well, although I haven't examined it closely.  
This is just a vague impression.)

After I resumed, it I fiddled with the USB port to add a second ethernet 
device (ifconfig eth0 down, ifconfig eth1 up to go from built-in wireless to 
a cat 5 connection.)  The messages from pegasus.c about intr status -84 then 
continue for several pages, but don't seem to be hurting anything.  I do know 
I have to rmmod the usb stuff before I suspend or it freezes on resume 
complaining about USB.  (This was true in -test11, anyway.  Haven't tried it 
under 2.6.0.)

2.6.0 is definitely a ".0" release as far as my logs are concerned... :)

> Regards,
>
> Nigel

Rob

