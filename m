Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275539AbRJAVQ1>; Mon, 1 Oct 2001 17:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRJAVQS>; Mon, 1 Oct 2001 17:16:18 -0400
Received: from [128.55.19.167] ([128.55.19.167]:35018 "EHLO lanshark.nersc.gov")
	by vger.kernel.org with ESMTP id <S275539AbRJAVP7>;
	Mon, 1 Oct 2001 17:15:59 -0400
Message-ID: <3BB8DCD5.A2CF293D@lbl.gov>
Date: Mon, 01 Oct 2001 14:15:01 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: endless APIC error messages..
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I know, I've got a busted ABIT-BP2 system board.

Running 2.4, I get thousands of the APIC error messages, which fill my
syslog.

Is there a reason for this constant spewing?  The short little patch,
that simply does stops the system from complaining any more - it's
busted - we know that.

--- linux/arch/i386/kernel/apic.c       Mon Oct  1 14:12:50 2001
+++ linux-2.4.9-ac16/arch/i386/kernel/apic.c    Mon Oct  1 14:10:19 2001
@@ -37,6 +37,8 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
 
+static int apic_error_count = 50;
+
 int get_maxlvt(void)
 {
        unsigned int v, ver, maxlvt;
@@ -1061,8 +1063,11 @@
           6: Received illegal vector
           7: Illegal register address
        */
-       printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
-               smp_processor_id(), v , v1);
+       if (apic_error_count != 0) {
+               apic_error_count--;
+               printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
+                smp_processor_id(), v , v1);
+       }
 }
 
 /*

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
