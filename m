Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbUK2PmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbUK2PmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUK2PmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:42:09 -0500
Received: from [220.248.27.114] ([220.248.27.114]:17037 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261737AbUK2PlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:41:24 -0500
Date: Mon, 29 Nov 2004 23:40:41 +0800
From: hugang@soulinfo.com
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: ppcfix.diff
Message-ID: <20041129154041.GB4616@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Morton:

Please apply this patch, to fix compile error in debian woody.
$gcc -v
Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

--- 2.6.9-lzf/arch/ppc/syslib/open_pic.c	2004-11-26 12:32:58.000000000 +0800
+++ 2.6.9/arch/ppc/syslib/open_pic.c	2004-11-28 23:16:58.000000000 +0800
@@ -776,7 +776,8 @@ static void openpic_mapirq(u_int irq, cp
 	if (ISR[irq] == 0)
 		return;
 	if (!cpus_empty(keepmask)) {
-		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
+		cpumask_t irqdest;
+		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
 		cpus_and(irqdest, irqdest, keepmask);
 		cpus_or(physmask, physmask, irqdest);
 	}
-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
