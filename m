Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277419AbRJJVpF>; Wed, 10 Oct 2001 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277424AbRJJVoy>; Wed, 10 Oct 2001 17:44:54 -0400
Received: from helios.ankara.gantek.com ([213.74.180.65]:28070 "EHLO
	helios.ankara.gantek.com") by vger.kernel.org with ESMTP
	id <S277419AbRJJVol>; Wed, 10 Oct 2001 17:44:41 -0400
Date: Thu, 11 Oct 2001 00:41:43 +0300
From: Baurjan Ismagulov <ibr@gantek.com>
To: linux-kernel@vger.kernel.org
Subject: window_ret_fault on SPARC
Message-ID: <20011011004142.A12773@kerberos.local.ankara.gantek.com>
Mail-Followup-To: Baurjan Ismagulov <ibr@gantek.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mmm.txt"
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my kernel gets into window_ret_fault while returning from trap to
user mode.

In the trap return code, SRMMU sets "Fault Address Valid" during
"save; LOAD_WINDOW(sp); restore". After that, SFSR=00000127 and
SFAR=efffed18. Loaded %fp value is efffece0, and [efffece0+38]
contains efffed50 -- at least, that is what I see in kgdb using "p/x
*(struct reg_window *)0xefffece0". I also tried to see that using
printk from window_ret_fault, but the kernel hung solidly (L1-A didn't
work).

I followed all vm_next links in current->mm->mmap; efffd000-effff000
area seems to be there. However, I was unable to track it via
current->pgd.

So:

1. Why do I get multiple (SFSR.OV=1) faults in srmmu_rett_stackchk?

2. How can I see whether page directories of the current process are
   set up correctly?

I would be very grateful if someone could help me to solve this problem. I'm using 2.2.19 on sun4m.

Thanks in advance,
Baurjan.
