Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRCIFqS>; Fri, 9 Mar 2001 00:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRCIFqJ>; Fri, 9 Mar 2001 00:46:09 -0500
Received: from kwanon.research.canon.com.au ([203.12.172.254]:24333 "HELO
	kwanon.research.canon.com.au") by vger.kernel.org with SMTP
	id <S130434AbRCIFp5>; Fri, 9 Mar 2001 00:45:57 -0500
Message-ID: <20010309054528.16862.qmail@cass.research.canon.com.au>
From: gjohnson@research.canon.com.au
Subject: Resolving physical addresses
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Mar 2001 16:45:28 +1100 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel-dudes,

I have used this snippet of code previously in a 2.2 kernel
to get the physical address of the user virtual address 'addr'.
It worked fine under 2.2, but gives me crap under 2.4. I have
looked at bits of code in the 2.4 memory manager that do
similar stuff, and it looks much the same. I call 'mlock' (as root)
on the allocated buffer in the user app before my driver
gets called to run this code.

I have tried this on a dual CPU system with both a UP and MP
kernel.

Is there something that I should be doing different in the
2.4 case, or is maybe 'mlock' broken?

I also used 'map_user_kiobuf' on the same buffer and when I
look at iobuf->locked, it says it ain't.

Any ideas, or is there an easier way to get physical address
of a user allocated buffer. The kiobuf is a bit obscure to
divine from the source.

Regards

Greg.

    pgd_t               *pgd;           /* PaGe Directory */
    pmd_t               *pmd;           /* Page Mid-level Directory */
    pte_t               *pte;           /* Page Table Entry */
    unsigned long       kern_addr;      /* Kernel address of addr. */
    unsigned long       addr_ofst;      /* Offset of addr within a page */

    /* Get the page table entry of the page that addr belongs */
    pgd = pgd_offset(current->mm, (unsigned long) addr);
    pmd = pmd_offset(pgd, (unsigned long) addr);
    pte = pte_offset(pmd, (unsigned long) addr);

    /* Calculate the offset of addr within a page and add to kern_addr */
    kern_addr = (unsigned long) pte_page(*pte);
    addr_ofst = addr & (PAGE_SIZE - 1);
    kern_addr += addr_ofst;

-- 
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

