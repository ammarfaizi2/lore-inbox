Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRJBMC1>; Tue, 2 Oct 2001 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272484AbRJBMCS>; Tue, 2 Oct 2001 08:02:18 -0400
Received: from [195.66.192.167] ([195.66.192.167]:44815 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272280AbRJBMCF>; Tue, 2 Oct 2001 08:02:05 -0400
Date: Tue, 2 Oct 2001 15:01:20 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <9121494397.20011002150120@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@ufl.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: Latency measurements
In-Reply-To: <1001972854.2277.49.camel@phantasy>
In-Reply-To: <15919370673.20011001160824@port.imtp.ilyichevsk.odessa.ua>
 <1001972854.2277.49.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
Monday, October 01, 2001, 11:47:31 PM, you wrote:

>> These are the longest held locks on my system
>> (PII 233 UP, 32MB RAM, SVGA 16bit color fb console, X)
>> Kernel: 2.4.10 + ext3 + preemption
>> I am very willing to test any patches to reduce latency.
>> 
>> 418253       BKL        1   712/tty_io.c        c01b41c5   714/tty_io.c
>> 222609       BKL        1   712/tty_io.c        c01b41c5   697/sched.c   
>> 152903 spin_lock        5   547/sched.c         c0114fd5   714/tty_io.c  
>> 132422       BKL        5   712/tty_io.c        c01b41c5   714/tty_io.c  
>> 104548       BKL        1   712/tty_io.c        c01b41c5  1380/sched.c

RL> Unfortunately there isn't much we can do about any of those locks.

RL> The locks in tty_io.c are have to be held, the fact you are using a
RL> framebuffer makes it a lot worse, though.  If there is an accelerated fb
RL> for your video card, I would suggest that.

That is a BKL which we are trying to get rid of.
What deadlock is prevented by lock_kernel()
in tty_io.c:712?

write() call there is actually a tty->ldisc.write().
Is it possible to move lock into tty->ldisc.write()
and make it a spinlock? I'd like to try, but I admit
I failed to track what fn ptr is placed in ldisc.write
in my case (fb console)  :-(

>> 222609       BKL 1 712/tty_io.c  697/sched.c
I don't quite understand how locked region can start in
712/tty_io.c and end in 697/sched.c?

This is strange too:
>> 152903 spin_lock 5 547/sched.c   714/tty_io.c
spinlock? Unlocked by unlock_kernel()???
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


