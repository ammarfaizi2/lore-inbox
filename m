Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSG2MQa>; Mon, 29 Jul 2002 08:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSG2MQa>; Mon, 29 Jul 2002 08:16:30 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:56464 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S316113AbSG2MQ3>; Mon, 29 Jul 2002 08:16:29 -0400
Date: Mon, 29 Jul 2002 14:19:49 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: link errors in 2.5.29+bk
Message-ID: <20020729121949.GJ29876@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Meelis Roos <mroos@linux.ee>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.43.0207291351390.24473-100000@romulus.cs.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.43.0207291351390.24473-100000@romulus.cs.ut.ee>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 01:53:34PM +0300, Meelis Roos wrote:

> Seems to be connected to the recent migration thread changes:
> 
> init/init.o: In function `do_pre_smp_initcalls':
> init/init.o(.text+0x59): undefined reference to `migration_init'

The attached patch fixes this.

===== init/main.c 1.59 vs edited =====
--- 1.59/init/main.c	Mon Jul 29 08:07:28 2002
+++ edited/init/main.c	Mon Jul 29 12:21:56 2002
@@ -526,10 +526,14 @@
 
 static void do_pre_smp_initcalls(void)
 {
+#if CONFIG_SMP
 	extern int migration_init(void);
+#endif
 	extern int spawn_ksoftirqd(void);
 
+#if CONFIG_SMP
 	migration_init();
+#endif
 	spawn_ksoftirqd();
 }

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
