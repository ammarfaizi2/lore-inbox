Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319216AbSHNFtj>; Wed, 14 Aug 2002 01:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319218AbSHNFti>; Wed, 14 Aug 2002 01:49:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34546 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319216AbSHNFti>;
	Wed, 14 Aug 2002 01:49:38 -0400
Date: Tue, 13 Aug 2002 22:52:09 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <1903084691.1029279127@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0208131320280.1260-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131320280.1260-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But this is exactly the kinds of cases that config options do 
> _not_ work well for.

OK ... you're right ;-) This is bad, especially for distribution
kernels. So I just need something to stop the NUMA-Q crashing.
Can I have the appended? Please, please, please? ;-)
It just adds an if switch to irq_balance which the compiler
optimises away anyway. Not a whiff of a config option. 
Tested on 2.5.31.

M.

diff -urN -X /home/mbligh/.diff.exclude 2.5.31-virgin/arch/i386/kernel/io_apic.c 2.5.31-irqbalance2/arch/i386/kernel/io_apic.c
--- 2.5.31-virgin/arch/i386/kernel/io_apic.c	Sat Aug 10 18:41:26 2002
+++ 2.5.31-irqbalance2/arch/i386/kernel/io_apic.c	Tue Aug 13 22:32:49 2002
@@ -251,6 +251,9 @@
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 
+	if (clustered_apic_mode)
+		return;
+
 	if (entry->timestamp != now) {
 		unsigned long allowed_mask;
 		int random_number;


