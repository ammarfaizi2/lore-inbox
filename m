Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWJGKtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWJGKtM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 06:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJGKtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 06:49:12 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:30639 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750818AbWJGKtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 06:49:11 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sat, 7 Oct 2006 12:49:47 +0200
User-Agent: KMail/1.8
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610060904.51936.oliver@neukum.org> <200610061410.10059.david-b@pacbell.net>
In-Reply-To: <200610061410.10059.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610071249.48194.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Oktober 2006 23:10 schrieb David Brownell:
> On Friday 06 October 2006 12:04 am, Oliver Neukum wrote:
> > Am Freitag, 6. Oktober 2006 04:47 schrieb David Brownell:
> > > On Thursday 05 October 2006 2:25 pm, Oliver Neukum wrote:
> > > 
> > > > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> > > > - there should be a common API for all devices
> > > 
> > > AFAIK there is no demonstrated need for an API to suspend
> > > individual devices.  ...
> > 
> > I doubt that a lot. 
> 
> You haven't demonstrated such a need either; so why doubt it?

OK, let me state the basics.

To get real power savings, we:
- blank the display
- spin down the hard drive
- put the CPU into an ACPI sleep state

To do the latter well, we need to make sure there's no DMA. It is
important that less or little DMA will not help. We need no DMA.
So we need to handle the commonest scenarios fully.

I dare say that the commonest scenario involving USB is a laptop with
an input device attached. Input devices are for practical purposes always
opened. A simple resume upon open and suspend upon close is useless.

Now you could et X (and gpm, etc...) to close the device after some
timeout. However, if you do so, you arrive at the counterintuitive
situation that you have to enable remote wakeup for a closed device
and the added complication that you need to generate and propagate
wakeup events. Allowing X to explicitely suspend on opened device is
simpler and more flexible. Furthermore, such a model can be extended
to keyboards.

[..]
> Likewise with autosuspending of network devices, which I'd
> actually like to see happen.  Starting in 2.6.19-rc, the USB
> drivers could be updated to do that, as I understand ... at
> least for hardware that has sane remote wakeup capabilities.
> No point in having host controllers doing nothing except
> polling a USB network adapter, unless there's actually some
> traffic directed to that host!

That's true, but insufficient.

	Regards
		Oliver
