Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFBUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFBUkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFBUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:40:34 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:36790 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261232AbVFBUhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:37:45 -0400
Date: Thu, 2 Jun 2005 16:37:44 -0400
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
Message-ID: <20050602203744.GP23488@csclub.uwaterloo.ca>
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net> <429E3338.9000401@keyaccess.nl> <20050602135737.GO23621@csclub.uwaterloo.ca> <429F0570.1090004@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429F0570.1090004@keyaccess.nl>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:11:12PM +0200, Rene Herman wrote:
> Many thanks for trying but our systems really are quite different. I'm 
> on an old fashioned north/south-bridge system, where everything does 
> compete for bus bandwidth but on newer systems it's all some form of 
> "hub architecture" (intel nomenclature) or whatever nVidia calls it. I'm 
> not too familiar with it, but I do believe that on that system one 
> needn't really expect a misbehaving EHCI controller to have (much?) 
> effect on IDE throughput.
> 
> Would you be willing to enable CONFIG_USB_DEBUG and then look at 
> /sys/class/usb_host/usbN/registers, for usbN your EHCI bus (the second 
> line of that file will say EHCI for that one)? Example for me:

I will try and do that when I get a chance.  I can also try it on a
machine with an add in ehci card (Via KT133 chipset + NEC ehci card).

> bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
> EHCI 1.00, hcd state 1
> structural params 0x00002204
> capability params 0x00006872
> status 0008 FLR
> command 010009 (park)=0 ithresh=1 period=256 RUN
> intrenable 37 IAA FATAL PCD ERR INT
> uframe 2dee
> port 1 status 001000 POWER sig=se0
> port 2 status 001000 POWER sig=se0
> port 3 status 001000 POWER sig=se0
> port 4 status 001000 POWER sig=se0
> irq normal 0 err 0 reclaim 0 (lost 0)
> complete 0 unlink 0
> 
> When my IDE throughput is normal, the "status" line is always as above, 
> but after switching on the USB2 HDD (and even after switching if off 
> again and/or unplugging it) "Async" and/or "Recl" start toggling on and 
> off (and IDE throughput drops) until I rmmod ehci-hcd. You'd need to 
> check the file a few times in a row...
> 
> In fact, anyone who could do the same would be much welcome. Certainly 
> with the EHCI controller on a PCI card, and even more certainly with a 
> VIA VT6212 EHCI controller on a PCI card.

> Your 41MB/s for the SATA disk on nForce2 does seem a bit low. The 50 
> here is with a PATA Maxtor 120G on a UDMA66 controller. I just checked 
> and I see that with current kernels hdparm -a hasn't as much influence 
> as it used to have on the hdparm -t result, but try after a "hdparm -a N 
> /dev/sda" (sda for SATA, right?) for at least N = 256, 512, 1024, 2048 
> and 4096...

Well the SATA is using an Sil3112A controller.  Not sure how fast they
are.

The system also isn't entirely idle, so who knows what might affect the
speed.  I only get 30M/s at the moment on the same type of WD 120G SATA
drive on an ICH5R chipset, although I am pretty sure I have got more
than that when it was idle before.

Len Sorensen
