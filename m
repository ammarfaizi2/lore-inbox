Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUIKTf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUIKTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 15:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbUIKTf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 15:35:57 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:18314 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268257AbUIKTfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 15:35:55 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: kill crash when too much memory is free
Date: Sat, 11 Sep 2004 21:22:24 +0200
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <20040910222915.GC1347@elf.ucw.cz> <200409111150.28457.rjw@sisk.pl>
In-Reply-To: <200409111150.28457.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409112122.24194.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 of September 2004 11:50, Rafael J. Wysocki wrote:
> On Saturday 11 of September 2004 00:29, Pavel Machek wrote:
[- snip -]
> 
> However, I think the problem is with the hardware, not with the driver: if 
the 
> sound driver is unloaded before suspend and loaded again after resume, the 
> box behaves as though it were loaded all the time (ie IRQ #5 goes mad).  Are 
> there any boot options that may help get around this?

Some good news here. :-)

If the kernel is booted with pci=routeirq and nmi_watchdog=0, almost all of 
the problems that I had with swsusp "magically" disappear.

One issue that remains is a USB-related crash (trace available at: 
http://www.sisk.pl/kernel/040911/swsusp-usb-trace.log), which does not 
prevent the box from waking up (as you can see in the trace), but requires 
the ohci_hcd module to be reloaded.  I have got rid of it by compiling the 
USB drivers into the kernel.

The second remaining "thing" is that the network interface on eth0 (sk98lin) 
does not come up properly after resume and I have to restart networking to 
make it work, but this is a non-issue.

Thanks a lot for your help, and if I can do something for you (like testing 
new code etc.), please let me know.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
