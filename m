Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTDHUvU (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTDHUvU (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:51:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46344 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261783AbTDHUvP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 16:51:15 -0400
Date: Tue, 8 Apr 2003 23:02:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Pavel Machek <pavel@ucw.cz>, Martin Hicks <mort@bork.org>,
       linux-kernel@vger.kernel.org, hpa@zytor.com, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
References: <20030407201337.GE28468@bork.org> <20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3k7e4ycys.fsf@trained-monkey.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Basically, each printk is assigned to a subsystem and that
> >> subsystem has the same set of values that the console_printk array
> >> has.  The difference is that the console_printk loglevel decides if
> >> the message goes to the console whereas the subsystem loglevel
> >> decides if that message goes to the log at all.
> 
> Pavel> Well, I consider this stop gap too... Right solution is to kill
> Pavel> printk()s from too verbose part so that it does not
> Pavel> overflow....
> 
> Hi Pavel,
> 
> Killing the printk's means they are not around if you have an end user
> who is running into problems at boot time. Having a feature like this
> means they can default to 'off' then if a problem arises, whoever is
> doing the support can ask the user to try and enable printk's for say
> SCSI and get the input, without haven to rebuild the kernel from
> scratch.

Well, I think we should first kill all crappy messages -- that
benefits everyone. I believe that if we kill all unneccessary
(carrying no information  except perhaps copyright or advertising)
will help current problem a lot.


See:Redundant:
Mar 31 21:38:54 amd kernel: Local APIC disabled by BIOS -- reenabling.
Mar 31 21:38:54 amd kernel: Found and enabled local APIC!
Strange:
Mar 31 21:38:54 amd kernel: -> /dev
Mar 31 21:38:54 amd kernel: -> /dev/console
Mar 31 21:38:54 amd kernel: -> /root
Could not those be made to a signle line? Or dropped completely?
Mar 31 21:38:54 amd kernel: enabled ExtINT on CPU#0
Mar 31 21:38:54 amd kernel: ESR value before enabling vector: 00000000
Mar 31 21:38:54 amd kernel: ESR value after enabling vector: 00000000
Useless:
Mar 31 21:38:54 amd kernel: Initializing RT netlink socket
Mar 31 21:38:54 amd kernel: mtrr: v2.0 (20020519)
I do not believe bio's are *that* important:
Mar 31 21:38:54 amd kernel: BIO: pool of 256 setup, 15Kb (60
bytes/bio)
Mar 31 21:38:54 amd kernel: biovec pool[0]:   1 bvecs: 256 entries (12
bytes)
Mar 31 21:38:54 amd kernel: biovec pool[1]:   4 bvecs: 256 entries (48
bytes)
Mar 31 21:38:54 amd kernel: biovec pool[2]:  16 bvecs: 256 entries
(192 bytes)
Mar 31 21:38:54 amd kernel: biovec pool[3]:  64 bvecs: 256 entries
(768 bytes)
Mar 31 21:38:54 amd kernel: biovec pool[4]: 128 bvecs: 256 entries
(1536 bytes)
Mar 31 21:38:55 amd kernel: biovec pool[5]: 256 bvecs: 256 entries
(3072 bytes)
Mar 31 21:38:55 amd kernel: block request queues:
Mar 31 21:38:55 amd kernel:  128 requests per read queue
Mar 31 21:38:55 amd kernel:  128 requests per write queue
Mar 31 21:38:55 amd kernel:  8 requests per batch
Mar 31 21:38:55 amd kernel:  enter congestion at 15
Mar 31 21:38:55 amd kernel:  exit congestion at 17
More useless stuff (could be usefull whhhhen CONFIG_MODULE, but when
in kernel?)
Mar 31 21:38:55 amd kernel: Linux Kernel Card Services 3.1.22
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver usbfs
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver hub
Mar 31 21:38:55 amd kernel: Coda Kernel/Venus communications, v5.3.15,
coda@cs.cmu.edu
Mar 31 21:38:55 amd kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Mar 31 21:38:55 amd kernel: NTFS driver 2.1.0 [Flags: R/O DEBUG].
Mar 31 21:38:55 amd kernel: udf: registering filesystem
Mar 31 21:38:55 amd kernel: Linux agpgart interface v0.100 (c) Dave
Jones
Mar 31 21:38:55 amd kernel: loop: loaded (max 8 devices)
Mar 31 21:38:55 amd kernel: pcnet32.c:v1.27b 01.10.2002
tsbogend@alpha.franken.de
Mar 31 21:38:55 amd kernel: PPP generic driver version 2.4.2
Mar 31 21:38:55 amd kernel: PPP Deflate Compression module registered
Mar 31 21:38:55 amd kernel: PPP BSD Compression module registered
Mar 31 21:38:55 amd kernel: Linux Tulip driver version 1.1.13 (May 11,
2002)
Mar 31 21:38:55 amd kernel: drivers/usb/host/uhci-hcd.c: USB Universal
Host Controller Interface driver v2.0
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver acm
Mar 31 21:38:55 amd kernel: drivers/usb/class/cdc-acm.c: v0.21:USB
Abstract Control Model driver for USB modems and ISDN adapte$Mar 31
21:38:55 amd kernel: drivers/usb/core/usb.c: registered new driver
usblp
Mar 31 21:38:55 amd kernel: drivers/usb/class/usblp.c: v0.13: USB
Printer Device Class driver
Mar 31 21:38:55 amd kernel: Initializing USB Mass Storage driver...
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver usb-storage
Mar 31 21:38:55 amd kernel: USB Mass Storage support registered.
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver hid
Mar 31 21:38:55 amd kernel: drivers/usb/input/hid-core.c: v2.0:USB HID
core driver
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver vicam
Mar 31 21:38:55 amd kernel: drivers/usb/net/cdc-ether.c:
drivers/usb/net/cdc-ether.c: v0.98.5 22 Sep 2001 Brad Hards and
anothe$Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered
new driver CDCEther
Mar 31 21:38:55 amd kernel: drivers/usb/core/usb.c: registered new
driver usbnet

...and so on andsimilar.
							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
