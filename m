Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbRCEXYA>; Mon, 5 Mar 2001 18:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRCEXXv>; Mon, 5 Mar 2001 18:23:51 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:42505 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S130766AbRCEXXo>;
	Mon, 5 Mar 2001 18:23:44 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 5 Mar 2001 23:20:53 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
Message-ID: <20010305232053.A16634@flint.arm.linux.org.uk>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local> <00d401c0a5c6$f289d200$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00d401c0a5c6$f289d200$6800000a@brownell.org>; from david-b@pacbell.net on Mon, Mar 05, 2001 at 02:52:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 02:52:24PM -0800, David Brownell wrote:
> I didn't see that thread.  I agree, pci_alloc_consistent() already has
> a signature that's up to the job.  The change you suggest would need
> to affect every architecture's implementation of that code ... which
> somehow seems not the best solution at this time.

Needless to say that USB is currently broken for the architectures that
need pci_alloc_consistent.

A while ago, I looked at what was required to convert the OHCI driver
to pci_alloc_consistent, and it turns out that the current interface is
highly sub-optimal.  It looks good on the face of it, but it _really_
does need sub-page allocations to make sense for USB.

At the time, I didn't feel like creating a custom sub-allocator just
for USB, and since then I haven't had the inclination nor motivation
to go back to trying to get my USB mouse or iPAQ communicating via USB.
(I've not used this USB port for 3 years anyway).

I'd be good to get it done "properly" at some point though.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
