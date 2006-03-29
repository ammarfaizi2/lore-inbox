Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWC2Xrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWC2Xrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWC2Xrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:47:51 -0500
Received: from mga07.intel.com ([143.182.124.22]:19573 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751286AbWC2Xru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:47:50 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,145,1141632000"; 
   d="scan'208"; a="16556351:sNHT23310805"
Date: Wed, 29 Mar 2006 15:47:48 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060329154748.A12897@unix-os.sc.intel.com>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org> <20060329150950.A12482@unix-os.sc.intel.com> <200603300936.22757.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200603300936.22757.ncunningham@cyclades.com>; from ncunningham@cyclades.com on Thu, Mar 30, 2006 at 09:36:16AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:36:16AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> 
> So if you have a single core x86, you want X86_PC, and if you have HT or SMP, 
> you want GENERICARCH? If so, could this be done via selects or depends or at 
> least defaults in Kconfig?

Yes, i think only SUSPEND_SMP is affect by this. I thought Rafael cced Pavel during 
that exchange, maybe i missed.

> 
> Regards,
> 
> Nigel

How about this patch.

Make SUSPEND_SMP depend on X86_GENERICARCH, since hotplug cpu requires !X86_PC 
due to some race in IPI handling.  See more discussion here

http://marc.theaimsgroup.com/?l=linux-kernel&m=114303306032338&w=2

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------------

Index: linux-2.6.16-git16/kernel/power/Kconfig
===================================================================
--- linux-2.6.16-git16.orig/kernel/power/Kconfig
+++ linux-2.6.16-git16/kernel/power/Kconfig
@@ -96,5 +96,5 @@ config SWSUSP_ENCRYPT

 config SUSPEND_SMP
        bool
-       depends on HOTPLUG_CPU && X86 && PM
+       depends on HOTPLUG_CPU && X86 && PM && X86_GENERICARCH
        default y


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
