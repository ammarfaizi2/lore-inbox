Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264716AbVBEAu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264716AbVBEAu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbVBEAuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:50:20 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:10348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264748AbVBEAsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:48:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Pq5a2VtJRQVwlKE9yISAHHIUk0eK56iAV18Bv6FSEjEui0uWuTFb+knAH9WyJ4dAuj0lhl31qzqBpK6//fg47Kj4n3dsWQIUgkKcBt5kUk2Vs6i5bFy3QR66BtMZ6TOCwfUwZE992pIK0iXY1YU3UCtz0Yopoxo0V8Wr750dl7o=
Message-ID: <9e47339105020416486cf19738@mail.gmail.com>
Date: Fri, 4 Feb 2005 19:48:45 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <200502041534.03004.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <200502041010.13220.jbarnes@engr.sgi.com>
	 <9e4733910502041459500ae8d3@mail.gmail.com>
	 <200502041534.03004.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /sys/class/pci_bus I show three buses. You wouldn't want the
> > legacy_io/mem attributes on each of these three buses since that
> > implies three independent address spaces.
> >
> > [jonsmirl@jonsmirl pci_bus]$ ls /sys/class/pci_bus
> > 0000:00  0000:01  0000:02
> 
> In that case they'll all point to the same memory and I/O space.  On the
> machines I coded it on, each bus has its own space.

If they all point to the same space, I can't tell whether I have three
legacy spaces or one. I need to know how many legacy spaces there are
in order to know how many VGA cards can simultaneously be enabled.

> We might have to add more arch code in that case, but I thought it might be
> easiest for apps if they could just open the space for the bus they're
> interested in and it would be routed correctly.  I think that'll be ok so
> long as two apps aren't trying to do stuff on the bus at the same time.
> 
> > In order to know how many VGA many simultaneous VGA devices you can
> > have there needs to be some way to count the number of legacy address
> > spaces. Maybe there should be a /sys/class/legacy to describe the
> > legacy spaces. Is it possible to have the same legacy space aliased at
> > two different addresses depending on which root bus is used to get to
> > it?

What I meant by the questions is how can my video reset program ask
these questions, it needs to know the answers in order to properly
reset the VGA hardware.  There needs to be some way to figure out the
answers from sysfs info.

1) how many legacy spaces are there
no way to tell 
2) how many VGA devices are in each space
no way to tell, you need to know which legacy space each card is in
3) how do I do VGA bus routing to access the VGA device
I've posted code that starts doing this
4) how do I address each of the devices.
The routing code I posted needs to be update to handle multiple spaces.

For example I might have a machine with 3 spaces, 2 vga in #1, 1 in #2
and zero in #3. In that case I can have two active VGA's. My home
machine has one space and 2 vga's so I can have one active. There
needs to be enough info available to figure this out.

Or maybe the answer is simpler, if the legacy_io/mem attributes exist,
then you can assume each bus has it's own legacy space. If they don't
exist then there is a single legacy space. Is this a safe assumption?

-- 
Jon Smirl
jonsmirl@gmail.com
