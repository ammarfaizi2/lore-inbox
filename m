Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUJKWaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUJKWaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUJKWaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:30:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:58050 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269294AbUJKW2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:28:39 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200410110947.38730.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
	 <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
	 <200410110947.38730.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097533687.13642.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 08:28:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A "hang" sounds like the pmcore bug I reported about a year ago...
> 
> It's rather foolish of the PM core to use the same semaphore to
> protect system-wide suspend/resume operations that it uses to
> for mutual exclusion on the device add/remove (which suspend
> and resume callbacks did happily in 2.4) ... since it's routine to
> unplug peripherals on suspended systems!

Definitely. One thing is: how to do it instead ? I've been thinking
about it for a while and am still wondering... do we want a list
mecanism with add/remove notifiers so the PM walk can keep in sync
with devices added/removed ? or should addition/removal be simply
postponed until the end of the sleep/wakeup process (I tend to vote
for that).

> Alternatively, if you're combininging USB_SUSPEND with any
> system-wide suspend operation, you're asking for trouble;
> the PM core is just not ready for that.  (In fact I've wondered
> if maybe 2.6.9 shouldn't discourage that combination more
> actively...)
> 
> But a keyboard-specific issue might be improved with the
> HID patch I posted last week, teaching that driver how to
> handle suspend() and resume() callbacks.
> 
> - Dave
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

