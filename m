Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266698AbRGKOIq>; Wed, 11 Jul 2001 10:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbRGKOIf>; Wed, 11 Jul 2001 10:08:35 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:33275 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S266698AbRGKOIV>; Wed, 11 Jul 2001 10:08:21 -0400
Date: Wed, 11 Jul 2001 15:09:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Dave Jones <davej@suse.de>
cc: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
In-Reply-To: <Pine.LNX.4.30.0107111421300.2003-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.21.0107111457010.2035-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Dave Jones wrote:
> 
> This patch (against 247pre6) should keep the cpuinfo in sync with the real
> state of the CPU..

Am I paranoid?  I feel nervous about "c->cpuid_level--" inferring
what we expect to happen to it, would prefer to check it (below).

Hugh

--- linux-2.4.7-pre6/arch/i386/kernel/setup.c	Wed Jul 11 11:23:22 2001
+++ linux/arch/i386/kernel/setup.c	Wed Jul 11 15:02:17 2001
@@ -1994,6 +1994,7 @@
 		wrmsr(0x119,lo,hi);
 		printk(KERN_NOTICE "CPU serial number disabled.\n");
 		clear_bit(X86_FEATURE_PN, &c->x86_capability);
+		c->cpuid_level = cpuid_eax(0);
 	}
 }
 

