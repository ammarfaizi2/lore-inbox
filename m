Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUHEEul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUHEEul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUHEEsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:48:39 -0400
Received: from holomorphy.com ([207.189.100.168]:63424 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267499AbUHEEqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:46:32 -0400
Date: Wed, 4 Aug 2004 21:46:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [5/13] reinstate smp_reschedule_irq()
Message-ID: <20040805044627.GW2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805044427.GV2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:44:27PM -0700, William Lee Irwin III wrote:
> The SMP initialization functions try to do btfixups on the wrong
> symbols for smp_processor_id(), which is now implemented in terms
> of current_thread_info()->cpu. hard_smp_processor_id() etc. are now
> in use where smp_processor_id() was once used.

smp_reschedule_irq() mysteriously vanished sometime after 2.4.
This patch reinstates it so that the kernel will link properly
and so cpus will set TIF_NEED_RESCHED when it's asked of them.

Index: mm2-2.6.8-rc2/arch/sparc/kernel/smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/smp.c
@@ -203,6 +203,11 @@
 	}
 }
 
+void smp_reschedule_irq(void)
+{
+	set_need_resched();
+}
+
 void smp_flush_page_to_ram(unsigned long page)
 {
 	/* Current theory is that those who call this are the one's
