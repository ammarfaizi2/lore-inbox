Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTFAD1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 23:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTFAD1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 23:27:23 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:56448
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261169AbTFAD1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 23:27:21 -0400
Date: Sat, 31 May 2003 23:30:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       "" <brian@interlinx.bc.ca>
Subject: [PATCH][2.5] Honour dont_enable_local_apic flag
Message-ID: <Pine.LNX.4.50.0305312302360.2614-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This flag doesn't get honoured in all cases, we still try and frob the 
APIC in APIC_init_uniprocessor, Tested by Brian.

Alan can i also send you a patch to disable the local apic from the kernel 
command line? It would be dependent on this patch.

	Zwane

Index: linux-2.5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.50
diff -u -p -B -r1.50 apic.c
--- linux-2.5/arch/i386/kernel/apic.c	30 May 2003 20:14:41 -0000	1.50
+++ linux-2.5/arch/i386/kernel/apic.c	31 May 2003 05:53:34 -0000
@@ -665,6 +665,7 @@ static int __init detect_init_APIC (void
 	return 0;
 
 no_apic:
+	dont_enable_local_apic = 1;
 	printk("No local APIC present or hardware disabled\n");
 	return -1;
 }
@@ -1127,6 +1128,9 @@ asmlinkage void smp_error_interrupt(void
  */
 int __init APIC_init_uniprocessor (void)
 {
+	if (dont_enable_local_apic)
+		return -1;
+
 	if (!smp_found_config && !cpu_has_apic)
 		return -1;
 

-- 
function.linuxpower.ca
