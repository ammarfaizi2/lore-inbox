Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDWUqk>; Mon, 23 Apr 2001 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDWUqa>; Mon, 23 Apr 2001 16:46:30 -0400
Received: from t2.redhat.com ([199.183.24.243]:57847 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131809AbRDWUqY>; Mon, 23 Apr 2001 16:46:24 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E14rmF9-0000Ii-00@the-village.bc.nu> 
In-Reply-To: <E14rmF9-0000Ii-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk@arm.linux.org.uk (Russell King), papadako@csd.uoc.gr (mythos),
        linux-kernel@vger.kernel.org,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: Can't compile 2.4.3 with agcc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Apr 2001 21:46:09 +0100
Message-ID: <2250.988058769@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



alan@lxorguk.ukuu.org.uk said:
> At least make the final printk a panic.. 

ingo.oeser@informatik.tu-chemnitz.de said:
> replace this with panic() please.

I considered this, but in the end decided to copy the method from a few 
lines above, which triggers in the case of no FPU and no FPE. I wasn't sure 
if there was a reason why we shouldn't panic() here.

RCS file: /inst/cvs/linux/include/asm-i386/bugs.h,v
retrieving revision 1.2.2.16
diff -u -r1.2.2.16 bugs.h
--- include/asm/bugs.h	2001/01/18 13:56:53	1.2.2.16
+++ include/asm/bugs.h	2001/04/23 20:40:57
@@ -80,8 +80,9 @@
 	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
 	 */
 	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
-		extern void __buggy_fxsr_alignment(void);
-		__buggy_fxsr_alignment();
+		printk(KERN_EMERG "FXSAVE data are not 16-byte aligned in task_struct.\n");
+		printk(KERN_EMERG "This is usually caused by a buggy compiler (perhaps pgcc?)\n");
+		panic("Cannot continue.");
 	}
 	if (cpu_has_fxsr) {
 		printk(KERN_INFO "Enabling fast FPU save and restore... ");


--
dwmw2


