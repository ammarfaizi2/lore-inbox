Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUDSVzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDSVzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUDSVzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:55:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12305 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261928AbUDSVzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:55:00 -0400
Date: Mon, 19 Apr 2004 23:54:50 +0200
From: Willy TARREAU <w@w.ods.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: cramerj@intel.com, scott.feldman@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040419215450.GA331@pcw.home.local>
References: <20040416224422.GA19095@tsunami.ccur.com> <20040417072455.GD596@alpha.home.local> <20040419165425.GA3988@tsunami.ccur.com> <20040419193930.GA28340@alpha.home.local> <20040419214247.GA5273@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419214247.GA5273@tsunami.ccur.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 05:42:47PM -0400, Joe Korty wrote:
> On Mon, Apr 19, 2004 at 09:39:30PM +0200, Willy Tarreau wrote:
> > On Mon, Apr 19, 2004 at 12:54:25PM -0400, Joe Korty wrote:
> >> 
> >> Uniprocessor 2.4.26 works fine.
> >> Uniprocessor 2.4.26 + local apic works fine.
> >> Uniprocessor 2.4.26 + local apic + io apic fails.
> > 
> > interesting. Unfortunately, I didn't have time to try on the machine I told
> > you about last day. But right here, I have a dual athlon communicating
> > with an alpha, both with e1000 (544) in 2.4.26. Since there's a PCI
> > bridge on your quad, I wonder if the IOAPIC doesn't trigger an interrupt
> > routing problem with bridges. Are all the ports unusable or do some of
> > them work reliably in APIC mode ?
> 
> I just verified that the Quad Ethernet board works with 2.6.5 SMP, so it
> is unlikely to be a bridge or other hardware problem.

Sorry that was not what I meant. I meant that the 2.4.26 irq routing or
I don't know what might experience difficulties due to the presence of
a PCI bridge on this board, and potentially this one particularly. I once
encountered such a problem in a desktop machine which would only see 3 out
of the 4 ports on an adaptec quad board, depending on the PCI slot it was
fit in ! It turned out to be a problem with region alignment or something
like this which was not correctly forwarded through the bridge (bios bug
or so at initialization).

> For 2.4.26, the Dell 650 has an Intel 82545EM Gigabit Ethernet Controller
> soldered in, which also uses the e1000 driver, and that works fine, so
> we know the 2.4.26 e1000 driver works with some of these Intel chips.

OK, same here.

> When the Quad board works, it negotiates down to 10 MBits/sec Half Duplex.
> Not sure yet if this is what it is supposed to be doing in our environment.

I remember something like this not long ago. It was what ethtool reported, but
the card was running either gigabit or a forced 100FDX without auto-neg on the
other side, I don't remember. Can you try a simple 4-pairs cable between two
ports on the quad to check what media is negociated ?

Also, can you cat /proc/interrupts with and without io/apic, and try without
ACPI as Zwane suggested ?

Cheers,
Willy

