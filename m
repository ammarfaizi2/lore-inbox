Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTLATlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 14:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTLATlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 14:41:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:29654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263918AbTLATlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 14:41:03 -0500
Date: Mon, 1 Dec 2003 11:33:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Missing L2-cache after warm boot
Message-Id: <20031201113300.7eb9bb7f.rddunlap@osdl.org>
In-Reply-To: <87ptf8bpnd.fsf@echidna.jochen.org>
References: <87ptf8bpnd.fsf@echidna.jochen.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Dec 2003 15:04:22 +0100 Jochen Hein <jochen@jochen.org> wrote:

| 
| I'm running 2.6.0-test11 on an older Thinkpad 390E,
| When booting into 2.6.0-test11 after running Windows2000 I get:
| 
...
| Dec  1 14:51:56 gswi1164 kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
| Dec  1 14:51:56 gswi1164 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
| Dec  1 14:51:56 gswi1164 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
...
| 
| When booting cold the boot messages are:
| 
...
| Dec  1 14:54:57 gswi1164 kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
| Dec  1 14:54:57 gswi1164 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
| Dec  1 14:54:57 gswi1164 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
| Dec  1 14:54:57 gswi1164 kernel: CPU: L2 cache: 256K

Can you apply this patch so that we can see what cache/TLB descriptors
are found during the boot?

--
~Randy


description:	dump cache/TLB descriptors while trying to identify them
product_versions: Linux 2.6.0-test11

diffstat:=
 arch/i386/kernel/cpu/intel.c |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./arch/i386/kernel/cpu/intel.c~caches ./arch/i386/kernel/cpu/intel.c
--- ./arch/i386/kernel/cpu/intel.c~caches	2003-11-26 12:43:27.000000000 -0800
+++ ./arch/i386/kernel/cpu/intel.c	2003-12-01 11:04:46.000000000 -0800
@@ -187,6 +187,7 @@ static void __init init_intel(struct cpu
 				unsigned char des = dp[j];
 				unsigned char k = 0;
 
+				printk("CPU: searching for des = 0x%x\n", des);
 				/* look up this descriptor in the table */
 				while (cache_table[k].descriptor != 0)
 				{

