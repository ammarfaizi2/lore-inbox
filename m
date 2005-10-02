Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVJBBI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVJBBI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVJBBI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 21:08:27 -0400
Received: from fmr21.intel.com ([143.183.121.13]:28907 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750930AbVJBBI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 21:08:26 -0400
Date: Sat, 1 Oct 2005 18:08:04 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, discuss@x86-64.org,
       ak@suse.de, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Message-ID: <20051001180804.A12268@unix-os.sc.intel.com>
References: <200509281624.29256.rjw@sisk.pl> <20050930182530.E28092@unix-os.sc.intel.com> <200510010947.25841.rjw@sisk.pl> <200510011203.20828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510011203.20828.rjw@sisk.pl>; from rjw@sisk.pl on Sat, Oct 01, 2005 at 12:03:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 12:03:20PM +0200, Rafael J. Wysocki wrote:
> It shows that there's something wrong with get_smp_config(), but it shouldn't
> have been called in the first place, as it was a non-SMP kernel.
> 
> The appended patch fixes the issue for me, but still if I run an SMP kernel on this
> box, it crashes in get_smp_config().
> 
> If you want me to debug this further, please tell me what to do next.

Rafael, can you check if the appended patch fixes your issue.

thanks,
suresh


--- linux-2.6.14-rc2/arch/x86_64/kernel/mpparse.c~	2005-10-01 17:16:59.452285584 -0700
+++ linux-2.6.14-rc2/arch/x86_64/kernel/mpparse.c	2005-10-01 17:22:21.053394784 -0700
@@ -549,7 +549,7 @@
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		if (!smp_read_mpc((void *)(unsigned long)mpf->mpf_physptr)) {
+		if (!smp_read_mpc(phys_to_virt(mpf->mpf_physptr))) {
 			smp_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
