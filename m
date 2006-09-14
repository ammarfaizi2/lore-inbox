Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWINUWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWINUWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWINUWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:22:07 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43738 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751127AbWINUWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:22:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Thu, 14 Sep 2006 22:21:05 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609141428070.5715-100000@iolanthe.rowland.org> <200609142137.52066.rjw@sisk.pl>
In-Reply-To: <200609142137.52066.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609142221.06507.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 21:37, Rafael J. Wysocki wrote:
> On Thursday, 14 September 2006 20:28, Alan Stern wrote:
> > On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:
> > 
> > > > Let's try a simpler test.  Leave USB_SUSPEND unset.
> > > > 
> > > > First rmmod ohci-hcd.  None of your full-speed USB devices will work, but 
> > > > that's okay.  Try the suspend-twice test and see what happens.
> > > > 
> > > > Second, rmmod ehci-hcd and modprobe ohci-hcd.  Again try the suspend-twice 
> > > > test.
> > > 
> > > Done, works (with USB_SUSPEND unset).
> > 
> > Okay, good.
> 
> Well, sorry.  This test has been passed, but after a reboot it refused to
> suspend just once giving the same messages that I've got from the kernel
> with USB_SUSPEND set (the relevant dmesg output is attached).

This only happens if _both_ ohci_hcd and ehci_hcd are loaded before the
suspend.
 
> > Then for the next stage, repeat the same tests but with  
> > USB_SUSPEND set.
> 
> Compiling.

The results are now the same with and without USB_SUSPEND set.  Namely,
if one hcd is loaded before a suspend (either ehci or ohci), it succeeds
(repeatable arbitrary number of times in a row).  However, if both hcds are
loaded before a suspend, it fails (100% of the time) and the messages are
like in the dmesg output attached to the previous message.

I've reproduced this behavior on another x86_64 box.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
