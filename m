Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTJ1X4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJ1X4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:56:10 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:45016 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261799AbTJ1X4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:56:08 -0500
Date: Tue, 28 Oct 2003 15:56:05 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [BUG] test9 ACPI bad: scheduling while atomic!
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8D5FDBB@pdsmsx403.ccr.corp.intel.com>
Message-ID: <Pine.GSO.4.58.0310271858210.12662@blinky>
References: <571ACEFD467F7749BC50E0A98C17CDD8D5FDBB@pdsmsx403.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003, Li, Shaohua wrote:

> The reason is just what you said. It's a race condition.

> In UP, the problem occurs also. But it can't cause anything, because spinlock
> does nothing in UP. In some machines which have the problem in UP, you will
> see some info like this:
> Hwregs-0760[35] hw_low_level_read: Unsupported address space:C8

It's clearly a spinlock that leads up to Alex's oops, but the T40 oops?

> > It seems rather theoretical, but perhaps we could fix it with a patch like
> > the following.  I tested it for kicks and didn't hit any problems, but I'm
> > afraid it risks more problems than it solves.  Thoughts?
>
> Did just discarding the events cause problem?

Hmmm.  I don't imagine it would.  Indeed, registering the address space handler
alone may be good enough for ECDT use.  I'd favor that.

Regardless, we still have the Thinkpad T40 problem.

On Tue, 28 Oct 2003, Li, Shaohua wrote:

> one solution is using bh to handle such events before EC device added.
> After EC is loaded, we still use keventd to handle the events. Any idea?

Aren't BHs obsolete?

