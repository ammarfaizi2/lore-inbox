Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135480AbRDWPxx>; Mon, 23 Apr 2001 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135474AbRDWPxg>; Mon, 23 Apr 2001 11:53:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:42482 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135471AbRDWPxE>; Mon, 23 Apr 2001 11:53:04 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010423154821.A26340@flint.arm.linux.org.uk> 
In-Reply-To: <20010423154821.A26340@flint.arm.linux.org.uk>  <Pine.GSO.4.33.0104231611090.15682-100000@iridanos.csd.uch.gr> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: mythos <papadako@csd.uoc.gr>, linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Apr 2001 16:52:53 +0100
Message-ID: <24644.988041173@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
> On Mon, Apr 23, 2001 at 04:13:47PM +0300, mythos wrote:
> > init/main.o(.text.init+0x65): undefined reference to `__buggy_fxsr_alignment'

> This is a FAQ!  (sorry, but I don't know if it is in a FAQ or not).
>  IIRC, you can't use pgcc to compile linux kernels.

Then the kernel should say so, rather than giving a cryptic message like 
that, and containing code which isn't actually guaranteed to compile, even 
with a compiler which _does_ align the structure as we want it.

Index: include/asm/bugs.h
===================================================================
RCS file: /inst/cvs/linux/include/asm-i386/bugs.h,v
retrieving revision 1.2.2.16
diff -u -r1.2.2.16 bugs.h
--- include/asm/bugs.h	2001/01/18 13:56:53	1.2.2.16
+++ include/asm/bugs.h	2001/04/23 15:45:28
@@ -80,8 +80,10 @@
 	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
 	 */
 	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
-		extern void __buggy_fxsr_alignment(void);
-		__buggy_fxsr_alignment();
+		printk(KERN_EMERG "ERROR: FXSAVE data are not 16-byte aligned in task_struct.\n");
+		printk(KERN_EMERG "This is usually caused by a buggy compiler (perhaps pgcc?)\n");
+		printk(KERN_EMERG "Cannot continue.\n");
+		for (;;) ;
 	}
 	if (cpu_has_fxsr) {
 		printk(KERN_INFO "Enabling fast FPU save and restore... ");


--
dwmw2


