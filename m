Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTFBErY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTFBErY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:47:24 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:387
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261861AbTFBErX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:47:23 -0400
Date: Mon, 2 Jun 2003 00:50:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
cc: Mikael Pettersson <mikpe@csd.uu.se>, "" <alan@lxorguk.ukuu.org.uk>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
In-Reply-To: <1054511535.6676.85.camel@pc>
Message-ID: <Pine.LNX.4.50.0306011950080.31534-100000@montezuma.mastecende.com>
References: <200306012308.h51N8K6j001404@harpo.it.uu.se> <1054511535.6676.85.camel@pc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with doing the clear apic capability flag, Brian how does this 
fare? This patch alone should fix it.

Index: linux-2.5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.54
diff -u -p -B -r1.54 apic.c
--- linux-2.5/arch/i386/kernel/apic.c	31 May 2003 19:01:05 -0000	1.54
+++ linux-2.5/arch/i386/kernel/apic.c	2 Jun 2003 03:50:31 -0000
@@ -609,7 +609,7 @@ static int __init detect_init_APIC (void
 
 	/* Disabled by DMI scan or kernel option? */
 	if (dont_enable_local_apic)
-		return -1;
+		goto no_apic;
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
@@ -665,6 +665,7 @@ static int __init detect_init_APIC (void
 	return 0;
 
 no_apic:
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	printk("No local APIC present or hardware disabled\n");
 	return -1;
 }

-- 
function.linuxpower.ca
