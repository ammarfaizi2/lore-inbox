Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267302AbRGKM1j>; Wed, 11 Jul 2001 08:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbRGKM13>; Wed, 11 Jul 2001 08:27:29 -0400
Received: from ns.suse.de ([213.95.15.193]:61704 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267296AbRGKM1P>;
	Wed, 11 Jul 2001 08:27:15 -0400
Date: Wed, 11 Jul 2001 14:23:21 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
In-Reply-To: <Pine.LNX.4.21.0107111239460.1306-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0107111421300.2003-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Hugh Dickins wrote:

> As others have said, cpuid level 3 corresponds to Processor Serial
> Number enabled.  I think what you have here is a machine on which
> the BIOS has disabled PSN on the first CPU, but left it enabled on the
> second CPU, and so the kernel has then disabled it on the second CPU.

I'll bet that's exactly what it is. Good work.

This patch (against 247pre6) should keep the cpuinfo in sync with the real
state of the CPU..

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux-247pre7/arch/i386/kernel/setup.c linux-dj/arch/i386/kernel/setup.c
--- linux-247pre7/arch/i386/kernel/setup.c	Wed Jul 11 13:16:10 2001
+++ linux-dj/arch/i386/kernel/setup.c	Wed Jul 11 13:18:27 2001
@@ -1994,6 +1994,7 @@
 		wrmsr(0x119,lo,hi);
 		printk(KERN_NOTICE "CPU serial number disabled.\n");
 		clear_bit(X86_FEATURE_PN, &c->x86_capability);
+		c->cpuid_level--;
 	}
 }


