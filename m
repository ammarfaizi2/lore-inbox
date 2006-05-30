Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWE3Uyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWE3Uyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWE3Uya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:54:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44454 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932464AbWE3Uy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:54:29 -0400
Date: Tue, 30 May 2006 22:54:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [patch, -rc5-mm1] lock validator: select KALLSYMS_ALL
Message-ID: <20060530205441.GA28015@elte.hu>
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148967947.3636.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.7 required=5.9 tests=ALL_TRUSTED,AWL,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> the reporter doesn't have CONFIG_KALLSYMS_ALL enabled which gives 
> sometimes misleading backtraces (should lockdep just enable 
> KALLSYMS_ALL to get more useful bugreports?)

agreed - the patch below does that.

-----------------------
Subject: lock validator: select KALLSYMS_ALL
From: Ingo Molnar <mingo@elte.hu>

all the kernel symbol printouts make alot more sense if KALLSYMS_ALL
is enabled too - force it on if lockdep is enabled.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 lib/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -342,6 +342,7 @@ config LOCKDEP
 	default y
 	select FRAME_POINTER
 	select KALLSYMS
+	select KALLSYMS_ALL
 	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
 
 config DEBUG_LOCKDEP
