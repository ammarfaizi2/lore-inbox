Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280981AbRKLUlt>; Mon, 12 Nov 2001 15:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280992AbRKLUl3>; Mon, 12 Nov 2001 15:41:29 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:52238 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S280981AbRKLUlX>; Mon, 12 Nov 2001 15:41:23 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "Daniel I. Applebaum" <kernel@danapple.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256B02.00718123.00@smtpnotes.altec.com>
Date: Mon, 12 Nov 2001 14:27:59 -0600
Subject: Re: 2.4.15-pre4 compile problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Try this patch (it works for me):

--- ./arch/i386/kernel/setup.c     Mon Nov 12 14:16:11 2001
+++ ./arch/i386/kernel/setup.c.fixed     Mon Nov 12 14:19:54 2001
@@ -2788,7 +2788,7 @@

 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-    return *pos < NR_CPUS ? &cpu_data[*pos] : NULL;
+    return *pos < NR_CPUS ? &(cpu_data)[*pos] : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {







"Daniel I. Applebaum" <kernel@danapple.com> on 11/12/2001 01:39:33 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  2.4.15-pre4 compile problem




While compiling 2.4.15-pre4:
+++++++++++++++
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o setup.o setup.c
setup.c: In function `c_start':
setup.c:2791: subscripted value is neither array nor pointer
setup.c:2792: warning: control reaches end of non-void function
gmake[1]: *** [setup.o] Error 1
gmake[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
gmake: *** [_dir_arch/i386/kernel] Error 2
+++++++++++++++++

Here's the block of code:
+++++++++++++++++
static void *c_start(struct seq_file *m, loff_t *pos)
{
        return *pos < NR_CPUS ? &cpu_data[*pos] : NULL;
}
+++++++++++++++++

Note that I'm compiling a non-SMP kernel.

Do I have to generate my .config from scatch each time, or can I copy
2.4.14/.config to 2.4.15-pre4/.config and run 'gmake menuconfig'?
(I've been doing the latter.)

Dan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




