Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbWCMUGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWCMUGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWCMUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:06:45 -0500
Received: from fmr20.intel.com ([134.134.136.19]:53906 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751828AbWCMUGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:06:44 -0500
Date: Mon, 13 Mar 2006 12:05:52 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, olel@ans.pl,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com, rajesh.shah@intel.com, ak@muc.de
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on 2.6.16-rc6
Message-ID: <20060313120552.A25020@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl> <20060311210353.7eccb6ed.akpm@osdl.org> <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl> <20060312032523.109361c1.akpm@osdl.org> <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl> <20060312073524.A9213@unix-os.sc.intel.com> <Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl> <20060312143053.530ef6c9.akpm@osdl.org> <20060313113615.A24797@unix-os.sc.intel.com> <20060313115155.24dfb6f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060313115155.24dfb6f3.akpm@osdl.org>; from akpm@osdl.org on Mon, Mar 13, 2006 at 11:51:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 11:51:55AM -0800, Andrew Morton wrote:
> 
> One of the main reasons for turning on CONFIG_HOTPLUG_CPU on x86 is
> actually for suspend-to-disk on SMP.  I don't think it's desirable to force
> all those little machines to use X86_GENERICARCH || X86_BIGSMP.  And it'd
> be good to make that warning go away for 2.6.16.

But we cant use X86_PC since it uses logical flat mode for IPI's that could 
cause hangup's if we deliver IPI's using IPI broadcast shortcut.

In i386 we do have an alternate that would use mask value to deliver IPI's
but Andi's recommendataion was to use flat physical mode just like what we
do for X86_64.

Other than the IPI mode, are there any other things that hurt small systems
by choosing bigsmp mode?

Venki suggested we could make it !X86_PC instead of listing 
GENERICARCH or BIGSMP separately.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center


When CONFIG_HOTPLUG_CPU is turned on we always use physflat mode (bigsmp) even 
when #of CPUs are less than 8 to avoid sending IPI to offline processors.

Without having BIGSMP on it spits out a warning during boot on systems that
seems misleading, since it complains even on systems that have less
than 8 cpus.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---------------------------------------------------------

 arch/i386/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc6-mm1/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/Kconfig
+++ linux-2.6.16-rc6-mm1/arch/i386/Kconfig
@@ -760,7 +760,7 @@ config PHYSICAL_START
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
 	---help---
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
