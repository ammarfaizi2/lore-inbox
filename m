Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVBHW5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVBHW5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVBHW5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:57:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:25578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261664AbVBHW5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:57:14 -0500
Date: Tue, 8 Feb 2005 14:57:07 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: 2.6.10-ac12 + kernbench ==  oom-killer: (OSDL)
Message-ID: <20050208145707.1ebbd468@es175>
Organization: OSDL
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running 2.6.10-ac10 on the STP 1-CPU machines, we don't seem to be able to complete
a kernbench run without hitting the OOM-killer. ( kernbench is multiple kernel compiles,
of course ) Machine is 800 mhz PIII with 1GB memory. We reduce memory for some of the runs.

Typical results:

stp1-001 login: oom-killer: gfp_mask=0xd2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:       14084kB (0kB HighMem)
Active:95617 inactive:4153 dirty:0 writeback:78 unstable:0 free:3521 slab:10320 
mapped:99590 pagetables:12514
DMA free:1860kB min:88kB low:108kB high:132kB active:3512kB inactive:3428kB pres
ent:16384kB pages_scanned:3318 all_unreclaimable? no
protections[]: 0 0 0
Normal free:12224kB min:2800kB low:3500kB high:4200kB active:378956kB inactive:1
3184kB present:506880kB pages_scanned:10146 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:
0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 375*4kB 33*8kB 2*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048
kB 0*4096kB = 1860kB
Normal: 2194*4kB 107*8kB 24*16kB 1*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 
1*2048kB 0*4096kB = 12224kB
HighMem: empty
Swap cache: add 14113357, delete 14112531, find 151467/1660782, race 427+1738
Out of Memory: Killed process 14970 (cc1).
-------------------------
It looks like some oom-related stuff went into -ac10, will try retest with 
-ac9 and -ac10, see what happens. Lemme know if we can do more

cliffw


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
