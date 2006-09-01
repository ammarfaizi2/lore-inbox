Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWIAOMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWIAOMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAOMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:12:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:15882 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750812AbWIAOMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:12:37 -0400
Date: Fri, 1 Sep 2006 10:12:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jan-Hendrik Zab <xaero@gmx.de>
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Problem with USB storage devices, error -110
In-Reply-To: <20060831202621.1ae04865@localhost>
Message-ID: <Pine.LNX.4.44L0.0609011006190.6444-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006, Jan-Hendrik Zab wrote:

> Hello,
> any USB storage devices (like an external USB HDD) that I connect to
> the USB PCI adaptor card fail to be 'recognized' correctly by the
> kernel. The dmesg output looks like this:
> 
> usb 3-1: new full speed USB device using uhci_hcd and address 2
> usb usb2: suspend_rh (auto-stop)
> usb 3-1: ep0 maxpacket = 8
> usb 3-1: khubd timed out on ep0in len=-8/18
> usb 3-1: device descriptor read/all, error -110
> usb 3-1: new full speed USB device using uhci_hcd and address 3
> usb 3-1: khubd timed out on ep0in len=-8/64
> usb 3-1: khubd timed out on ep0in len=-8/64
> usb 3-1: khubd timed out on ep0in len=-8/64
> usb 3-1: device descriptor read/64, error -110
> usb 3-1: khubd timed out on ep0in len=-8/64
> usb 3-1: khubd timed out on ep0in len=-8/64
> usb 3-1: khubd timed out on ep0in len=-8/64
> usb 3-1: device descriptor read/64, error -110
> usb 3-1: new full speed USB device using uhci_hcd and address 4
> 
> I've also uploaded the complete dmesg output to:
> http://v3ng34nce.org/dmesg_output.bz2
> 
> The computer where the problem appears is running kernel 2.6.18-rc5
> now, after showing similar errors under the 'unstable' SMP Debian kernel
> 2.6.17-1-686.

It seems pretty clear that the UHCI controller hardware on your PCI card
isn't working.  The "len=-8/64" messages are a dead giveaway; you can't
get a negative length with a timeout failure if the controller is working
right.  At least, not unless you have some other USB devices already
attached to the same controller and using up all the bandwidth.

The fact that it fails in the same way with all the USB devices you attach 
is another indicator that the controller is bad.

Alan Stern

