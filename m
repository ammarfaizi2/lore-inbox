Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276302AbRI1Uvw>; Fri, 28 Sep 2001 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276303AbRI1Uvm>; Fri, 28 Sep 2001 16:51:42 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:20107 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S276302AbRI1Uvh>; Fri, 28 Sep 2001 16:51:37 -0400
Date: Fri, 28 Sep 2001 21:52:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com
Subject: Re: Linux 2.4.9-ac16
Message-ID: <20010928215201.C15457@flint.arm.linux.org.uk>
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Thu, Sep 27, 2001 at 06:51:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Somewhere between -ac14 and -ac16, the following appeared:

--- linux/include/asm-s390/pgtable.h~	Fri Sep 28 20:54:54 2001
+++ linux/include/asm-s390/pgtable.h	Fri Sep 28 21:45:18 2001
@@ -500,10 +500,5 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)   (1)
 
-/*
- * No page table caches to initialise
- */
-#define pgtable_cache_init()	do { } while (0)
-
 #endif /* _S390_PAGE_H */
 

So, I decided to check for pgtable_cache_init in arch/s390 and
include/asm-s390 but couldn't find it - I guess this is a mismerge
or something the S390 people missed.

pgtable_cache_init() must be implemented in all architectures.  Any
that don't implement it must make the call a no-op as per the original
pgtable.h.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

