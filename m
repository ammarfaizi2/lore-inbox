Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWBWAu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWBWAu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWBWAu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:50:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14742 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750980AbWBWAuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:50:25 -0500
Date: Wed, 22 Feb 2006 16:50:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: maule@sgi.com, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com, gregkh@suse.de
Subject: Re: Altix SN2 2.6.16-rc1-mm5 build breakage (was:  msi support)
Message-Id: <20060222165009.6493e6a1.pj@sgi.com>
In-Reply-To: <20060203202742.1e514fcc.akpm@osdl.org>
References: <20060119194647.12213.44658.14543@lnx-maule.americas.sgi.com>
	<20060119194702.12213.16524.93275@lnx-maule.americas.sgi.com>
	<20060203201441.194be500.pj@sgi.com>
	<20060203202531.27d685fa.akpm@osdl.org>
	<20060203202742.1e514fcc.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 3, Andrew wrote:
> Actually, gregkh-pci-altix-msi-support-git-ia64-fix.patch fix`es
> git-ia64.patch when gregkh-pci-altix-msi-support.patch

Is it time to reinsert that patch?

My ia64 sn build fails again, complaining:


===========================
  CC      arch/ia64/sn/pci/tioce_provider.o
arch/ia64/sn/pci/tioce_provider.c:720:46: macro "ATE_MAKE" requires 3 arguments, but only 2 given
===========================


Your broken-out/series file (2.6.16-rc4-mm1) has the lines:

    # Need this when gregkh-pci-altix-msi-support.patch comes back
    #gregkh-pci-altix-msi-support-git-ia64-fix.patch

I guess that is this patch below, which fixes my sn build just fine.
Holler if you need it as a proper patch.


--- 2.6.16-rc4-mm1.orig/arch/ia64/sn/pci/tioce_provider.c       2006-02-22 16:21:52.054985166 -0800
+++ 2.6.16-rc4-mm1/arch/ia64/sn/pci/tioce_provider.c    2006-02-22 16:31:21.594755653 -0800
@@ -717,7 +717,7 @@ tioce_reserve_m32(struct tioce_kernel *c
        while (ate_index <= last_ate) {
                u64 ate;

-               ate = ATE_MAKE(0xdeadbeef, ps);
+               ate = ATE_MAKE(0xdeadbeef, ps, 0);
                ce_kern->ce_ate3240_shadow[ate_index] = ate;
                tioce_mmr_storei(ce_kern, &ce_mmr->ce_ure_ate3240[ate_index],
                                 ate);


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
