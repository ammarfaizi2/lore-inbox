Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVI3OFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVI3OFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVI3OFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:05:09 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:35736 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030304AbVI3OFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:05:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EScwZk31UZkYv7uwySF3kJQx2FWTJr3jX02I2lUCe2J6hs+gx2hOxrBsi3dbdNwmp+llLBAc5WTaIWdCp11R7h4Aauxi2v6L/NMtoltlR/JsTosS2fM9TcGGapWF9RytpiNT9Jy7PFjWHcdfBMJ2ZlvfQdkRkIAZq8uVKSwdvzg=
Date: Fri, 30 Sep 2005 18:16:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: "Aaron M. Ucko" <ucko@debian.org>
Subject: Fwd: [PATCH] cpufreq: honor cpu_sibling_map in speedstep-centrino.c
Message-ID: <20050930141603.GA26810@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: kernel-janitors@lists.osdl.org

speedstep-centrino.c should honor cpu_sibling_map for the sake of
recent Intel processors, which support both Centrino-style Enhanced
SpeedStep and hyperthreading; even newer dual-core chips may need the
same fix.

--- linux-source-2.6.13.2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~	2005-08-28 19:41:01.000000000 -0400
+++ linux-source-2.6.13.2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-09-28 17:23:37.000000000 -0400
@@ -498,6 +498,10 @@
 	if (cpu->x86_vendor != X86_VENDOR_INTEL || !cpu_has(cpu, X86_FEATURE_EST))
 		return -ENODEV;
 
+#ifdef CONFIG_SMP
+	policy->cpus = cpu_sibling_map[policy->cpu];
+#endif
+
 	for (i = 0; i < N_IDS; i++)
 		if (centrino_verify_cpu_id(cpu, &cpu_ids[i]))
 			break;


