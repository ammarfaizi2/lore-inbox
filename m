Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUHDC6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUHDC6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUHDC5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:57:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:15011 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265697AbUHDC4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:56:40 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408031928.08475.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091588163.5225.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 12:56:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Passing PM_SUSPEND_* values (0-3) instead of PCI power states (0-4),
> as PCI drivers have previously expected, looks like it ought to be a
> simplifying assumption.  Simpler is often good ... though this makes
> me suspect "too simple".  Especially since it pushes policy choices
> into device drivers (normally not good, except for quirks like "this
> driver+hardware can't do D3, so let's use D2")..

Actually, I took a shortcut with my PPC implementation of swsusp,
which was to tweak the numbering of PM_SUSPEND_* so that

 PM_SUSPEND_STANDBY	= 1
 PM_SUSPEND_MEM		= 3
 PM_SUSPEND_DISK	= 4

Which has the "side effect" of matching S states and mostly D states
with the exception of disk, for the few drivers that care...

But in the long run, this may add confusion instead of clearing things,
I agree we should rather move to completely different types, though I
don't feel like re-typing every callbacks in the tree right now...

Ben.


