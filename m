Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVCZENA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVCZENA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCZENA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:13:00 -0500
Received: from fmr23.intel.com ([143.183.121.15]:59104 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261975AbVCZEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 23:12:56 -0500
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
From: Len Brown <len.brown@intel.com>
To: Jason Uhlenkott <jasonuhl@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20050326025704.GE207782@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326014327.GB207782@dragonfly.engr.sgi.com>
	 <1111802218.19916.59.camel@d845pe>
	 <20050326020212.GC207782@dragonfly.engr.sgi.com>
	 <1111803861.19920.91.camel@d845pe>
	 <20050326025704.GE207782@dragonfly.engr.sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1111810359.19919.113.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2005 23:12:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 21:57, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 09:24:21PM -0500, Len Brown wrote:
> > What bad things happen if you define CONFIG_PM on SN2?
> 
> None, other than slightly enlarging the kernel with some
> suspend/resume stuff we don't care about.  It's always been
> unavailable for SN2 builds:
> 
> depends on IA64_GENERIC || IA64_DIG || IA64_HP_ZX1 ||
> IA64_HP_ZX1_SWIOTLB
> 
> but there doesn't appear to be any particular reason for that other
> than us not needing it (and in fact SN2 systems can run IA64_GENERIC
> kernels with CONFIG_PM enabled without incident).

good.

I realize now I didn't answer your original question.
The reason ACPI now depends on PM is that
it makes it easier for us to do a more orderly shutdown --
acpi registers as a device so it can do some stuff
upon the PM device shutdowns -- before interrupts are disabled.

I think with all the twisty turney passages
related to the suspend states, poweroff, sys-req, and now kexec,
that it is best if we can keep the code paths as
common as possible or some of them will never get the
testing needed to prevent them from getting broken.

Also, it is now common practice to include PM && ACPI together
in the x86 world.  Though technically one could have
ACPI w/o PM and you'd have lost only ACPI_SLEEP, virtually
nobody seems to use/depend-on that combination.

Obviously I hadn't considered SN2 or built its config
before that 1-liner.  I'll be sure to build it next time.

> > Re: CONFIG_ACPI_BOOT
> > I've got a patch that makes it go away -- this looks like
> > a good reason for me to dust it off...  Looks like
> > arch/ia64/Kconfig defines ACPI and then pulls in
> drivers/acpi/Kconfig,
> > which it should not do - it should look like i386/Kconfig...
> 
> Sounds good to me.  Does that mean everything currently controlled by
> CONFIG_ACPI_BOOT will be controlled by CONFIG_ACPI instead?

yes.  this was in -mm a while back, but got pushed onto the back
burner when more pressing things came up.

thanks,
-Len


