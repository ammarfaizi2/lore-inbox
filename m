Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWJ0Sph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWJ0Sph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWJ0Sph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:45:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750747AbWJ0Spg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:45:36 -0400
Date: Fri, 27 Oct 2006 11:39:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-Id: <20061027113908.4a82c28a.akpm@osdl.org>
In-Reply-To: <20061027172219.GC30416@elf.ucw.cz>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 19:22:19 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > I've found only 1 real bug from all of this.  The pci MSI initialization
> > issue.  It's on my queue of things to fix.  Andrew has also sent me
> > another "interesting" patch about making sure devices are found by the
> > time we hit another init level which I'll see about adding too.
> 
> And the swsusp vs. SATA issue? Currently, SATA can be initialized
> after swsusp, leading to swsusp not finding its image and failing...

How can sata be initialised after swsusp?  Are they each using correctly
prioritised initcall levels?

If so then the problem is presumably that sata initialisation is started
before swsusp initialisation, but sata completes _after_ swsusp
initialisation has run.  In which case the as-yet-untested
drivers-wait-for-threaded-probes-between-initcall-levels.patch should fix
this.

Greg, I think I'll send vmlinuxlds-consolidate-initcall-sections.patch into
Linus for 2.6.19, make things easier for everyone.

I'll send both patches.  Please test ;)
