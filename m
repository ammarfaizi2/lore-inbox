Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750851AbWFDSUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWFDSUU (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 14:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWFDSUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 14:20:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:7099 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750851AbWFDSUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 14:20:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3
Date: Sun, 4 Jun 2006 20:20:43 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060603232004.68c4e1e3.akpm@osdl.org>
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606042020.43715.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 08:20, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/

Small compilation fix needed for x86_64 without SMP:

 arch/x86_64/kernel/mce_amd.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.17-rc5-mm3/arch/x86_64/kernel/mce_amd.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/arch/x86_64/kernel/mce_amd.c
+++ linux-2.6.17-rc5-mm3/arch/x86_64/kernel/mce_amd.c
@@ -494,7 +494,11 @@ static __cpuinit int threshold_create_ba
 
 	kobject_set_name(&b->kobj, "threshold_bank%i", bank);
 	b->kobj.parent = &per_cpu(device_mce, cpu).kobj;
+#ifdef CONFIG_SMP
 	b->cpus = cpu_core_map[cpu];
+#else
+	b->cpus = CPU_MASK_CPU0;
+#endif
 
 	err = kobject_register(&b->kobj);
 	if (err)
