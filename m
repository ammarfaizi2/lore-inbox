Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTGFUEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTGFUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:04:08 -0400
Received: from www.13thfloor.at ([212.16.59.250]:43751 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262431AbTGFUEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:04:05 -0400
Date: Sun, 6 Jul 2003 22:18:44 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gigag@bezeqint.net
Subject: Re: Patch for 3.5/0.5 address space split
Message-ID: <20030706201843.GC24753@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	gigag@bezeqint.net
References: <bac2312a.9f399e92.8177000@mas3.bezeqint.net> <26930000.1057510039@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <26930000.1057510039@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 09:47:20AM -0700, Martin J. Bligh wrote:
> > Could anybody point out to patches available for 3.5/0.5 address 
> > space split for 2.4 and 2.5 kernels?
> 
> It's in 2.4-aa and 2.5-mjb trees. 2.5 has the added feature that it
> can now do that for PAE (> 4GB) machines (from Dave Hansen). 
> 
> > Any other working options? I managed to compile 2.4.21 kernel 
> > with 1/3 split, but not with 0.5/3.5. The last one simply doesn't 
> > boot. What could I be doing wrong?
> 
> You can chage PAGE_OFFSET yourself, but there's a few places to change
> it ... do a grep -r for "C0000000", and hack all those - one of them
> is in some .lds file or something, I forget.

I change it to use QEMU an x86 emulator ...

arch/i386/vmlinux.lds
include/asm-i386/page.h

the following patch changes it from 0xC0000000 to 0x90000000

HTH,
Herbert


diff -NurbP --minimal linux-2.4.21-P1/arch/i386/vmlinux.lds linux-2.4.21-P1-qemu/arch/i386/vmlinux.lds
--- linux-2.4.21-P1/arch/i386/vmlinux.lds       Mon Feb 25 20:37:53 2002
+++ linux-2.4.21-P1-qemu/arch/i386/vmlinux.lds  Fri Jun 27 15:48:35 2003
@@ -6,7 +6,7 @@
 ENTRY(_start)
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = 0x90000000 + 0x100000;
   _text = .;                   /* Text and read-only data */
   .text : {
        *(.text)
diff -NurbP --minimal linux-2.4.21-P1/include/asm-i386/page.h linux-2.4.21-P1-qemu/include/asm-i386/page.h
--- linux-2.4.21-P1/include/asm-i386/page.h     Thu Jun 26 23:40:59 2003
+++ linux-2.4.21-P1-qemu/include/asm-i386/page.h        Fri Jun 27 15:47:52 2003
@@ -78,7 +78,7 @@
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
-#define __PAGE_OFFSET          (0xC0000000)
+#define __PAGE_OFFSET          (0x90000000)
 
 /*
  * This much address space is reserved for vmalloc() and iomap()



> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
