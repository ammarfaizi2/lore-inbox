Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSEKCaq>; Fri, 10 May 2002 22:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSEKCap>; Fri, 10 May 2002 22:30:45 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:36358 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316194AbSEKCap>;
	Fri, 10 May 2002 22:30:45 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Nathan <wfilardo@fuse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX build broken in 2.5.15+Kbuild? 
In-Reply-To: Your message of "Fri, 10 May 2002 21:47:39 -0400."
             <3CDC783B.7040700@fuse.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 12:30:34 +1000
Message-ID: <3691.1021084234@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 21:47:39 -0400, 
Nathan <wfilardo@fuse.net> wrote:
>Using Kbuild-2.5 core 12, common against 2.5.15-1, i386 against 
>2.5.15-1, and some ACPI fixups in arch/i386/{pci,kernel}/Makefile.in to 
>make their latest patch work.
>$ make -f Makefile-2.5 drivers/scsi/aic7xxx/aic7xxx_core.o
>make[1]: Nothing to be done for `drivers/scsi/aic7xxx/aic7xxx_core.o'.

While converting the aic7xxx mess to something sane, I missed a line.
There is a secondary problem where the aic7xxx_{seq,reg}.h files are
always rebuilt, I am tracking that down now.

diff -ur 2.5.15-kbuild-2.5/drivers/scsi/aic7xxx/Makefile.in 2.5.15-kbuild-2.5.new/drivers/scsi/aic7xxx/Makefile.in
--- 2.5.15-kbuild-2.5/drivers/scsi/aic7xxx/Makefile.in	Sat May 11 12:28:02 2002
+++ 2.5.15-kbuild-2.5.new/drivers/scsi/aic7xxx/Makefile.in	Sat May 11 12:23:07 2002
@@ -15,6 +15,8 @@
 
 objlink(aic7xxx.o $(AIC7XXX_OBJS))
 
+select(CONFIG_SCSI_AIC7XXX aic7xxx.o)
+
 extra_cflags_all($(src_includelist /drivers/scsi))
 
 # Only aic7xxx.c includes aic7xxx_seq.h.
@@ -47,12 +49,12 @@
   ifneq ($(KBUILD_SRCTREE_000),$(KBUILD_OBJTREE))
     user_command(aic7xxx_seq.h
 	($(srcfile_base aic7xxx_seq.h))
-	(cp -a $< $@)
+	(cp -fa $< $@)
 	()
 	)
     user_command(aic7xxx_reg.h
 	($(srcfile_base aic7xxx_reg.h))
-	(cp -a $< $@)
+	(cp -fa $< $@)
 	()
 	)
   endif

