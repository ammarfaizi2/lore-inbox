Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVHSNSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVHSNSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVHSNSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:18:46 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:57808 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S932478AbVHSNSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:18:45 -0400
Message-ID: <4305DC2C.3060307@ens-lyon.org>
Date: Fri, 19 Aug 2005 15:18:36 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/sysrq.c: In function 'sysrq_handle_showregs':
drivers/char/sysrq.c:186: warning: statement with no effect

This is caused by a smp call while CONFIG_SMP is not set.
The attached patch fixes this.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice


--- linux-mm/drivers/char/sysrq.c.old	2005-08-19 15:14:53.000000000 +0200
+++ linux-mm/drivers/char/sysrq.c	2005-08-19 15:15:12.000000000 +0200
@@ -182,7 +182,7 @@ static void sysrq_handle_showregs(int ke
 	if (pt_regs)
 		show_regs(pt_regs);
 	bust_spinlocks(0);
-#if defined(__i386__) && defined(CONFIG_SMP)
+#ifdef __i386__
 	smp_nmi_call_function(smp_show_regs, NULL, 0);
 #endif
 }

