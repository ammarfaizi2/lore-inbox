Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbTGIJ21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbTGIJ21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:28:27 -0400
Received: from webmail.insa-lyon.fr ([134.214.79.204]:18115 "EHLO
	mail.insa-lyon.fr") by vger.kernel.org with ESMTP id S267647AbTGIJ2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:28:24 -0400
Date: Wed, 9 Jul 2003 11:43:00 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org
Subject: Patch preempt and win4lin
Message-ID: <20030709094300.GA21693@pc.aurel32>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.4i (2003-03-19)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am maintaining the Debian package containing the preemptible kernel 
from Robert Love. 

A user told me that win4lin stops working when the preemptible patch is
used. He sent me a patch (see below); I have tested it on my computer it
seems to work, however I don't understand exactly what it does. 

Could anybody can give me some comments on this patch and the possible
consequences it could generate?

Thanks
Aurelien


##
# This patch will apply to a 2.4.18 tree that has been patched with
# preempt-kernel-rml-2.4.18-5.patch
#
--- linux-2.4.18-orig/arch/i386/kernel/entry.S  Mon Feb 25 12:37:53 2002
++++ linux-2.4.18/arch/i386/kernel/entry.S       Wed Feb 27 07:16:58
2002
@@ -293,9 +293,8 @@
        jnz restore_all
        cmpl $0,need_resched(%ebx)
        jz restore_all
-       movl SYMBOL_NAME(irq_stat)+irq_stat_local_bh_count CPU_INDX,%ecx
-       addl SYMBOL_NAME(irq_stat)+irq_stat_local_irq_count
        CPU_INDX,%ecx
-       jnz restore_all
+       testl $IF_MASK,EFLAGS(%esp)     # Ints off (execption path) ?
+       jz restore_all
        incl preempt_count(%ebx)
        sti
        call SYMBOL_NAME(preempt_schedule)

