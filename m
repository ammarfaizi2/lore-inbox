Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJJQRn>; Thu, 10 Oct 2002 12:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbSJJQRm>; Thu, 10 Oct 2002 12:17:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38669 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261650AbSJJQRm>;
	Thu, 10 Oct 2002 12:17:42 -0400
Date: Thu, 10 Oct 2002 18:22:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make allmodconfig broken in 2.5.41?
Message-ID: <20021010182251.A1407@mars.ravnborg.org>
Mail-Followup-To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210100100240.19850-100000@alumno.inacap.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210100100240.19850-100000@alumno.inacap.cl>; from rmaureira@alumno.inacap.cl on Thu, Oct 10, 2002 at 01:02:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 01:02:34AM -0400, Robinson Maureira Castillo wrote:
> drivers/scsi/53c700.c:162:22: 53c700_d.h: No such file or directory
Error in makefile, attached patch fixes this.

> make -f drivers/scsi/aacraid/Makefile fastdep
> /home/rmaureira/kj/2.5/linux-2.5.41/Rules.make:15: *** kbuild: 
> drivers/scsi/aacraid/Makefile - Usage of O_TARGET := aacraid.o is obsolete 
> in 2.5. Please fix!.  Stop.
As it says the Makefile for aacraid uses O_TARGET which is now obsolete.
Fix exists in -ac and in latest snapshot of Linus's tree.

	Sam

===== drivers/scsi/Makefile 1.26 vs edited =====
--- 1.26/drivers/scsi/Makefile	Tue Oct  1 19:04:56 2002
+++ edited/drivers/scsi/Makefile	Thu Oct 10 18:21:15 2002
@@ -137,7 +137,7 @@
 $(obj)/53c7,8xx.o: $(obj)/53c8xx_d.h $(obj)/53c8xx_u.h
 $(obj)/53c7xx.o:   $(obj)/53c7xx_d.h $(obj)/53c7xx_u.h
 $(obj)/sim710.o:   $(obj)/sim710_d.h
-$(obj)/53c700.o $(MODVERDIR)/53c700.ver: $(obj)/53c700_d.h
+$(obj)/53c700.o $(MODVERDIR)/$(obj)/53c700.ver: $(obj)/53c700_d.h
 
 # If you want to play with the firmware, uncomment
 # GENERATE_FIRMWARE := 1
@@ -162,4 +162,4 @@
 $(obj)/53c700_d.h: $(src)/53c700.scr $(src)/script_asm.pl
 	$(PERL) -s $(src)/script_asm.pl -ncr7x0_family $@ $(@:_d.h=_u.h) < $<
 
-endif
\ No newline at end of file
+endif
