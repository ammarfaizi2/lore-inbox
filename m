Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVATQds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVATQds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVATQTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:19:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12751 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262233AbVATQRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:17:19 -0500
Date: Thu, 20 Jan 2005 17:16:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: [patch] minor spinlock cleanups
Message-ID: <20050120161626.GD13812@elte.hu>
References: <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au> <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu> <20050120161116.GA13812@elte.hu> <20050120161259.GB13812@elte.hu> <20050120161450.GC13812@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120161450.GC13812@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this patch didnt change due to can_lock but i've resent it so that the
patch stream is complete. this concludes my current spinlock patches.]
--

cleanup: remove stale semicolon from linux/spinlock.h and stale space
from asm-i386/spinlock.h.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -202,7 +202,7 @@ typedef struct {
 #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
 #define spin_is_locked(lock)	((void)(lock), 0)
 #define _raw_spin_trylock(lock)	(((void)(lock), 1))
-#define spin_unlock_wait(lock)	(void)(lock);
+#define spin_unlock_wait(lock)	(void)(lock)
 #define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -92,7 +92,7 @@ static inline void spin_unlock_wait(spin
  * (except on PPro SMP or if we are using OOSTORE)
  * (PPro errata 66, 92)
  */
- 
+
 #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
 
 #define spin_unlock_string \
