Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136464AbREDR0l>; Fri, 4 May 2001 13:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136467AbREDR0V>; Fri, 4 May 2001 13:26:21 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:61658 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136466AbREDR0R>; Fri, 4 May 2001 13:26:17 -0400
Message-ID: <3AF2E569.47AED98D@home.com>
Date: Fri, 04 May 2001 10:22:49 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: REVISED: Experimentation with Athlon and fast_page_copy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
 After removing my head from my a**, I revised the code that checks
the memory copy in the fast_page_copy routine.  The machine then
proceeded
not to stop at my panic, but I got my "normal" oopses.  I then had an
idea and removed all the prefetch instructions from the beginning of the
routine and tried the resultin kernel.  I now have no crashes.
What could this mean?

Here is a nother patch just so you can keep me honest if I
made another mistake:

-------------------------
diff -r ./arch/i386/lib/mmx.c ../lin2/linux/arch/i386/lib/mmx.c
149,150c149
<
< /*    __asm__ __volatile__ (
---
>       __asm__ __volatile__ (
158c157
<               "3: movw $0x1AEB, 1b\n"
---
>               "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
166c165
< */
---
>
170c169
<               "1: nop\n" /* prefetch 320(%0)\n" */
---
>               "1: prefetch 320(%0)\n"                                         
-------------------------

  Please let me know if that makes sense :).

  Thank you,
   Seth
