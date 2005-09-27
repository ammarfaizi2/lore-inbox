Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVI0FSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVI0FSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVI0FSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:18:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:21226 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964813AbVI0FSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:18:23 -0400
Subject: Re: Fw: Re: 2.6.14-rc2-mm1 ide problems on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, ak@suse.de
In-Reply-To: <20050926151149.6332c94e.akpm@osdl.org>
References: <20050926151149.6332c94e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 22:17:52 -0700
Message-Id: <1127798272.16275.40.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 15:11 -0700, Andrew Morton wrote:
> Or just do the bisection search by hand.
> 
> Either way, can you please find the time to do this?  I have no idea
> what broke it.
> 
> Except maybe acpi.  Try just linus.patch and git-acpi.patch, perhaps.
> 
> 
> Begin forwarded message:
> 
> Date: Mon, 26 Sep 2005 23:02:40 +0400
> From: Alexey Dobriyan <adobriyan@gmail.com>
> To: Badari Pulavarty <pbadari@us.ibm.com>
> Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
> Subject: Re: 2.6.14-rc2-mm1 ide problems on AMD64
> 
> 
> On Mon, Sep 26, 2005 at 11:07:00AM -0700, Badari Pulavarty wrote:
> > 2.6.14-rc2-mm1 doesn't seem to boot on my AMD64 box. It hangs
> > while probing "ide" disks. I spent time looking at it and
> > here is what I know so far.
> > 
> > 	2.6.13: works fine
> > 	2.6.13-mm series: works fine
> > 	2.6.14-rc2: works fine
> > 	2.6.14-rc2 + linus.patch (from -mm1): works fine
> > 	2.6.14-rc2-mm1: hangs on boot
> > 
> > I looked through all the changes in "drivers/ide/" in -mm
> > and none of them seemed to cause the problem. I added tracing
> > to figure out whats happening. It hangs while doing, "do_probe()"
> > Here is the calling sequence:
> > 	 
> > 	ide_scan_pcidev()
> > 	   amd74xx_probe()
> > 	     ide_setup_pci_device()
> > 	       probe_hwif_init_with_fixup()
> > 	         probe_hwif()
> > 	           probe_for_drive()
> > 	            do_probe()
> > 	         
> > If anyone has fixes/debug to try, please let me know.

Finally, tracked the problem causing patch in -mm tree.
Its,

x86_64-no-idle-tick.patch

I backed out the patch and my machine works fine.

Thanks,
Badari

