Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130926AbRCFEyK>; Mon, 5 Mar 2001 23:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130927AbRCFEyA>; Mon, 5 Mar 2001 23:54:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42119 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130926AbRCFExv>;
	Mon, 5 Mar 2001 23:53:51 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15012.27969.175306.527274@pizda.ninka.net>
Date: Mon, 5 Mar 2001 20:53:21 -0800 (PST)
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>,
        Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
In-Reply-To: <20010305232053.A16634@flint.arm.linux.org.uk>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
	<00d401c0a5c6$f289d200$6800000a@brownell.org>
	<20010305232053.A16634@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > A while ago, I looked at what was required to convert the OHCI driver
 > to pci_alloc_consistent, and it turns out that the current interface is
 > highly sub-optimal.  It looks good on the face of it, but it _really_
 > does need sub-page allocations to make sense for USB.
 > 
 > At the time, I didn't feel like creating a custom sub-allocator just
 > for USB, and since then I haven't had the inclination nor motivation
 > to go back to trying to get my USB mouse or iPAQ communicating via USB.
 > (I've not used this USB port for 3 years anyway).

Gerard Roudier wrote for the sym53c8xx driver the exact thing
UHCI/OHCI need for this.

I think people are pissing their pants over the pci_alloc_consistent
interface for no reason.  It gives PAGE<<order sized/aligned chunks
back to the caller at the request of Linus so that drivers did not
have to guess "is this 16-byte aligned..." etc.

Later,
David S. Miller
davem@redhat.com
