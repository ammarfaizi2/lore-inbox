Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSBKTGt>; Mon, 11 Feb 2002 14:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290125AbSBKTGk>; Mon, 11 Feb 2002 14:06:40 -0500
Received: from zero.tech9.net ([209.61.188.187]:36626 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290184AbSBKTGd>;
	Mon, 11 Feb 2002 14:06:33 -0500
Subject: Re: [BUG] Panic in 2.5.4 during bootup after POSIX conformance
	testing by UNIFIX
From: Robert Love <rml@tech9.net>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In-Reply-To: <3C67D9CB.2030806@oracle.com>
In-Reply-To: <Pine.LNX.4.30.0202111453330.28560-200000@mustard.heime.net> 
	<3C67D9CB.2030806@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 14:06:01 -0500
Message-Id: <1013454372.6781.418.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can both of you try the attached patch (thanks to Mikael Pettersson),
and tell me if it solves your problem?

	Robert Love

--- linux-2.5.4/include/asm-i386/smplock.h.~1~  Mon Feb 11 12:21:46 2002
+++ linux-2.5.4/include/asm-i386/smplock.h      Mon Feb 11 16:55:18 2002
@@ -15,7 +15,7 @@
 #else
 #ifdef CONFIG_PREEMPT
 #define kernel_locked()                preempt_get_count()
-#define global_irq_holder      0
+#define global_irq_holder      0xFF    /* XXX: NO_PROC_ID */
 #else
 #define kernel_locked()                1
 #endif

