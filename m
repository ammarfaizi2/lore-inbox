Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSBJWnb>; Sun, 10 Feb 2002 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSBJWnV>; Sun, 10 Feb 2002 17:43:21 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:24973 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S284794AbSBJWnF>; Sun, 10 Feb 2002 17:43:05 -0500
Message-ID: <3C66F7C4.D559680D@oracle.com>
Date: Sun, 10 Feb 2002 23:44:20 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre6 fails to build on UP (sched.c)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.4-pre6/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
sched.c: In function `schedule':
sched.c:664: `global_irq_holder' undeclared (first use in this function)
sched.c:664: (Each undeclared identifier is reported only once
sched.c:664: for each function it appears in.)
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.4-pre6/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4-pre6/kernel'
make: *** [_dir_kernel] Error 2

It appears that global_irq_holder will only be seen from
 <asm/hardirq.h> if CONFIG_SMP is defined. I haven't dug
 deeper to see whether this is due to CONFIG_PREEMPT (to
 which I said 'Y') or not.

--alessandro

 "If your heart is a flame burning brightly
   you'll have light and you'll never be cold
  And soon you will know that you just grow / You're not growing old"
                              (Husker Du, "Flexible Flyer")
