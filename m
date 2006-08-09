Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030664AbWHIK2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030664AbWHIK2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030661AbWHIK2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:28:23 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:64746 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030658AbWHIK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:28:21 -0400
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: ananth@in.ibm.com
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-arch@vger.kernel.org
In-Reply-To: <20060809101948.GA1701@in.ibm.com>
References: <20060807115537.GA15253@in.ibm.com>
	 <20060809094311.GA20050@in.ibm.com> <20060809094516.GA17993@infradead.org>
	 <200608091155.50842.ak@suse.de>  <20060809101948.GA1701@in.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 09 Aug 2006 12:28:18 +0200
Message-Id: <1155119298.4641.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 15:49 +0530, Ananth N Mavinakayanahalli wrote:
> Updated patch ...
> 
> Add the "return_value" macro that just extracts the return value given
> the pt_regs. Useful in situations such as while using function-return
> probes.

return_value definition for s390 see below.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

---

diff -urpN linux-2.6.18-rc3/include/asm-s390/ptrace.h linux-2.6.18-s390/include/asm-s390/ptrace.h
--- linux-2.6.18-rc3/include/asm-s390/ptrace.h	2006-06-29 12:47:32.000000000 +0200
+++ linux-2.6.18-s390/include/asm-s390/ptrace.h	2006-08-09 12:25:23.000000000 +0200
@@ -472,6 +472,7 @@ struct user_regs_struct
 
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
+#define return_value(regs)((regs)->gprs[2])
 #define profile_pc(regs) instruction_pointer(regs)
 extern void show_regs(struct pt_regs * regs);
 #endif


