Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbUJ1Cbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUJ1Cbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 22:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbUJ1Cbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 22:31:47 -0400
Received: from fmr03.intel.com ([143.183.121.5]:28324 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262726AbUJ1Can
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 22:30:43 -0400
Date: Wed, 27 Oct 2004 19:27:39 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: 2.6.10-rc4-mm1 hpet compile fix for AMD64
Message-ID: <20041027192739.A6088@unix-os.sc.intel.com>
References: <1098914436.20643.155.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098914436.20643.155.camel@dyn318077bld.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Oct 27, 2004 at 03:00:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 27, 2004 at 03:00:37PM -0700, Badari Pulavarty wrote:
> Hi Andrew,
> 
> Here is the HPET compile fix for AMD64. Without this, you 
> get following link error. (without HPET)
> 
> arch/x86_64/kernel/built-in.o(.text+0x6426): In function `timer_resume':
> arch/x86_64/kernel/time.c:971: undefined reference to `is_hpet_enabled'
> 
> 

That would be a bug introduced by my hpet-reenabling-after-suspend-resume.patch
This should be a better fix.

Thanks,
Venki

Signed-off-by:: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>

--- linux-2.6.9//arch/x86_64/kernel/time.c.org	2004-10-05 15:23:44.903948384 -0700
+++ linux-2.6.9//arch/x86_64/kernel/time.c	2004-10-05 15:30:41.242655280 -0700
@@ -899,7 +899,7 @@ static int timer_resume(struct sys_devic
 	unsigned long flags;
 	unsigned long sec;
 
-	if (is_hpet_enabled())
+	if (vxtime.hpet_address)
 		hpet_reenable();
 
 	sec = get_cmos_time() + clock_cmos_diff;
