Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317936AbSFNPnf>; Fri, 14 Jun 2002 11:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317940AbSFNPne>; Fri, 14 Jun 2002 11:43:34 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:46028 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317936AbSFNPnd>; Fri, 14 Jun 2002 11:43:33 -0400
Date: Fri, 14 Jun 2002 17:14:31 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Dan Aloni <da-x@gmx.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] 2.5.21 deadlocks on UP (SMP kernel) w/ IOAPIC
In-Reply-To: <Pine.LNX.4.44.0206141732160.2640-100000@e2>
Message-ID: <Pine.LNX.4.44.0206141712590.30400-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch updated to fix a thinko spotted out by Dan Aloni

--- linux-2.5.19/arch/i386/kernel/io_apic.c.orig	Fri Jun 14 17:43:20 2002
+++ linux-2.5.19/arch/i386/kernel/io_apic.c	Fri Jun 14 17:42:23 2002
@@ -251,7 +251,7 @@
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 
-	if (unlikely(entry->timestamp != now)) {
+	if ((entry->timestamp != now) && (smp_num_cpus > 1)) {
 		unsigned long allowed_mask;
 		int random_number;
 

Linus, please apply.

Regards,
	Zwane Mwaikambo
-- 
http://function.linuxpower.ca
		

