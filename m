Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUI1XDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUI1XDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUI1XDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:03:31 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:31548 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268076AbUI1XDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:03:30 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040928221600.D14747@flint.arm.linux.org.uk>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <1096405831.2513.37.camel@deimos.microgate.com>
	 <20040928221600.D14747@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1096412582.6003.8.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 28 Sep 2004 18:03:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:16, Russell King wrote:
> On Tue, Sep 28, 2004 at 04:10:31PM -0500, Paul Fulghum wrote:
> Some 16x50 ports (most of the ones higher than 16550A) have auto flow
> control, so if this is enabled you really don't want to drop bytes in
> the FIFO on the floor.

The alternative is to implement a flow control
mechanism between the flip buffer layer and
the tty drivers to (at the very least)
enable/disable receive interrupts.

Since the flip buffer implementation is probably
going to need rework anyways (eventually) along
with the other tty locking issues, this may not
be a trivial task.

Dropping the bytes is a simple, local fix that
will be more sane than the current
behavior of locking the machine.

A more optimized solution is likely to take a while.

-- 
Paul Fulghum
paulkf@microgate.com


