Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbTLRRWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbTLRRWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:22:32 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:21376
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265233AbTLRRWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:22:31 -0500
Date: Thu, 18 Dec 2003 12:21:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Miroslaw KLABA <totoro@totoro.be>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Double Interrupt with HT
In-Reply-To: <20031218173528.370211b6.totoro@totoro.be>
Message-ID: <Pine.LNX.4.58.0312181219570.1710@montezuma.fsmlabs.com>
References: <20031215155843.210107b6.totoro@totoro.be>
 <1071603069.991.194.camel@cog.beaverton.ibm.com> <1071615336.3fdf8d6840208@ssl0.ovh.net>
 <1071618630.1013.11.camel@cog.beaverton.ibm.com> <1071630228.3fdfc794eb353@ssl0.ovh.net>
 <1071717730.1117.26.camel@cog.beaverton.ibm.com> <20031218131437.239e69e5.totoro@totoro.be>
 <Pine.LNX.4.58.0312180849480.1710@montezuma.fsmlabs.com>
 <20031218173528.370211b6.totoro@totoro.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Miroslaw KLABA wrote:

> My fault...
> It works now.
> `while true; do date; sleep 1; done` counts well now.
> Thanks.
> But now, how may I help to find this bug in apic code?

Thanks for verifying that Miroslaw, could you also test the following
patch (against 2.4.23) ?

Ta,
	Zwane

Index: linux-2.4.23/include/asm-i386/smpboot.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.23/include/asm-i386/smpboot.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.h
--- linux-2.4.23/include/asm-i386/smpboot.h	4 Dec 2003 22:20:21 -0000	1.1.1.1
+++ linux-2.4.23/include/asm-i386/smpboot.h	18 Dec 2003 17:19:28 -0000
@@ -57,7 +57,7 @@ static inline void detect_clustered_apic
 #define esr_disable (0)
 #define detect_clustered_apic(x,y)
 #define INT_DEST_ADDR_MODE (APIC_DEST_LOGICAL)	/* logical delivery */
-#define INT_DELIVERY_MODE (dest_LowestPrio)
+#define INT_DELIVERY_MODE (dest_Fixed)
 #endif /* CONFIG_X86_CLUSTERED_APIC */
 #define BAD_APICID 0xFFu

