Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131799AbRCOT7E>; Thu, 15 Mar 2001 14:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131824AbRCOT6y>; Thu, 15 Mar 2001 14:58:54 -0500
Received: from colorfullife.com ([216.156.138.34]:62474 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131823AbRCOT6k>;
	Thu, 15 Mar 2001 14:58:40 -0500
Message-ID: <3AB11EDB.CCA47F45@colorfullife.com>
Date: Thu, 15 Mar 2001 20:58:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: sampsa@netsonic.fi, linux-kernel@vger.kernel.org
Subject: Re: Performance is weird (fwd)
Content-Type: multipart/mixed;
 boundary="------------3805A27AD7A488A56CA6E9D2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3805A27AD7A488A56CA6E9D2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've attached a patch.
I tried to trigger the problem with my 10 MBit ne2k-pci connection, but
without success.

Could you try it?
I've tested it with -ac17, and it applies to 2.4.2 cleanly.

--
	Manfred
--------------3805A27AD7A488A56CA6E9D2
Content-Type: text/plain; charset=us-ascii;
 name="patch-proc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-proc"

--- 2.4/arch/i386/kernel/process.c	Thu Feb 22 22:28:52 2001
+++ build-2.4/arch/i386/kernel/process.c	Thu Mar 15 20:35:12 2001
@@ -81,6 +81,11 @@
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
+		if (softirq_active(smp_processor_id()) & softirq_mask(smp_processor_id())) {
+			__sti();
+			do_softirq();
+			return;
+		}
 		if (!current->need_resched)
 			safe_halt();
 		else

--------------3805A27AD7A488A56CA6E9D2--

