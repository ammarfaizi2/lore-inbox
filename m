Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316449AbSEUAG1>; Mon, 20 May 2002 20:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316450AbSEUAG0>; Mon, 20 May 2002 20:06:26 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:59013 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S316449AbSEUAG0>;
	Mon, 20 May 2002 20:06:26 -0400
Date: Mon, 20 May 2002 17:05:23 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/kernel/irq.c: do_IRQ()
Message-ID: <20020520170523.I20837@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though a comment in arch/i386/kernel/irq.c: do_IRQ() clearly states:

         * 0 return value means that this irq is already being
         * handled by some other CPU. (or is disabled)

it seems that the function can only ever return (1). We wrote some low-level
interrupt handling code that depends on the correct value of this function.
Is the following patch what was initially desired? (patched against 2.4.18
tarball from kernel.org...)

Thanks,
William Jhun

---
*** irq.c.orig	Mon May 20 16:55:42 2002
--- irq.c	Mon May 20 16:57:00 2002
***************
*** 639,645 ****
  
  	if (softirq_pending(cpu))
  		do_softirq();
! 	return 1;
  }
  
  /**
--- 639,645 ----
  
  	if (softirq_pending(cpu))
  		do_softirq();
! 	return (action != NULL);
  }
  
  /**

