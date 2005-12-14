Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVLNTaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVLNTaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVLNTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:30:22 -0500
Received: from fsmlabs.com ([168.103.115.128]:16797 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932242AbVLNTaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:30:19 -0500
X-ASG-Debug-ID: 1134588617-4056-163-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 14 Dec 2005 11:35:46 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gerd Knorr <kraxel@suse.de>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Xen merge mainline list <xen-merge@lists.xensource.com>
X-ASG-Orig-Subj: Re: [patch] SMP alternatives for i386
Subject: Re: [patch] SMP alternatives for i386
In-Reply-To: <439EE742.5040909@suse.de>
Message-ID: <Pine.LNX.4.64.0512141129090.1678@montezuma.fsmlabs.com>
References: <439EE742.5040909@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6297
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.15-rc5/arch/i386/kernel/smpboot.c work-2.6.15-rc5/arch/i386/kernel/smpboot.c
--- linux-2.6.15-rc5/arch/i386/kernel/smpboot.c	2005-12-06 17:00:36.000000000 +0100
+++ work-2.6.15-rc5/arch/i386/kernel/smpboot.c	2005-12-06 17:06:48.000000000 +0100
@@ -1351,6 +1352,9 @@
 	fixup_irqs(map);
 	/* It's now safe to remove this processor from the online map */
 	cpu_clear(cpu, cpu_online_map);
+
+	if (1 == num_online_cpus())
+		alternatives_smp_switch(0);
 	return 0;
 }

Is that really safe there? Ideally you want to do the switch when the 
processor going offline is no longer executing kernel code.

