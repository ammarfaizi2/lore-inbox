Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317496AbSFIBCQ>; Sat, 8 Jun 2002 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSFIBCQ>; Sat, 8 Jun 2002 21:02:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:46349 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317496AbSFIBCP>;
	Sat, 8 Jun 2002 21:02:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Resync with kbuild 2.5 
In-Reply-To: Your message of "Sat, 08 Jun 2002 14:41:23 +0400."
             <20020608104123.GA369@stingr.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jun 2002 11:02:04 +1000
Message-ID: <30170.1023584524@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2002 14:41:23 +0400, 
Paul P Komkoff Jr <i@stingr.net> wrote:
>kbuild25-3.0-for-2.4.19-pre10-2.bz2
>kbuild25-3.0-for-2.4.19-pre10-ac2-2.bz2
>
>Resynched with latest kbuild 2.5 core-18, which fixes some bugs.
>Unfortunately, sourceforge version of kbuild*i386* still don't contain
>s/CC/CC_real/ "fix" for Makefile.defs.*config. Mine contains.

Thanks for spotting that, the fix did not get backported from 2.5
kernels.  New kbuild 2.5 patches for i386 on 2.4.18 and 2.4.19-pre10
will be on sourceforge soon.  The update against kbuild 2.5
i386-2.4.19-pre10-1 is :-

Index: 19-pre10.2/arch/i386/Makefile.defs.noconfig
--- 19-pre10.2/arch/i386/Makefile.defs.noconfig Fri, 07 Jun 2002 18:29:03 +1000 kaos (linux-2.4/m/f/40_Makefile.d 1.7 644)
+++ 19-pre10.2(w)/arch/i386/Makefile.defs.noconfig Sun, 09 Jun 2002 10:17:43 +1000 kaos (linux-2.4/m/f/40_Makefile.d 1.7 644)
@@ -10,6 +10,8 @@
 # Note: When this is included by the top level Makefile, not all CFLAGS have been
 #       set.  Some CFLAGS cannot be set until after CROSS_COMPILE is stable, in
 #       particular CC still scans user space includes at this point.
+#
+# Use $(CC) in this file, not $(CC_real).
 
 LDFLAGS			+= -m elf_i386
 OBJCOPYFLAGS		+= -O binary -R .note -R .comment -S
Index: 19-pre10.2/arch/i386/Makefile.defs.config
--- 19-pre10.2/arch/i386/Makefile.defs.config Mon, 19 Nov 2001 15:25:43 +1100 kaos (linux-2.4/m/f/41_Makefile.d 1.2 644)
+++ 19-pre10.2(w)/arch/i386/Makefile.defs.config Sun, 09 Jun 2002 10:17:43 +1000 kaos (linux-2.4/m/f/41_Makefile.d 1.2 644)
@@ -11,6 +11,7 @@
 # ifneq ($(subst n,,$(CONFIG_xxx)),) is equivalent to the old
 # ifdef CONFIG_xxx but is CML2 compatible.
 #
+# Use $(CC_real) in this file, not $(CC).
 
 # Negated test, add to cflags if CONFIG_FRAME_POINTER is not set.
 ifeq ($(subst n,,$(CONFIG_FRAME_POINTER)),)
@@ -50,11 +51,11 @@ ifneq ($(subst n,,$(CONFIG_MPENTIUM4)),)
 endif
 
 ifneq ($(subst n,,$(CONFIG_MK6)),)
-  CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
+  CFLAGS += $(shell if $(CC_real) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
 endif
 
 ifneq ($(subst n,,$(CONFIG_MK7)),)
-  CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+  CFLAGS += $(shell if $(CC_real) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
 endif
 
 ifneq ($(subst n,,$(CONFIG_MCRUSOE)),)

