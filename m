Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWD0E7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWD0E7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWD0E7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:59:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:43915 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964905AbWD0E7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:59:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:from;
        b=e3lm7JUjFwRt1jg6+39oQj4Rd9JK31mV+PBziezS3a4cLJjOp/VlimRmWn/bCGjexqNazmbsCgWb4PNnwoh2gUnuTa3Jng4oafvimycVU0G8bdhyAVDMEeuqr7vlcx2NRCq56sxpVzWzoONmanfBPzPWLNP/Gc8woypTjzO/QUY=
Date: Wed, 26 Apr 2006 21:58:14 -0700 (PDT)
To: akpm@osdl.org, dwalker@mvista.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Profile likely/unlikely macros -v2
Message-ID: <Pine.LNX.4.64.0604262156100.11930@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot use this patch until we find a workaround.

Well, this is the workaround I used. :-)

I'm glad you've seen this too. Maybe someone on the list could figure out the real fix.

diff --git a/arch/i386/kernel/cpu/intel_cacheinfo.c b/arch/i386/kernel/cpu/intel_cacheinfo.c
index c8547a6..c33182a 100644
--- a/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ b/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -571,7 +571,7 @@ static int __cpuinit cpuid4_cache_sysfs_
 		return -ENOENT;
 
 	/* Allocate all required memory */
-	cache_kobject[cpu] = kmalloc(sizeof(struct kobject), GFP_KERNEL);
+	cache_kobject[cpu] = __kmalloc(sizeof(struct kobject), GFP_KERNEL);
 	if (unlikely(cache_kobject[cpu] == NULL))
 		goto err_out;
 	memset(cache_kobject[cpu], 0, sizeof(struct kobject));
