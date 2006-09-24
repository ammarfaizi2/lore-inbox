Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWIXUyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWIXUyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIXUyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:54:40 -0400
Received: from mx2.rowland.org ([192.131.102.7]:23821 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S932091AbWIXUyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:54:39 -0400
Date: Sun, 24 Sep 2006 16:54:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] usb still sucks battery in -rc7-mm1
In-Reply-To: <20060924090858.GA1852@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0609241647230.14008-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006, Pavel Machek wrote:

> Hi!
> 
> I made some quick experiments, and usb still eats 4W of battery
> power. (With whole machine eating 9W, that's kind of a big deal)...
> 
> This particular machine has usb bluetooth, but it can be disabled by
> firmware, and appears unplugged. (I did that). It also has fingerprint
> scanner, that can't be disabled, but that does not have driver (only
> driven by useland, and was unused in this experiment).
> 
> Any ideas?

The USB autosuspend patches are still not entirely in -mm.  They contain a
couple of bugs that have to get fixed first.  When they do get merged you
should see considerable improvement.  Note that although they will reduce
the amount of power being used by the USB controllers and will stop the
DMA activity (thus allowing your CPU to enter C2), they won't put the
controllers into D3.  For that you'll have to get PCI autosuspend...  :-)

In the meantime, if all you care about is power consumption there are 
some things you can do.  The easiest is simply to rmmod ehci-hcd, 
ohci-hcd, and uhci-hcd.  After all, if you're not using USB there's no 
reason to let the drivers eat up memory, CPU time, and power.

Alan Stern

