Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUJRU6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUJRU6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUJRU6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:58:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32393 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267306AbUJRU5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:57:55 -0400
Date: Mon, 18 Oct 2004 15:57:04 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64: VMX memsetting incorrect size
Message-ID: <20041018155704.036a674d@localhost>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup of an incorrect memset() size for vmx in restore_sigcontext.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN arch/ppc64/kernel/signal.c~vmx_memset_size arch/ppc64/kernel/signal.c
--- linux-2.6-bk/arch/ppc64/kernel/signal.c~vmx_memset_size	Mon Oct 18 15:39:34 2004
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/signal.c	Mon Oct 18 15:39:47 2004
@@ -210,7 +210,7 @@ static long restore_sigcontext(struct pt
 	if (v_regs != 0 && (regs->msr & MSR_VEC) != 0)
 		err |= __copy_from_user(current->thread.vr, v_regs, 33 * sizeof(vector128));
 	else if (current->thread.used_vr)
-		memset(&current->thread.vr, 0, 33);
+		memset(&current->thread.vr, 0, 33 * sizeof(vector128));
 	/* Always get VRSAVE back */
 	if (v_regs != 0)
 		err |= __get_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);

_
