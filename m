Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132071AbQKVBuz>; Tue, 21 Nov 2000 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbQKVBuf>; Tue, 21 Nov 2000 20:50:35 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:38930 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S132071AbQKVBud>; Tue, 21 Nov 2000 20:50:33 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
Date: Tue, 21 Nov 2000 18:20:29 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <00112118202900.25333@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
>> I tried to compile 2.4.0-test11-ac1, and here is where the compile bombed 
out:
>> 
>> /usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes 
>> -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o 
>> sched.o sched.c
>> irq.c:182: conflicting types for `global_irq_lock'
>> /usr/src/linux/include/asm/hardirq.h:45: previous declaration of 
>> `global_irq_lock'
>
>I'll check this. I take it you tried an SMP build ?

Yes, this above build attempt was for an SMP kernel.  When I got home,
I tried to build an UP kernel with test11-ac1, and as I'm sure you know 
already, it worked perfectly.  I then tried to build another SMP kernel, with 
the same results as above.  

I submitted a tiny patchlet earlier for this.  It seems to fix the symptoms.
I compiled and ran a kernel with this patch on the SMP box at work.

I replicated the associated comment for people searching on this pattern.

I'm at home now, please cc any questions or comments to elenstev@mesatop.com.

Steven 

Here is the patchlet again:

diff -u linux/include/asm/hardirq.h.orig linux/include/asm/hardirq.h
--- linux/include/asm/hardirq.h.orig    Tue Nov 21 13:38:07 2000
+++ linux/include/asm/hardirq.h Tue Nov 21 13:40:13 2000
@@ -42,7 +42,7 @@
 #include <asm/smp.h>

 extern unsigned char global_irq_holder;
-extern unsigned volatile int global_irq_lock;
+extern unsigned volatile long global_irq_lock; /* long for set_bit --RR */

 static inline int irqs_running (void)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
