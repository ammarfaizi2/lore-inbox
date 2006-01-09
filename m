Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWAITJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWAITJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWAITJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:09:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:65249 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750708AbWAITJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:09:02 -0500
Date: Mon, 9 Jan 2006 14:09:01 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       <linux-usb-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <E1Ew1sd-0000k3-00@mars.bretschneidernet.de>
Message-ID: <Pine.LNX.4.44L0.0601091401470.7576-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Martin Bretschneider wrote:

> Yes, I also use the OHCI controller (I guessed that this is
> necessary for low speed USB devices...), I commented the calls of
> quirk_usb_disable_?hci and renamed the compiled modules so that they
> cannot be loaded. Thus, the PS/2 keyboard *does* work with "USB
> keyboard support" enabled in the BIOS with kernel 2.6.15. But - of
> cource - no USB device does work.

Good work!  This proves that the i8042 driver _is_ compatible with BIOS 
legacy support.

The next step is to find out which part of the USB handoff code isn't
working right.  Martin, first try uncommenting just the
quirk_usb_disable_ohci call but leave the modules renamed.  That will
indicate whether the problem is in the handoff code or in the driver.

Next, try renaming the ohci-hcd.ko file back to its correct name so it
does get loaded.  If the keyboard continues to work then the problem must
lie in either UHCI or EHCI.  Try doing the same two-part test (enable the
quirk code and then un-rename the file) with each of them to see exactly
at what point the keyboard stops working.

Alan Stern

