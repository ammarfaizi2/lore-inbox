Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271610AbRIBLBn>; Sun, 2 Sep 2001 07:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271612AbRIBLBd>; Sun, 2 Sep 2001 07:01:33 -0400
Received: from [212.150.193.195] ([212.150.193.195]:3596 "EHLO
	dubek.checkpoint.com") by vger.kernel.org with ESMTP
	id <S271610AbRIBLBZ>; Sun, 2 Sep 2001 07:01:25 -0400
Date: Sun, 2 Sep 2001 14:01:26 +0300
From: Elisheva Alexander <ealexand@checkpoint.com>
To: linux-kernel@vger.kernel.org
Subject: buffer_head slab memory leak, Linux bug?
Message-ID: <20010902140126.E28228@checkpoint.com>
Reply-To: Elisheva Alexander <eli7@cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux dubek 2.4.2-2
X-Sign: Taurus
X-Subliminal-Message: doonga doonga doonga
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel list,

if anyone can send me some pointers or hints on how to tackle this bug i 
will be very happy.

on an SMP machine i get:
"stuck on TLB IPI wait (CPU#1)"
the driver that i am debugging uses a spin lock, and sometimes we take the
lock for a pretty long time.
this happens during heavy load, which is why i think that the problem
is that in smp_flush_tlb() in ./arch/i386/kernel/smp.c, one of the CPUs gets 
all upset that the other CPU is stuck in the lock for too long, and releases 
it before it was ment to be released.

things i did that didn't help:

a patch that fixed a similar problem in reiserfs
(http://www.geocrawler.com/mail/msg.php3?msg_id=3962182&list=3455)
the patch for the fast pentium problem, since i have a pentium III.
(http://www.ultraviolet.org/mail-archives/reiserfs.2000/6201.html)

i put a breakpoint when this occurs using kGDB, but i am not able to get 
the registers (and stack) of the CPU that is stuck, only the one that 
prints the message. so i don't really know where this occurs
in our own code. 
does anyone know how i may extract the stack of the second CPU at the 
time of this error?

I am using an Intel pentium III with dual CPU.
I am debugging check point's firewall and vpn modules, with kernel-2.2.14 
from the redhat RPM, but this also happens with the latest 2.2.19.

it happens quite often (at random), so it's not too hard to recreate it.

thanks a lot.

(please CC me, as i am not subscribed to the list.)

-- 
 Elisheva Alexander                          Software Developer
================================================================
 Email from people at checkpoint.com does not usually represent 
 official policy of Check Point (TM) Software Technologies Ltd.
