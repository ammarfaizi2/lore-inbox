Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157515AbQHLRhq>; Sat, 12 Aug 2000 13:37:46 -0400
Received: by vger.rutgers.edu id <S157410AbQHLRhg>; Sat, 12 Aug 2000 13:37:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4970 "EHLO www.linux.org.uk") by vger.rutgers.edu with ESMTP id <S157176AbQHLRhW>; Sat, 12 Aug 2000 13:37:22 -0400
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200008121801.TAA11768@flint.arm.linux.org.uk>
Subject: PageSkip
To: linux-kernel@vger.rutgers.edu
Date: Sat, 12 Aug 2000 19:01:53 +0100 (BST)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

I've just done a grep for PageSkip on all .c and .h files in the current
(2.4.0-test6) kernel, and have come up with:

./include/asm-i386/pgtable.h:#define PageSkip(page)             (0)
./include/asm-mips/pgtable.h:#define PageSkip(page)             (0)
./include/asm-alpha/pgtable.h:#define PageSkip(page)            (0)
./include/asm-m68k/pgtable.h:#define PageSkip(page)             (0)
./include/asm-ppc/pgtable.h:#define PageSkip(page)              (0)
./include/asm-arm/pgtable.h:#define PageSkip(page)              (machine_is_riscpc() && test_bit(PG_skip, &(page)->flags))
./include/asm-sh/pgtable.h:#define PageSkip(page)               (0)
./include/asm-ia64/pgtable.h:#define PageSkip(page)             (0)
./include/asm-mips64/pgtable.h:#define PageSkip(page)           test_bit(PG_skip, &(page)->flags)
./include/asm-s390/pgtable.h:#define PageSkip(page)          (0)
./arch/arm/mm/init.c:                   if (PageSkip(page)) {
./arch/mips64/sgi-ip27/ip27-memory.c:                   if (PageSkip(mem_map+tmp))

Since this macro is only used in two architecture-specific places, is there
any reason to keep it in the header files?

On ARM, I'm planning on moving it out of pgtable.h and into mm/init.c.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
