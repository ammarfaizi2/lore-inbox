Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTEKMPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTEKMPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:15:14 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:59521
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261300AbTEKMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:15:13 -0400
Date: Sun, 11 May 2003 08:17:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jos Hulzink <josh@stack.nl>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
In-Reply-To: <200305111200.31242.josh@stack.nl>
Message-ID: <Pine.LNX.4.50.0305110813140.15337-100000@montezuma.mastecende.com>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]>
 <200305111200.31242.josh@stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Jos Hulzink wrote:

> For the Mandrake 2.4.21-0.13mdk kernel, there is no noirqbalance option in the 
> kernel. I tried to contact the Mandrake guys about this, but unfortunately 
> their response is 0. This patch also fails badly, and I haven't decided yet 
> wether I'm willing to help a company which doesn't seem to care at all and 
> uses pre-kernels in their distribution.

It was a bug in 2.4, fixed in Alan's tree by setting target_cpus to 0xff 
(previously cpu_online_map). There is no noirqbalance option in 2.4 
because there is no in kernel irq balancer.

	Zwane

Index: linux-2.4.21-pre1/include/asm-i386/smpboot.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.19/include/asm-i386/smpboot.h,v
retrieving revision 1.2
diff -u -p -B -r1.2 smpboot.h
--- linux-2.4.21-pre1/include/asm-i386/smpboot.h	8 Mar 2003 21:54:33 -0000	1.2
+++ linux-2.4.21-pre1/include/asm-i386/smpboot.h	10 Apr 2003 11:19:05 -0000
@@ -116,6 +116,6 @@ static inline int target_cpus(void)
 	return cpu_online_map;
 }
 #else
-#define target_cpus() (cpu_online_map)
+#define target_cpus() (0xFF)
 #endif
 #endif

-- 
function.linuxpower.ca
