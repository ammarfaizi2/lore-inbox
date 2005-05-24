Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVEXPRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVEXPRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVEXPRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:17:22 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:20679 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262084AbVEXPRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:17:08 -0400
Message-ID: <4293456F.8070608@telia.com>
Date: Tue, 24 May 2005 17:17:03 +0200
From: Simon Strandman <simon.strandman@telia.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4-git7 fails to build on x86_64 if CONFIG_BUG is off.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I don't know if this is a supported configuration, but I tried turning 
off CONFIG_BUG just to see what difference it would make. But it fails 
to build with this error:

  CC      arch/x86_64/kernel/process.o
  CC      arch/x86_64/kernel/semaphore.o
  CC      arch/x86_64/kernel/signal.o
  AS      arch/x86_64/kernel/entry.o
  CC      arch/x86_64/kernel/traps.o
  CC      arch/x86_64/kernel/irq.o
  CC      arch/x86_64/kernel/ptrace.o
  CC      arch/x86_64/kernel/time.o
  CC      arch/x86_64/kernel/ioport.o
  CC      arch/x86_64/kernel/ldt.o
  CC      arch/x86_64/kernel/setup.o
In file included from include/linux/dma-mapping.h:19,
                 from include/asm-generic/pci-dma-compat.h:7,
                 from include/asm/pci.h:94,
                 from include/linux/pci.h:904,
                 from arch/x86_64/kernel/setup.c:39:
include/asm/dma-mapping.h: In function `dma_sync_single_for_cpu':
include/asm/dma-mapping.h:67: varning: implicit deklaration av funktion 
"out_of_line_bug"
  CC      arch/x86_64/kernel/i8259.o
  CC      arch/x86_64/kernel/sys_x86_64.o
  CC      arch/x86_64/kernel/x8664_ksyms.o
In file included from include/linux/dma-mapping.h:19,
                 from include/asm-generic/pci-dma-compat.h:7,
                 from include/asm/pci.h:94,
                 from include/linux/pci.h:904,
                 from arch/x86_64/kernel/x8664_ksyms.c:10:
include/asm/dma-mapping.h: In function `dma_sync_single_for_cpu':
include/asm/dma-mapping.h:67: varning: implicit deklaration av funktion 
"out_of_line_bug"
arch/x86_64/kernel/x8664_ksyms.c: At top level:
arch/x86_64/kernel/x8664_ksyms.c:196: error: conflicting types for 
'out_of_line_bug'
include/asm/dma-mapping.h:67: error: previous implicit declaration of 
'out_of_line_bug' was here
make[1]: *** [arch/x86_64/kernel/x8664_ksyms.o] Fel 1
make: *** [arch/x86_64/kernel] Fel 2

This is with gcc 3.4.3, binutils 2.16 and I have the -ck patch applied. 
It works fine with CONFIG_BUG set to y. My kernel config: 
http://snigel.no-ip.com/~nxsty/linux/config

-- 
Simon Strandman <simon.strandman@telia.com>

