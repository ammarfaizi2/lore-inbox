Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUI0JLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUI0JLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUI0JLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:11:07 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:33230 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266543AbUI0JKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:10:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Mon, 27 Sep 2004 11:11:42 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <200409251214.28743.rjw@sisk.pl> <200409270001.09311.rjw@sisk.pl> <20040926223351.GO28810@elf.ucw.cz>
In-Reply-To: <20040926223351.GO28810@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271111.42812.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 27 of September 2004 00:33, Pavel Machek wrote:
[-- snip --]
> > I've got two logs (attached), one of which is taken from the system with 
all 
> > modules loaded (swsusp.log), and the other comes from the system with no 
> > modules except for ipv6 (swsusp-nomod.log).  As you can see from the first 
> > log, the system with all modules loaded slows down significantly after 
> > pci_device_resume() is called for the device having vendor id = 0x10de 
> > (NVidia) and device id = 0x00d7 (no idea).  The system without modules is 
> 
> lspci, and take a look?

albercik:~ # lspci -n
[ ... ]
0000:00:02.0 Class 0c03: 10de:00d7 (rev a5)
0000:00:02.1 Class 0c03: 10de:00d7 (rev a5)
0000:00:02.2 Class 0c03: 10de:00d8 (rev a2)
[ ... ]

albercik:~ # lspci
[ ... ]
0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
[ ... ]

So, it's the USB 1.1 controller (OHCI).

> > capable of writing 80-83% of pages to the swap _before_ slows down too and 
I 
> > have to wait for 1/2 h for the remaining ~20%.
> 
> Strange, *very* strange.

Yes, it is.

> > I'm afraid I can't get any more info until I sort out the sysrq
> > problem.
> 
> This should remap magic key to both-shifts-both-alts-key. Worked for
> me once...

Thanks a lot, but it turned out to be much simpler: sysrq was disabled by an 
initscript (shame on me, shame, shame).  I'll get the traces as soon as I can 
get something to attach to the serial console.  In the meantime, I'll try to 
look at the USB stuff.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
