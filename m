Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUB0APb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUB0APb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:15:31 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7637 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261411AbUB0APV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:15:21 -0500
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
From: john stultz <johnstul@us.ibm.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Go Taniguchi <go@turbolinux.co.jp>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040226231550.GY25779@parcelfarce.linux.theplanet.co.uk>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077668801.2857.63.camel@cog.beaverton.ibm.com>
	 <20040224170645.392abcff.akpm@osdl.org> <403E0563.9050007@turbolinux.co.jp>
	 <1077830762.2857.164.camel@cog.beaverton.ibm.com>
	 <1077836576.2857.168.camel@cog.beaverton.ibm.com>
	 <20040226231550.GY25779@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1077840891.2857.175.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 16:14:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-26 at 15:15, Matthew Wilcox wrote:
> On Thu, Feb 26, 2004 at 03:02:56PM -0800, john stultz wrote:
> > On Thu, 2004-02-26 at 13:26, john stultz wrote:
> > > On Thu, 2004-02-26 at 06:40, Go Taniguchi wrote:
> > > > Hi,
> > > > 
> > > > Andrew Morton wrote:
> > > > > john stultz <johnstul@us.ibm.com> wrote:
> > > > >>I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
> > > > >>there as well. 
> > > > 
> > > > Problem patch is expanded-pci-config-space.patch.
> > > > x440 can not enable acpi by dmi_scan.
> > > > expanded-pci-config-space.patch need acpi support.
> > > > So, kernel can not get x440's xAPIC interrupt.
> > > 
> > > Wow, thanks for that analysis Go! I'll test it here to confirm. 
> > 
> > Yep, I've confirmed that backing out the expanded-pci-config-space patch
> > solves it. Thanks again, Go, for hunting that down! 
> > 
> > Matthew, any ideas why the patch fails if the system has an ACPI
> > blacklist entry?
> 
> Hrm.  I was just asked to break out some of the ACPI code rearrangement
> from the rest of the patch.  Can you try this patch instead of the
> expanded-pci-config-space.patch and tell me whether it continues to fail
> for you?

Unfortunately it does still hang with that patch. 

> I don't understand why it should make a difference though.  It looks
> to me like the current code will also fail to call the HPET code if the
> bios is blacklisted.

I'm a bit pressed for time at the moment, so I can't dig too deeply
right now, but I'll happily test any patches you might think will help. 

thanks
-john

