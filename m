Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbVHSOGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVHSOGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 10:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVHSOGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 10:06:06 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:58030 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S932658AbVHSOGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 10:06:02 -0400
Message-ID: <4305E742.7060506@ens-lyon.org>
Date: Fri, 19 Aug 2005 16:05:54 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <4305DDBF.1060309@ens-lyon.org> <20050819142746.B2880@flint.arm.linux.org.uk> <4305E189.1080903@ens-lyon.org> <20050819144509.C2880@flint.arm.linux.org.uk>
In-Reply-To: <20050819144509.C2880@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19.08.2005 15:45, Russell King a écrit :
> #ifdef CONFIG_SMP
> extern int smp_nmi_call_function(void (*fn)(void *), void *priv, int
whatever);
> #else
> static inline int smp_nmi_call_function(void (*fn)(void *), void
*priv, int whatever)
> {
> 	return 0;
> }
> #endif
>
> Obviously I've probably got the arguments to smp_nmi_call_function()
> wrong, so they'll need fixing.  I'm sure the above will point you in
> the right direction though.

Thanks, that worked.
Patch attached.
We might have to do the same for smp_call_function one day.

Brice


--- linux-mm/include/linux/smp.h.old	2005-08-19 15:55:03.000000000 +0200
+++ linux-mm/include/linux/smp.h	2005-08-19 15:54:01.000000000 +0200
@@ -100,12 +100,16 @@ void smp_prepare_boot_cpu(void);
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
-#define smp_nmi_call_function(func, info, wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)

+static inline int smp_nmi_call_function (smp_nmi_function func,
+					 void *info, int wait) {
+	return 0;
+}
+
 #endif /* !SMP */

 /*

